<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<style type="text/css">
#fengmiannBox {
	width: 150px;
	height: 100px;
	border: 1px solid #dddddd;
	margin-bottom: 5px;
}

#imgTip {
	color: #8e8787;
	line-height: 100px;
}
</style>
<title>添加轮播图</title>
</head>
<body>
	<nav class="breadcrumb"> <i class="Hui-iconfont">&#xe67f;</i> 首页
	<span class="c-gray en">&gt;</span> 内容管理 <span class="c-gray en">&gt;</span>
	添加轮播图<a class="btn btn-success radius r"
		style="line-height: 1.6em; margin-top: 3px"
		href="javascript:location.replace(location.href);" title="刷新"><i
		class="Hui-iconfont">&#xe68f;</i></a></nav>
	<form class="form form-horizontal" id="form-article-send">
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2"><span
				class="c-red">*</span>封面图片：</label>
			<div class="formControls col-xs-8 col-sm-6">
				<div id="fengmiannBox" align="center">
					<span id="imgTip"><i class="Hui-iconfont">&#xe642;</i>请选择图片</span>
				</div>
				<span class="btn-upload form-group"> <input type="hidden" name="imageUrl" id="imageUrl"><a href="javascript:void();"
					class="btn btn-primary radius" style="margin-left: 20px;"><i
						class="Hui-file-icon Hui-iconfont">&#xe642;</i>&nbsp;&nbsp; 选择图片</a> <input
					type="file" multiple name="image" accept="image/*"
					class="input-file" id="fengmian" onchange="fileChange(this);">
				</span>
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2"></label>
			<div class="formControls col-xs-8 col-sm-6">
				<input type="button" class="btn btn-primary radius" value="提交" id="contentForm">
				<input type="button" value="重置" class="btn btn-primary radius"/>
			</div>
		</div>
	</form>
	<jsp:include page="./page/common.jsp"></jsp:include>
	<script type="text/javascript" src="../js/admin/sendArticle.js"></script>
	<script src="../js/admin/uploadImage.js"></script>
	<script type="text/javascript">
	$("#contentForm").on("click", function() {
		$.ajax({
			type: 'POST',
			url: '/imageUpload/delete.action',
			data: {"oldUrl":getUrls()}
		});
		$('#form-article-send').ajaxSubmit( //ajax方式提交表单
				{
					url : '/content/add.action',
					type : 'post',
					dataType : 'json',
					beforeSubmit : function() {
					},
					success : function(data) {
						if (data.status == 200) {
							layer.confirm(data.msg, {btn: ['确定'], title: "提示"},function(index) {
								var index = parent.layer.getFrameIndex(window.name);
								setTimeout(function(){parent.layer.close(index)},0); 
							});
						} else {
							layer.msg(data.msg, {
								icon : 2,
								time : 1000
							});
						}
					},
					clearForm : false,//禁止清楚表单
					resetForm : false
				//禁止重置表单
				});
	});
	</script>
</body>
</html>