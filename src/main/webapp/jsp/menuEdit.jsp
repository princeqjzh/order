<%@ page import="com.lesson.service.CategoryManager" %>
<%@ page import="com.lesson.model.Category" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	CategoryManager categoryManager = (CategoryManager)session.getAttribute("categoryManager");
%>

<html>
<head>
	<title>编辑菜品详情</title>
	<style>
		input.none {border:none}
		select.none {border:none}
	</style>
</head>

<body>
	<h2>编辑菜品详情</h2>

	<form action="/saveMenu" method = "post">
		<table border="1" cellspacing="0" cellpadding="5">
			<tr>
				<th>菜品ID</th>
				<th>菜品名称</th>
				<th>菜品分类</th>
				<th>菜品单价</th>
			</tr>
			<tr>
				<td><input class = "none" type="text" name="mid" value = "${menu.mid}" readonly = "readonly"/></td>
				<td><input class = "none" type="text" name="mname" value = "${menu.mname}"/></td>
				<td>
					<c:set var="ccid" scope="request" value="${menu.cid}" /> <!--获取当前cid-->
					<select class = "none" name="cid">
						<%
							List<Category> categories = categoryManager.getAllCategories();
							int ccid = ((Integer)request.getAttribute("ccid")).intValue();
							for(Category category: categories){
						%>
								<option value = "<%=category.getCid()%>"
								<%
									if(category.getCid() == ccid){
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
				</td>
				<td><input class = "none" type="text" name="price" value = "${menu.price}"/></td>
			</tr>
		</table>
		<br>
		<input type = "submit" value = "提交修改"/>
		&nbsp;
		<input type = "button" value = "取消" onclick="window.location.href='/showMenus'"/>
	</form>

</body>
</html>