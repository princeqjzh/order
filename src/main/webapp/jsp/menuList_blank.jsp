<%@ page import="com.lesson.service.CategoryManager" %>
<%@ page import="com.lesson.model.Category" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	CategoryManager categoryManager = (CategoryManager)session.getAttribute("categoryManager");
	String currentCid = request.getParameter("cid");
	String currentUseCookie = request.getParameter("useCookie");

	//获取当前站点所需要的cookie: ckUseCookie, ckCid
	Cookie[] cookies = request.getCookies();

	Cookie ckUseCookie = null;
	Cookie ckCid = null;
	for (int i = 0; cookies != null && i < cookies.length; i++) {
		if ("ckUseCookie".equals(cookies[i].getName())) {
			ckUseCookie = cookies[i];
			System.out.println("ckUseCookie 的值为" + ckUseCookie.getName() + " = " + ckUseCookie.getValue());
		} else if ("ckCid".equals(cookies[i].getName())) {
			ckCid = cookies[i];
			System.out.println("ckCid 的值是" + ckCid.getName() + " = " + ckCid.getValue());
		}
	}

	//如果ckUseCookie = on 并且当前的 currentCid 为空 则尝试提交相应的请求
	if(ckUseCookie != null && ckUseCookie.getValue().equalsIgnoreCase("on") && currentCid == null){
%>
		<jsp:forward page="/showMenus">
			<jsp:param name="useCookie" value="<%=ckUseCookie.getValue()%>"></jsp:param>
			<jsp:param name="cid" value="<%=ckCid.getValue()%>"></jsp:param>
		</jsp:forward>
<%
	}
%>

<html>
<head>
	<title>主菜单</title>
</head>

<body>
	<h2>当前菜单</h2>
	<form action = "/showMenus" method = "post">
		<b>查询：</b>
		<select name="cid">
			<option value="all"
				<% if(currentCid == null){ out.println("selected"); }%>
			>全部</option>
			<%
				List<Category> categories = categoryManager.getAllCategories();
				for(Category category:categories){
			%>
					<option value="<%=category.getCid()%>"
						<%
							if(currentCid != null && currentCid.equalsIgnoreCase(new Integer(category.getCid()).toString())){
								out.println("selected");
							}
						%>
					>
						<%=category.getCname()%>
					</option>
			<%
				}
			%>
		</select>
		<input type = "submit", value = "提交查询"/>
		&nbsp;|&nbsp;
		<input type = "button" value = "添加菜品" onclick="window.location.href='/addMenu'">
		&nbsp;|&nbsp;
		<input type = "button" value = "管理分类" onclick="window.location.href='/showCategories'">
		&nbsp;|&nbsp;
		<input type = "checkbox" name = "useCookie"
		<%
			if(currentUseCookie != null && currentUseCookie.equalsIgnoreCase("on")){
		%>
				checked value="on"
		<%
			}
		%>
		/> 使用cookie
	</form>

	<table border="1" cellspacing="0" cellpadding="5">
		<tr>
			<th>点菜</th>
			<th>菜品编号</th>
			<th>菜品名称</th>
			<th>分类ID</th>
			<th>价钱</th>
			<th>相关操作</th>
		</tr>
		<c:forEach items="${menus}" var="menu">
			<tr>
				<td align="center"><input type="checkbox"/></td>
				<td align="center">${menu.mid}</td>
				<td>${menu.mname}</td>
				<td>
					<c:set var="cid" scope="request" value="${menu.cid}" />
					<%=categoryManager.getCategoryById(((Integer)request.getAttribute("cid")).intValue()).getCname()%>
				</td>
				<td align="center">${menu.price}</td>
				<td>
					<input type = "button" value = "删除" onclick="javascript:if(confirm('确认删除${menu.mname}'))window.location.href='/delete/${menu.mid}'">
					<input type = "button" value = "更新" onclick="window.location.href='/editMenu/${menu.mid}'">
				</td>
			</tr>
		</c:forEach>
	</table>

</body>
</html>