package com.mag.dao;

import com.mag.domain.TransactionRecord;
import com.mag.util.SqlHelper;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class TransactionRecordDAO {

    // 新增一条交易记录
    public boolean insertRecord(TransactionRecord record) {
        String sql = "INSERT INTO TransactionRecord_Info (personID, type, amount, location, transactionTime, pendingBalanceAfter) " +
                "VALUES (?, ?, ?, ?, ?, ?)";
        String[] parameters = {
                record.getPersonID() + "",
                record.getType(),
                record.getAmount() + "",
                record.getLocation(),
                new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(record.getTransactionTime()),
                record.getPendingBalanceAfter() + ""
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
                record.setPersonId(rs.getString("personID"));
                record.setType(rs.getString("type"));
                record.setAmount(rs.getInt("amount"));
                record.setLocation(rs.getString("location"));
                record.setTransactionTime(rs.getTimestamp("transactionTime"));
                record.setPendingBalanceAfter(rs.getDouble("pendingBalanceAfter"));
                list.add(record);
            }
        } catch (Exception e) {
            System.out.println("查询交易记录失败：" + e.getMessage());
        } finally {
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

    // 查询最近50条记录
    public List<TransactionRecord> findRecentRecords(String personID) {
        String sql = "SELECT * FROM TransactionRecord_Info WHERE personID = ? ORDER BY transactionTime DESC LIMIT 50";
        String[] parameters = { personID };
        ResultSet rs = null;
        List<TransactionRecord> list = new ArrayList<>();

        try {
            rs = SqlHelper.executeQuery(sql, parameters);
            while (rs.next()) {
                TransactionRecord record = new TransactionRecord();
                record.setRecordID(rs.getInt("recordID"));
                record.setPersonId(rs.getString("personID"));
                record.setType(rs.getString("type"));
                record.setAmount(rs.getInt("amount"));
                record.setLocation(rs.getString("location"));
                record.setTransactionTime(rs.getTimestamp("transactionTime"));
                record.setPendingBalanceAfter(rs.getDouble("pendingBalanceAfter"));
                list.add(record);
            }
        } catch (Exception e) {
            System.out.println("查询最近50条交易记录失败：" + e.getMessage());
        } finally {
            SqlHelper.close(SqlHelper.getCt(), SqlHelper.getPs(), SqlHelper.getRs());
        }
        return list;
    }
}
