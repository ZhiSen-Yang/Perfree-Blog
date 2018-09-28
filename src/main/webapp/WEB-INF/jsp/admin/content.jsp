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
<title>发表文章</title>
</head>
<body>
	<nav class="breadcrumb"> <i class="Hui-iconfont">&#xe67f;</i> 首页
	<span class="c-gray en">&gt;</span> 内容管理 <span class="c-gray en">&gt;</span>
	轮播图管理 <a class="btn btn-success radius r"
		style="line-height: 1.6em; margin-top: 3px"
		href="javascript:location.replace(location.href);" title="刷新"><i
		class="Hui-iconfont">&#xe68f;</i></a></nav>

	<div class="page-container">
		<div class="cl pd-5 bg-1 bk-gray mt-20">
			<span class="l"><a href="javascript:;" onclick="datadel()"
				class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i>
					批量删除</a><a class="btn btn-primary radius"
				onclick="content_add('添加图片','/admin/content-add.html',800,500)" href="javascript:;"><i
					class="Hui-iconfont">&#xe600;</i> 添加图片</a></span> <span class="r" id="pageCount">共有数据：<strong>${total}</strong>
				条
			</span>
		</div>
		<div class="mt-20">
			<table
				class="table table-border table-bordered table-bg table-hover table-sort table-responsive">
				<thead>
					<tr class="text-c">
						<th width="25"><input type="checkbox" name="content" value=""></th>
						<th>ID</th>
						<th>图片(点击查看大图)</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${contents}" var="content">
					<tr class="text-c">
						<td>
							<input type="checkbox" value="${content.id}" name="content">
							<input type="hidden" value="${content.imageUrl}" name="imageUrl"/>	
						</td>
						<td>${content.id}</td>
						<td class="text-c">
							<a href="javascript:;" onclick="imagePrview('图片查看','${content.imageUrl}');">
								<img src="${content.imageUrl}" alt="..." class="thumbnail" width="60px" height="30px">
							</a>
						</td>
						<td class="f-14 td-manage"><a style="text-decoration: none"
							class="ml-5" onClick="article_del(this,'${content.id}','${content.imageUrl }')"
							href="javascript:;" title="删除"><i class="Hui-iconfont">&#xe6e2;</i></a></td>
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
	
		//分页
		$('.table-sort').dataTable({
			
		});
		function imagePrview(title,url){
			layer.open({
				type: 1,
				area: ['800px', '500px'],
				title: title,
				content: "<img src='"+url+"' alt='木有图片,丢了' width='800px' height='450px'>"
				});
		}
		/*删除*/
		function article_del(obj, id,imageUrl) {
			layer.confirm('确认要删除吗？', function(index) {
				var params = {"id":id,"imageUrl":imageUrl+","};
				$.post(
					"/delContent.action",
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
		/*图片-添加*/
		function content_add(title,url,w,h){
			layer.open({
				type: 2,
				area: [w+'px', h+'px'],
				title: title,
				fix: false, //不固定
				content: url,
				end:function(){           //这个是无论是确认还是取消，只要层被销毁了，end都会执行，不携带任何参数。
					//窗口关闭后，会执行这里的代写,刷新代码写就可以了
					window.location.reload();
					}
			});
		}
		
		
		//批量删除
		function datadel(){
			var checkedbox = $("input[name='content']:checked");
			if(checkedbox.length == 0){
				alert("请选择要删除的轮播图");
				return;
			}
			var ids = "";
			var imageUrl="";
			var box = $("input[name='content']:checked").each(function(j) {
			    if (j >= 0) {
			    	 ids += $(this).val() + ",";
			       imageUrl+=$(this).siblings("input[name='imageUrl']").val()+",";
			    }
			});
			layer.confirm('确认删除吗？',function(index){
			$.post(
					"/deleteContents.action",
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