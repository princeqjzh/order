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
	String thisPageleftMenuOpen = "root"; //设定left页中的打开状态下拉菜单
	String thisPageleftMenu = "menuList"; //设定left页中的菜单箭头标注位置
	request.setAttribute("leftMenuOpen",thisPageleftMenuOpen);
	request.setAttribute("leftMenu",thisPageleftMenu);
%>

<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<title>主菜单</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<!-- basic styles -->
		<%@ include file="common/commonStyle.jsp"%>
	</head>

	<body>
		<div class="navbar navbar-default" id="navbar">
			<%@include file="common/header.jsp"%>
			<!-- /.container -->
		</div>

		<div class="main-container" id="main-container">
			<script type="text/javascript">
				try{ace.settings.check('main-container' , 'fixed')}catch(e){}
			</script>

			<div class="main-container-inner">
				<a class="menu-toggler" id="menu-toggler" href="#">
					<span class="menu-text"></span>
				</a>

				<div class="sidebar" id="sidebar">
					<%@include file="common/leftTree.jsp"%>
					<!-- /.nav-list -->

					<script type="text/javascript">
						try{ace.settings.check('sidebar' , 'collapsed')}catch(e){}
					</script>
				</div>

				<div class="main-content">
					<div class="breadcrumbs" id="breadcrumbs">
						<script type="text/javascript">
							try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
						</script>

						<ul class="breadcrumb">
							<li>
								<i class="icon-dashboard"></i>
								<a href="#">主菜单</a>
							</li>
						</ul><!-- .breadcrumb -->

						<div class="nav-search" id="nav-search">
							<%--<form class="form-search">--%>
								<%--<span class="input-icon">--%>
									<%--<input type="text" placeholder="Search ..." class="nav-search-input" id="nav-search-input" autocomplete="off" />--%>
									<%--<i class="icon-search nav-search-icon"></i>--%>
								<%--</span>--%>
							<%--</form>--%>
								<form class="form-search" action = "/showMenus" method = "post">
									<b>查询：</b>
									<select name="cid" class="tree-folder-name">
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
									<input type = "submit", value = "提交查询" class="btn btn-xs"/>
									&nbsp;|&nbsp;
									<%--<input type = "button" value = "添加菜品" onclick="window.location.href='/addMenu'" class="btn btn-xs">--%>
									<%--&nbsp;|&nbsp;--%>
									<%--<input type = "button" value = "管理分类" onclick="window.location.href='/showCategories'" class="btn btn-xs">--%>
									<%--&nbsp;|&nbsp;--%>
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
						</div><!-- #nav-search -->
					</div>
					<div class="table-responsive">
					<table border="1" cellspacing="0" cellpadding="5" class="table table-striped table-bordered table-hover">
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
					</div>

					<!-- /.page-content -->
				</div><!-- /.main-content -->

				<!-- /#ace-settings-container -->
			</div><!-- /.main-container-inner -->

			<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
				<i class="icon-double-angle-up icon-only bigger-110"></i>
			</a>
		</div>
		<!-- /.main-container -->

		<!-- basic scripts -->

		<!--[if !IE]> -->

		<!-- <![endif]-->

		<!--[if IE]>
<![endif]-->

		<!--[if !IE]> -->

		<script type="text/javascript">
			window.jQuery || document.write("<script src='../assets/js/jquery-2.0.3.min.js'>"+"<"+"script>");
		</script>

		<!-- <![endif]-->

		<!--[if IE]>
<script type="text/javascript">
 window.jQuery || document.write("<script src='../assets/js/jquery-1.10.2.min.js'>"+"<"+"script>");
</script>
<![endif]-->

		<script type="text/javascript">
			if("ontouchend" in document) document.write("<script src='../assets/js/jquery.mobile.custom.min.js'>"+"<"+"script>");
		</script>
		<script src="../assets/js/bootstrap.min.js"></script>
		<script src="../assets/js/typeahead-bs2.min.js"></script>

		<!-- page specific plugin scripts -->

		<!--[if lte IE 8]>
		  <script src="../assets/js/excanvas.min.js"></script>
		<![endif]-->

		<script src="../assets/js/jquery-ui-1.10.3.custom.min.js"></script>
		<script src="../assets/js/jquery.ui.touch-punch.min.js"></script>
		<script src="../assets/js/jquery.slimscroll.min.js"></script>
		<script src="../assets/js/jquery.easy-pie-chart.min.js"></script>
		<script src="../assets/js/jquery.sparkline.min.js"></script>
		<script src="../assets/js/flot/jquery.flot.min.js"></script>
		<script src="../assets/js/flot/jquery.flot.pie.min.js"></script>
		<script src="../assets/js/flot/jquery.flot.resize.min.js"></script>

		<!-- ace scripts -->

		<script src="../assets/js/ace-elements.min.js"></script>
		<script src="../assets/js/ace.min.js"></script>

		<!-- inline scripts related to this page -->

		<script type="text/javascript">
			jQuery(function($) {
				$('.easy-pie-chart.percentage').each(function(){
					var $box = $(this).closest('.infobox');
					var barColor = $(this).data('color') || (!$box.hasClass('infobox-dark') ? $box.css('color') : 'rgba(255,255,255,0.95)');
					var trackColor = barColor == 'rgba(255,255,255,0.95)' ? 'rgba(255,255,255,0.25)' : '#E2E2E2';
					var size = parseInt($(this).data('size')) || 50;
					$(this).easyPieChart({
						barColor: barColor,
						trackColor: trackColor,
						scaleColor: false,
						lineCap: 'butt',
						lineWidth: parseInt(size/10),
						animate: /msie\s*(8|7|6)/.test(navigator.userAgent.toLowerCase()) ? false : 1000,
						size: size
					});
				})
			
				$('.sparkline').each(function(){
					var $box = $(this).closest('.infobox');
					var barColor = !$box.hasClass('infobox-dark') ? $box.css('color') : '#FFF';
					$(this).sparkline('html', {tagValuesAttribute:'data-values', type: 'bar', barColor: barColor , chartRangeMin:$(this).data('min') || 0} );
				});
			
			
			
			
			  var placeholder = $('#piechart-placeholder').css({'width':'90%' , 'min-height':'150px'});
			  var data = [
				{ label: "social networks",  data: 38.7, color: "#68BC31"},
				{ label: "search engines",  data: 24.5, color: "#2091CF"},
				{ label: "ad campaigns",  data: 8.2, color: "#AF4E96"},
				{ label: "direct traffic",  data: 18.6, color: "#DA5430"},
				{ label: "other",  data: 10, color: "#FEE074"}
			  ]
			  function drawPieChart(placeholder, data, position) {
			 	  $.plot(placeholder, data, {
					series: {
						pie: {
							show: true,
							tilt:0.8,
							highlight: {
								opacity: 0.25
							},
							stroke: {
								color: '#fff',
								width: 2
							},
							startAngle: 2
						}
					},
					legend: {
						show: true,
						position: position || "ne", 
						labelBoxBorderColor: null,
						margin:[-30,15]
					}
					,
					grid: {
						hoverable: true,
						clickable: true
					}
				 })
			 }
			 drawPieChart(placeholder, data);
			
			 /**
			 we saved the drawing function and the data to redraw with different position later when switching to RTL mode dynamically
			 so that's not needed actually.
			 */
			 placeholder.data('chart', data);
			 placeholder.data('draw', drawPieChart);
			
			
			
			  var $tooltip = $("<div class='tooltip top in'><div class='tooltip-inner'></div></div>").hide().appendTo('body');
			  var previousPoint = null;
			
			  placeholder.on('plothover', function (event, pos, item) {
				if(item) {
					if (previousPoint != item.seriesIndex) {
						previousPoint = item.seriesIndex;
						var tip = item.series['label'] + " : " + item.series['percent']+'%';
						$tooltip.show().children(0).text(tip);
					}
					$tooltip.css({top:pos.pageY + 10, left:pos.pageX + 10});
				} else {
					$tooltip.hide();
					previousPoint = null;
				}
				
			 });
			
			
			
			
			
			
				var d1 = [];
				for (var i = 0; i < Math.PI * 2; i += 0.5) {
					d1.push([i, Math.sin(i)]);
				}
			
				var d2 = [];
				for (var i = 0; i < Math.PI * 2; i += 0.5) {
					d2.push([i, Math.cos(i)]);
				}
			
				var d3 = [];
				for (var i = 0; i < Math.PI * 2; i += 0.2) {
					d3.push([i, Math.tan(i)]);
				}
				
			
				var sales_charts = $('#sales-charts').css({'width':'100%' , 'height':'220px'});
				$.plot("#sales-charts", [
					{ label: "Domains", data: d1 },
					{ label: "Hosting", data: d2 },
					{ label: "Services", data: d3 }
				], {
					hoverable: true,
					shadowSize: 0,
					series: {
						lines: { show: true },
						points: { show: true }
					},
					xaxis: {
						tickLength: 0
					},
					yaxis: {
						ticks: 10,
						min: -2,
						max: 2,
						tickDecimals: 3
					},
					grid: {
						backgroundColor: { colors: [ "#fff", "#fff" ] },
						borderWidth: 1,
						borderColor:'#555'
					}
				});
			
			
				$('#recent-box [data-rel="tooltip"]').tooltip({placement: tooltip_placement});
				function tooltip_placement(context, source) {
					var $source = $(source);
					var $parent = $source.closest('.tab-content')
					var off1 = $parent.offset();
					var w1 = $parent.width();
			
					var off2 = $source.offset();
					var w2 = $source.width();
			
					if( parseInt(off2.left) < parseInt(off1.left) + parseInt(w1 / 2) ) return 'right';
					return 'left';
				}
			
			
				$('.dialogs,.comments').slimScroll({
					height: '300px'
			    });
				
				
				//Android's default browser somehow is confused when tapping on label which will lead to dragging the task
				//so disable dragging when clicking on label
				var agent = navigator.userAgent.toLowerCase();
				if("ontouchstart" in document && /applewebkit/.test(agent) && /android/.test(agent))
				  $('#tasks').on('touchstart', function(e){
					var li = $(e.target).closest('#tasks li');
					if(li.length == 0)return;
					var label = li.find('label.inline').get(0);
					if(label == e.target || $.contains(label, e.target)) e.stopImmediatePropagation() ;
				});
			
				$('#tasks').sortable({
					opacity:0.8,
					revert:true,
					forceHelperSize:true,
					placeholder: 'draggable-placeholder',
					forcePlaceholderSize:true,
					tolerance:'pointer',
					stop: function( event, ui ) {//just for Chrome!!!! so that dropdowns on items don't appear below other items after being moved
						$(ui.item).css('z-index', 'auto');
					}
					}
				);
				$('#tasks').disableSelection();
				$('#tasks input:checkbox').removeAttr('checked').on('click', function(){
					if(this.checked) $(this).closest('li').addClass('selected');
					else $(this).closest('li').removeClass('selected');
				});
				
			
			})
		</script>

</body>
</html>

