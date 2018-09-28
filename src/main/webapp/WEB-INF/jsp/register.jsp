<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Perfree的个人博客-注册</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath }/images/favicon.ico" type="image/x-icon">
 <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<link href="${pageContext.request.contextPath }/js/login/css/style.css" rel="stylesheet" type="text/css" media="all" />
<link href="${pageContext.request.contextPath }/js/login/css/font-awesome.css" rel="stylesheet"> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/js/login/css/verify.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/js/dialog/sweetalert.css">
<script src="${pageContext.request.contextPath }/js/login/js/jquery.min.js"></script> 
<script src="${pageContext.request.contextPath }/js/login/js/script.js"></script> 
<script src="${pageContext.request.contextPath }/js/dialog/sweetalert.min.js"></script>
</head>
<body>
	<!-- main -->
	<div class="main-agile">
		<div id="w3ls_form" class="signin-form">
			<!-- Sign up Form-->
			<form id="signin" action="/subRegister.action" method="post">
				<a href="/login.html" title="点我登录" style="color:#009ffb;">登录</a>
				<h3>注册账号</h3>
				<input type="text" name="phone" placeholder="请输入手机号码" required="true"  onblur="checkMobile(this.value);" value="${user.phone }" id="loginPhone"/>
				<input type="text" name="nickname" placeholder="请输入昵称" required="true" onblur="checkNick(this.value);" value="${user.nickname }" id="nickname"/>
				<input type="password" name="password" placeholder="密码" required="true" onblur="checkPass(this.value);" value="${user.password }" id="pass"/>	
				<div id="mpanel1">
        		</div>
				<span id="tip">${error }</span><br>
				<input type="button" value="立即注册" onclick="subRegister();"> 
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
	var pass = -1;
	var nick = -1;
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
	    $.ajax({
            type: "POST",
            dataType: "json",
            url: "/regxPhone.action" ,//url
            data: {"phone":str},
            success: function (data) {
                if (data.status == 200) {
                	 $("#tip").text("");
                	 phone = 1;
                }else{
				    $("#tip").text("手机号已存在,请直接登录~");
				    phone = -1;
                }
            }
        });
	  } else {
		phone = -1;
		$("#tip").text("请输入正确的手机号~");
	  }
	}
	
	//验证昵称
	function checkNick(str){
		if(str.length<4 || str.length>16){
			nick = -1;
			$("#tip").text("昵称长度应在4-16位之间~");
		}else{
			$.ajax({
	            type: "POST",
	            dataType: "json",
	            url: "/checkNick.action" ,//url
	            data: {"nickname":str},
	            success: function (data) {
	                if (data.status == 200) {
	                	 $("#tip").text("");
	                	 nick = 1;
	                }else{
					    $("#tip").text("昵称已存在,换一个试试~");
					    nick = -1;
	                }
	            }
	        });
		}
	}
	//验证密码
	function checkPass(str) {
	  var re = /^[a-zA-Z]\w{5,17}$/;
	  if (re.test(str)) {
	    pass = 1;
	    $("#tip").text("");
	  } else {
		pass = -1;
		$("#tip").text("密码长度应在6-18之间且以字母开头~");
	  }
	}
	//注册
	function subRegister() {
		var loginPhone = $("#loginPhone").val();
		var nickname = $("#nickname").val();
		var password = $("#pass").val();
		checkMobile(loginPhone);
		checkNick(nickname);
		checkPass(password);
		if(phone==1){
			if(nick == 1){
				if(pass ==-1){
					$("#tip").text("密码长度应在6-18之间且以字母开头~");
				}else{
					if(code==-1){
						$("#tip").text("请滑动验证~");
					}else{
						$("#tip").text("");
						 $.ajax({
					            //几个参数需要注意一下
				                type: "POST",//方法类型
				                dataType: "json",//预期服务器返回的数据类型
				                url: "/subRegister.action" ,//url
				                data: $('#signin').serialize(),
				                success: function (data) {
				                    if (data.status == 200) {
				                    	swal({title:"注册成功",
	                                          text:"赶快去登录吧~",
	                                          type:"success"},function(){window.location="/login.html"});
				                    }else{
				                    	swal({title:"注册失败",
	                                          text:"再试一试?",
	                                          type:"error"});
				                    }
				                    ;
				                },
				                error : function() {
				                	swal({title:"注册失败",
                                        text:"再试一试?",
                                        type:"error"});
				                }
				            });
						 
						 
					}
				}
			}else{
				$("#tip").text("昵称格式错误或昵称已存在");
			}
			
		}else{
			$("#tip").text("手机号错误或手机号已存在~");
		}
	}
	
	</script>
</body>
</html>