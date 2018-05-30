package com.lesson.controller;

import com.lesson.model.Menu;
import com.lesson.service.CategoryManager;
import com.lesson.service.MenuManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

@Controller
public class OrderEntryControllor {
    @Autowired
    MenuManager menuManager;

    @Autowired
    CategoryManager categoryManager;

    Logger logger = Logger.getLogger(OrderEntryControllor.class);

    /**
     * 展示菜品
     *
     * @param model
     * @param mid     菜品id （查询用）
     * @param cid     菜品分类id （查询用）
     * @param request
     * @return
     */
    @RequestMapping(value = "/showMenus")
    public String showMenus(Model model,
                            @RequestParam(value = "mid", required = false) String mid,
                            @RequestParam(value = "cid", required = false) String cid,
                            @RequestParam(value = "useCookie", required = false) String useCookie,
                            HttpServletRequest request,
                            HttpServletResponse response) {
        logger.info("mid = " + mid);
        logger.info("cid = " + cid);
        logger.info("useCookie = " + useCookie);

        //判断mid cid为空的情形
        if (mid == null || mid.equalsIgnoreCase("") || mid.equalsIgnoreCase("all")) {
            mid = "%";
        }
        if (cid == null || cid.equalsIgnoreCase("") || cid.equalsIgnoreCase("all")) {
            cid = "%";
        }

        HttpSession session = request.getSession();
        String sessionId = session.getId();
        model.addAttribute("menus", menuManager.getMenusByMidCid(mid, cid));
        session.setAttribute("categoryManager", categoryManager);



        //配置cookie
        if(useCookie != null && useCookie.equalsIgnoreCase("on")){
            int expire = 3600 * 24 * 30; //如果使用cookie，则将过期时间设为1个月
            logger.info("用户选择使用cookie，进入使用cookies的控制逻辑！");
            Cookie ckUseCookie = new Cookie("ckUseCookie","on");
            Cookie ckCid = new Cookie("ckCid",cid);
            ckUseCookie.setMaxAge(expire);
            ckCid.setMaxAge(expire);

            response.addCookie(ckUseCookie);
            response.addCookie(ckCid);
        }else{
            int expire = -1; //如果使用cookie，则将过期时间设为-1 控制该cookie立刻过期
            logger.info("用户没有选择使用cookie，进入不使用cookies的控制逻辑！");
            Cookie ckUseCookie =new Cookie("ckUseCookie","");
            Cookie ckCid =new Cookie("ckCid","");
            ckUseCookie.setMaxAge(expire);
            ckCid.setMaxAge(expire);

            response.addCookie(ckUseCookie);
            response.addCookie(ckCid);
        }

        logger.info("Session Id = " + sessionId);
        return "jsp/menuList.jsp";
    }

    /**
     * 展示编辑菜品页
     *
     * @param model
     * @param mid     菜品id
     * @param request
     * @return
     */
    @RequestMapping(value = "/editMenu/{mid}", method = RequestMethod.GET)
    public String editMenu(Model model,
                           @PathVariable String mid,
                           HttpServletRequest request) {
        logger.info("Start editMenu!");
        Menu menu = menuManager.getMenuByMid(mid);
        HttpSession session = request.getSession();

        model.addAttribute("menu", menu);
        session.setAttribute("categoryManager", categoryManager);
        return "jsp/menuEdit.jsp";
    }

    /**
     * 展示添加菜品页
     *
     * @param model
     * @param request
     * @return
     */
    @RequestMapping(value = "/addMenu", method = RequestMethod.GET)
    public String addMenu(Model model, HttpServletRequest request) {
        logger.info("Start addMenu!");
        HttpSession session = request.getSession();

        session.setAttribute("categoryManager", categoryManager);
        return "jsp/menuAdd.jsp";
    }

    /**
     * 保存菜品 （新建或更新）
     *
     * @param model
     * @param request
     * @param mid     -1 代表新建菜品，其他代表更新菜品
     * @param cid     分类ID
     * @param mname   菜品名称
     * @param price   菜品价格
     * @return
     * @throws UnsupportedEncodingException
     */
    @RequestMapping(value = "/saveMenu", method = RequestMethod.POST)
    public String saveMenu(Model model,
                           HttpServletRequest request,
                           @RequestParam(value = "mid", required = true) int mid,
                           @RequestParam(value = "new_cid", required = true) int cid,
                           @RequestParam(value = "mname", required = true) String mname,
                           @RequestParam(value = "price", required = true) float price) throws UnsupportedEncodingException {
        if (mname != null && !mname.equalsIgnoreCase("")) {
            mname = new String(mname.getBytes("ISO-8859-1"), "utf8");
        }

        if (mid >= 1) {
            logger.info("保存菜品更新！");
            logger.info("Request Param: mid = " + mid);
            logger.info("Request Param: cid = " + cid);
            logger.info("Request Param: mname = " + mname);
            logger.info("Request Param: price = " + price);
            menuManager.updateMenuByMid(mid, cid, mname, price);
        } else if (mid == -1) {
            logger.info("添加新菜品！");
            logger.info("Request Param: cid = " + cid);
            logger.info("Request Param: mname = " + mname);
            logger.info("Request Param: price = " + price);
            menuManager.addMenu(cid, mname, price);
        } else {
            logger.error("出错了，mid 不正确！");
        }

        HttpSession session = request.getSession();
        model.addAttribute("menus", menuManager.getAllMenus());
        session.setAttribute("categoryManager", categoryManager);
        return "jsp/menuList.jsp";
    }

    /**
     * 删除菜品
     *
     * @param model
     * @param mid     菜品id
     * @param request
     * @return
     */
    @RequestMapping(value = "/delete/{mid}", method = RequestMethod.GET) //按照ID展示
    public String deleteMenu(Model model,
                             @PathVariable int mid,
                             HttpServletRequest request,
                             HttpServletResponse response) {
        menuManager.deleteMenuByMid(mid); //删除对应menu

        HttpSession session = request.getSession();
        model.addAttribute("menus", menuManager.getAllMenus());
        session.setAttribute("categoryManager", categoryManager);

        return "/showMenus";
    }

    /**
     * 展示所有菜品分类
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/showCategories")
    public String showCategories(Model model) {
        model.addAttribute("categories", categoryManager.getAllCategories());
        return "jsp/categoryList.jsp";
    }

    /**
     * 展示添加菜品分类页面
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/addCategory", method = RequestMethod.GET)
    public String addCategory(Model model) {
        logger.info("Start addCategory!");
        return "jsp/categoryAdd.jsp";
    }

    /**
     * 修改菜品分类
     *
     * @param model
     * @param cid   菜品分类id
     * @return
     */
    @RequestMapping(value = "/editCategory/{cid}")
    public String editCategory(Model model, @PathVariable int cid) {
        model.addAttribute("category", categoryManager.getCategoryById(cid));
        return "jsp/categoryEdit.jsp";
    }

    /**
     * 保存菜品分类
     *
     * @param model
     * @param cid   菜品分类id
     * @param cname 菜品分类名称
     * @return
     * @throws UnsupportedEncodingException
     */
    @RequestMapping(value = "/saveCategory", method = RequestMethod.POST)
    public String saveCategory(Model model,
                               @RequestParam(value = "cid", required = true) int cid,
                               @RequestParam(value = "cname", required = true) String cname) throws UnsupportedEncodingException {
        if (cname != null && !cname.equalsIgnoreCase("")) {
            cname = new String(cname.getBytes("ISO-8859-1"), "utf8");
        }

        if (cid >= 1) {
            logger.info("更新保存菜品分类！");
            logger.info("cid = " + cid);
            logger.info("cname = " + cname);
            categoryManager.updateCategoryById(cid, cname);
        } else if (cid == -1) {
            logger.info("添加新菜品分类！");
            logger.info("cname = " + cname);
            categoryManager.addCategory(cname);
        } else {
            logger.info("出错了，id 不正确！");
        }
        model.addAttribute("categories", categoryManager.getAllCategories());
        return "jsp/categoryList.jsp";
    }

    /**
     * 删除菜品分类
     *
     * @param model
     * @param cid   菜品分类id
     * @return
     */
    @RequestMapping(value = "/deleteCategory/{cid}")
    public String deleteCategoryById(Model model,
                                     @PathVariable int cid,
                                     HttpServletRequest request) {
        try {
            categoryManager.deleteCategoryById(cid);
        } catch (Exception ex) {
            String errMsg = ex.getMessage();
            logger.info("发生错误无法删除！");
            logger.info(errMsg);
            if (errMsg.contains("MySQLIntegrityConstraintViolationException")) {
                logger.error("存在依赖，不能删除该值");
                String cname = categoryManager.getCategoryById(cid).getCname();
                HttpSession session = request.getSession();
                session.setAttribute("errMsg", "出错啦：\"" + cname + "\"下仍有菜品，不能删除该分类！");
            }
        }
        model.addAttribute("categories", categoryManager.getAllCategories());
        return "jsp/categoryList.jsp";
    }

}
