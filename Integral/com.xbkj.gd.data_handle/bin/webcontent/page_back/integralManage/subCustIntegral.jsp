<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@include file="/coframe/tools/skins/common.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- 
  - Author(s): rjc
  - Date: 2017-09-06 11:23:07
  - Description: 添加客户积分
-->
<head>
<title>添加客户积分</title>
<body>
	<div id="form1" method="post" class="nui-fit" style="height:80%; width:100%;">
		<center>
		<table >
			<tr>
				<div id="customerIntegral">当前总积分为：</div>  
			</tr> 
			<tr>           
				<td style="text-align:right;">积分：</td>
				<td style="text-align:left;">
					<input id="customer_idcard" class="nui-hidden" name= "customer_idcard" />
					 <input id="customer_integral" name="customer_integral" vtype="float"  class="nui-textbox"
					 	required="true" style="width:200px;" onvaluechanged="onValueChanged"/>
				</td>
			</tr>
			<tr>           
				<td style="text-align:right;">兑换明细：</td>
				<td style="text-align:left;">
					 <input id="conversion_detail"  name="conversion_detail" class="nui-textarea"
					 	 required="true" style="width:200px;height:60px;" />
				</td>
			</tr>
		</table>
		</center>
	</div>
	 <div class="nui-toolbar" style="text-align:center;padding:0px;height:20%;" borderStyle="border:0;">
        <a id="savedata" class="nui-button" style="width:60px;" iconCls="icon-save" onclick="SaveData()">保存</a>
        <span style="display:inline-block;width:25px;"></span>
        <a class="nui-button" style="width:60px;" iconCls="icon-cancel" onclick="onCancel()">取消</a>
    </div>
</body>
	 <script type="text/javascript">
		nui.parse();
		var form = new nui.Form("#form1");
		
		function onValueChanged(e){
			//nui.alert(e.value);
			var val = e.value;
			if(val <= 0){
				nui.alert("积分不能小于等于0！");
			}
		}
		
		var pk_customer_info = "";
		var countIntegral = 0;
		function SetData(data){
			var row = nui.clone(data);
			if(row){
				pk_customer_info = row.pk_customer_info;
				nui.get("customer_idcard").setValue(pk_customer_info);//身份证字段存的是客户主键
				var json = {idcard:pk_customer_info};
				nui.ajax({
					url:"com.xbkj.gd.data_handle.cust.integralManager.countCustInegral.biz.ext",
					data:json,
					cache:false,
					contentType:"text/json",
					success:function(data){
						var data = nui.decode(data);
						countIntegral = data.count;
						/* $("#customerIntegral").val("当前总积分为：asas"); 
						nui.get("customerIntegral").setValue("当前总积分为：" + data.count); */
						document.getElementById("customerIntegral").innerHTML = "当前总积分为：" + countIntegral;
					}
				}); 
				
			}else{
				nui.alert("身份证号为空");
			}
		}
		
		
		//保存损失事件类型记录
		function SaveData(){
			nui.get("savedata").setEnabled(false);//防止反复提交
			//需要判断积分减少后不能为负数。
			
			//校验
			form.validate();
			if(form.isValid() == false){
				return;
			}
			//得到数据
			var o = form.getData(true, true);
			if((countIntegral - o.customer_integral) < 0){
				nui.alert("积分兑换超过了总积分。");
				nui.get("savedata").setEnabled(true)
				return;
			}
			
			if(o.customer_integral <= 0){
				nui.alert("积分必须大于0");
				nui.get("savedata").setEnabled(true)
				return;
			}
			
			var json = nui.encode({flag:"1", vo:o});
			nui.ajax({
				url:"com.xbkj.gd.data_handle.cust.integralManager.modifyIntegral.biz.ext",
				cache:false,
				data:json,
				type:"POST",
				contentType:"text/json",
				success: function(text){
					var msg = nui.decode(text);
					nui.alert(msg.msg.message);
					if(msg.msg.flag){//添加成功关闭，添加不成功，不关闭窗口
						CloseWindow("ok");
					}
					nui.get("savedata").setEnabled(true)
				},
				error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText);
                    CloseWindow();
                }
			});
			nui.get("savedata").setEnabled(true)
		}
		
		//名字校验
		function validateName(e){
			var val = e.value;
			var reg = new RegExp("^[\u2E80-\u9FFF]*$");
			/* if(!reg.test(val)){
				e.isValid = false;//输入的特殊字符
				nui.alert("级别名称只能输入中文！");
				return;
			} */
		}
		
		/*
			校验编码
			空校验
			格式校验（数字和英文）
			唯一性校验
		*/
		function onCodeValidation(e){
			//得到输入的编码
			var val = e.value;
			if(val == "" || val == null){
				e.isValid = false;
				return;
			}
			
			/* var regu = "^[0-9a-zA-Z]*$"
			var re = new RegExp(regu);
			if(!re.test(val)){
				e.isValid = false;//输入的特殊字符
				nui.alert("编码由数字字母组成，请重新填写");
				return;
			} */
			//需要校验的编码
			var json = nui.encode({vo:{eventtype_code:val}});
			nui.ajax({
				url:".biz.ext",
				cache:false,
				data:json,
				type:"POST",
				contentType:"text/json",
				success: function(action){
					if(action.count > 0){
						e.isValid = false;
						nui.alert("编码 "+val+" 重复，请重新输入");
					}
					if(action.count < 0){
						e.isValid = false;
					}
				}
			});
			
		}
		
		//关闭窗口
		function CloseWindow(action) {            
            if (action == "close" && form.isChanged()) {
                if (confirm("数据被修改了，是否先保存？")) {
                    return false;
                }
            }
            if(window.CloseOwnerWindow){
				return window.CloseOwnerWindow(action);
			}else{
				window.close();
			}   
                   
        }
        function onOk(e) {
            SaveData();
        }
        function onCancel(e) {
            CloseWindow("cancel");
        }
        
		
	</script>
</html>