package com.lesson.service.impl;

import com.lesson.dao.CategoryDAO;
import com.lesson.model.Category;
import com.lesson.service.CategoryManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryManagerImpl implements CategoryManager {

    Logger logger = Logger.getLogger(CategoryManagerImpl.class);

    @Autowired
    CategoryDAO categoryDAO;

    public List<Category> getAllCategories() {
        return categoryDAO.getAllCategories();
    }

    public Category getCategoryById(int cid) {
        List<Category> categories = categoryDAO.getCategoriesById(cid);
        if (categories == null || categories.size() == 0 || categories.size() > 1) {
            return null;
        }

        return categories.get(0);
    }

    public int addCategory(String cname) {
        return categoryDAO.addCategory(cname);
    }

    public int updateCategoryById(int cid, String cname) {
        return categoryDAO.updateCategoryById(cid, cname);
    }

    public int deleteCategoryById(int cid) {
        return categoryDAO.deleteCategoryById(cid);
    }
}
