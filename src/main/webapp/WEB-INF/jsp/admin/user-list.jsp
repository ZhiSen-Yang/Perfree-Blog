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
</head>
<body>
	<nav class="breadcrumb"> <i class="Hui-iconfont">&#xe67f;</i> 首页
	<span class="c-gray en">&gt;</span> 用户管理 <span class="c-gray en">&gt;</span>
	用户列表 <a class="btn btn-success radius r"
		style="line-height: 1.6em; margin-top: 3px"
		href="javascript:location.replace(location.href);" title="刷新"><i
		class="Hui-iconfont">&#xe68f;</i></a></nav>
	<div class="page-container">
		<div class="cl pd-5 bg-1 bk-gray mt-20">
			<span class="l"><a href="javascript:;" onclick="datadel()"
				class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i>
					批量删除</a></span> <span
				class="r">共有数据：<strong>${length }</strong> 条
			</span>
		</div>
		<div class="mt-20">
			<table
				class="table table-border table-bordered table-bg table-hover table-sort table-responsive">
				<thead>
					<tr class="text-c">
						<th width="25"><input type="checkbox" name="u" value=""></th>
						<th width="80">ID</th>
						<th >昵称</th>
						<th width="120">手机</th>
						<th width="150">头像</th>
						<th width="120">注册时间</th>
						<th width="120">操作</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${users }" var="user">
					<tr class="text-c">
						<td><input type="checkbox" value="${user.id }" name="u">
							<input type="hidden" name="image" value="${user.image }"/>
						</td>
						<td>${user.id }</td>
						<td>${user.nickname }</td>
						<td>${user.phone }</td>
						<td class="text-c"><img src="${user.image }"
							alt="..." class="thumbnail" width="60px" height="30px"></td>
						<td>${user.createTime }</td>
						<td class="f-14 td-manage">
							<a style="text-decoration: none" class="ml-5"
							onClick="article_del(this,'${user.id}','${user.image }')" href="javascript:;"
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
$('.table-sort').dataTable({
	"aaSorting": [[ 1, "desc" ]],//默认第几个排序
	"bStateSave": true,//状态保存
	"pading":false
});

/*删除*/
function article_del(obj,id,imageUrl){
	layer.confirm('确认要删除吗？',function(index){
		var params = {"id":id,"imageUrl":imageUrl};
		$.post(
			"/delUser.action",
			params,
			function(data){
				if(data.status==200){
					layer.confirm('删除成功!', {btn: ['确定'], title: "提示"},function(index) {
						location.replace(location.href);
					});
				}else{
					layer.msg(data.msg,{icon:2,time:1000});
				}
			}
		);
	});
}


//批量删除用户
function datadel(){
	var checkedbox = $("input[name='u']:checked");
	if(checkedbox.length == 0){
		layer.confirm('请选择要删除的用户!', {btn: ['确定'], title: "提示"});
	}
	var ids = "";
	var imageUrl="";
	var box = $("input[name='u']:checked").each(function(j) {
	    if (j >= 0) {
	       ids += $(this).val() + ","
	       imageUrl+=$(this).siblings("input[name='image']").val()+",";
	    }
	});
	layer.confirm('确认删除吗？',function(index){
			$.post(
					"/deleteUsers.action",
					{"ids":ids,"imageUrl":imageUrl},
					function(data){
						if(data.status == 200){
							layer.confirm('删除成功!', {btn: ['确定'], title: "提示"},function(index) {
								location.replace(location.href);
							});
						}else{
							layer.msg('删除失败',{icon:2,time:1000});
						}
					}
				);
	});
}
</script> 
</body>
</html>