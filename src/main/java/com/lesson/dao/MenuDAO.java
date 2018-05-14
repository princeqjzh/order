package com.lesson.dao;

import com.lesson.model.Menu;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface MenuDAO {
    @Select("SELECT * FROM menus;")
    @Results({
            @Result(column = "mid", property = "mid"),
            @Result(column = "cid", property = "cid"),
            @Result(column = "mname", property = "mname"),
            @Result(column = "price", property = "price")
    })
    public List<Menu> getAllMenus();

    @Select("SELECT * FROM menus where mid like #{mid} and cid like #{cid};")
    @Results({
            @Result(column = "mid", property = "mid"),
            @Result(column = "cid", property = "cid"),
            @Result(column = "mname", property = "mname"),
            @Result(column = "price", property = "price")
    })
    public List<Menu> getMenuByMidCid(@Param("mid") String mid, @Param("cid") String cid);

    @Insert("insert into menus (cid, mname, price) values (#{cid}, #{mname}, #{price});")
    @Result(javaType = int.class)
    public int addMenu(@Param("cid") int cid, @Param("mname") String mname, @Param("price") float price);

    @Update("update menus set cid = #{cid}, mname = #{mname}, price = #{price} where mid = #{mid};")
    @Result(javaType = int.class)
    public int updateMenuByMid(@Param("mid") int mid, @Param("cid") int cid, @Param("mname") String mname, @Param("price") float price);

    @Delete("delete from menus where mid = #{mid};")
    @Result(javaType = int.class)
    public int deleteMenuByMid(@Param("mid") int mid);
}
