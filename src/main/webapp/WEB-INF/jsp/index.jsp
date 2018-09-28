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
<title>Perfree的个人博客-首页</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath }/images/favicon.ico" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="./css/style.css"
	media="screen">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/font-awesome.min.css"
	media="screen">
<script src="./js/jquery-2.2.4.min.js" type="text/javascript"></script>
</head>
<body>
	<jsp:include page="./page/header.jsp"></jsp:include>
	<div class="container">
		<link rel="stylesheet" href="./css/simplePaging.css">
		<script src="./js/simplePaging.min.js"></script>
		<main class="main" role="main" id="articles">
		<div class="rslides_container">
			<ul class="rslides" id="slider">
				<c:forEach var="content" items="${contents }">
					<li><a href="#" target="_blank" id="content" ><img src="${content.imageUrl }" alt="图片走丢了=="></a></li>
				</c:forEach>
			</ul>
		</div>
		<div class="clear"></div>
		<div class="post istop cate1 auth1" id="stick">
		</div>
		<div id="articles">
		</div>
		</main>
		<script type="text/javascript">
		$("#articles").append("<div class='loading'></div>");
		$.ajax({
			type: 'POST',
			url: '/protal/getStickArticles.action',
			dataType: 'json',
			success: function(data){
				$("#articles > .loading").remove();
				$("#stick > h2").remove();
				if(data.status==200){
					var sticks="";
					$.each(data.data,function(index,item){
						sticks+="<h2>"+
							"<span>置顶<span id='stickTex'>推荐</span></span> <a href='/toArticle/"+item.id+".html' title='"+item.title+"'>"+item.title+"</a>"+
							"</h2>";
					});
					$("#stick").append(sticks);
				}else{
				}
			}
		});
		getNewArticles(1);
		 function getNewArticles(page) {
			 $.ajax({
					type: 'POST',
					url: '/protal/getNewArticles.action',
					data: {"page":page,"pageSize":8},
					dataType: 'json',
					success: function(data){
							var articles="";
							$("#articles > #newArticle").remove();
							$("#articles > #pages").remove();
							$.each(data.list,function(index,item){
								commonTime = timestampToTime(item.updateTime);
								articles+="<article class='post cate1 auth1' id='newArticle'>"+
											"<div class='thumb'>"+
												"<a href='/toArticle/"+item.id+".html' title='"+item.title+"' target='_blank'>"+
													"<img alt='"+item.title+"' src='"+item.imageUrl+"'>"+
												"</a>"+
											"</div>"+
											"<span class='post-cat'>"+
												"<a href='/protal/toBoard/"+item.boardId+".html' title='"+item.boardName+"' target='_blank'>"+item.boardName+"</a>"+
											"</span>"+
											"<h2>"+
												"<a href='/toArticle/"+item.id+".html' title='"+item.title+"' target='_blank'>"+item.title+"</a>"+
											"</h2>"+
											"<div class='entry loop-entry'>"+
												"<p>"+item.context+"</p>"+
											"</div>"+
											"<div class='postmeta'>"+
												"<span><i class='fa fa-clock-o'></i> "+commonTime+"</span> <span><i class='fa fa-eye'></i> "+item.pageView+"</span> <span><i class='fa fa-comment-o'></i> "+item.revertNum+"</span>"+
											"</div></article> ";
							});
							$("#articles").append(articles);
							$("#articles").append("<div class='post cate1 auth1' id='pages'><div class='simplePaging'></div></div>");
							var newPage =page;
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
									getNewArticles(newPage);
								}
					            }
					        });
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