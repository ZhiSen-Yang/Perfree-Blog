<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="${pageContext.request.contextPath }/js/admin/static/h-ui/css/H-ui.min.css" rel="stylesheet"
          type="text/css" />
    <link href="${pageContext.request.contextPath }/js/admin/static/h-ui.admin/css/H-ui.admin.css"
          rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath }/js/admin/lib/Hui-iconfont/1.0.8/iconfont.css"
          rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath }/js/admin/static/h-ui.admin/css/style.css" />
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath }/js/admin/static/h-ui.admin/skin/green/skin.css" id="skin" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/js/admin/lib/editor.md/css/editormd.css" />
    <link href="${pageContext.request.contextPath }/js/admin/ui-choose.css" rel="stylesheet" />
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
    <title>关于我</title>
</head>

<body>
<nav class="breadcrumb"> <i class="Hui-iconfont">&#xe67f;</i> 首页
    <span class="c-gray en">&gt;</span> 资料管理 <span class="c-gray en">&gt;</span>
    资料管理 <a class="btn btn-success radius r"
            style="line-height: 1.6em; margin-top: 3px"
            href="javascript:location.replace(location.href);" title="刷新"><i
            class="Hui-iconfont">&#xe68f;</i></a></nav>
<form class="form form-horizontal" id="form-article-send" method="post"
      enctype="multipart/form-data">

    </div>
    <div class="row cl">
        <label class="form-label col-xs-4 col-sm-2"><span
                class="c-red">*</span>昵称：</label>
        <div class="formControls col-xs-8 col-sm-2">
            <input type="text" value="${abourt.name}"
                   class="input-text radius size-M" name="name" id="name">
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-xs-4 col-sm-2"><span
                class="c-red">*</span>GitHub昵称：</label>
        <div class="formControls col-xs-8 col-sm-2">
            <input type="text" value="${abourt.githubName}"
                   class="input-text radius size-M" name="githubName" id="githubName">
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-xs-4 col-sm-2"><span
                class="c-red">*</span>GitHub链接：</label>
        <div class="formControls col-xs-8 col-sm-2">
            <input type="text" value="${abourt.githubUrl}"
                   class="input-text radius size-M" name="githubUrl" id="githubUrl">
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-xs-4 col-sm-2"><span
                class="c-red">*</span>微博昵称：</label>
        <div class="formControls col-xs-8 col-sm-2">
            <input type="text" value="${abourt.weiboName}"
                   class="input-text radius size-M" name="weiboName" id="weiboName">
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-xs-4 col-sm-2"><span
                class="c-red">*</span>微博链接：</label>
        <div class="formControls col-xs-8 col-sm-2">
            <input type="text" value="${abourt.weiboUrl}"
                   class="input-text radius size-M" name="weiboUrl" id="weiboUrl">
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-xs-4 col-sm-2"><span
                class="c-red">*</span>QQ：</label>
        <div class="formControls col-xs-8 col-sm-2">
            <input type="text" value="${abourt.QQ}"
                   class="input-text radius size-M" name="QQ" id="QQ">
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-xs-4 col-sm-2"><span
                class="c-red">*</span>头像：</label>
        <div class="formControls col-xs-8 col-sm-6">
            <div id="fengmiannBox" align="center">
                <img alt='' src='${abourt.imageUrl }' width='150px' height='100px' id='fengmianImg'>
            </div>
            <span class="btn-upload form-group"> <input type="hidden" name="imageUrl" id="imageUrl" value="${abourt.imageUrl }"><a href="javascript:;"
                    class="btn btn-primary radius" style="margin-left: 20px;"><i
                    class="Hui-file-icon Hui-iconfont">&#xe642;</i>&nbsp;&nbsp; 选择图片</a> <input
                    type="file" multiple name="imageFile" accept="image/*"
                    class="input-file" id="fengmian" onchange="fileChange(this);">
				</span>
        </div>
    </div>
    <div class="row cl">
        <div class="formControls col-xs-12 col-sm-12">
            <div id="test-editormd">
					<textarea style="display: none;" name="abs" id="context">${abourt.abs }</textarea>
                <!-- 第二个隐藏文本域，用来构造生成的HTML代码，方便表单POST提交，这里的name可以任意取，后台接受时以这个name键为准 -->
                <textarea class="editormd-html-textarea" name="html"></textarea>
            </div>
        </div>
        <script src="${pageContext.request.contextPath }/js/admin/lib/editor.md/examples/js/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath }/js/admin/lib/editor.md/editormd.js"></script>
        <script type="text/javascript">
            $(function() {
                var testEditor = editormd("test-editormd", {
                    width : "90%",
                    height : 500,
                    markdown : "",
                    path : '/js/admin/lib/editor.md/lib/',
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
                   value="提交">
        </div>
    </div>
</form>

<jsp:include page="./page/common.jsp"></jsp:include>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/admin/sendArticle.js"></script>
<script src="${pageContext.request.contextPath }/js/admin/ui-choose.js"></script>
<script src="${pageContext.request.contextPath }/js/admin/uploadImage.js"></script>
<script type="text/javascript">
    // 将所有.ui-choose实例化
    $('.ui-choose').ui_choose();

    $("#articleForm").on("click", function() {
        var name = $("#name").val();
        if (name == null || name=="") {
            layer.confirm('请输入昵称!', {btn: ['确定'], title: "提示"});
            return;
        }
        var githubName = $("#githubName").val();
        if (githubName == null || githubName == "") {
            layer.confirm('请输入github名称!', {btn: ['确定'], title: "提示"});
            return;
        }
        var githubUrl = $("#githubUrl").val();
        if (githubUrl == null || githubUrl == "") {
            layer.confirm('请输GitHub链接!', {btn: ['确定'], title: "提示"});
            return;
        }
        var weiboName = $("#weiboName").val();
        if (weiboName == null || weiboName == "") {
            layer.confirm('请输入微博昵称!', {btn: ['确定'], title: "提示"});
            return;
        }
        var weiboUrl = $("#weiboUrl").val();
        if (weiboUrl == null || weiboUrl == "") {
            layer.confirm('请输入微博链接!', {btn: ['确定'], title: "提示"});
            return;
        }
        var QQ = $("#QQ").val();
        if (QQ == null || QQ == "") {
            layer.confirm('请输入QQ号码!', {btn: ['确定'], title: "提示"});
            return;
        }
        var imageUrl = $("#imageUrl").val();
        if (imageUrl == null || imageUrl == "") {
            layer.confirm('请上传头像!', {btn: ['确定'], title: "提示"});
            return;
        }
        layer.confirm('确定要更新资料吗?',function(index) {
            $.ajax({
                type: 'POST',
                url: '/imageUpload/delete.action',
                data: {"oldUrl":getUrls()}
            });
            $('#form-article-send').ajaxSubmit( //ajax方式提交表单
                {
                    url : '/abourt/updateAbourt.action',
                    type : 'post',
                    dataType : 'json',
                    beforeSubmit : function() {
                    },
                    success : function(data) {
                        if (data.status == 200) {
                            layer.confirm('资料已更新', {btn: ['确定'], title: "提示"},function(index) {
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