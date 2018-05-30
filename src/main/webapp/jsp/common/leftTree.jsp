<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String _currentMenu = (String) request.getAttribute("leftMenu");
    String _currentMenuOpen = (String) request.getAttribute("leftMenuOpen");
    System.out.println("_currentMenu = " + _currentMenu);
    System.out.println("_currentMenuOpen = " + _currentMenuOpen);
%>
<script type="text/javascript">
    try{ace.settings.check('sidebar' , 'fixed')}catch(e){}
</script>

<div class="sidebar-shortcuts" id="sidebar-shortcuts">
    <div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">
        <button class="btn btn-success" onclick="window.location.href='/showMenus'">
            <i class="icon-signal"></i>
        </button>

        <button class="btn btn-info" onclick="window.location.href='/addMenu'">
            <i class="icon-pencil"></i>
        </button>

        <button class="btn btn-warning" onclick="window.location.href='/showCategories'">
            <i class="icon-group"></i>
        </button>

        <button class="btn btn-danger" onclick="window.location.href='/showMenus'">
            <i class="icon-cogs"></i>
        </button>
    </div>

    <div class="sidebar-shortcuts-mini" id="sidebar-shortcuts-mini">
        <span class="btn btn-success"></span>

        <span class="btn btn-info"></span>

        <span class="btn btn-warning"></span>

        <span class="btn btn-danger"></span>
    </div>
</div>
<!-- #sidebar-shortcuts -->
<ul class="nav nav-list">
    <li <%if ("menuList".equalsIgnoreCase(_currentMenu)) {%> class='active'  <%}%>>
        <a href="/showMenus">
            <i class="icon-dashboard"></i>
            <span class="menu-text"> 主菜单</span>
        </a>
    </li>

    <li <%if ("adControl".equalsIgnoreCase(_currentMenuOpen)) {%> class="active open" <%}%>>
        <a href="#" class="dropdown-toggle">
            <i class="icon-desktop"></i> <span class="menu-text"> 管理控制 </span>
            <b class="arrow icon-angle-down"></b>
        </a>

        <ul class="submenu">
            <li <%if ("addMenu".equalsIgnoreCase(_currentMenu)) {%> class='active'  <%}%>>
                <a href="/addMenu">
                    <i class="icon-double-angle-right"></i>添加菜品
                </a>
            </li>
            <li <%if ("cateList".equalsIgnoreCase(_currentMenu)) {%> class='active'  <%}%>>
                <a href="/showCategories">
                    <i class="icon-double-angle-right"></i>查看菜品分类
                </a>
            </li>
            <li>
                <a href="/addCategory">
                    <i class="icon-double-angle-right"></i>添加菜品分类
                </a>
            </li>
        </ul>
    </li>
</ul><!-- /.nav-list -->