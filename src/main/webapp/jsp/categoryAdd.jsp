<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
	<title>添加菜品分类</title>
	<style>
		input.none {border:1}
		select.none {border:1}
	</style>
</head>

<body>
	<h2>添加菜品分类</h2>
	<form action="/saveCategory" method = "post">
		<table border="1" cellspacing="0" cellpadding="5">
			<tr>
				<th>菜品分类名称</th>
			</tr>
			<tr>
				<td>
					<input type="text" name="cid" value="-1" hidden/>
					<input class = "none" type="text" name="cname"/>
				</td>
			</tr>
		</table>
		<br>
		<input type = "submit" value = "添加"/>
		&nbsp;
		<input type = "button" value = "取消" onclick="window.location.href='/showCategories'"/>
	</form>

</body>
</html>