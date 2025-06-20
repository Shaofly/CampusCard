package com.mag.domain;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Announcement {
    private int recordID;               // 主键，自增
    private String title;               // 标题
    private String content;             // 正文
    private String author;              // 作者（默认为“系统”）
    private Date announcementDate;    // 日期（YYYY-MM-DD）

    public int getRecordID() {
        return recordID;
    }

    public void setRecordID(int recordID) {
        this.recordID = recordID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public Date getAnnouncementDate() {
        return announcementDate;
    }

    public void setAnnouncementDate(Date announcementDate) {
        this.announcementDate = announcementDate;
    }
    
    public String getAnnouncementDateString(){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(announcementDate);
    }
}
