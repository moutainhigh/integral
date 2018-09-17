/*
 * Copyright 2013 Primeton Technologies Ltd.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.gocom.components.coframe.org.util;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.gocom.components.coframe.org.dataset.OrgEmployee;
import org.gocom.components.coframe.org.dataset.OrgOrganization;
import org.gocom.components.coframe.org.dataset.OrgPosition;
import org.gocom.components.coframe.org.dataset.OrgTreeNode;
import org.gocom.components.coframe.tools.IconCls;

import com.primeton.cap.party.Party;
import commonj.sdo.DataObject;

/**
 * 构造机构树的辅助类
 *
 * @author yangzhou (mailto:yangzhou@primeton.com)
 */
public class OrgTreeNodeHelper {

	/**
	 * 将机构、岗位、员工结点构造为treeNodes
	 * @param orgs
	 * @param positions
	 * @param emps
	 * @return
	 */
	public static DataObject[] buildOrgTreeNodes(OrgOrganization[] orgs, 
			OrgPosition[] positions, OrgEmployee[] emps) {
		List<DataObject> results = new ArrayList<DataObject>();
		
		results.addAll(Arrays.asList(OrgTreeNodeConvertor.convert(orgs)));
		results.addAll(Arrays.asList(OrgTreeNodeConvertor.convert(positions)));
		results.addAll(Arrays.asList(OrgTreeNodeConvertor.convert(emps)));
		
		return results.toArray(new DataObject[results.size()]);
	}
	
	/**
	 * @param orgPartyList
	 * @return
	 */
	public static DataObject[] buildOrgTreeNodes(List<Party> orgPartyList) {
		List<DataObject> results = new ArrayList<DataObject>();
		
		for(Party orgParty : orgPartyList) {
			OrgTreeNode node = OrgTreeNode.FACTORY.create();
			node.setNodeId(orgParty.getId());
			node.setNodeType(OrgOrganization.NODE_TYPE);
			node.setNodeName(orgParty.getName());
			node.setIconCls(IconCls.ORGANIZATION);
			node.set(IOrgConstants.ORGID_PROPERTY, String.valueOf(orgParty.getId()));
			node.set(IOrgConstants.ORGNAME_PROPERTY, String.valueOf(orgParty.getName()));
			node.set("isLeaf", false);
			node.set("expanded", false);
			results.add(node);
		}
		return results.toArray(new DataObject[results.size()]);
	}
}
