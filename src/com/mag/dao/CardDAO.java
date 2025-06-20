package com.mag.dao;

import com.mag.domain.CampusCard;
import com.mag.util.SqlHelper;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CardDAO {

    // 默认构造函数
    public CardDAO() {}

    // 根据personID和状态（两种都要）查询CampusCard信息
    public CampusCard findCardByPersonID(String personID,String status1,String status2){
        String sql = "SELECT * FROM CampusCard_Info WHERE personID = ? AND (status = ? OR status = ?)";
        String[] parameters = { personID , status1, status2};
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

    // 根据personID和一种状态查询CampusCard信息
    public CampusCard findCardByPersonID(String personID,String status){
        String sql = "SELECT * FROM CampusCard_Info WHERE personID = ? AND status = ? ";
        String[] parameters = { personID , status};
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
                card.isOnlineTransfer() ? "1" : "0",
                card.getStatus(),
                card.getCardType(),
                card.getRole(),
                card.getCampusLocation(),
                card.getRegisterDateString(),  // 转换为 "yyyy-MM-dd"
                card.getPhoneNumber(),
                card.getIDNumber(),
                card.getEmail(),
                card.getMessage(),
                card.isAdmin() ? "1" : "0", //true如果转为String无法导入sql
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
    public boolean updateCardByCardID(CampusCard card){
        String sql = "UPDATE CampusCard_Info SET " +
                "name=?, gender=?, avatar=?, department=?, major=?, grade=?, className=?, " +
                "balance=?, pendingBalance=?, maxLimit=?, password=?, passwordPay=?, " +
                "isOnlineTransfer=?, status=?, cardType=?, role=?, campusLocation=?, " +
                "registerDate=?, phoneNumber=?, IDNumber=?, email=?, message=?, isAdmin=? " +
                "WHERE cardID=?";

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
                card.isOnlineTransfer() ? "1" : "0",
                card.getStatus(),
                card.getCardType(),
                card.getRole(),
                card.getCampusLocation(),
                card.getRegisterDateString(), // 格式化日期为 yyyy-MM-dd
                card.getPhoneNumber(),
                card.getIDNumber(),
                card.getEmail(),
                card.getMessage(),
                card.isAdmin() ? "1" : "0",
                card.getCardID()
        };

        try {
            int result = SqlHelper.executeUpdateReturnCount(sql, parameters);
            System.out.println("执行updateCard SQL影响行数：" + result);
            System.out.println("参数：" + java.util.Arrays.toString(parameters));
            return result > 0;
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

    // 修改pendingBalance
    public boolean updatePendingBalance(String personID, double newPending) {
        String sql = "UPDATE CampusCard_Info SET pendingBalance=? WHERE personID=?";
        String[] parameters = { String.valueOf(newPending), personID };
        try {
            SqlHelper.executeUpdate(sql, parameters);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
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

    // 获取某一页的卡片列表
    // 这一部分实在是太寒酸了，LIMIT的bug修了整整两个小时，不许忘记。。。。
    public List<CampusCard> findCardsByPage(int currentPage, int pageSize) {
        List<CampusCard> cards = new ArrayList<>();
//        String sql = "SELECT * FROM CampusCard_Info ORDER BY personID LIMIT ?, ?";
        int offset = (currentPage - 1) * pageSize;
//        String[] params = { String.valueOf(offset),String.valueOf(pageSize) };
        String sql = "SELECT * FROM CampusCard_Info ORDER BY personID LIMIT " + offset + ", " + pageSize;
        ResultSet rs = null;
        try {
//            rs = SqlHelper.executeQuery(sql, params);
            rs = SqlHelper.executeQuery(sql, null);

            System.out.println("开始遍历结果集");// 找bug用的
            while (rs.next()) {
                CampusCard card = new CampusCard();
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
                cards.add(card);
                System.out.println("查到一条记录：" + rs.getString("personID") + ", " + rs.getString("name"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            SqlHelper.close(SqlHelper.getCt(), SqlHelper.getPs(), SqlHelper.getRs());
        }
        return cards;
    }

    // 查询卡片总数
    public int countAllCards() {
        String sql = "SELECT COUNT(*) FROM CampusCard_Info";
        ResultSet rs = null;
        try {
            rs = SqlHelper.executeQuery(sql, null);
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            SqlHelper.close(SqlHelper.getCt(), SqlHelper.getPs(), SqlHelper.getRs());
        }
        return 0;
    }

    // 计算总金额
    public double sumAllNormalBalance() {
        String sql = "SELECT SUM(balance) AS total FROM CampusCard_Info WHERE status = '正常'";
        ResultSet rs = null;
        try {
            rs = SqlHelper.executeQuery(sql, null);
            if (rs.next()) {
                double total = rs.getDouble("total");
                System.out.println("查询正常卡总金额为：" + total);
                return total;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            SqlHelper.close(SqlHelper.getCt(), SqlHelper.getPs(), SqlHelper.getRs());
        }
        return 0.0;
    }

    // 模糊查找+分页
    public List<CampusCard> findCardsByKeywordAndPage(String keyword, int currentPage, int pageSize) {
        List<CampusCard> cards = new ArrayList<>();
        int offset = (currentPage - 1) * pageSize;

        // 构造模糊搜索SQL
        // 支持卡号、学号/工号、姓名三个字段的模糊匹配
        String sql = "SELECT * FROM CampusCard_Info " +
                "WHERE cardID LIKE ? OR personID LIKE ? OR name LIKE ? " +
                "ORDER BY personID ASC, registerDate DESC " +
                "LIMIT " + offset + ", " + pageSize;

        String fuzzy = "%" + (keyword == null ? "" : keyword.trim()) + "%";
        String[] params = {fuzzy, fuzzy, fuzzy};
        ResultSet rs = null;
        try {
            rs = SqlHelper.executeQuery(sql, params);
            while (rs.next()) {
                CampusCard card = new CampusCard();
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
                cards.add(card);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            SqlHelper.close(SqlHelper.getCt(), SqlHelper.getPs(), SqlHelper.getRs());
        }
        return cards;
    }

    public int countCardsByKeyword(String keyword) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM CampusCard_Info WHERE cardID LIKE ? OR personID LIKE ? OR name LIKE ?";
        String fuzzy = "%" + (keyword == null ? "" : keyword.trim()) + "%";
        String[] params = {fuzzy, fuzzy, fuzzy};
        ResultSet rs = null;
        try {
            rs = SqlHelper.executeQuery(sql, params);
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            SqlHelper.close(SqlHelper.getCt(), SqlHelper.getPs(), SqlHelper.getRs());
        }
        return count;
    }
}
