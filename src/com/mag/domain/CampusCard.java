package com.mag.domain;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

public class CampusCard {
    private int recordID;                 // 数据库主键，记录号，从0开始自增
    private String cardID;              // 校园卡号；4位“CARD”前缀+6位年月日+6位时分秒+3位随机数：CARD20240528142300123
    private String personID;            // 学号/教职工号；十位数字，例如2023211098
    private String name;                // 姓名
    private String gender;              // 性别：男/女
    private String avatar;              // 头像路径（如 /images/avatar123.jpg）
    private String department;          // 院系：学院全称
    private String major;               // 专业：专业全称
    private String grade;               // 年级：20xx级
    private String className;           // 班级：班级简称
    private double balance;             // 校园卡余额：保留两位小数
    private double pendingBalance;      // 待圈存余额：同上
    private int maxLimit;               // 单次消费限额，大于30需验证支付密码
    private String password;            // 登录密码：至少有一个大写字母、小写字母、数字，允许特殊字符"_"和"."，至少8位
    private String passwordPay;         // 支付密码，大于30元需要验证；默认是身份证号后六位
    private boolean isOnlineTransfer;   // 是否支持在线转账（微信、支付宝）
    private String status;              // 卡状态（正常/挂失/冻结/注销）
    private String cardType;            // 卡类型（正常/临时）
    private String role;                // 卡所属人身份（学生/教室/后勤/附属中小学生）
    private String campusLocation;      // 校区位置（合肥校区/宣城校区）
    private Date registerDate;          // 开卡日期（输入输出标准YYYY-MM-DD）
    private String phoneNumber;         // 手机号
    private String IDNumber;            // 身份证号 最多18位，考虑留学生
    private String email;               // 邮箱 必须有@
    private String message;             // 消息通知 无消息为空
    private boolean isAdmin;            // 是否为系统管理员

    //默认构造函数
    public CampusCard() {
        this.isAdmin=false;
        this.isOnlineTransfer=false;
        this.avatar=null;
        this.message=null;
    }

    //recordID
    public int getRecordID() {
        return recordID;
    }
    public void setRecordID(int recordID) {
        this.recordID = recordID;
    }

    //cardID
    public String getCardID() {
        return cardID;
    }
    public void setCardID(String cardID) {
        this.cardID = cardID;
    }

    //personID
    public String getPersonID(){
        return personID;
    }
    public void setPersonID(String personID) {
        this.personID = personID;
    }

    //name
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    //gender
    public String getGender() {
        return gender;
    }
    public void setGender(String gender) {
        this.gender = gender;
    }

    //avatar
    public String getAvatar(){
        return avatar;
    }
    public void setAvatar(String avatar){
        this.avatar = avatar;
    }

    //department
    public String getDepartment() {
        return department;
    }
    public void setDepartment(String department) {
        this.department = department;
    }

    //major
    public String getMajor() {
        return major;
    }
    public void setMajor(String major) {
        this.major = major;
    }

    //grade
    public String getGrade() {
        return grade;
    }
    public void setGrade(String grade) {
        this.grade = grade;
    }

    //className
    public String getClassName() {
        return className;
    }
    public void setClassName(String className) {
        this.className = className;
    }

    //balance
    public double getBalance() {
        return balance;
    }
    public void setBalance(double balance) {
        this.balance = balance;
    }

    //pendingBalance
    public double getPendingBalance() {
        return pendingBalance;
    }
    public void setPendingBalance(double pendingBalance) {
        this.pendingBalance = pendingBalance;
    }

    //maxLimit
    public int getMaxLimit() {
        return maxLimit;
    }
    public void setMaxLimit(int maxLimit) {
        this.maxLimit = maxLimit;
    }

    //password
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    //passwordPay
    public String getPasswordPay() {
        return passwordPay;
    }
    public void setPasswordPay(String passwordPay) {
        this.passwordPay = passwordPay;
    }

    //isOnlineTransfer
    public boolean isOnlineTransfer() {
        return isOnlineTransfer;
    }
    public void setOnlineTransfer(boolean onlineTransfer) {
        isOnlineTransfer = onlineTransfer;
    }

    //status
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    //cardType
    public String getCardType() {
        return cardType;
    }
    public void setCardType(String cardType) {
        this.cardType = cardType;
    }

    //role
    public String getRole() {
        return role;
    }
    public void setRole(String role) {
        this.role = role;
    }

    //campusLocation
    public String getCampusLocation() {
        return campusLocation;
    }
    public void setCampusLocation(String campusLocation) {
        this.campusLocation = campusLocation;
    }

    //registerDate-------------------------
    public Date getRegisterDate() {
        return registerDate;
    }
    public void setRegisterDate(Date registerDate) {
        this.registerDate = registerDate;
    }
    //Getter（格式化字符串）
    public String getRegisterDateString() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(registerDate);
    }
    //Setter（表单字符串 -> Date）
    public void setRegisterDate(String registerDate) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            this.registerDate = sdf.parse(registerDate);
        } catch (ParseException e) {
            System.out.println("日期格式错误：" + e.getMessage());
        }
    }
    //---------------------------------------

    //phoneNumber
    public String getPhoneNumber() {
        return phoneNumber;
    }
    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    //IDNumber
    public String getIDNumber() {
        return IDNumber;
    }
    public void setIDNumber(String IDNumber) {
        this.IDNumber = IDNumber;
    }

    //email
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    //message
    public String getMessage() {
        return message;
    }
    public void setMessage(String message) {
        this.message = message;
    }

    //isAdmin
    public boolean isAdmin() {
        return isAdmin;
    }
    public void setAdmin(boolean isAdmin) {
        this.isAdmin = isAdmin;
    }

    // 自动设置卡号与开卡时间方法
    public static CampusCard createWithAutoFields() {
        CampusCard card = new CampusCard();
        card.setRegisterDate(new Date());
        card.setCardID(generateCardID(card.getRegisterDate()));
        return card;
    }

    // 生成唯一卡号
    public static String generateCardID(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String prefix = "CARD";
        String timePart = sdf.format(date != null ? date : new Date());
        int random = new Random().nextInt(900) + 100; // 100~999
        return prefix + timePart + random;
    }

}
