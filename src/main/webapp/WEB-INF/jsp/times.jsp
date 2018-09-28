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
<title>Perfree的个人博客-时间流</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath }/images/favicon.ico" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/style.css"
	media="screen">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/font-awesome.min.css"
	media="screen">
<script src="${pageContext.request.contextPath }/js/jquery-2.2.4.min.js" type="text/javascript"></script>
</head>
<body>
	<jsp:include page="./page/header.jsp"></jsp:include>
	<div class="container">
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/times.css" media="screen">
		<main class="main" role="main">
			<div class="">
				<div class="post istop cate1 auth1">
					<div id="timeBox">
						<c:forEach var="article" items="${articles }">
							<a id="articleBox" href="/toArticle/${article.id }.html">
								<div id="imgBox">
									<img alt='${article.title }' src='${article.imageUrl }' height="50px" />
								</div>
								<span id="articleTitle">${article.title }</span>
								<span id="articleTime"><i class="fa fa-clock-o"></i><fmt:formatDate value="${article.updateTime}" pattern="yyyy年MM月dd日HH点mm分ss秒" /></span>
							</a>
							<span id="timeLog"><i class="fa fa-circle-o-notch fa-spin"></i></span>
						</c:forEach>
					</div>
					<div id="loadingArticle">
						
					</div>
					<a href="javascript:;" id="seeMore" onclick="seeMoreArticle()">
						<span><i class="fa fa-angle-double-down"></i></span>&nbsp;查看更多
					</a>
					<script type="text/javascript">
						var page=1;
						function seeMoreArticle() {
							var loadingArticle="<img alt='' src='${pageContext.request.contextPath }/images/loading3.gif' id='loadimg'>";
							$("#loadingArticle").append(loadingArticle);
							page+=1;
							$.ajax({
								type: 'POST',
								url: "/protal/getNewArticlesByAjax.action",
								data: {"page":page,"pageSize":20},
								dataType: 'json',
								success: function(data){
										var articles="";
										if(data != null && data!=""){
											$.each(data,function(index,item){
												articles+="<a id='articleBox' href='/toArticle/"+item.id+".html'>"+
																"<div id='imgBox'>"+
																"<img alt='"+item.title+"' src='"+item.imageUrl+"' />"+
															"</div>"+
															"<span id='articleTitle'>"+item.title+"</span>"+
															"<span id='articleTime'><i class='fa fa-clock-o'></i>"+timestampToTime(item.updateTime)+"</span>"+
														"</a>"+
														"<span id='timeLog'><i class='fa fa-circle-o-notch fa-spin'></i></span>";
											});
											$("#loadingArticle > #loadimg").remove();
											$("#timeBox").append(articles);
										}else{
											$("#loadingArticle > #loadimg").remove();
											$("#seeMore>span").remove();
											$("#seeMore").text("木有数据了=_=");
										}
								}
							});
						}
						function timestampToTime(timestamp) {
					        var date = new Date(timestamp);//时间戳为10位需*1000，时间戳为13位的话不需乘1000
					        var Y = date.getFullYear() + '-';
					        var M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
					        var D = date.getDate() + ' ';
					        var h = date.getHours() + ':';
					        var m = date.getMinutes() + ':';
					        var s = date.getSeconds();
					        return Y+M+D+h+m+s;
					    }
					</script>
				</div>
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
		
	</script>
</body>
</html>