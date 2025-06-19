package com.mag.servlet;

import com.mag.dao.CardDAO;
import com.mag.domain.CampusCard;
import com.mag.service.CardService;
// import com.mag.dao.TransactionRecordDAO; // 后续可以加
// import com.mag.domain.TransactionRecord;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

public class TransferServlet extends HttpServlet {
    private final CardService cardService = new CardService();
    // TODO: private final TransactionRecordDAO recordDAO = new TransactionRecordDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        CampusCard sender = (session != null) ? (CampusCard) session.getAttribute("loginCard") : null;

        String receiverPersonID = request.getParameter("personID");
        String receiverName = request.getParameter("name");
        String passwordPay = request.getParameter("passwordPay");
        String amountStr = request.getParameter("amount");
        double amount;

        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // 1. 基本校验
        if (sender == null) {
            out.write("{\"success\":false, \"msg\":\"未登录！\"}");
            return;
        }
        if (!"正常".equals(sender.getStatus())) {
            out.write("{\"success\":false, \"msg\":\"本卡片状态异常！\"}");
            return;
        }
        if (!sender.getPasswordPay().equals(passwordPay)) {
            out.write("{\"success\":false, \"msg\":\"支付密码错误！\"}");
            return;
        }
        if (receiverPersonID == null || receiverPersonID.trim().isEmpty()) {
            out.write("{\"success\":false, \"msg\":\"请输入对方学号！\"}");
            return;
        }
        if (amountStr == null) {
            out.write("{\"success\":false, \"msg\":\"请输入转账金额！\"}");
            return;
        }
        try {
            amount = Double.parseDouble(amountStr);
        } catch (NumberFormatException e) {
            out.write("{\"success\":false, \"msg\":\"转账金额格式不正确！\"}");
            return;
        }
        if (amount <= 0) {
            out.write("{\"success\":false, \"msg\":\"转账金额必须大于0！\"}");
            return;
        }

        // 2. 查询对方卡片
        CampusCard receiver = cardService.findCardByPersonID(receiverPersonID);
        if (receiver == null || !"正常".equals(receiver.getStatus())) {
            out.write("{\"success\":false, \"msg\":\"对方账户不存在或不可用！\"}");
            return;
        }
        if (!receiver.getName().equals(receiverName)) {
            out.write("{\"success\":false, \"msg\":\"收款人姓名不匹配！\"}");
            return;
        }
        if (receiverPersonID.equals(sender.getPersonID())) {
            out.write("{\"success\":false, \"msg\":\"不能给自己转账！\"}");
            return;
        }

        // 3. 校验余额（pendingBalance 允许为负，但余额+pending不能为负）
        double totalAvailable = sender.getBalance() + sender.getPendingBalance();
        if (amount > totalAvailable) {
            out.write("{\"success\":false, \"msg\":\"余额不足，无法转账！\"}");
            return;
        }
        double senderNewPending = sender.getPendingBalance() - amount;
        if (sender.getBalance() + senderNewPending < 0) {
            out.write("{\"success\":false, \"msg\":\"余额不足，无法转账！\"}");
            return;
        }
        double receiverNewPending = receiver.getPendingBalance() + amount;

        // 4. 更新数据库（目前不加事务，安全但太麻烦）
        boolean senderUpdated = cardService.updatePendingBalance(sender.getPersonID(), senderNewPending);
        boolean receiverUpdated = cardService.updatePendingBalance(receiver.getPersonID(), receiverNewPending);

        if (senderUpdated && receiverUpdated) {
            // 5. 及时同步 session 里的 loginCard
            sender.setPendingBalance(senderNewPending);
            session.setAttribute("loginCard", sender);

            // 6. 生成转账流水记录（TODO: 实际应插入两条记录：一条“转出”，一条“转入”）
            // 示例：recordDAO.insertTransferRecord(sender, receiver, amount, ...);

            out.write("{\"success\":true, \"msg\":\"转账成功！\"}");
        } else {
            out.write("{\"success\":false, \"msg\":\"转账失败，系统异常！\"}");
        }
    }
}