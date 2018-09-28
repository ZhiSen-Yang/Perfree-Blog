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
<title>发表文章</title>
</head>
<body>
	<nav class="breadcrumb"> <i class="Hui-iconfont">&#xe67f;</i> 首页
	<span class="c-gray en">&gt;</span> 标签管理 <span class="c-gray en">&gt;</span>
	添加标签<a class="btn btn-success radius r"
		style="line-height: 1.6em; margin-top: 3px"
		href="javascript:location.replace(location.href);" title="刷新"><i
		class="Hui-iconfont">&#xe68f;</i></a></nav>
	<form class="form form-horizontal" id="form-article-send" method="post" >
		<div class="row cl">
			<label class="form-label col-xs-2 col-sm-1"><span
				class="c-red">*</span>标签名：</label>
			<div class="formControls col-xs-4 col-sm-4">
				<input type="hidden" name="id" value="" id="tagId"/>
				<input type="text" placeholder="请输入标签名"
					class="input-text radius size-M" name="name" id="tagName">
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-2 col-sm-2"></label>
			<div class="formControls col-xs-4 col-sm-4">
				<input type="button" class="btn btn-primary radius" value="提交" id="tagForm">
			</div>
		</div>
	</form>
	<jsp:include page="./page/common.jsp"></jsp:include>
	<script type="text/javascript" src="../js/admin/sendArticle.js"></script>
	<script type="text/javascript">
		$("#tagForm").on("click",function(){
			
			     var name = $("#tagName").val();
		         $('#form-article-send').ajaxSubmit(      //ajax方式提交表单
					{
						url: '/tag/add.action',
						type: 'post',
						dataType: 'json',
						success: function (data) {
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
						clearForm: false,//禁止清楚表单
						resetForm: false //禁止重置表单
					});  
		});
	</script>
</body>
</html>