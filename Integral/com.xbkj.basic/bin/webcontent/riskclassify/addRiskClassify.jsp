<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@include file="/coframe/tools/skins/common.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- 
  - Author(s): lwl
  - Date: 2016-07-05 15:22:34
  - Description:
-->
<head>
<title>新建</title>
</head>
<body>
	<div id="form1" method="post" class="nui-fit" style="height:85%">
		<input id="parent_code" name="parent_code" class="nui-hidden" />
		<input id="classify_level" name="classify_level" class="nui-hidden" />
		<table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table_new">
			<tr>
				<td class="nui-form-label">分类编码：</td>
				<td>
					 <input id="classify_code" name="classify_code" class="nui-textbox nui-form-input" onvalidation="onCodeValidation" required="true" vtype="maxLength:20"/>
				</td>
				<td class="nui-form-label">分类名称：</td>
				<td>
					 <input id="classify_name"  name="classify_name" class="nui-textbox nui-form-input" onvalidation="validateName" required="true" vtype="maxLength:100"/>
				</td>
			</tr>
			<tr>
				<td class="nui-form-label">是否为叶子节点：</td>
				<td>
 					<input id="isLeaf" class="nui-combobox nui-form-input" name="isLeaf" value="0" valueField="id" textField="text" data="isLeaf"/>
				</td>
			</tr>
			<tr>
				<td class="nui-form-label">举例说明：</td>
				<td  colspan="3">
					<input id="explain" class="nui-textarea nui-form-input" name="explain" style="width:300px;height:60px;" vtype="maxLength:200"/> 
				</td>
			</tr>
		</table>
	</div>
		<div class="nui-toolbar" style="text-align:center;padding:0px;height:15%;" borderStyle="border:0;">
	        <a class="nui-button" style="width:60px;" iconCls="icon-save" onclick="saveData()">保存</a>
	        <span style="display:inline-block;width:25px;"></span>
	        <a class="nui-button" style="width:60px;" iconCls="icon-cancel" onclick="cancel()">取消</a>
	    </div>  
</body>
<script type="text/javascript">
 	var isLeaf = [{id:0,text:'否'},{id:1,text:'是'}];
	nui.parse();
	var form = new nui.Form("#form1");
	var pid = "";
	//保存
    function saveData(){
	    //校验
		form.validate();
		if(form.isValid() == false){
			return;
		}
		//得到数据
		var o = form.getData(true, true);
		if(pid == ""){
			//设置pid
			o.parent_code = "root";	
		}else{
			//设置pid
			o.parent_code = pid;
		}
		var json = nui.encode({vo:o});
		nui.ajax({
			url:"com.vbm.grc.basic.risk.classify.riskclassify.addRiskClassify.biz.ext",
			cache:false,
			data:json,
			type:"POST",
			contentType:"text/json",
			success: function(msg){
				if(msg.msg.flag){
					nui.alert(msg.msg.message);
					CloseWindow("ok");
					return;
				}else{
					nui.alert(msg.msg.message);
					CloseWindow("close");
					return;
				}
			},
			error: function (jqXHR, textStatus, errorThrown) {
                alert(jqXHR.responseText);
                CloseWindow();
            }
		});
    }
    //校验分类编码
    function onCodeValidation(e){
		//得到输入的编码
		var val = e.value;
		if(val == "" || val == null){
			e.isValid = false;
		}
		var regu = "^[0-9a-zA-Z]*$"
		var re = new RegExp(regu);
		if(!re.test(val)){
			//输入的特殊字符
			e.isValid = false;
			nui.alert("分类编码由数字字母组成，请重新填写");
			return;
		}	
		var json = nui.encode({vo:{classify_code:val}});
		$.ajax({
			url:"com.vbm.grc.basic.risk.classify.riskclassify.validateRiskClassifyCode.biz.ext",
			cache:false,
			data:json,
			type:"POST",
			contentType:"text/json",
			success: function(action){
				if(action.result > 0){
					e.isValid = false;
					nui.alert("编码 "+val+" 重复");
					return;
				}
				if(action.result == -1){
					e.isValid = false;
					nui.alert("分类编码为空");
					return;
				}
			}
		});
			
		}
	//校验业务领域名称
	function validateName(e){
		var val = e.value;
		var reg = new RegExp("^[\u2E80-\u9FFF]*$");
		if(!reg.test(val)){
			//输入的特殊字符
			e.isValid = false;
			nui.alert("分类名称只能输入中文！");
			return;
		}
	}
	//初始化数据，得到parentCode
	function SetData(data){
		//跨页面的数据，必须克隆才可以使用
		data = nui.clone(data);
		pid = data.parentCode;
		var level = data.level;
		//Number是js内置对象。不用Number层级会出现乱序（层级顺序出错）
		level = Number(level) +1;
		//设置层级 
		nui.get("classify_level").setValue(level);
		//设置pid
		nui.get("parent_code").setValue(pid);
	}
	//关闭窗口
	function CloseWindow(action) {            
        if (action == "close" && form.isChanged()) {
            if (confirm("数据被修改了，是否先保存？")) {
                return false;
            }
        }
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();            
    }
    function cancel(e) {
        CloseWindow("cancel");
    }	
</script>
</html>