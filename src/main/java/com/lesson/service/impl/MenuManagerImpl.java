package com.lesson.service.impl;

import com.lesson.model.Menu;
import com.lesson.dao.MenuDAO;
import com.lesson.service.MenuManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MenuManagerImpl implements MenuManager {
    Logger logger = Logger.getLogger(MenuManagerImpl.class);

    @Autowired
    MenuDAO menuDAO;

    public List<Menu> getAllMenus() {
        return menuDAO.getAllMenus();
    }

    public List<Menu> getMenusByMidCid(String mid, String cid) {
        return menuDAO.getMenuByMidCid(mid, cid);
    }

    public Menu getMenuByMid(String mid) {
        List<Menu> menus = menuDAO.getMenuByMidCid(mid, "%");

        if (menus == null) { //如果是空直接返回null
            logger.info("查询menu无返回接口，请检查后台是否出错！");
            return null;
        }

        int size = menus.size();

        if (size == 0) {
            logger.info("菜品查询返回结果为空 mid = " + mid);
            return null;
        } else if (size > 1) {
            logger.error("DB mid 重复 mid = " + mid);
            return null;
        }

        return menus.get(0);
    }

    public int addMenu(int cid, String mname, float price) {
        logger.info("添加菜品 cid = " + cid + ", mname = " + mname + ", price = " + price);
        return menuDAO.addMenu(cid, mname, price);
    }

    public int updateMenuByMid(int mid, int cid, String mname, float price) {
        logger.info("更新菜品详情 mid = " + mid + ", cid = " + cid + ", mname = " + mname + ", price = " + price);
        return menuDAO.updateMenuByMid(mid, cid, mname, price);
    }

    public int deleteMenuByMid(int mid) {
        int inpactRowNum = menuDAO.deleteMenuByMid(mid);
        if (inpactRowNum == 1) {
            logger.info("对应菜品已被删除，mid = " + mid);
        } else {
            logger.info("对应菜品删除失败, mid = " + mid);
        }
        return inpactRowNum;
    }
}
