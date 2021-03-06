<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<title>Perfree的个人博客-标签</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath }/images/favicon.ico" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="./css/style.css"
	media="screen">
<link rel="stylesheet" type="text/css" href="./css/font-awesome.min.css"
	media="screen">
</head>
<body>
	<jsp:include page="./page/header.jsp"></jsp:include>
	<div class="container">
		<script src="./js/jquery-2.2.4.min.js" type="text/javascript"></script>
		<main class="main" role="main">
			<div class="">
				<div class="post istop cate1 auth1">
					<h5><i class="fa fa-tags"></i>全部标签</h5>
					<link rel="stylesheet" type="text/css" href="./css/tag.css" media="screen">
					<div id="tagsList">
						<c:forEach var="tag" items="${tags }">
							<a href="/protal/toTag/${tag.id }.html" title="${tag.name }" id="tagbox">
								<i class="fa fa-tag"></i>
								<span>${tag.name }</span>							
							</a>
						</c:forEach>
					</div>
					</div>
		</main>
		<jsp:include page="./page/right.jsp"></jsp:include>
	</div>
	
	
	<jsp:include page="./page/footer.jsp"></jsp:include>
	<div class="backtop">
		<a title="返回顶部"><i class="fa fa-chevron-circle-up fa-2x"></i></a>
	</div>
	<script type="text/javascript" src="./js/leonhere.js"></script>
	<script type="text/javascript" src="./js/jquery.pjax.min.js"></script>
	<script type="text/javascript" src="./js/responsiveslides.min.js"></script>
	<script type="text/javascript" src="./js/jquery.lazyload.js"></script>
	<script type="text/javascript" src="./js/love.js"></script>
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