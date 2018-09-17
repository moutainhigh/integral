<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@include file="/coframe/tools/skins/common.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- 
  - Author(s): fangwl (mailto:fangwl@primeton.com)
  - Date: 2013-03-01 10:34:42
  - Description:
-->
<head>
</head>
<body>
	<div style="padding:5px 5px 0px 5px;">
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
	<div class="nui-fit" style="padding:0px 5px 5px 5px;">
		<input id="appid" name="appid" class="nui-hidden" />
	    <div id="funcgroupgrid" class="nui-datagrid" style="width:100%;height:100%;" 
	    url="org.gocom.components.coframe.framework.FuncGroupManager.queryFuncGroup.biz.ext" onselectionchanged="selectionChanged" idField="menuid" allowResize="false"
	    sizeList="[10,20,50,100]" multiSelect="true" onrowdblclick="edit()">
		    	<div property="columns">
		        <div type="checkcolumn" ></div>
		        <div field="funcgroupname" width="100" headerAlign="center" allowSort="false">功能组名称</div>    
		        <div field="grouplevel" width="100" headerAlign="center" allowSort="false">节点层次</div>                            
		        <div field="funcgroupseq" width="100" headerAlign="center" allowSort="false">功能组序号</div>
		        <div field="isleaf" width="100" headerAlign="center" allowSort="false" renderer="onIsLeafRenderer">是否叶子节点</div>
		    </div>
		</div>
	</div>
    <script type="text/javascript">
	 	nui.parse();
		var grid = nui.get("funcgroupgrid");
		var appid = <%=request.getParameter("realId") %>;
		document.getElementById("appid").value = appid;
		var data = {appid:appid};
        grid.load(data);
		
        function add() {
            nui.open({
                url: "<%=request.getContextPath() %>/coframe/framework/functiongroup/funcgroup_add.jsp",
                title: "新增功能组", 
                width: 400, 
                height: 100,
                allowResize:false,
                onload: function () {
                	var id = document.getElementById("appid").value;
                	var data = {appid:id};
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
                    url: "<%=request.getContextPath() %>/coframe/framework/functiongroup/funcgroup_edit.jsp",
                    title: "编辑功能组", 
                    width: 400, 
                    height: 100,
                    allowResize:false,
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
            	nodes.push({realId:rows[i].funcgroupid,type:"functiongroup"});
            }
            if (rows.length > 0) {
                nui.confirm("功能组下所有的功能信息及子功能组信息也将被删除，确定？","删除确认",function(action){
                	if(action!="ok") return;
                    var json = nui.encode({nodes:nodes});
                    $.ajax({
                         url: "org.gocom.components.coframe.framework.ApplicationManager.deleteApplications.biz.ext",
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
            if (e.value == "y") return "是";
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