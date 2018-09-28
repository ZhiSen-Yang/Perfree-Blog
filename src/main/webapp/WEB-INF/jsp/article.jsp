<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="UTF-8"> 
<meta http-equiv="Cache-Control" content="no-transform"> 
<meta http-equiv="Cache-Control" content="no-siteapp"> 
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
<meta http-equiv="Content-Language" content="zh-CN"> 
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/style.css"
	media="screen">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/font-awesome.min.css"
	media="screen">
<script src="${pageContext.request.contextPath }/js/jquery-2.2.4.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/admin/lib/editor.md/lib/marked.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/admin/lib/editor.md/lib/prettify.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/admin/lib/editor.md/editormd.min.js"></script>
<title>Perfree的个人博客-${article.title }</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath }/images/favicon.ico" type="image/x-icon">
</head>
<body>
	<jsp:include page="./page/header.jsp"></jsp:include>
	<div class="container">
		<div class="breadcrumb">
			<i class="icon-home"></i> <a href="${pageContext.request.contextPath }/">主页</a> &gt; <a
				href="/protal/toBoard/${article.boardId }.html">${article.boardName }</a> &gt;
		</div>
		<main class="main" role="main">
		<div class="clear"></div>
		<article class="post cate1  auth1"> <!-- 标题 -->
		<h1>${article.title }</h1>
		<div class="postmeta article-meta">
			<span><i class='fa fa-clock-o'></i> 时间: <fmt:formatDate value="${article.updateTime}" pattern="yyyy-MM-dd HH:mm:ss" /> </span> 
			<span><i class="fa fa-bars"></i> 分类: <a href="/toBoard/${article.boardId }.html" title="${article.boardName }" target="_blank">${article.boardName }</a></span>
			<span><i class='fa fa-eye'></i> ${article.pageView } </span>
		</div>
	<link rel="stylesheet" href="${pageContext.request.contextPath }/js/admin/lib/editor.md/css/editormd.css" />
		<!-- 正文 -->
		<div class="entry" id="doc-content">
			
			<textarea style="display:none;">${article.context }</textarea>
		</div>
			<script type="text/javascript">
			    
			 </script>
		<script>
				$.getScript('${pageContext.request.contextPath }/js/admin/lib/editor.md/lib/marked.min.js',function(){});
				$.getScript('${pageContext.request.contextPath }/js/admin/lib/editor.md/lib/prettify.min.js',function(){});
				$.getScript('${pageContext.request.contextPath }/js/admin/lib/editor.md/editormd.min.js',function(){
					
					var testEditor;
				        testEditor = editormd.markdownToHTML("doc-content", {//注意：这里是上面DIV的id
				            htmlDecode: "style,script,iframe",
				    });
				});
		</script>
		<div id="tags">
		</div>
		</article>
		<div class="post istop cate1 auth1" id="revertInput">
			<link  rel="stylesheet" href="${pageContext.request.contextPath }/js/revert/css/main.css" />
			<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/js/revert/css/sinaFaceAndEffec.css" />
					<c:choose>
						<c:when test="${userSession != null }">
						<div class="comment">
							<div class="emojiContent">
								<div class="cont-box">
									<textarea class="text" placeholder="讲两句吧?..." id="emjoText" onfocus="removeRevertTip();"></textarea>
								</div>
								<div class="tools-box">
									<div class="operator-box-btn"><span class="face-icon"  >☺</span></div>
									<div class="submit-btn"><input type="button" onClick="out()"value="提交评论" /></div>
								</div>
							</div>
							<div id="revertTip"></div>
						</div>
						</c:when>
						<c:otherwise>
							<div id="loginTip">
								<i class="fa fa-cog fa-spin"></i>
								<span>有什么想说的,<a href="${pageContext.request.contextPath }/login.html">登录</a>即可评论~</span>
							</div>
						</c:otherwise>
					</c:choose>
		<script type="text/javascript">
			$.getScript('${pageContext.request.contextPath }/js/revert/js/main.js',function(){});
			$.getScript('${pageContext.request.contextPath }/js/revert/js/sinaFaceAndEffec.js',function(){
				
				// 绑定表情
				$('.face-icon').SinaEmotion($('.text'));
				});
			var articleId = "${article.id }";
			
		</script>
		<link rel="stylesheet" href="${pageContext.request.contextPath }/js/dialog/sweetalert.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath }/css/simplePaging.css">
		<script src="${pageContext.request.contextPath }/js/simplePaging.min.js"></script>
		<script src="${pageContext.request.contextPath }/js/dialog/sweetalert.min.js"></script>
		<link  rel="stylesheet" href="${pageContext.request.contextPath }/css/article.css" />
		<div id="revertBox">
		</div>
		<script type="text/javascript">
		var id = "${article.id}";
		var totalPage = 1;
		getTags(id);
		function getTags(id) {
			$.ajax({
				type: 'POST',
				url: "/protal/getArticleTags.action",
				data: {"id":id},
				dataType: 'json',
				success: function(data){
					var tags = "";
					$("#tags > span").remove();
					$.each(data.data,function(index,item){
						tags += "<span><i class='fa fa-tag'></i> <a href='/protal/toTag/"+item.id+".html'>"+item.name+"</a></span>&nbsp;&nbsp;";
					});
					$("#tags").append(tags);
				}
			});
		}
		getReverts(1,id);
		function getReverts(page,id) {
			 $.ajax({
					type: 'POST',
					url: "/protal/getReverts.action",
					data: {"page":page,"pageSize":8,"id":id},
					dataType: 'json',
					success: function(data){
							var reverts="";
							$("#revertBox > #revertList").remove();
							$("#revertBox > #pages").remove();
							$.each(data.list,function(index,item){
								commonTime = timestampToTime(item.createTime);
								reverts+="<div id='revertList'>"+
													"<div id='revertLeft'>"+
													"<img alt='"+item.nickname+"' src='"+item.image+"'>"+
												"</div>"+
												"<div id='revertRight'>"+
													"<span id='userName'>"+item.nickname+"</span>"+
													"<span id='floor'>#"+((data.pageNum-1)*8+index+1)+"楼</span>"+
													"<div id='revertContext'>"+item.context+"</div>"+
													"<span id='revertTime'><i class='fa fa-clock-o'></i> 日期:"+commonTime+"</span>"+
												"</div>"+
											"</div>";
							});
							$("#revertBox").append(reverts);
							if(data.totalPage!= null && data.totalPage!=""){
								$("#revertBox").append("<div class='simplePaging' id='pages'></div>");
								var newPage =page;
								totalPage = data.totalPage;
								$(".simplePaging").simplePaging({
						            allPage: data.totalPage,//总页数
						            showPage: 10,//显示页数
						            startPage: 1,//第一页页码数字
						            initPage: data.pageNum,//加载完毕自动跳转到第n页(初始化激活页)
						            initPageClick:true,//每次页面加载完毕后，是否触发initPage页的绑定事件
						            first: "首页",//首页显示字符
						            last: "尾页",//尾页显示字符
						            prev: "«",//上一页显示字符
						            next: "»",//下一页显示字符
						            showTurnTo: true,//是否显示跳转按钮，true显示，false不显示
						            animateType: "animation",//过渡模式：动画“animation”、跳动“jumpy”、快速移动“fast”、正常速度移动“normal”、缓慢的速度移动“slow”、异常缓慢的速度移动“verySlow”
						            animationTime: 0,//animateType为animation时，动画过渡时间(ms)
						            callBack: function (num) {
						            	newPage=num;
									if(newPage!=page){
										getReverts(newPage,id);
									}
						            }
						        });
							}else{
								$("#revertBox").append("<div class='tip' id='pages'>还没有人评论哦~</div>");
							}
					}
				});
		}
		function out() {
			var inputText = $('.text').val();
			if(inputText == null || inputText == ""){
				$("#revertTip").text("请输入评论内容~");
				return;
			}
			if(inputText.length > 200){
				$("#revertTip").text("请保持评论内容在200字以内~");
				return;
			}
			$('.text').val("");
			$.ajax({
				type: 'POST',
				url: "/sendRevert.action",
				data: {"articleId":articleId,"context":AnalyticEmotion(inputText)},
				dataType: 'json',
				success: function(data){
					if(data.status==200){
						swal({title:"评论发表成功~",
							text:"非常感谢~",
							type:"success"
						},function(){});
						 getReverts(totalPage,id);
					}else{
						swal(
								  data.msg,
								  '再来一次吧~',
								  'error'
								);
					}
				}
			});
		}
		function timestampToTime(timestamp) {
	        var date = new Date(timestamp);//时间戳为10位需*1000，时间戳为13位的话不需乘1000
	        var Y = date.getFullYear() + '/';
	        var M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '/';
	        var D = date.getDate();
	        var h = date.getHours() + ':';
	        var m = date.getMinutes() + ':';
	        var s = date.getSeconds();
	        return Y+M+D+h+m+s;
	    }
		function removeRevertTip() {
			$("#revertTip").text("");
		}
		</script>
		</div>
		</main>
		<jsp:include page="./page/right.jsp"></jsp:include>
	</div>
	<jsp:include page="./page/footer.jsp"></jsp:include>
	<div class="backtop">
		<a title="返回顶部"><i class="fa fa-chevron-circle-up fa-2x"></i></a>
	</div>
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/leonhere.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.pjax.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/responsiveslides.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.lazyload.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/love.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {

			$(".post .thumb img,.entry img").lazyload({

				placeholder : "./images/grey.gif",

				effect : "fadeIn"

			});

		});
	</script>
</body>
</html>