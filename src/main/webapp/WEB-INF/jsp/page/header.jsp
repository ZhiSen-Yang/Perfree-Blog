<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<header class="site-header" role="banner">
	<div class="header">        
		<div class="top-box">
			<div class="logo">
				<a href="/" title="Perfree的个人博客"><img
					src="${pageContext.request.contextPath }/images/logo.png" alt="Perfree的个人博客"></a>
			</div>
			<nav class="nav" role="navigation">
				<div class="menu">
					<ul>
						<li id="nvabar-item-index"><a href="/"><i
								class="fa fa-home"></i> 首页</a></li>
						<li id="navbar-category-1"><a href="/board.html"><i
								class="fa fa-bars"></i> 分类</a></li>
						<li id="navbar-category-1"><a href="/tags.html"><i
								class="fa fa-tags"></i> 标签</a></li>
						<li id="navbar-category-1"><a href="/times.html"><i
								class="fa fa-calendar"></i> 时间流</a></li>
						<li id="navbar-page-2"><a href="/abourt.html"><i
								class="fa fa-vcard"></i> 关于我</a></li>
						<c:choose>
							<c:when test="${userSession != null }">
								<li id="navbar-page-2"><a href="javascript:;"><i
								class="fa fa-user-o"></i> ${userSession.nickname }</a>
									<ul>
										<li id="navbar-page-2-1"><a href="javascript:;" onclick="logout();"><i
								class="fa fa-user-times">&nbsp;</i>退出登录</a></li>
									
									</ul>
								</li>
							</c:when>
							<c:otherwise>
								<li id="navbar-page-2">
									<a href="/login.html"><i class="fa fa-plane"></i> 登录&nbsp;|&nbsp;注册</a>
								</li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
				<script type="text/javascript">
					function logout() {
						$.ajax({
							type: 'POST',
							url: '/logout.action',
							success: function(data){
								window.location.reload();
							}
						});
					}
				</script>
			</nav>
		</div>
	</div>
	<div class="clear"></div>
</header>
