package com.mag.service;

import com.mag.dao.TransactionRecordDAO;
import com.mag.domain.TransactionRecord;

import java.util.List;

public class TransactionRecordService {

    private final TransactionRecordDAO recordDAO = new TransactionRecordDAO();

    public TransactionRecordService() {}

    // 新增一条交易记录
    public boolean addRecord(TransactionRecord record) {
        return recordDAO.insertRecord(record);
    }

    // 根据personID查询全部交易记录（时间倒序）
    public List<TransactionRecord> getAllRecordsByPersonID(String personID) {
        return recordDAO.findRecordsByPersonID(personID);
    }

    // 查询最近50条记录
    public List<TransactionRecord> getRecentRecords(String personID) {
        return recordDAO.findRecentRecords(personID);
    }

    // 根据recordID删除一条交易记录
    public boolean deleteRecord(int recordID) {
        return recordDAO.deleteRecordByID(recordID);
    }
}