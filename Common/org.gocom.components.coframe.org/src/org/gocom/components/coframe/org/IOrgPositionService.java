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
package org.gocom.components.coframe.org;

import org.gocom.components.coframe.org.dataset.OrgOrganization;
import org.gocom.components.coframe.org.dataset.OrgPosition;
import org.gocom.components.coframe.org.dataset.QueryPositionEmp;
import org.gocom.components.coframe.org.util.OrgResponse;

import com.eos.das.entity.criteria.CriteriaType;
import com.eos.foundation.PageCond;

/**
 * 岗位服务接口
 *
 * @author yangzhou (mailto:yangzhou@primeton.com)
 */
public interface IOrgPositionService{

	/**
	 * 添加岗位
	 * @param orgPosition 
	 * @return 添加状态返回对象
	 */
	OrgResponse addOrgPosition(OrgPosition orgPosition);

	/**
	 *
	 * @param orgPositions OrgPosition[]
	 */
	void deleteOrgPosition(OrgPosition[] orgPositions);
	
	/**
	 * 根据id,父节点删除岗位
	 * @param id
	 * @param parentId
	 * @param parentType
	 */
	void deleteOrgPosition(String id, String parentId, String parentType);

	/**
	 *
	 * @param orgPosition OrgPosition[]
	 */
	void getOrgPosition(OrgPosition orgPosition);

	/**
	 *
	 * @param criteria CriteriaType
	 * @param page PageCond
	 * @return OrgPosition[]
	 */
	OrgPosition[] queryOrgPositions(CriteriaType criteriaType,
			PageCond pageCond);

	/**
	 * 更新岗位
	 * @param orgPosition
	 * @return 更新状态返回对象
	 */
	OrgResponse updateOrgPosition(OrgPosition orgPosition);
	
	/**
	 * 获取岗位下的所有子岗位
	 * @param positionid
	 * @return
	 */
	OrgPosition[] querySubPositions(String positionid);
	
	/**
	 * 获取岗位下的所有员工
	 * @param orgid
	 * @return
	 */
	QueryPositionEmp[] queryEmployeesOfPosition(String positionid);
	
	/**
	 * 岗位的总记录
	 * @param criteria
	 * @return 总记录
	 */
	int countOrgPositions(CriteriaType criteria);
	
	/**
	 * 获取子岗位的同时获取父岗位信息
	 * @param position
	 * @return 岗位
	 */
	OrgPosition getOrgPositionWithParent(OrgPosition position);

	/**
	 * 根据父机构级联删除子岗位；删除子岗位之前，需要维护子岗位和人员的关系
	 * @param parentOrg
	 */
	void deleteOrgPositionCascadeByParentOrg(OrgOrganization parentOrg);
	
	/**
	 * 根据机构查询出所有的子岗位
	 * @param org
	 * @return 子岗位列表
	 */
	OrgPosition[] querySubPositionsByOrg(OrgOrganization org);

}