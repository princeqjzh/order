package com.lesson.dao;

import com.lesson.model.Category;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface CategoryDAO {
    @Select("SELECT * FROM categories;")
    @Results({
            @Result(column = "cid", property = "cid"),
            @Result(column = "cname", property = "cname")
    })
    public List<Category> getAllCategories();

    @Select("SELECT * FROM categories where cid = #{cid};")
    @Results({
            @Result(column = "cid", property = "cid"),
            @Result(column = "cname", property = "cname")
    })
    public List<Category> getCategoriesById(@Param("cid") int cid);

    @Select("SELECT * FROM categories where cid = #{cid};")
    @Results({
            @Result(column = "cid", property = "cid"),
            @Result(column = "cname", property = "cname")
    })
    public Category getCategoryById(@Param("cid") int cid);

    @Insert("insert into categories (cname) values (#{cname});")
    @Result(javaType = int.class)
    public int addCategory(@Param("cname") String cname);

    @Update("update categories set cname = #{cname} where cid = #{cid}")
    @Result(javaType = int.class)
    public int updateCategoryById(@Param("cid") int cid, @Param("cname") String cname);

    @Delete("delete from categories where cid = #{cid};")
    @Result(javaType = int.class)
    public int deleteCategoryById(@Param("cid") int cid);
}
