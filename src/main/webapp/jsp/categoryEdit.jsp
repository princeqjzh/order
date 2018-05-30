<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
	<title>编辑菜品分类</title>
	<style>
		input.none {border:none}
		select.none {border:none}
	</style>
</head>

<body>
	<h2>编辑菜品分类</h2>

	<form action="/saveCategory" method = "post">
		<table border="1" cellspacing="0" cellpadding="5">
			<tr>
				<th>菜品分类ID</th>
				<th>菜品分类名称</th>
			</tr>
			<tr>
				<td><input class = "none" type="text" name="cid" value = "${category.cid}" readonly = "readonly"/></td>
				<td><input class = "none" type="text" name="cname" value = "${category.cname}"/></td>
			</tr>
		</table>
		<br>
		<input type = "submit" value = "提交修改"/>
		&nbsp;
		<input type = "button" value = "取消" onclick="window.location.href='/showCategories'"/>
	</form>

</body>
</html>