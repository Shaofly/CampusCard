package com.mag.dao;

import com.mag.domain.CampusCard;
import com.mag.util.SqlHelper;

import java.sql.ResultSet;

public class CardDAO {

    // 默认构造函数
    public CardDAO() {}

    // 根据personID查询CampusCard信息
    public CampusCard findCardByPersonID(String personID){
        String sql = "SELECT * FROM CampusCard_Info WHERE personID = ? AND status = ?";
        String[] parameters = { personID , "正常"};
        CampusCard card = null;
        ResultSet rs = null;

        try {
            rs = SqlHelper.executeQuery(sql, parameters);
            if (rs.next()) {
                card = new CampusCard();
                card.setRecordID(rs.getInt("recordID"));
                card.setCardID(rs.getString("cardID"));
                card.setPersonID(rs.getString("personID"));
                card.setName(rs.getString("name"));
                card.setGender(rs.getString("gender"));
                card.setAvatar(rs.getString("avatar"));
                card.setDepartment(rs.getString("department"));
                card.setMajor(rs.getString("major"));
                card.setGrade(rs.getString("grade"));
                card.setClassName(rs.getString("className"));
                card.setBalance(rs.getDouble("balance"));
                card.setPendingBalance(rs.getDouble("pendingBalance"));
                card.setMaxLimit(rs.getInt("maxLimit"));
                card.setPassword(rs.getString("password"));
                card.setPasswordPay(rs.getString("passwordPay"));
                card.setOnlineTransfer(rs.getBoolean("isOnlineTransfer"));
                card.setStatus(rs.getString("status"));
                card.setCardType(rs.getString("cardType"));
                card.setRole(rs.getString("role"));
                card.setCampusLocation(rs.getString("campusLocation"));
                card.setRegisterDate(rs.getDate("registerDate"));
                card.setPhoneNumber(rs.getString("phoneNumber"));
                card.setIDNumber(rs.getString("IDNumber"));
                card.setEmail(rs.getString("email"));
                card.setMessage(rs.getString("message"));
                card.setAdmin(rs.getBoolean("isAdmin"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            SqlHelper.close(SqlHelper.getCt(), SqlHelper.getPs(), SqlHelper.getRs());
        }
        return card;
    }

    // 根据cardID查询CampusCard信息
    public CampusCard findCardByCardID(String cardID){
        String sql = "SELECT * FROM CampusCard_Info WHERE cardID = ?";
        String[] parameters = { cardID };
        CampusCard card = null;
        ResultSet rs = null;

        try{
            rs = SqlHelper.executeQuery(sql, parameters);
            if (rs.next()) {
                card = new CampusCard();
                card.setRecordID(rs.getInt("recordID"));
                card.setCardID(rs.getString("cardID"));
                card.setPersonID(rs.getString("personID"));
                card.setName(rs.getString("name"));
                card.setGender(rs.getString("gender"));
                card.setAvatar(rs.getString("avatar"));
                card.setDepartment(rs.getString("department"));
                card.setMajor(rs.getString("major"));
                card.setGrade(rs.getString("grade"));
                card.setClassName(rs.getString("className"));
                card.setBalance(rs.getDouble("balance"));
                card.setPendingBalance(rs.getDouble("pendingBalance"));
                card.setMaxLimit(rs.getInt("maxLimit"));
                card.setPassword(rs.getString("password"));
                card.setPasswordPay(rs.getString("passwordPay"));
                card.setOnlineTransfer(rs.getBoolean("isOnlineTransfer"));
                card.setStatus(rs.getString("status"));
                card.setCardType(rs.getString("cardType"));
                card.setRole(rs.getString("role"));
                card.setCampusLocation(rs.getString("campusLocation"));
                card.setRegisterDate(rs.getDate("registerDate"));
                card.setPhoneNumber(rs.getString("phoneNumber"));
                card.setIDNumber(rs.getString("IDNumber"));
                card.setEmail(rs.getString("email"));
                card.setMessage(rs.getString("message"));
                card.setAdmin(rs.getBoolean("isAdmin"));
            }
        }
        catch(Exception e){
            e.printStackTrace();
        }finally{
            SqlHelper.close(SqlHelper.getCt(), SqlHelper.getPs(), SqlHelper.getRs());
        }
        return card;
    }

    // 新增一条CampusCard
    public boolean insertCard(CampusCard card){
        String sql = "INSERT INTO CampusCard_Info (cardID, personID, name, gender, avatar, department, major, grade, className, balance, pendingBalance, maxLimit, password, passwordPay, isOnlineTransfer, status, cardType, role, campusLocation, registerDate, phoneNumber, IDNumber, email, message, isAdmin) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        String[] params = {
                card.getCardID(),
                card.getPersonID(),
                card.getName(),
                card.getGender(),
                card.getAvatar(),
                card.getDepartment(),
                card.getMajor(),
                card.getGrade(),
                card.getClassName(),
                String.valueOf(card.getBalance()),
                String.valueOf(card.getPendingBalance()),
                String.valueOf(card.getMaxLimit()),
                card.getPassword(),
                card.getPasswordPay(),
                String.valueOf(card.isOnlineTransfer()),
                card.getStatus(),
                card.getCardType(),
                card.getRole(),
                card.getCampusLocation(),
                card.getRegisterDateString(),  // 转换为 "yyyy-MM-dd"
                card.getPhoneNumber(),
                card.getIDNumber(),
                card.getEmail(),
                card.getMessage(),
                String.valueOf(card.isAdmin())
        };

        try {
            SqlHelper.executeUpdate(sql, params);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 更新CampusCard在数据库的信息
    public boolean updateCard(CampusCard card){
        String sql = "UPDATE CampusCard_Info SET " +
                "name=?, gender=?, avatar=?, department=?, major=?, grade=?, className=?, " +
                "balance=?, pendingBalance=?, maxLimit=?, password=?, passwordPay=?, " +
                "isOnlineTransfer=?, status=?, cardType=?, role=?, campusLocation=?, " +
                "registerDate=?, phoneNumber=?, IDNumber=?, email=?, message=?, isAdmin=? " +
                "WHERE personID=?";

        String[] parameters = {
                card.getName(),
                card.getGender(),
                card.getAvatar(),
                card.getDepartment(),
                card.getMajor(),
                card.getGrade(),
                card.getClassName(),
                String.valueOf(card.getBalance()),
                String.valueOf(card.getPendingBalance()),
                String.valueOf(card.getMaxLimit()),
                card.getPassword(),
                card.getPasswordPay(),
                String.valueOf(card.isOnlineTransfer()),
                card.getStatus(),
                card.getCardType(),
                card.getRole(),
                card.getCampusLocation(),
                card.getRegisterDateString(), // 格式化日期为 yyyy-MM-dd
                card.getPhoneNumber(),
                card.getIDNumber(),
                card.getEmail(),
                card.getMessage(),
                String.valueOf(card.isAdmin()),
                card.getPersonID()
        };

        try {
            SqlHelper.executeUpdate(sql, parameters);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 根据 cardID 将校园卡状态设置为 newStatus
    public boolean updateCardStatus(String cardID, String newStatus) {
        String sql = "UPDATE CampusCard_Info SET status = ? WHERE cardID = ?";
        String[] params = { newStatus, cardID };

        try {
            SqlHelper.executeUpdate(sql, params);
            return true;
        } catch (Exception e) {
            System.out.println("更新卡状态失败：" + e.getMessage());
            return false;
        }
    }

    // 根据 cardID 删除 CampusCard 记录
    public boolean deleteCard(String cardID) {
        String sql = "DELETE FROM CampusCard_Info WHERE cardID = ?";
        String[] parameters = { cardID };

        try {
            SqlHelper.executeUpdate(sql, parameters);
            return true;
        } catch (Exception e) {
            System.out.println("删除校园卡信息失败：" + e.getMessage());
            return false;
        }
    }


}
