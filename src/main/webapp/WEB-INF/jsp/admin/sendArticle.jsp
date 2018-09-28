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
<link rel="stylesheet" href="../js/admin/lib/editor.md/css/editormd.css" />
<link href="../js/admin/ui-choose.css" rel="stylesheet" />
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
<title>发表文章</title>
</head>

<body>
	<nav class="breadcrumb"> <i class="Hui-iconfont">&#xe67f;</i> 首页
	<span class="c-gray en">&gt;</span> 文章管理 <span class="c-gray en">&gt;</span>
	发表文章 <a class="btn btn-success radius r"
		style="line-height: 1.6em; margin-top: 3px"
		href="javascript:location.replace(location.href);" title="刷新"><i
		class="Hui-iconfont">&#xe68f;</i></a></nav>
	<form class="form form-horizontal" id="form-article-send" method="post"
		enctype="multipart/form-data">
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2"><span
				class="c-red">*</span>选择分类：</label>
			<div class="formControls col-xs-8 col-sm-2">
				<span class="select-box"> <select class="select" size="1"
					name="parentId" onchange="parent()" id="pid">
						<option value="0">----请选择-----</option>
						<c:forEach items="${parent}" var="parentBoard">
							<option value="${parentBoard.id }">${parentBoard.name }</option>
						</c:forEach>
				</select>
				</span>
			</div>
			<div class="formControls col-xs-8 col-sm-2">
				<span class="select-box"> <select class="select" size="1"
					name="boardId" id="child">
						<!-- 动态追加option -->
						<option>---请选择----</option>
				</select>
				</span>
			</div>

		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2"><span
				class="c-red">*</span>选择标签：</label>
			<div class="formControls col-xs-8 col-sm-6">
				<table class="demo-table">
					<tr>
						<td><select class="ui-choose" multiple="multiple" id="uc_04"
							name="tagId">
								<c:forEach items="${tags}" var="tag">
									<option value="${tag.id }">${tag.name }</option>
								</c:forEach>
						</select></td>
					</tr>
				</table>
			</div>
		</div>
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
			<label class="form-label col-xs-4 col-sm-2"><span
				class="c-red">*</span>标题：</label>
			<div class="formControls col-xs-8 col-sm-6">
				<input type="text" placeholder="请输入文章标题"
					class="input-text radius size-M" name="title" id="title">
			</div>
		</div>
		<div class="row cl">
			<div class="formControls col-xs-12 col-sm-12">
				<div id="test-editormd">
					<textarea style="display: none;" name="context" id="context"></textarea>
					<!-- 第二个隐藏文本域，用来构造生成的HTML代码，方便表单POST提交，这里的name可以任意取，后台接受时以这个name键为准 -->
					<textarea class="editormd-html-textarea" name="html"></textarea>
				</div>
			</div>
			<script src="../js/admin/lib/editor.md/examples/js/jquery.min.js"></script>
			<script src="../js/admin/lib/editor.md/editormd.js"></script>
			<script type="text/javascript">
				$(function() {
					 editormd.emoji= {
			                    path  : "../js/admin/lib/editor.md/plugins/emoji-dialog/emoji/",
			                    ext   : ".png"
			                };
					var testEditor = editormd("test-editormd", {
						width : "90%",
						height : 640,
						markdown : "",
						toc : true,
						path : '../js/admin/lib/editor.md/lib/',
						saveHTMLToTextarea : true,
						htmlDecode : "style,script,iframe",
						emoji : true,
						imageUpload : true,
						imageFormats : [ "jpg", "jpeg", "gif", "png", "bmp",
								"webp" ],
						imageUploadURL : "/imageUpload.action",
					});
				});
			</script>
		</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2"></label>
			<div class="formControls col-xs-8 col-sm-6">
				<input type="button" class="btn btn-primary radius" id="articleForm"
					value="提交"> <input type="button" value="重置"
					class="btn btn-primary radius" />
			</div>
		</div>
	</form>

	<jsp:include page="./page/common.jsp"></jsp:include>
	<script type="text/javascript" src="../js/admin/sendArticle.js"></script>
	<script src="../js/admin/ui-choose.js"></script>
	<script src="../js/admin/uploadImage.js"></script>
	<script type="text/javascript">
		function parent() {
			var pid = $("#pid").val();
			if (pid == 0) {
				layer.confirm('请选择一级分类!', {btn: ['确定'], title: "提示"});
				return;
			}
			$.post(
					"/getchildBoard.action",
					{
						pid : pid
					},
					function(data) {
						var optionString = "";
						var beanList = data; //返回的json数据
						if (beanList) { //判断
							for (var i = 0; i < beanList.length; i++) { //遍历，动态赋值
								optionString += "<option grade=\""+beanList[i].id+"\" value=\""+beanList[i].id+"\"";  
	                        optionString += ">"
										+ beanList[i].name
										+ "</option>"; //动态添加数据  
							}
							$("select[name=demo2]")
									.append(optionString); // 为当前name为asd的select添加数据。
						}
						;
						$("#child").html(optionString);//清除下拉框

					});
		}
		// 将所有.ui-choose实例化
		$('.ui-choose').ui_choose();

		// uc_04 select 多选
		var uc_04 = $('#uc_04').ui_choose();
		uc_04.click = function(value, item) {
			console.log('click', value);
		};
		uc_04.change = function(value, item) {
			console.log('change', value);
		};
		$("#articleForm").on("click", function() {
			var pid = $("#pid").val();
			if (pid == 0) {
				layer.confirm('请选择分类!', {btn: ['确定'], title: "提示"});
				return;
			}
			var imgl = $("#imageUrl").val();
			if (imgl == null || imgl == "") {
				layer.confirm('请上传封面图片!', {btn: ['确定'], title: "提示"});
				return;
			}
			var title = $("#title").val();
			if (title == null || title == "") {
				layer.confirm('请输入标题!', {btn: ['确定'], title: "提示"});
				return;
			}
			var context = $("#context").val();
			if (context == null || context == "") {
				layer.confirm('请输入文章内容!', {btn: ['确定'], title: "提示"});
				return;
			}
			layer.confirm('确定要发表此文章吗?',function(index) {
				$.ajax({
					type: 'POST',
					url: '/imageUpload/delete.action',
					data: {"oldUrl":getUrls()}
				});
			$('#form-article-send').ajaxSubmit( //ajax方式提交表单
			{
				url : '/article/send.action',
				type : 'post',
				dataType : 'json',
				beforeSubmit : function() {
				},
				success : function(data) {
					if (data.status == 200) {
						layer.confirm('文章已发表', {btn: ['确定'], title: "提示"},function(index) {
							location.replace(location.href);
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
		});
	</script>
</body>
</html>