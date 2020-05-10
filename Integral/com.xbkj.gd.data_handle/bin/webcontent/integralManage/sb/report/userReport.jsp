<%@page import="com.primeton.cap.AppUserManager"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@include file="/coframe/tools/skins/common.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- 
  - Author(s): rjc
  - Date: 2019-11-09 09:14:03
  - Description: 个人礼品统计
-->
<head>
	<title>个人礼品统计</title>
</head>
<body>
	<div id="form1" style="padding:10px 10px 0px 10px;">
		<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
	        <table>
	            <tr>
		            <td>
		                	名称：<input id="product_name" class="nui-textbox" name="product_name" 
		                		emptyText="请输入..." style="width:150px;"/>
		                		<input id="now_user" class="nui-hidden" name="now_user" value="xxx"/>
		            </td>
		             <td>
		                	开始时间：<input id="start_date" class="nui-datepicker" name="start_date" emptyText="请选择..." allowInput="true"style="width:100px;" />
		            </td>
		            <td>
		                	结束时间：<input id="end_date" class="nui-datepicker" name="end_date" 
		                		emptyText="请选择..." style="width:100px;" allowInput="true"/>
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
		            	<a class="nui-button" iconCls="icon-download" onclick="downReport()" plain="true">导出</a>
		            </td>
	            </tr>
	        </table>
	    </div>
    </div>
    <div class="nui-fit" style="padding:0px 10px 10px 10px;">
	    <div id="grid" class="nui-datagrid" style="width:100%;height:100%;" 
		    url="com.xbkj.gd.data_handle.prod.report.productReport.biz.ext"  
		    	idField="pk_product" dataField="vos" allowResize="false" multiSelect="false" 
		    	allowCellSelect="false">
		    <input class="nui-hidden" name="pk_apply_product"/>
		    <div property="columns">
		        <div type="checkcolumn"></div>
		        <div field="orgname" width="100px" headerAlign="center" >机构</div> 
		        <div field="apply_user" width="150px" headerAlign="center" allowSort="false">分理处</div>
		        <div field="apply_product_name" width="150px" headerAlign="center" allowSort="false">礼品</div>
		        <div field="apply_product_num" width="120px" headerAlign="center" allowSort="false">申请礼品总数</div> 
		        <div field="org_sub_num" width="90px" headerAlign="center" >兑换总数</div> 
		        <div field="allot_product_num" width="90px" headerAlign="center" >调换总数</div> 
		        <div field="residue_class" width="90px" headerAlign="center" >剩余总数</div>
		        
		    </div>
		</div>
	</div>
	<form id="excelForm" action="<%=request.getContextPath() %>/gd/data_handle/integralManage/sb/report/prodReportExp.jsp" 
	 	method="post" target="excelIFrame">
	     <input type="hidden" name="counttype" value="1" />
	     <input type="hidden" name="now_user" value="xxx" />
	     <input type="hidden" name="start_date" id="start_date_form" />
    	 <input type="hidden" name="end_date" id="end_date_form" />
    	 <input type="hidden" name="product_name" id="product_name_form" />
	</form>
	<iframe id="excelIFrame" name="excelIFrame" style="display:none;"></iframe>
	<script type="text/javascript">
		nui.parse();
		var grid = nui.get("grid");
		var form = new nui.Form("#form1");
		function search(){
			//查询
			let params = form.getData();
			params.counttype = 1;
			grid.load({params:params});
		}
		
		function downReport(){
			let product_name = nui.get("product_name").getValue();
			let start_date = nui.get("start_date").getValue();
			let end_date = nui.get("end_date").getValue();
			
			document.getElementById("product_name_form").value=product_name;
			document.getElementById("start_date_form").value=start_date;
			document.getElementById("end_date_form").value=end_date;
			document.getElementById("excelForm").submit();
		}
			
	</script>
</body>
</html>