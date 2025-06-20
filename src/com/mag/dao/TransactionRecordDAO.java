package com.mag.dao;

import com.mag.domain.TransactionRecord;
import com.mag.util.SqlHelper;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class TransactionRecordDAO {

    // 新增一条交易记录
    public boolean insertRecord(TransactionRecord record) {
        String sql = "INSERT INTO TransactionRecord_Info " +
                "(personID, type, amount, location, transactionTime, pendingBalanceAfter, senderPersonID, receiverPersonID, relatedToRecordID, description) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        String[] parameters = {
                record.getPersonID(),
                record.getType(),
                String.valueOf(record.getAmount()),
                record.getLocation(),
                new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(record.getTransactionTime()),
                String.valueOf(record.getPendingBalanceAfter()),
                record.getSenderPersonID(),
                record.getReceiverPersonID(),
                record.getRelatedToRecordID(),
                record.getDescription()
        };
        try {
            SqlHelper.executeUpdate(sql, parameters);
            return true;
        } catch (Exception e) {
            System.out.println("插入交易记录失败：" + e.getMessage());
            return false;
        }
    }

    // 根据personID查询所有交易记录
    public List<TransactionRecord> findRecordsByPersonID(String personID) {
        String sql = "SELECT * FROM TransactionRecord_Info WHERE personID = ? ORDER BY transactionTime DESC";
        String[] parameters = { personID };
        ResultSet rs = null;
        List<TransactionRecord> list = new ArrayList<>();

        try {
            rs = SqlHelper.executeQuery(sql, parameters);
            while (rs.next()) {
                TransactionRecord record = new TransactionRecord();
                record.setRecordID(rs.getInt("recordID"));
                record.setPersonID(rs.getString("personID"));  // 方法名拼写要和你的类一致
                record.setType(rs.getString("type"));
                record.setAmount(rs.getDouble("amount"));      // 金额应为double
                record.setLocation(rs.getString("location"));
                record.setTransactionTime(rs.getTimestamp("transactionTime"));
                record.setPendingBalanceAfter(rs.getDouble("pendingBalanceAfter"));

                // 新增字段的处理
                record.setSenderPersonID(rs.getString("senderPersonID"));
                record.setReceiverPersonID(rs.getString("receiverPersonID"));
                record.setRelatedToRecordID(rs.getString("relatedToRecordID"));
                record.setDescription(rs.getString("description"));

                list.add(record);
            }
        } catch (Exception e) {
            System.out.println("查询交易记录失败：" + e.getMessage());
        } finally {
            // 这里建议不要用SqlHelper的静态变量关资源，应该传入rs再关（更安全）。
            SqlHelper.close(SqlHelper.getCt(), SqlHelper.getPs(), SqlHelper.getRs());
        }
        return list;
    }

    // 根据recordID删除交易记录
    public boolean deleteRecordByID(int recordID) {
        String sql = "DELETE FROM TransactionRecord_Info WHERE recordID = ?";
        String[] parameters = { recordID + "" };
        try {
            SqlHelper.executeUpdate(sql, parameters);
            return true;
        } catch (Exception e) {
            System.out.println("删除交易记录失败：" + e.getMessage());
            return false;
        }
    }

    // 查询某人最近N条流水
    public List<TransactionRecord> findRecentRecords(String personID, int limit) {
        String sql = "SELECT * FROM TransactionRecord_Info WHERE personID = ? ORDER BY transactionTime DESC LIMIT + limit";
        List<TransactionRecord> list = new ArrayList<>();
        ResultSet rs = null;
        try {
            // 注意参数顺序和类型
            String[] params = { personID };
            rs = SqlHelper.executeQuery(sql, params);
            while (rs.next()) {
                TransactionRecord record = new TransactionRecord();
                record.setRecordID(rs.getInt("recordID"));
                record.setPersonID(rs.getString("personID"));
                record.setType(rs.getString("type"));
                record.setAmount(rs.getDouble("amount"));
                record.setLocation(rs.getString("location"));
                record.setTransactionTime(rs.getTimestamp("transactionTime"));
                record.setPendingBalanceAfter(rs.getDouble("pendingBalanceAfter"));
                record.setSenderPersonID(rs.getString("senderPersonID"));
                record.setReceiverPersonID(rs.getString("receiverPersonID"));
                record.setRelatedToRecordID(rs.getString("relatedToRecordID"));
                record.setDescription(rs.getString("description"));
                list.add(record);
            }
        } catch (Exception e) {
            System.out.println("查询最近" + limit + "条交易记录失败：" + e.getMessage());
        } finally {
            SqlHelper.close(SqlHelper.getCt(), SqlHelper.getPs(), SqlHelper.getRs());
        }
        return list;
    }


}
