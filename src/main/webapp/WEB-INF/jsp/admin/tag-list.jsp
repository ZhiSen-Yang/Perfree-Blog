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
	<span class="c-gray en">&gt;</span> 标签管理 <span class="c-gray en">&gt;</span>
	标签列表 <a class="btn btn-success radius r"
		style="line-height: 1.6em; margin-top: 3px"
		href="javascript:location.replace(location.href);" title="刷新"><i
		class="Hui-iconfont">&#xe68f;</i></a></nav>
	<div class="page-container">
		<div class="cl pd-5 bg-1 bk-gray mt-20">
			<span class="l"><a href="javascript:;" onclick="datadel()"
				class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i>
					批量删除</a><a class="btn btn-primary radius"
				onclick="content_add('添加标签','/admin/tag-add.html')" href="javascript:;"><i
					class="Hui-iconfont">&#xe600;</i> 添加标签</a></span> <span
				class="r" id="pageCount">共有数据：<strong>${length}</strong> 条
			</span>
		</div>
		<div class="mt-20">
			<table
				class="table table-border table-bordered table-bg table-hover table-sort table-responsive layui-table">
				<thead>
					<tr class="text-c">
					<!-- 复选框 --> 
						<th width="25"><input type="checkbox" name="tag" value=""></th>
						<th width="80">ID</th>
						<th>标签名</th>
						<th width="120">操作</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${tags}" var="tag">
					<tr class="text-c">
						<td><input type="checkbox" value="${tag.id}" name="tag"></td>
						<td name="id">${tag.id}</td>
						<td>${tag.name}</td>
						<td class="f-14 td-manage"><a title="编辑" href="javascript:article_edit('${tag.id }','${tag.name }');"><i class="Hui-iconfont">&#xe6df;</i></a>
							<a style="text-decoration: none" class="ml-5"
							onClick="article_del(this,'${tag.id }')" href="javascript:;"
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
	$('.table-sort').dataTable({//方法里面什么都不用写就可以实现分页
});

/*删除*/
function article_del(obj,id){
	layer.confirm('确认要删除吗？',function(index){
		var params = {"id":id};
		$.post(
			"/delTag.action",
			params,
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

function article_edit(tagid,tagName){
	    	var index = layer.open({
	    			type: 2,
	    			title:'编辑标签',
	    			content: '/admin/tag-edit.html',
	    			area: ['600px', '400px'],
	    			success: function (layero, index) {
	                    // 获取子页面的iframe
	                    var iframe = window['layui-layer-iframe' + index];
	                    // 向子页面的全局函数child传参
	                    iframe.childId(tagid);
	                    iframe.childName(tagName);
	                },
	    			end:function(){           //这个是无论是确认还是取消，只要层被销毁了，end都会执行，不携带任何参数。
	    			//窗口关闭后，会执行这里的代写,刷新代码写就可以了
	    			window.location.reload();
	    			}
	    		});
}
function content_add(title,url){
	layer.open({
		type: 2,
		area: ['600px', '400px'],
		title: title,
		fix: false, //不固定
		content: url,
		end:function(){           //这个是无论是确认还是取消，只要层被销毁了，end都会执行，不携带任何参数。
			//窗口关闭后，会执行这里的代写,刷新代码写就可以了
			window.location.reload();
			}
	});
}
function datadel(){
	var checkedbox = $("input[name='tag']:checked");
	if(checkedbox.length == 0){
		layer.confirm('请选择要删除的标签!', {btn: ['确定'], title: "提示"});
		return;
	}
	var ids = "";
	var box = $("input[name='tag']:checked").each(function(j) {
	    if (j >= 0) {
	    	 ids += $(this).val() + ",";
	    }
	});
	layer.confirm('确认删除吗？',function(index){
			$.post(
					"/deleteTags/ids="+ids+".action",
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