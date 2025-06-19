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
        return cardDAO.findCardByPersonID(personID);
    }
    // 根据cardID查询CampusCard对象
    public CampusCard findCardByCardID(String cardID) {
        return cardDAO.findCardByCardID(cardID);
    }
    //--------------------------------------------

    // 新增一张CampusCard
    public boolean addCard(CampusCard card) {
        return cardDAO.insertCard(card);
    }

    // 更新卡信息
    public boolean updateCard(CampusCard card){
        return cardDAO.updateCard(card);
    }

    // 修改卡状态：正常/挂失/冻结/
    public boolean updateCardStatus(String cardID, String newStatus) {
        return cardDAO.updateCardStatus(cardID, newStatus);
    }

    public boolean updatePendingBalance(String personID, double newPending){
        return cardDAO.updatePendingBalance(personID,newPending);
    }

    // 彻底删除卡信息
    public boolean deleteCard(String cardID){
        return cardDAO.deleteCard(cardID);
    }

    // 分页查询
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
