<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../js/admin/static/h-ui/css/H-ui.min.css" rel="stylesheet"
	type="text/css" />
<link href="../js/admin/static/h-ui.admin/css/H-ui.admin.css"
	rel="stylesheet" type="text/css" />
<link href="../js/admin/lib/Hui-iconfont/1.0.8/iconfont.css"
	rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css"
	href="../js/admin/static/h-ui.admin/css/style.css" />
<link rel="stylesheet" type="text/css"
	href="../js/admin/static/h-ui.admin/skin/green/skin.css" id="skin" />
<title>文章列表</title>
</head>
<body>
	<nav class="breadcrumb"> <i class="Hui-iconfont">&#xe67f;</i> 首页
	<span class="c-gray en">&gt;</span> 文章管理 <span class="c-gray en">&gt;</span>
	文章列表 <a class="btn btn-success radius r"
		style="line-height: 1.6em; margin-top: 3px"
		href="javascript:location.replace(location.href);" title="刷新"><i
		class="Hui-iconfont">&#xe68f;</i></a></nav>
	<div class="page-container">
		<div class="text-c">
			<label><span class="c-red">*</span>选择分类：</label> <span
				class="select-box inline"> <select class="select" size="1"
				name="parentId1" onchange="parent1()" id="pid1">
					<option value="0">----请选择-----</option>
					<c:forEach items="${parents}" var="parentBoard1">

						<option value="${parentBoard1.id }">${parentBoard1.name }</option>
					</c:forEach>
			</select>
			</span> <span class="select-box inline"> <select class="select"
				size="1" name="boardId1" id="child1" onchange="getArticle();">
					<!-- 动态追加option -->
					<option value="0">---请选择----</option>
			</select>
			</span>
		</div>
		<div class="cl pd-5 bg-1 bk-gray mt-20">
			<span class="l"><a href="javascript:;" onclick="datadel()"
				class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i>
					批量删除</a></span> <span class="r" id="pageCount">共有数据：<strong>0</strong> 条
			</span>
		</div>
		<div class="mt-20">
			<table
				class="table table-border table-bordered table-bg table-hover table-sort table-responsive" id="articleList">
				<thead>
					<tr class="text-c">
						<th width="30"><input type="checkbox" name="" value=""></th>
						<th width="120">ID</th>
						<th>标题</th>
						<th width="100">分类</th>
						<th width="150">更新时间</th>
						<th width="60">浏览次数</th>
						<th width="60">文章状态</th>
						<th width="120">操作</th>
					</tr>
				</thead>
				<tbody id="articles" class="text-c">
				</tbody>
			</table>
		</div>
	</div>
	<jsp:include page="./page/common.jsp"></jsp:include>
	<script type="text/javascript"
		src="../js/admin/lib/My97DatePicker/4.8/WdatePicker.js"></script>
	<script type="text/javascript"
		src="../js/admin/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
	<script type="text/javascript"
		src="../js/admin/lib/laypage/1.2/laypage.js"></script>
	<script type="text/javascript">
function article_edit(title,url,id,w,h){
	var index = layer.open({
		type: 2,
		title: title,
		content: url,
		end:function(){           //这个是无论是确认还是取消，只要层被销毁了，end都会执行，不携带任何参数。
			//窗口关闭后，会执行这里的代写,刷新代码写就可以了
			getArticle();
			}
	});
	layer.full(index);
}



//分类下拉框
function parent1() {
	var pid = $("#pid1").val();
	if (pid == 0) {
		layer.confirm('请选择一级分类!', {btn: ['确定'], title: "提示"});
		return;
	}
			$.post(
					"/getchildBoard.action",
					{
						pid : pid
					},
					function(data) {
						var optionString = "<option value='0'>---请选择----</option>";
						var beanList = data; //返回的json数据
						if (beanList) { //判断
							for (var i = 0; i < beanList.length; i++) { //遍历，动态赋值
								optionString += "<option grade=\""+beanList[i].id+"\" value=\""+beanList[i].id+"\"";  
	                        optionString += ">"
										+ beanList[i].name
										+ "</option>"; //动态添加数据  
							}
							$("select[name=boardId1]")
									.append(optionString); // 为当前name为asd的select添加数据。
						}
						;
						$("#child1").html(optionString);//清除下拉框

					});
		}
$('.table-sort').DataTable({});
		function getArticle(){
			var childBoardId = $("#child1").val();
			if (childBoardId == 0) {
				var datatable = $('.table-sort').dataTable();
				 if (datatable) {  
			         datatable.fnClearTable();    //清空数据
			         datatable.fnDestroy();         //销毁datatable
			        } 
				 $('.table-sort').DataTable({});
				 $("#pageCount > strong").text(0);
				return;
			}
			var datatable = $('.table-sort').dataTable();
	        if (datatable) {  
	         datatable.fnClearTable();    //清空数据
	         datatable.fnDestroy();         //销毁datatable
	        } 
			$.fn.dataTable.ext.errMode = "throw";
			    var table = $('.table-sort').DataTable( {
			    	  ajax: {
			              url: '/article/list.action',
			              data: {"boardId":childBoardId},
			              type: 'POST'
			           }, 
			        "columns": [
			            { "data": null },
			            { "data": "id" },
			            { "data": "title" },
			            { "data": "boardName" },
			            { "data": "updateTime", 
			            	"render" : function(data, type, full, meta) {
			            		var unixTimestamp = new Date(data) ;
								commonTime = unixTimestamp.toLocaleString();
								return  commonTime;
								}	
			            },
			            { "data": "pageView" },
			            { "data": "stick" , 
			            	"render" : function(data, type, full, meta) {
			            		if(data == 1){
			            			return "置顶";
			            		}else{
									return  "正常";
			            		}
								}	
			            },
			            { "data": null }
			        ],
			        "columnDefs": [
			     // 增加一列，包括删除和修改，同时将我们需要传递的数据传递到链接中
	                  {
	                      "targets": [0], // 目标列位置，下标从0开始
	                      "data": "id ", // 数据列名
	                      "render": function(data, type, full) { // 返回自定义内容
	                          return "<input type='checkbox' value='"+data.id+"' name='ids'>"+
	                          "<input type='hidden' value='"+data.imageUrl+"' name='imageUrl'>";
	                      }
	                      },
		                  // 增加一列，包括删除和修改，同时将我们需要传递的数据传递到链接中
		                  {
		                      "targets": [7], // 目标列位置，下标从0开始
		                      "data": "id", // 数据列名
		                      "render": function(data, type, full) { // 返回自定义内容
		                          return "<a style='text-decoration: none'"+
										"onClick='article_stick(this,"+data.id+","+data.stick+");' href='javascript:;'"+
										"class='ml-5' title='置顶/取消置顶'><i class='Hui-iconfont'>&#xe6dc;</i></a>"+
										"<a style='text-decoration: none'"+
										"onClick='article_revert(\"所属文章:&nbsp;&nbsp;&nbsp;"+data.title+"\",\"/admin/revert-list/"+data.id+".html\",800,400)' href='javascript:;'"+
										"class='ml-5' title='评论管理'><i class='Hui-iconfont'>&#xe622;</i></a>"+
										"<a style='text-decoration: none' class='ml-5'"+
										"onClick='article_edit(\"文章编辑\",\"/article/toEdit/"+data.id+"/"+data.boardId+".html\",10001)'"+
										"href='javascript:;' title='编辑'><i class='Hui-iconfont'>&#xe6df;</i></a>"+
										"<a style='text-decoration: none' class='ml-5'"+
										"onClick='article_del(this,"+data.id+",\""+data.imageUrl+"\");' href='javascript:;'"+
										"title='删除'><i class='Hui-iconfont'>&#xe6e2;</i></a>";
		                      }
		                  }
		              ],
		              "fnInitComplete": function (oSettings, json) {
		            	  $("#pageCount > strong").text(json.recordsFiltered);
		              }
			    } );
		}
		
		/*删除*/
		function article_del(obj,id,imageUrl){
			layer.confirm('文章及其评论都将删除,确认删除吗？',function(index){
				$.ajax({
					type: 'POST',
					url: '/article/del.action',
					data: {"id":id+",","imageUrl":imageUrl+","},
					dataType: 'json',
					success: function(data){
						if (data.status==200) {
							layer.msg('已删除!',{icon:1,time:1000});
							getArticle();
						}else{
							layer.msg(data.msg,{icon:2,time:1000});
						}
					},
					error:function(data) {
						layer.msg(data.msg,{icon:2,time:1000});
					},
				});		
			});
		}
		//批量删除
		function datadel(){
			var checkedbox = $("input[name='ids']:checked");
			if(checkedbox.length == 0){
				layer.confirm('请选择要删除的文章!', {btn: ['确定'], title: "提示"});
			}
			var ids = "";
			var imageUrl="";
			var box = $("input[name='ids']:checked").each(function(j) {
			    if (j >= 0) {
			       ids += $(this).val() + ","
			       imageUrl+=$(this).siblings("input[name='imageUrl']").val()+",";
			    }
			});
				layer.confirm('文章及其评论都将删除,确认删除吗？',function(index){
					$.ajax({
						type: 'POST',
						url: '/article/del.action',
						data: {"id":ids,"imageUrl":imageUrl},
						dataType: 'json',
						success: function(data){
							layer.msg('已删除!',{icon:1,time:1000});
							getArticle();
						},
						error:function(data) {
							layer.msg(data.msg,{icon:2,time:1000});
						},
					});	
				});
			}
		/*置顶*/
		function article_stick(obj,id,stick){
			var tip = "";
			var succ = "";
			if(stick==0){
				tip="确定要置顶吗?";
				succ="置顶成功";
			}else{
				tip="确定要取消置顶吗?";
				succ="取消置顶成功";
			}
			layer.confirm(tip,function(index){
				$.ajax({
					type: 'POST',
					url: '/article/stick.action',
					data: {"id":id,"stick":stick},
					dataType: 'json',
					success: function(data){
						layer.msg(succ,{icon:1,time:1000});
						getArticle();
					},
					error:function(data) {
						layer.msg(data.msg,{icon:2,time:1000});
					},
				});		
			});
		}
		function article_revert(title,url,w,h,id){
			layer.open({
				type: 2,
				area: [w+'px', h +'px'],
				fix: false, //不固定
				maxmin: true,
				shade:0.4,
				title: title,
				content: url
				});
		}
</script>

</body>
</html>