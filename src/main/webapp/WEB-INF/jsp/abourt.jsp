<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<title>关于我</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath }/images/favicon.ico" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="./css/style.css"
	media="screen">
<link rel="stylesheet" type="text/css" href="./css/font-awesome.min.css"
	media="screen">
<script src="./js/jquery-2.2.4.min.js" type="text/javascript"></script>
</head>
<body>
	<jsp:include page="./page/header.jsp"></jsp:include>
	<div class="container">
		<main class="main" role="main" id="articles">
			<link rel="stylesheet" type="text/css" href="./css/abourt.css" media="screen">
			<div class="post istop cate1 auth1" id="abourt">
				<div id="abourtBox">
					<div id="leftBox">
						<img alt="" src="/images/user.jpg">
						<div id="myName">Perfree</div>
					</div>
					<div id="rightBox">
						<div id="city">
							<span><i class="fa fa-home"></i> 城市:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa fa-map-marker"></i> 开封</span>
						</div>
						<div id="qq">
							<span><i class="fa fa-qq"></i> QQ:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;741223257</span>
						</div>
						<div id="weibo">
							<span><i class="fa fa-weibo"></i> 微博:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="https://weibo.com/gbcxf" target="_blank">隔壁村小飞</a></span>
						</div>
						<div id="github">
							<span><i class="fa fa-github"></i> github:&nbsp;&nbsp;&nbsp;<a href="https://github.com/perfree" target="_blank">perfree</a></span>
						</div>
						<div id="absBox">
							<span>生活的过往成为了回忆，但人生并不是活在回忆，我们对待人生的态度，就是化解苦难和感恩幸福，用对幸福积极的信念，去沟通和改造那些种种的可能，活好这当下，去改变，人生最大的富有，就在于我们还能够面对生活，所以更不必要挑剔生活的突兀和冷暖。</span>
						</div>
					</div>
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