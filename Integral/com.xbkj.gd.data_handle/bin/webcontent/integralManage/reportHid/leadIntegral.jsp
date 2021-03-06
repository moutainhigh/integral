<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@include file="/coframe/tools/skins/common.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- 
  - Author(s): rjc
  - Date: 2019-01-10 22:43:20
  - Description:
-->
<head>
<title>提前积分明细</title>
</head>
<body>
	<div id="form1" style="padding:10px 10px 0px 10px;">
		<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
	        <table>
	            <tr>
		            <td>
		                	身份证号：<input id="customer_idcard" class="nui-textbox" name="customer_idcard" 
		                		 required="true" emptyText="请输入..." style="width:150px;" />
		            </td>
		            <td>
		                	开始时间：<input id="start_date"class="nui-datepicker" name="start_date" emptyText="请选择..." allowInput="true"style="width:100px;" />
		            </td>
		            <td>
		                	结束时间：<input id="end_date" class="nui-datepicker" name="end_date" 
		                		emptyText="请选择..." style="width:100px;" allowInput="true"/>
		            </td>
		            <td>
		            	<a class="nui-button" iconCls="icon-search" onclick="search('4')" plain="true">查询</a>
		            </td>
	            </tr>
	        </table>
	    </div>
    </div>
		
    <div class="nui-fit" style="padding:0px 10px 10px 10px;">
		<input id="pk_customer_info" name="pk_integral_detail" class="nui-hidden" />
	    <div id="grid" class="nui-datagrid" style="width:100%;height:100%;" 
		    url="com.xbkj.gd.data_handle.cust.integralManager.queryCustIntegal.biz.ext"  
		    	idField="pk_customer_info" dataField="vos" allowResize="false" multiSelect="false" 
		    	allowCellSelect="false">
		    <input class="nui-hidden" name="pk_customer_info"/>
		    <div property="columns">
		        <div type="checkcolumn"></div>
		        <div field="def3" width="60px" headerAlign="center" allowSort="false">年份</div>
	<!-- 	        <div field="def8" width="60px" headerAlign="center" allowSort="false">序号</div> -->
		        <div field="customer_name" width="60px" headerAlign="center" allowSort="false">客户名</div>
		        <div field="customer_idcard" width="150px" headerAlign="center" allowSort="false">身份证</div>
		        <div field="customer_account" width="150px" headerAlign="center" allowSort="false">账号</div>
		        <div field="def7" width="100px" headerAlign="center" allowSort="false">账户序号</div>
		        <div field="customer_integral" width="100px" headerAlign="center" allowSort="false">提前支取积分</div>
		        <div field="def1" width="120px" headerAlign="center" allowSort="false">兑换商品</div>
		        <div field="ts" width=160px" headerAlign="center" allowSort="false" dateFormat="yyyy-MM-dd hh:mm:ss">录入时间</div>
		        <div field="empname" width=120px" headerAlign="center" allowSort="false">录入人</div>
		        <div field="orgname" width=120px" headerAlign="center" allowSort="false">录入机构</div>
		        <div field="remark" width=180px" headerAlign="center" allowSort="false">备注</div>
		    </div>
		</div>
	</div>
	
	
	<script type="text/javascript">
		nui.parse();
		var integral_type = 4;
		var grid = nui.get("grid");
		var form = new nui.Form("#form1");
		
		
		function search(integral_type){
			//查询
			if(form.validate() == false){
				nui.alert("身份证号必须输入");
				return;
			}
			var params = form.getData();
			params.hiddenFlag = 'Y';
			params.integral_type = integral_type;
			grid.load({params:params});
		}
		
		
			
	</script>
</body>
</html>