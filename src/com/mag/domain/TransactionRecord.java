package com.mag.domain;

import java.util.Date;

public class TransactionRecord {
    private int recordID;               // 主键
    private int personID;               // 对应校园卡personID
    private String type;                // 交易类型，消费/支出
    private int amount;                 // 金额，正数为收入，负数为支出
    private String location;            // 交易地点
    private Date transactionTime;       // 交易时间
    private double balanceAfter;        // 交易后卡内余额

    //recordID
    public int getRecordID() {
        return recordID;
    }
    public void setRecordID(int recordID) {
        this.recordID = recordID;
    }
    //personID
    public int getPersonID() {
        return personID;
    }
    public void setPersonId(int personID) {
        this.personID = personID;
    }
    //amount
    public int getAmount() {
        return amount;
    }
    public void setAmount(int amount) {
        this.amount = amount;
    }
    //type
    public String getType() {
        return type;
    }
    public void setType(String type) {
        this.type = type;
    }
    //location
    public String getLocation() {
        return location;
    }
    public void setLocation(String location) {
        this.location = location;
    }
    //transactionTime
    public Date getTransactionTime() {
        return transactionTime;
    }
    public void setTransactionTime(Date transactionTime) {
        this.transactionTime = transactionTime;
    }
    //balanceAfter
    public double getBalanceAfter() {
        return balanceAfter;
    }
    public void setBalanceAfter(double balanceAfter) {
        this.balanceAfter = balanceAfter;
    }
}
