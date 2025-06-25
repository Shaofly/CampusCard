package com.mag.dao;

import com.mag.domain.Announcement;
import com.mag.util.SqlHelper;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AnnouncementDAO {

    // 添加公告
    public boolean addAnnouncement(Announcement ann) {
        String sql = "INSERT INTO announcement (title, content, author, announcementDate, importance) VALUES (?, ?, ?, ?, ?)";
        String[] params = {
                ann.getTitle(),
                ann.getContent(),
                ann.getAuthor(),
                ann.getAnnouncementDate().toString(),
                String.valueOf(ann.getImportance())
        };
        try {
            SqlHelper.executeUpdate(sql, params);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 查询所有公告
    public List<Announcement> getAllAnnouncements() {
        String sql = "SELECT * FROM announcement ORDER BY importance ASC, announcementDate DESC";
        List<Announcement> list = new ArrayList<>();
        ResultSet rs = null;
        try {
            rs = SqlHelper.executeQuery(sql, null);
            while (rs.next()) {
                Announcement ann = new Announcement();
                ann.setRecordID(rs.getInt("recordID"));
                ann.setTitle(rs.getString("title"));
                ann.setContent(rs.getString("content"));
                ann.setAuthor(rs.getString("author"));
                ann.setAnnouncementDate(rs.getDate("announcementDate"));
                ann.setImportance(rs.getInt("importance"));
                list.add(ann);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            SqlHelper.close(SqlHelper.getCt(), SqlHelper.getPs(), SqlHelper.getRs());
        }
        return list;
    }

    // 根据ID查询公告
    public Announcement getAnnouncementById(int id) {
        String sql = "SELECT * FROM announcement WHERE recordID = ?";
        String[] params = { String.valueOf(id) };
        ResultSet rs = null;
        try {
            rs = SqlHelper.executeQuery(sql, params);
            if (rs.next()) {
                Announcement ann = new Announcement();
                ann.setRecordID(rs.getInt("recordID"));
                ann.setTitle(rs.getString("title"));
                ann.setContent(rs.getString("content"));
                ann.setAuthor(rs.getString("author"));
                ann.setAnnouncementDate(rs.getDate("announcementDate"));
                ann.setImportance(rs.getInt("importance"));
                return ann;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            SqlHelper.close(SqlHelper.getCt(), SqlHelper.getPs(), SqlHelper.getRs());
        }
        return null;
    }

    // 删除公告
    public boolean deleteAnnouncement(int id) {
        String sql = "DELETE FROM announcement WHERE recordID = ?";
        String[] params = { String.valueOf(id) };
        try {
            SqlHelper.executeUpdate(sql, params);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 修改公告
    public boolean updateAnnouncement(Announcement ann) {
        String sql = "UPDATE announcement SET title=?, content=?, author=?, announcementDate=?, importance=? WHERE recordID=?";
        String[] params = {
                ann.getTitle(),
                ann.getContent(),
                ann.getAuthor(),
                ann.getAnnouncementDate().toString(), // 根据你的Date类型调整
                String.valueOf(ann.getImportance()),
                String.valueOf(ann.getRecordID())
        };
        try {
            SqlHelper.executeUpdate(sql, params);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}