<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../js/admin/static/h-ui/css/H-ui.min.css" rel="stylesheet"
	type="text/css" />
<link href="../js/admin/static/h-ui.admin/css/H-ui.admin.css"
	rel="stylesheet" type="text/css" />
<link href="../js/admin/lib/Hui-iconfont/1.0.8/iconfont.css"
	rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css"
	href="../js/admin/static/h-ui.admin/css/style.css" />
<link rel="stylesheet" type="text/css"
	href="../js/admin/static/h-ui.admin/skin/green/skin.css" id="skin" />
<title>文章列表</title>
<style type="text/css">
</style>
</head>
<body>
	<nav class="breadcrumb"> <i class="Hui-iconfont">&#xe67f;</i> 首页
	<span class="c-gray en">&gt;</span> 分类管理 <span class="c-gray en">&gt;</span>
	分类管理 <a class="btn btn-success radius r"
		style="line-height: 1.6em; margin-top: 3px"
		href="javascript:location.replace(location.href);" title="刷新"><i
		class="Hui-iconfont">&#xe68f;</i></a></nav>
	<div class="page-container">
		<div class="cl pd-5 bg-1 bk-gray mt-20">
			<span class="l"><a class="btn btn-primary radius"
				onclick="board_parentAdd('添加一级分类','/admin/board-parentAdd.html','800','400')" href="javascript:;"><i
					class="Hui-iconfont">&#xe600;</i> 添加一级分类</a></span> <span
				class="r" id="pageCount">共有数据：<strong>${count }</strong> 条
			</span>
		</div>
		<div class="mt-20">
			<table
				class="table table-border table-bordered table-bg table-hover table-sort table-responsive">
				<thead>
					<tr class="text-c">
						<th width="80">ID</th>
						<th>一级分类名称</th>
						<th width="120">子分类操作</th>
						<th width="120">操作</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${parent}" var="parentBoard">
					<tr class="text-c">
						<td>${parentBoard.id }</td>
						<td>${parentBoard.name }</td>
						<td><input class="btn btn-primary size-S radius" type="button" value="查看子分类" onclick="board_childList('${parentBoard.name }','/toBoard_childList/${parentBoard.id }.html','800','400');"></td>
						<td class="f-14 td-manage"><a style="text-decoration: none" class="ml-5"
							onClick="board_parentEdit('一级分类编辑','/toBoard_parentEdit/${parentBoard.id }.html','800','400')"
							href="javascript:;" title="编辑"><i class="Hui-iconfont">&#xe6df;</i></a>
							<a style="text-decoration: none" class="ml-5"
							onClick="board_parent_del(this,'${parentBoard.id }')" href="javascript:;"
							title="删除"><i class="Hui-iconfont">&#xe6e2;</i></a></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<jsp:include page="./page/common.jsp"></jsp:include>
	<script type="text/javascript" src="../js/admin/lib/My97DatePicker/4.8/WdatePicker.js"></script> 
	<script type="text/javascript" src="../js/admin/lib/datatables/1.10.0/jquery.dataTables.min.js"></script> 
	<script type="text/javascript" src="../js/admin/lib/laypage/1.2/laypage.js"></script>
	<script type="text/javascript">
		function board_parentAdd(title,url,w,h){
			layer.open({
				type: 2,
				area: [w+'px', h +'px'],
				fix: false, //不固定
				maxmin: true,
				shade:0.4,
				title: title,
				content: url,
				end:function(){           //这个是无论是确认还是取消，只要层被销毁了，end都会执行，不携带任何参数。
				//窗口关闭后，会执行这里的代写,刷新代码写就可以了
				window.location.reload();
				},
				});
		}
		function board_parentEdit(title,url,w,h,id){
			layer.open({
				type: 2,
				area: [w+'px', h +'px'],
				fix: false, //不固定
				maxmin: true,
				shade:0.4,
				title: title,
				content: url,
				end:function(){           //这个是无论是确认还是取消，只要层被销毁了，end都会执行，不携带任何参数。
				//窗口关闭后，会执行这里的代写,刷新代码写就可以了
				window.location.reload();
				},
				});
		}
		$(function(){
			$('.table-sort').dataTable({
				"aaSorting": [[ 1, "desc" ]],//默认第几个排序
				"bStateSave": true,//状态保存
			});
			
		});
		function board_childList(title,url,w,h){
			var index = layer.open({
				type: 2,
				title: title,
				content: url
			});
			layer.full(index);
		}
		/*删除*/
		function board_parent_del(obj,id){
			layer.confirm('分类下所有子分类及帖子和评论都将删除,确认删除吗？',function(index){
				$.ajax({
					type: 'POST',
					url: '/parentBoard/del.action',
					data: {"id":id},
					dataType: 'json',
					success: function(data){
						$(obj).parents("tr").remove();
						layer.msg('已删除!',{icon:1,time:1000});
						var count = $("#pageCount > strong").text();
						$("#pageCount > strong").text(count-1);
					},
					error:function(data) {
						layer.msg(data.msg,{icon:2,time:1000});
					},
				});		
			});
		}
	</script>
</body>
</html>