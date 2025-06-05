package com.mag.service;

import com.mag.dao.CardDAO;
import com.mag.domain.CampusCard;

import javax.smartcardio.Card;

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

    // 彻底删除卡信息
    public boolean deleteCard(String cardID){
        return cardDAO.deleteCard(cardID);
    }

}
