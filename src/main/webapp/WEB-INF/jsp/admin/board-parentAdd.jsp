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
<script type="text/javascript" charset="utf-8" src="../js/admin/lib/utf8-jsp/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="../js/admin/lib/utf8-jsp/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="../js/admin/lib/utf8-jsp/lang/zh-cn/zh-cn.js"></script>
<title>发表文章</title>
</head>
<body>
	<nav class="breadcrumb"> <i class="Hui-iconfont">&#xe67f;</i> 首页
	<span class="c-gray en">&gt;</span> 分类管理 <span class="c-gray en">&gt;</span>
	<c:choose>
		<c:when test="${board == null }">
			添加一级分类
		</c:when>
		<c:otherwise>
			编辑分类
		</c:otherwise>
	</c:choose>
	<a class="btn btn-success radius r"
		style="line-height: 1.6em; margin-top: 3px"
		href="javascript:location.replace(location.href);" title="刷新"><i
		class="Hui-iconfont">&#xe68f;</i></a></nav>
	<form class="form form-horizontal" id="form-article-send" method="post" >
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2"><span
				class="c-red">*</span>一级分类名：</label>
			<div class="formControls col-xs-8 col-sm-6">
				<c:choose>
				<c:when test="${board == null }">
					<input type="hidden" name="parentId" value="0">
					<input type="text" placeholder="请输入一级分类名"
						class="input-text radius size-M" name="name" id="boardName">
				</c:when>
				<c:otherwise>
					<input type="hidden" name="id" value="${board.id }">
					<input type="text" value="${board.name }"
						class="input-text radius size-M" name="name" id="boardName">
				</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2"></label>
			<div class="formControls col-xs-8 col-sm-6">
				<input type="button" class="btn btn-primary radius" value="提交" id="boardForm">
			</div>
		</div>
	</form>
	<jsp:include page="./page/common.jsp"></jsp:include>
	<script type="text/javascript">
		var url;
		<c:choose>
			<c:when test="${board == null }">
				url = "/board/add.action";
			</c:when>
			<c:otherwise>
				url = "/board/edit.action";
			</c:otherwise>
		</c:choose>
		$("#boardForm").on("click",function(){
			
		         $('#form-article-send').ajaxSubmit(      //ajax方式提交表单
					{
						url: url,
						type: 'post',
						dataType: 'json',
						//beforeSubmit: function () {},
						success: function (data) {
							if (data.status == 200) {
								var index = parent.layer.getFrameIndex(window.name);
								setTimeout(function(){parent.layer.close(index)},0); 
							} else {
								alert(data.msg);
							}
						},
						clearForm: false,//禁止清楚表单
						resetForm: false //禁止重置表单
					});  
		});
	</script>
</body>
</html>