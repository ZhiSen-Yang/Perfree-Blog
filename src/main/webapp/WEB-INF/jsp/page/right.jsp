<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<aside class="sidebar">
	<section class="widget" id="search">
		<h3>
			<i class="fa fa-search"></i> 搜索
		</h3>
		<div>
			<form name="formsearch" action="/protal/toSearchArticle.html" method="post" id="formsearch">
				<input type="text" name="search" size="11" id="searchText" onfocus="removeTip();"/> <input type="button"
					value="搜索" onclick="searchSubmit();"/>
			<div id="searchTip"></div>
			</form>
		</div>
	</section>
	<section class="widget" id="scroll">
		<h3>
			<i class="fa fa-fire"></i> 热门文章
		</h3>
	</section>
</aside>
<script type="text/javascript">
		$.ajax({
			type: 'POST',
			url: '/protal/getHotArticles.action',
			dataType: 'json',
			success: function(data){
				if(data.status==200){
					$("#scroll > ul").remove();
					var hots="";
					$.each(data.data,function(index,item){
					commonTime = timestampToTime(item.updateTime);
						hots+="<ul class='hot-post'>"+
									"<li>"+
										"<div class='thumb'>"+
											"<a href='/toArticle/"+item.id+".html' title='"+item.title+"'>"+
												"<img src='"+item.imageUrl+"' alt='"+item.title+"'>"+
											"</a>"+
										"</div>"+
										"<div class='hot-title'>"+
											"<a href='/toArticle/"+item.id+".html' title='"+item.title+"'>"+item.title+"</a>"+
										"</div>"+
										"<div class='hot-time'>"+
											"<i class='fa fa-clock-o'></i> "+commonTime+""+
										"</div>"+
								"</li>"+
							"</ul>";
					});
					$("#scroll").append(hots);
				}else{
				}
			}
		
	});
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
		function searchSubmit() {
			var searchText = $("#searchText").val();
			if(searchText != null && searchText != ""){
				$("#formsearch").submit();
			}else{
				$("#searchTip").text("请输入搜索内容~");
			}
		}
		function removeTip() {
			$("#searchTip").text("");
		}
</script>
