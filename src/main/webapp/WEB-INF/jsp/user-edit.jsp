<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="/js/kindeditor-4.1.10/themes/default/default.css" type="text/css" rel="stylesheet">
<script type="text/javascript" charset="utf-8" src="/js/kindeditor-4.1.10/kindeditor-all-min.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/kindeditor-4.1.10/lang/zh_CN.js"></script>
<div style="padding:10px 10px 10px 10px">
	<form id="userEditForm" class="userForm" method="post">
		<input type="hidden" name="id"/>
	    <table cellpadding="5">
			<tr>
				<td>用户名:</td>
				<td><input class="easyui-textbox" type="text" name="username" data-options="required:true" style="width: 280px;"></input></td>
			</tr>
			<tr>
				<td>密码:</td>
				<td><input class="easyui-textbox" type="text" name="password" data-options="required:true" style="width: 280px;"></input></td>
			</tr>
			<tr>
				<td>手机号:</td>
				<td><input class="easyui-textbox" type="text" name="phone" data-options="required:true" style="width: 280px;"></input></td>
			</tr>
			<tr>
				<td>邮箱:</td>
				<td><input class="easyui-textbox" type="text" name="email" data-options="required:true" style="width: 280px;"></input></td>
			</tr>
	    </table>
	</form>
	<div style="padding:5px">
	    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">提交</a>
	</div>
</div>
<script type="text/javascript">

	function submitForm(){
		if(!$('#userEditForm').form('validate')){
			$.messager.alert('提示','表单还未填写完成!');
			return ;
		}

		var paramJson = [];
		$("#userEditForm .params li").each(function(i,e){
			var trs = $(e).find("tr");
			var group = trs.eq(0).text();
			var ps = [];
			for(var i = 1;i<trs.length;i++){
				var tr = trs.eq(i);
				ps.push({
					"k" : $.trim(tr.find("td").eq(0).find("span").text()),
					"v" : $.trim(tr.find("input").val())
				});
			}
			paramJson.push({
				"group" : group,
				"params": ps
			});
		});
		paramJson = JSON.stringify(paramJson);
		
		$("#userEditForm [name=userParams]").val(paramJson);
		
		$.post("/rest/user/update",$("#userEditForm").serialize(), function(data){
			if(data.status == 200){
				$.messager.alert('提示','修改用户成功!','info',function(){
					$("#userEditWindow").window('close');
                    $("#userList").datagrid("reload");
				});
			}
		});
	}
</script>
