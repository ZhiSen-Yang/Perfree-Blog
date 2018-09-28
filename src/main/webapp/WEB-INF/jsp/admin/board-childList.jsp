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
<title>子分类列表</title>
</head>
<body>
	<nav class="breadcrumb"> <i class="Hui-iconfont">&#xe67f;</i> 首页
	<span class="c-gray en">&gt;</span> 分类管理 <span class="c-gray en">&gt;</span>
	子分类列表 <a class="btn btn-success radius r"
		style="line-height: 1.6em; margin-top: 3px"
		href="javascript:location.replace(location.href);" title="刷新"><i
		class="Hui-iconfont">&#xe68f;</i></a></nav>
	<div class="page-container">
		<div class="cl pd-5 bg-1 bk-gray mt-20">
			<span class="l"><a class="btn btn-primary radius"
				onclick="board_childAdd('添加子分类','/admin/board-childAdd.html','800','400','${parentId}')" href="javascript:;"><i
					class="Hui-iconfont">&#xe600;</i> 添加子分类</a></span> <span
				class="r" id="pageCount">共有数据：<strong>${count }</strong> 条
			</span>
		</div>
		<div class="mt-20">
			<table
				class="table table-border table-bordered table-bg table-hover table-sort table-responsive">
				<thead>
					<tr class="text-c">
						<th width="80">ID</th>
						<th>子分类名称</th>
						<th width="400">简介</th>
						<th width="150">图片(点击查看大图)</th>
						<th width="120">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${childBoards != null }">
							<c:forEach var="childBoard" items="${childBoards }">
								<tr class="text-c">
									<td>${childBoard.id }</td>
									<td>${childBoard.name }</td>
									<td>${childBoard.abs }</td>
									<td>
										<c:choose>
											<c:when test="${childBoard.image != null }">
												<a href="javascript:;" onclick="imagePrview('${childBoard.name }','${childBoard.image }');">
													<img src="${childBoard.image }" alt="..." class="thumbnail" width="60px" height="30px">
												</a>
											</c:when>
											<c:otherwise>
											没有图片
											</c:otherwise>
										</c:choose>
									</td>
									<td class="f-14 td-manage"><a
										style="text-decoration: none" class="ml-5"
										onClick="board_childEdit('子分类编辑','/toBoard_childEdit/${childBoard.id }.html','800','400')"
										href="javascript:;" title="编辑"><i class="Hui-iconfont">&#xe6df;</i></a>
										<a style="text-decoration: none" class="ml-5"
										onClick="board_child_del(this,'${childBoard.id }','${childBoard.image}')" href="javascript:;"
										title="删除"><i class="Hui-iconfont">&#xe6e2;</i></a></td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
						
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
	</div>
	<jsp:include page="./page/common.jsp"></jsp:include>
	<script type="text/javascript" src="../js/admin/lib/My97DatePicker/4.8/WdatePicker.js"></script> 
	<script type="text/javascript" src="../js/admin/lib/datatables/1.10.0/jquery.dataTables.min.js"></script> 
	<script type="text/javascript" src="../js/admin/lib/laypage/1.2/laypage.js"></script>
	<script type="text/javascript">
	$('.table-sort').dataTable({
	});
	function board_childAdd(title,url,w,h,parentId){
		layer.open({
			type: 2,
			area: [w+'px', h +'px'],
			fix: false, //不固定
			maxmin: true,
			shade:0.4,
			title: title,
			content: url,
			success: function (layero, index) {
                // 获取子页面的iframe
                var iframe = window['layui-layer-iframe' + index];
                // 向子页面的全局函数child传参
                iframe.child(parentId);
            },
			end:function(){           //这个是无论是确认还是取消，只要层被销毁了，end都会执行，不携带任何参数。
			//窗口关闭后，会执行这里的代写,刷新代码写就可以了
			window.location.reload();
			},
			});
	}
	function imagePrview(title,url){
		layer.open({
			type: 1,
			area: ['800px', '500px'],
			title: title,
			content: "<img src='"+url+"' alt='木有图片,丢了' width='800px' height='450px'>"
			});
	}
	function board_childEdit(title,url,w,h,id){
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
	/*删除*/
	function board_child_del(obj,id,imageUrl){
		layer.confirm('分类下所有帖子及评论都将删除,确认删除吗？',function(index){
			$.ajax({
				type: 'POST',
				url: '/childBoard/del.action',
				data: {"id":id,"imageUrl":imageUrl+","},
				dataType: 'json',
				success: function(data){
					if(data.status==200){
						layer.confirm('删除成功!', {btn: ['确定'], title: "提示"},function(index) {
							location.replace(location.href);
						});
					}else{
						layer.msg(data.msg,{icon:2,time:1000});
					}
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