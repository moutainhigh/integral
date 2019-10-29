<%@page import="com.primeton.cap.AppUserManager"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@include file="/coframe/tools/skins/common.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- 
  - Author(s): rjc
  - Date: 2019-10-18 17:03:19
  - Description: 查询商品审批进度
-->
<head>
	<title>查询商品审批进度</title>
	<script src="<%=request.getContextPath() %>/gd/data_handle/integralManage/swfupload/swfupload.js" type="text/javascript"></script>
</head>
<body>
	<div id="form1" style="padding:10px 10px 0px 10px;">
		<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
	        <table>
	            <tr>
		            <td>
		                	编号：<input id="product_code"class="nui-textbox" name="product_code" emptyText="请输入..." style="width:140px;" />
		            </td>
		            <td>
		                	名称：<input id="product_name" class="nui-textbox" name="product_name" 
		                		emptyText="请输入..." style="width:150px;"/>
		            </td>
	            </tr>
	        </table>
	    </div>
    </div>
	<div style="padding:0px 10px 0px 10px;">
		<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
	        <table style="width:100%;">
	            <tr>
		            <td style="width:100%;">
		            	<a class="nui-button" iconCls="icon-search" onclick="search()" plain="true">查询</a>
		            </td>
	            </tr>
	        </table>
	    </div>
    </div>
   
    <div class="nui-fit" style="padding:0px 10px 10px 10px;">
	    <div id="grid" class="nui-datagrid" style="width:100%;height:100%;" 
		    url="com.xbkj.gd.data_handle.prod.applyProduct.page.biz.ext"  
		    	idField="pk_product" dataField="vos" allowResize="false" multiSelect="false" 
		    	allowCellSelect="false">
		    <input class="nui-hidden" name="pk_apply_product"/>
		    <div property="columns">
		        <div type="checkcolumn"></div>
		        <div field="pk_audit_product" width="150px" headerAlign="center" allowSort="false">审批ID</div>
		        <div field="apply_product_code" width="150px" headerAlign="center" allowSort="false">申请商品编号</div>
		        <div field="apply_product_name" width="120px" headerAlign="center" allowSort="false">申请商品名称</div> 
		        <div field="apply_product_num" width="90px" headerAlign="center" >申请商品数量</div> 
		        <div field="audit_product_num" width="90px" headerAlign="center" >审批通过数量</div> 
		        <div field="audit_status" type="comboboxcolumn" renderer="statusRenderer" width=120px" headerAlign="center" allowSort="false" >状态</div>
		        <div field="audit_user" width=120px" headerAlign="center" allowSort="false">审批人</div>
		        <div field="audit_date" width=120px" headerAlign="center" allowSort="false" dateFormat="yyyy-MM-dd hh:mm:ss">审批时间</div>
		       	<div field="remark" width=120px" headerAlign="center" allowSort="false">备注</div> 
		    </div>
		</div>
	</div>
	
	
	<script type="text/javascript">
		var applyData =[{id:"1",text:"审批中"},{id:"2", text:"审批通过"},{id:"3", text:"审批拒绝"}];
		
		nui.parse();
		var grid = nui.get("grid");
		var form = new nui.Form("#form1");
		function statusRenderer(e){
      		var val = e.value;
      		
        	for(let i = 0; i < applyData.length; i++){
        		let inn = applyData[i];
        		if(inn.id == val){return inn.text;}
        	}
      	}
		function search(){
			//查询
			let params = form.getData();
			grid.load({params:params});
		}
			
	</script>
</body>
</html>