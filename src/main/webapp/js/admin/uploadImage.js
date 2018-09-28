var oldUrls="";
function fileChange(imageUpload) {
			$("#fengmiannBox > #imgTip").remove();
			$("#fengmiannBox > #fengmianImg").remove();
			var tip = "<span id='imgTip'><i class='Hui-iconfont'>&#xe642;</i>正在上传......</span>";
			$("#fengmiannBox").append(tip);
			var formData = new FormData();
			formData.append("editormd-image-file", $("#fengmian")[0].files[0]);
			var oldUrl = $("#imageUrl").val();
			if(oldUrl != null && oldUrl !=""){
				setUrls(oldUrl);
			}
			$.ajax({
						url : '/imageUpload.action',
						type : 'post',
						data : formData,
						processData : false,
						contentType : false,
						dataType : 'json',
						success : function(data) {
							if(data.success==1){
								$("#imageUrl").val(data.url);
								var image = "<img alt='' src='"+data.url+"' width='150px' height='100px' id='fengmianImg'>";
								$("#fengmiannBox > #imgTip").remove();
								$("#fengmiannBox").append(image);
							}else{
								alert(data.message);
								$("#fengmiannBox > #imgTip").remove();
								var tip = "<span id='imgTip'><i class='Hui-iconfont'>&#xe642;</i>请选择图片</span>";
								$("#fengmiannBox").append(tip);
							}
						}
					});
		}
function setUrls(oldUrl){
	oldUrls+=oldUrl+",";
}
function resetUrls(){
	oldUrls="";
}
function getUrls(){
	return oldUrls;
}