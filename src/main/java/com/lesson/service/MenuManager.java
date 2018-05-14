package com.lesson.service;

import com.lesson.model.Menu;

import java.util.List;

public interface MenuManager {
    public List<Menu> getAllMenus();

    public List<Menu> getMenusByMidCid(String mid, String cid);

    public Menu getMenuByMid(String mid);

    public int addMenu(int cid, String mname, float price);

    public int updateMenuByMid(int mid, int cid, String mname, float price);

    public int deleteMenuByMid(int mid);
}
