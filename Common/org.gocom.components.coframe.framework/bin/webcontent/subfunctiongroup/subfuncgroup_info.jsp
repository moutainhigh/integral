<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@include file="/coframe/tools/skins/common.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- 
  - Author(s): fangwl (mailto:fangwl@primeton.com)
  - Date: 2013-03-01 10:34:55
  - Description:
-->
<head>
</head>
<body>
<div style="padding:5px;">
	<div id="form1">
	<div style="padding-top:2px;padding-bottom:2px;">
	</div>
       <table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table" >
            <tr>
                <th class="nui-form-label"><label for="appfuncgroup.funcgroupname$text">子功能组名称：</label></th>
                <td>    
                    <input id="appfuncgroup.funcgroupname" name="appfuncgroup.funcgroupname" class="nui-textbox nui-form-input" required="true"  vtype="rangeLength:1,20"/>
                    <input name="appfuncgroup.funcgroupid" class="nui-hidden"/>
                    <input name="appfuncgroup.grouplevel" class="nui-hidden"/>
                    <input name="appfuncgroup.funcgroupseq" class="nui-hidden"/>
                    <input name="appfuncgroup.isleaf" class="nui-hidden"/>
                </td>
            </tr>
	        <tr>
				<td style="text-align:center;spacing:5px;">
					<a class="nui-button" style="width:60px;" iconCls="icon-save" onclick="onOk()">保存</a>
	        		<span style="display:inline-block;width:25px;"></span>
				</td>
			</tr>
        </table>         
    </div>
</div>
	<script type="text/javascript">
        nui.parse();
        var form = new nui.Form("form1");
        var funcgroupid = "<%= request.getParameter("realId") %>";
        var json = nui.encode({template:{funcgroupid:funcgroupid}});
	    $.ajax({
	        url: "org.gocom.components.coframe.framework.FuncGroupManager.getFuncGroup.biz.ext",
	        type: 'POST',
	        data: json,
	        cache: false,
	        contentType:'text/json',
	        cache: false,
	        success: function (text) {
	            var o = nui.decode(text);
	            form.setData(o);
	            form.setChanged(false);
	        }
	    });
        function SaveData() {
            var o = form.getData(true,true);            

            form.validate();
            if (form.isValid() == false) return;

            var json = nui.encode(o);
            $.ajax({
                url: "org.gocom.components.coframe.framework.FuncGroupManager.updateFuncGroup.biz.ext",
                type: 'POST',
                data: json,
                cache: false,
                contentType:'text/json',
                success: function (text) {
                    nui.alert("保存成功！");
                    parent.refreshParentNode();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    nui.alert("保存失败！");
                }
            });
        }

        //标准方法接口定义
        function SetData(data) {
            //跨页面传递的数据对象，克隆后才可以安全使用
                data = nui.clone(data);
				var json = nui.encode({template:data});
                $.ajax({
                    url: "org.gocom.components.coframe.framework.FuncGroupManager.getFuncGroup.biz.ext",
                    type: 'POST',
	                data: json,
	                cache: false,
	                contentType:'text/json',
                    cache: false,
                    success: function (text) {
                        var o = nui.decode(text);
                        form.setData(o);
                        form.setChanged(false);
                    }
                });
        }
        
        function CloseWindow(action) {            
            if (action == "close" && form.isChanged()) {
                if (confirm("数据被修改了，是否先保存？")) {
                    return false;
                }
            }
            if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
            else window.close();            
        }
        function onOk(e) {
            SaveData();
        }
        function onCancel(e) {
            CloseWindow("cancel");
        }
    </script>
</body>
</html>