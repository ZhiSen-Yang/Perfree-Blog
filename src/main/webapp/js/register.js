/*
* @Author: galen
* @Date:   2018-01-05 09:37:55
* @Last Modified by:   galen
* @Last Modified time: 2018-01-05 09:37:55
*/

$(document).ready(function(){

	$(".close_rzb_career_advice").click(function(){
		$(".rzb_career_advice").hide();
	});

    $(".pi-tab a").click(function(){
        var index= $(this).index();
        $(".pi-user-info-top").eq(index).show().siblings().hide();
    });

   /*
      注册页面的短信验证码ajax发送
    */

   $(".get_code").click(function () {


       var  userPhone=$("#phone").val();
       console.log("进入log");
        $.ajax({
            type: 'get',
            url: '/getsms',
            data:{"userPhone":userPhone},
            success:function(res) {
               /*
                  开始倒计时
                */
                if(res=="success"){

                    $(".get_code").css({"background-color":"#f0f0f0","color":"#bbb"});
                    var count=60;
                    var timer= setInterval(function () {
                        console.log("进来了");
                        if(count>0){
                            $(".get_code").text(count+"秒后重新获取");

                            count--;
                        }else{
                            $(".get_code").text("重新获取");
                            $(".get_code").css({"background-color":"#897d6b","color":"#fff"});
                            clearInterval(timer);
                        }
                    },1000)

                }else if(res=="fail"){

                    alert("用户已存在,请直接登录");
                    setTimeout("window.location.href='/login'",1000);
                }

            }


       });
   });
   /**
    * 登录时候电话号码校验
    */
	$("#phone").focus(function(){
        $(".legal_input").hide();
         $(".error_info").html("");
   		 }).blur(function(){
         var myreg=/^[1][3,4,5,7,8][0-9]{9}$/;
            if($("#phone").val() == "" || $("#phone").val().length == 0){
             $(".error_info").html("*手机号码不能为空！");
            }else if (!myreg.test($("#phone").val())) {
               $(".error_info").html("*电话号码错误！");
            } else {
                 $(".legal_input").show();
            }
	  });
		/**
		 * 注册页面密码验证
		 */
	$("#pass").focus(function(){
		$(".error_pass").html("*密码只能包含数字，字母，下划线，最少有六位数组成!");
		$(".legal_password").hide();
   		 }).blur(function(){
   			var zz=/^([\d]|[\w]){6,16}$/;
   			if($("#pass").val()=="" || $("#pass").val().length==0){
				$(".error_pass").html("*密码不能为空！");
			}else if(!zz.test($("#pass").val())){
				$(".error_pass").html("*密码格式错误！");
			}else  if($("#password").val() != $("#pass").val()){
				$(".legal_password").hide();
				$(".error_pass").html("");
			}else{
				$(".legal_password").show();
				$(".error_pass").html("");
			}	
	  });
	$("#password").blur(function(){
		
		if($("#password").val()=="" || $("#password").val().length==0){
			$(".error_password").html("*密码不能为空！");
		}else if($("#password").val() == $("#pass").val()){
			$(".legal_password").show();
		}else{
			$(".legal_password").hide();
			$(".error_password").html("*两次密码不一致，请重新输入！");
			
		}	
	}).focus(function(){
		$(".error_password").html("");
		
	});
	
    /*
     登录时候使用的loginsms
     */
    $(".get_code_login").click(function () {
        var  userPhone=$("#phone").val();
        console.log("进入log");
        $.ajax({
            type: 'get',
            url: '/loginsms',
            data:{"userPhone":userPhone},
            success:function(res) {
                /*
                   开始倒计时
                 */
                console.log(res);
                if(res=="success"){
                    $(".get_code_login").css({"background-color":"#f0f0f0","color":"#bbb"});
                    var count=60;
                    var timer= setInterval(function () {
                        console.log("进来了");
                        if(count>0){
                            $(".get_code_login").text(count+"秒后重新获取");

                            count--;
                        }else{
                            $(".get_code_login").text("重新获取");
                            $(".get_code_login").css({"background-color":"#897d6b","color":"#fff"});
                            clearInterval(timer);
                        }
                    },1000)

                }else{
                    alert("验证码获取失败");
                }
            }


        });
    });



})