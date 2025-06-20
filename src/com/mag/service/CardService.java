package com.mag.service;

import com.mag.dao.CardDAO;
import com.mag.domain.CampusCard;

import java.util.List;

public class CardService {
    private final CardDAO cardDAO = new CardDAO();

    public CardService() {}

    // 查询--------------------------------------------
    // 根据personID查询CampusCard对象
    public CampusCard findCardByPersonID(String personID) {
        return cardDAO.findCardByPersonID(personID,"正常","挂失");
    }
    // 根据cardID查询CampusCard对象
    public CampusCard findCardByCardID(String cardID) {
        return cardDAO.findCardByCardID(cardID);
    }
    //--------------------------------------------

    // 新增一张CampusCard
    public boolean addCard(CampusCard card) {
        CampusCard oldCard = cardDAO.findCardByPersonID(card.getPersonID(), "正常", "挂失");
        boolean updateOld = true;
        if (oldCard != null) {
            // 注销旧卡
            updateOld = cardDAO.updateCardStatus(oldCard.getCardID(), "注销");
        }
        // 设置新卡状态为正常
        card.setStatus("正常");
        // 插入新卡
        boolean insertNew = cardDAO.insertCard(card);

        // 只有旧卡状态更新成功 且 新卡插入成功才算成功
        return updateOld && insertNew;
    }

    // 更新卡信息
    public boolean updateCard(CampusCard card){
        return cardDAO.updateCardByCardID(card);
    }

    // 修改卡状态：正常/挂失/冻结/注销
    public boolean updateCardStatus(String cardID, String newStatus) {
        return cardDAO.updateCardStatus(cardID, newStatus);
    }

    public boolean cancelCard(String cardID){
        if(findCardByCardID(cardID).getStatus().equals("注销")){
            return false;
        }else {
            return cardDAO.updateCardStatus(cardID,"注销");
        }
    }

    public boolean updatePendingBalance(String personID, double newPending){
        return cardDAO.updatePendingBalance(personID,newPending);
    }

    // 彻底删除卡信息
    public boolean deleteCard(String cardID){
        return cardDAO.deleteCard(cardID);
    }

    // 分页+关键词模糊搜索（按学号升序、注册日期降序）
    public List<CampusCard> searchCards(String keyword, int currentPage, int pageSize) {
        // 参数校验与默认值
        if (currentPage <= 0) currentPage = 1;
        if (pageSize <= 0) pageSize = 10;
        // keyword 允许为空字符串
        return cardDAO.findCardsByKeywordAndPage(keyword, currentPage, pageSize);
    }

    // 返回模糊搜索总条数（分页控件用）
    public int countCardsByKeyword(String keyword) {
        return cardDAO.countCardsByKeyword(keyword);
    }

    // 无条件的分页查询
    public List<CampusCard> findCardsByPage(int currentPage, int pageSize) {
        return cardDAO.findCardsByPage(currentPage, pageSize);
    }

    // 查询总卡数
    public int countAllCards() {
        return cardDAO.countAllCards();
    }

    // 查询总金额（所有正常卡）
    public double sumAllNormalBalance(){
        return cardDAO.sumAllNormalBalance();
    }

}
