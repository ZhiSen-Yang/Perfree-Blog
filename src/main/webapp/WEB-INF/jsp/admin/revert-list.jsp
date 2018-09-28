<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
<title>文章列表</title>
</head>
<body>
	<nav class="breadcrumb"> <i class="Hui-iconfont">&#xe67f;</i> 首页
	<span class="c-gray en">&gt;</span> 评论管理 <span class="c-gray en">&gt;</span>
	评论列表 <a class="btn btn-success radius r"
		style="line-height: 1.6em; margin-top: 3px"
		href="javascript:location.replace(location.href);" title="刷新"><i
		class="Hui-iconfont">&#xe68f;</i></a></nav>
	<div class="page-container">
		<div class="row cl">
			<div class="formControls col-xs-8 col-sm-10">
				<c:choose>
					<c:when test="${reverts[0] != null }">
						<c:forEach var="revert" items="${reverts }" varStatus="i">
							<ul class="commentList">
								<li class="item cl">
									<a href="#">
										<i class="avatar size-L radius">
											<c:choose>
												<c:when test="${revert.image != null }">
													<img alt="" src="${revert.image }">
												</c:when>
												<c:otherwise>
													<img alt="" src="${pageContext.request.contextPath }/js/admin/static/h-ui/images/ucnter/avatar-default.jpg">
												</c:otherwise>
											</c:choose>
										</i>
									</a>
									<div class="comment-main">
										<header class="comment-header">
										<div class="comment-meta">
											<span>#${i['index']+1 }楼</span>
											<a class="comment-author" href="#">${revert.nickname }</a> 评论于
											<time>
												<fmt:formatDate value="${revert.createTime }" pattern="yyyy-MM-dd HH:mm:ss" />
											</time>
											<a style="text-decoration: none" class="ml-5"
										onClick="article_del(this,'${revert.id }')" href="javascript:;"
										title="删除"><i class="Hui-iconfont">&#xe6e2;</i></a>
										</div>
										</header>
										<div class="comment-body">
											<p>
											${revert.context }
											</p>
										</div>
									</div></li>
							</ul>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<h5>还没有人评论哦~</h5>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
	<jsp:include page="./page/common.jsp"></jsp:include>
	<script type="text/javascript">
		/*删除*/
		function article_del(obj, id) {
			layer.confirm('确认要删除吗？', function(index) {
				$.ajax({
					type : 'POST',
					url : '/revert/del.action',
					data: {"id":id},
					dataType : 'json',
					success : function(data) {
						if(data.status == 200){
							$(obj).parents("ul").remove();
							layer.msg('已删除!', {
								icon : 1,
								time : 1000
							});
						}else{
							layer.msg(data.msg, {
								icon : 2,
								time : 1000
							});
						}
					},
					error : function(data) {
						layer.msg(data.msg, {
							icon : 2,
							time : 1000
						});
					},
				});
			});
		}
	</script>
</body>
</html>