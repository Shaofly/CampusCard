package com.mag.domain;

import java.util.Date;

public class TransactionRecord {
    private int recordID;               // 主键
    private String personID;               // 对应校园卡personID
    private String type;                // 交易类型，消费/充值/转入/转出/退款
    private double amount;              // 金额，正数为收入，负数为支出
    private String location;            // 交易地点（如果是线上转账，则地点为“ONLINE”）
    private Date transactionTime;       // 交易时间
    private double pendingBalanceAfter; // 交易后卡内待圈存余额
    private String senderPersonID;      // 转账人：如果是线上转账入，此项值为转账人的“personID”，否则为null
    private String receiverPersonID;    // 被转账人：如果是线上转出，此项值为收款人的“personID”，否则为null
    private String relatedToRecordID;   // 退款的流水‘recordID’，如果流水类型不为退款，则为null
    private String description;         // 流水消息，自动生成。
    // 如果类型是消费："你于‘transitionTime’在‘location’消费‘amount’元"
    // 如果类型是充值："你于‘transitionTime’充值‘amount’元"
    // 如果类型是转入："你于‘transitionTime’收到‘senderPersonID’转账‘amount’元"
    // 如果类型是转出："你于‘transitionTime’向‘receiverPersonID’转出‘amount’元"
    // 如果类型是退款："你于‘transitionTime’收到退款‘amount’元，原订单编号为‘relatedToRecordID’"

    public TransactionRecord(){}

    public TransactionRecord(int recordID, String personID, String type, double amount,
                             String location, Date transactionTime, double pendingBalanceAfter,
                             String senderPersonID, String receiverPersonID, String relatedToRecordID,
                             String description) {
        this.recordID = recordID;
        this.personID = personID;
        this.type = type;
        this.amount = amount;
        this.location = location;
        this.transactionTime = transactionTime;
        this.pendingBalanceAfter = pendingBalanceAfter;
        this.senderPersonID = senderPersonID;
        this.receiverPersonID = receiverPersonID;
        this.relatedToRecordID = relatedToRecordID;
        this.description = description;
    }

    //recordID
    public int getRecordID() {
        return recordID;
    }
    public void setRecordID(int recordID) {
        this.recordID = recordID;
    }
    //personID
    public String getPersonID() {
        return personID;
    }
    public void setPersonId(String personID) {
        this.personID = personID;
    }
    //amount
    public double getAmount() {
        return amount;
    }
    public void setAmount(double amount) {
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
    //pendingBalanceAfter
    public double getPendingBalanceAfter() {
        return pendingBalanceAfter;
    }
    public void setPendingBalanceAfter(double pendingBalanceAfter) {
        this.pendingBalanceAfter = pendingBalanceAfter;
    }

    public void setPersonID(String personID) {
        this.personID = personID;
    }

    public String getSenderPersonID() {
        return senderPersonID;
    }

    public void setSenderPersonID(String senderPersonID) {
        this.senderPersonID = senderPersonID;
    }

    public String getReceiverPersonID() {
        return receiverPersonID;
    }

    public void setReceiverPersonID(String receiverPersonID) {
        this.receiverPersonID = receiverPersonID;
    }

    public String getRelatedToRecordID() {
        return relatedToRecordID;
    }

    public void setRelatedToRecordID(String relatedToRecordID) {
        this.relatedToRecordID = relatedToRecordID;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "TransactionRecord{" +
                "recordID=" + recordID +
                ", personID='" + personID + '\'' +
                ", type='" + type + '\'' +
                ", amount=" + amount +
                ", location='" + location + '\'' +
                ", transactionTime=" + transactionTime +
                ", pendingBalanceAfter=" + pendingBalanceAfter +
                ", senderPersonID='" + senderPersonID + '\'' +
                ", receiverPersonID='" + receiverPersonID + '\'' +
                ", relatedToRecordID='" + relatedToRecordID + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}
