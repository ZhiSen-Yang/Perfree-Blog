<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Perfree的个人博客-管理登录</title>
 <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<link href="${pageContext.request.contextPath }/js/login/css/style.css" rel="stylesheet" type="text/css" media="all" />
<link href="${pageContext.request.contextPath }/js/login/css/font-awesome.css" rel="stylesheet"> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/js/login/css/verify.css">
<script src="${pageContext.request.contextPath }/js/login/js/jquery.min.js"></script> 
<script src="${pageContext.request.contextPath }/js/login/js/script.js"></script> 

</head>
<body>
	<!-- main -->
	<div class="main-agile">
		<div id="w3ls_form" class="signin-form">
			<!-- Sign In Form -->
			<form id="signin" action="/admin/subLogin.action" method="post">
				<h2>后台登录</h2>
				<input type="text" name="phone" placeholder="请输入手机号码" onchange="checkMobile(this.value);" value="${user.phone }" onfocus="onFocus();" id="loginPhone"/>
				<input type="password" name="password" placeholder="密码" required="true" onfocus="onFocus()" value="${user.password }" id="pass"/>	 
				<div id="mpanel1">
        		</div>
				<!-- <input type="checkbox" id="brand" value="">
				<label for="brand"><span></span> 记住我 ?</label>  -->
				<span id="tip">${error }</span><br>
				<input type="button" value="立即登录" onclick="subLogin();">
				<!-- <div class="signin-agileits-bottom"> 
					<p><a href="#">忘记密码 ?</a></p>    
				</div>  -->
			</form>
			<!-- //Sign In Form -->
			<!-- Sign up Form-->
			<form id="signup" action="#" method="post">
				<div class="ribbon"><a href="#" id="flipToRecover1" class="flipLink" title="点我登录">登录</a></div>
				<h3>注册账号</h3>
				<input type="text" name="User Name" placeholder="请输入手机号码" required="" onchange=""/>
				<input type="text" name="Email" placeholder="请输入昵称" required=""/>
				<input type="password" name="Password" placeholder="密码" required=""/>	
				<input type="checkbox" id="brand1" value="">
				<span id="tip">${error }</span><br>
				<input type="button" value="立即注册"> 
			</form>
			<!-- Sign up Form-->
		</div>
		<!-- copyright -->
		<div class="copyright">
			<p> Copyright © 2018 Perfree 版权所有 &nbsp; &nbsp; &nbsp;<a
				href="${pageContext.request.contextPath }/admin/index.html" title="网站后台" >网站后台</a></p>
		</div>
		<!-- //copyright -->  
	</div>	
	 <script type="text/javascript" src="${pageContext.request.contextPath }/js/login/js/verify.js" ></script>
	<script type="text/javascript">
	var code = -1;
	var phone = -1;
	$('#mpanel1').slideVerify({
		type : 1,		//类型
		vOffset : 5,	//误差量，根据需求自行调整
        barSize : {
        	width : '100%',
        	height : '40px',
        },
        ready : function() {
    	},
        success : function() {
        	code=1;
        },
        error : function() {
        	code = -1;
        }
        
    });
	//验证手机号
	function checkMobile(str) {
	  var re = /^1\d{10}$/;
	  if (re.test(str)) {
	    phone = 1;
	  } else {
		phone = -1;
	  }
	}
	//登录
	function subLogin() {
		var loginPhone = $("#loginPhone").val();
		checkMobile(loginPhone);
		if(phone==1){
			var pass = $("#pass").val();
			if(pass ==null||pass==""){
				$("#tip").text("请输入密码~");
			}else{
				if(code==-1){
					$("#tip").text("请滑动验证~");
				}else{
					$("#tip").text("");
					 $("#signin").submit();
				}
			}
		}else{
			$("#tip").text("请输入正确的手机号~");
		}
	}
	
	//获取焦点事件
	function onFocus() {
		$("#tip").text("");
	}
	</script>
</body>
</html>