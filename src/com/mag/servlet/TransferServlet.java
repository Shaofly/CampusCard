package com.mag.servlet;

import com.mag.domain.CampusCard;
import com.mag.domain.TransactionRecord;
import com.mag.service.CardService;
import com.mag.service.TransactionRecordService;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

public class TransferServlet extends HttpServlet {
    private final CardService cardService = new CardService();
    private final TransactionRecordService recordService = new TransactionRecordService();

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

            // 6. 生成转账流水记录（插入两条记录：一条“转出”，一条“转入”）
            java.util.Date now = new java.util.Date();

            // 6.1. 转出方流水（sender）
            TransactionRecord outRecord = new TransactionRecord();
            outRecord.setPersonID(sender.getPersonID());
            outRecord.setType("转出");
            outRecord.setAmount(-amount); // 支出记负数
            outRecord.setLocation("ONLINE");
            outRecord.setTransactionTime(now);
            outRecord.setPendingBalanceAfter(senderNewPending); // 注意用扣钱后的pending
            outRecord.setSenderPersonID(null); // 本人
            outRecord.setReceiverPersonID(receiver.getPersonID());
            outRecord.setRelatedToRecordID(null);
            outRecord.setDescription("你于" + new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(now)
                    + " 向 " + receiver.getName() + "(" + receiver.getPersonID() + ") 转出 " + amount + " 元");

            // 6.2. 转入方流水（receiver）
            TransactionRecord inRecord = new TransactionRecord();
            inRecord.setPersonID(receiver.getPersonID());
            inRecord.setType("转入");
            inRecord.setAmount(amount); // 收入记正数
            inRecord.setLocation("ONLINE");
            inRecord.setTransactionTime(now);
            inRecord.setPendingBalanceAfter(receiverNewPending); // 加钱后的pending
            inRecord.setSenderPersonID(sender.getPersonID());
            inRecord.setReceiverPersonID(null); // 本人
            inRecord.setRelatedToRecordID(null);
            inRecord.setDescription("你于" + new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(now)
                    + " 收到 " + sender.getName() + "(" + sender.getPersonID() + ") 转账 " + amount + " 元");

            // 插入两条记录
            boolean rec1 = recordService.insertRecord(outRecord);
            boolean rec2 = recordService.insertRecord(inRecord);

            if (rec1 && rec2) {
                out.write("{\"success\":true, \"msg\":\"转账成功！\"}");
            } else {
                out.write("{\"success\":false, \"msg\":\"转账成功但流水记录失败！\"}");
            }

        } else {
            out.write("{\"success\":false, \"msg\":\"转账失败，系统异常！\"}");
        }
    }
}