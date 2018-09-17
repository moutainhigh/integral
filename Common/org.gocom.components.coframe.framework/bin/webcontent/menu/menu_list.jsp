<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@include file="/coframe/tools/skins/common.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- 
  - Author(s): fangwl (mailto:fangwl@primeton.com)
  - Date: 2013-02-28 10:38:33
  - Description:选中菜单的子菜单列表，tab页中使用
-->
<head>
</head>
<body>
	<div style="padding:10px 10px 0px 10px;">
		<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
	        <table style="width:100%;">
	            <tr>
		            <td style="width:100%;">
		                <a class="nui-button" iconCls="icon-add" onclick="add()">增加</a>
		            	<a class="nui-button" iconCls="icon-edit" onclick="edit()" id="edit_btn">编辑</a>
		            	<a class="nui-button" iconCls="icon-remove" onclick="remove()">删除</a>
		            </td>
	            </tr>
	        </table>
	    </div>
    </div>
    <div class="nui-fit" style="padding:0px 10px 10px 10px;">
		<input id="parentmenuid" name="parentmenuid" class="nui-hidden" />
	    <div id="menugrid" class="nui-datagrid" style="width:100%;height:100%;" 
	    url="org.gocom.components.coframe.framework.MenuManager.queryMenu.biz.ext"  idField="menuid" allowResize="false"
	    sizeList="[10,20,50,100]" multiSelect="true" onrowdblclick="edit()" onselectionchanged="selectionChanged" allowCellSelect="false">
		    <div property="columns">
		        <div type="checkcolumn" ></div>
		        <div field="menucode" width="100" headerAlign="center" allowSort="false">菜单代码</div>
		        <div field="menuname" width="100" headerAlign="center" allowSort="false">菜单名称</div> 
		        <div field="menulabel" width="100" headerAlign="center" allowSort="false">菜单显示名称</div>    
		        <div field="isleaf" width="100" headerAlign="center" allowSort="false" renderer="onIsLeafRenderer">是否叶子菜单</div>
		        <div field="menulevel" width="100" headerAlign="center" allowSort="false">菜单层次</div>
		    </div>
		</div>
	</div>
    <script type="text/javascript">
   		nui.parse();
		var grid = nui.get("menugrid");
        var parentmenuid = "<%=request.getParameter("id") %>";
		document.getElementById("parentmenuid").value = parentmenuid;
		var data = {parentmenuid:parentmenuid};
        grid.load(data);
        function add() {
            nui.open({
                url: "<%=request.getContextPath() %>/coframe/framework/menu/menu_add.jsp",
                title: "新增菜单",
                width: 600,
                height: 167,
                onload: function () {
                	var id = document.getElementById("parentmenuid").value;
                	var data = {parentmenuid:id};
                	var iframe = this.getIFrameEl();
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function (action) {
              	 	if(action=="ok"){
	                	parent.refresh();
	                    grid.reload();
                    }
                }
            });
        }
        
        function edit() {
            var row = grid.getSelected();
            if (row) {
                nui.open({
                    url: "<%=request.getContextPath() %>/coframe/framework/menu/menu_edit.jsp",
                    title: "编辑菜单",
                    width: 600,
                	height: 167,
                    onload: function () {
                        var iframe = this.getIFrameEl();
                        var data = row;
                        iframe.contentWindow.SetData(data);
                    },
                    ondestroy: function (action) {
                    	if(action=="ok"){
	                    	parent.refresh();
	                        grid.reload();
	                    }
                    }
                });
                
            } else {
                alert("请选中一条记录");
            }
            
        }
        
        function remove() {
            var rows = grid.getSelecteds();
            var nodes = [];
            
            for(var i=0; i<rows.length;i++){
            	nodes.push({menuid:rows[i].menuid});
            }
            if (rows.length > 0) {
            	nui.confirm("该菜单下的所有子菜单都将被删除，确定？","删除确认",function(action){
	            	if(action!="ok") return;
	            	var json = nui.encode({nodes:nodes});
                    $.ajax({
                        url: "org.gocom.components.coframe.framework.MenuManager.deleteMenus.biz.ext",
		                type: 'POST',
		                data: json,
		                cache: false,
		                contentType:'text/json',
                        success: function (text) {
                            grid.reload();
                            parent.refresh();
                        },
                        error: function () {
                        }
                    });
                });
            } else {
                alert("请选中一条记录");
            }
        }
        
		function onIsLeafRenderer(e) {
            if (e.value == "1") return "是";
            else return "否";
        }  
        
        function selectionChanged(){
			var rows = grid.getSelecteds();
			if(rows.length>1){
				//disable edit button
				nui.get("edit_btn").disable();
			}else{
				nui.get("edit_btn").enable();
			}
		}     
	</script>
</body>
</html>