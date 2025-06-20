package com.mag.service;

import com.mag.dao.CardDAO;
import com.mag.domain.CampusCard;

public class LoginService {
    private final CardDAO cardDAO = new CardDAO();

    // 获取当前用户完整信息
    public CampusCard getCard(String personID) {
        return cardDAO.findCardByPersonID(personID,"正常","挂失");
    }

    // 判断登录的账号密码是否正确
    public boolean login(String personID, String password) {
        CampusCard tempCard = cardDAO.findCardByPersonID(personID,"正常","挂失");
        if (tempCard == null) {
            return false;  // 账号不存在
        }
        return password != null && password.equals(tempCard.getPassword());
    }

    // 判断学号/工号账户是否拥有管理员权限
    public boolean isAdmin(String personID){
        CampusCard tempCard = cardDAO.findCardByPersonID(personID,"正常","挂失");
        return tempCard != null && tempCard.isAdmin();
    }

    // 检查账户是否存在（用于登录输入账户时实时验证）
    public boolean accountExists(String personID) {
        return cardDAO.findCardByPersonID(personID,"正常","挂失") != null;
    }
}
