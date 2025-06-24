package com.mag.servlet;

import com.mag.domain.TransactionRecord;
import com.mag.service.TransactionRecordService;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.List;

public class RecentTransactionServlet extends HttpServlet {
    private final TransactionRecordService recordService = new TransactionRecordService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String personID = request.getParameter("personID");
        if (personID == null || personID.trim().isEmpty()) {
            out.print("{\"success\":false,\"msg\":\"参数缺失\"}");
            out.close();
            return;
        }

        try {
            List<TransactionRecord> list = recordService.getRecentRecords(personID, 10);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

            StringBuilder sb = new StringBuilder();
            sb.append("{\"success\":true,\"data\":[");
            for (int i = 0; i < list.size(); i++) {
                TransactionRecord tr = list.get(i);
                if (i > 0) sb.append(",");
                sb.append("{")
                        .append("\"recordID\":").append(tr.getRecordID()).append(",")
                        .append("\"type\":\"").append(tr.getType()).append("\",")
                        .append("\"transactionTime\":\"").append(sdf.format(tr.getTransactionTime())).append("\",")
                        .append("\"location\":\"").append(tr.getLocation()).append("\"")
                        .append("}");
            }
            sb.append("]}");
            out.print(sb.toString());
        } catch (Exception e) {
            out.print("{\"success\":false,\"msg\":\"服务器异常: " + e.getMessage() + "\"}");
        } finally {
            out.close();
        }
    }
}