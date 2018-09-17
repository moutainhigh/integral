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
package org.gocom.components.coframe.org.party.manager;

import static org.gocom.components.coframe.org.util.IOrgConstants.EMPID_PROPERTY;

import org.gocom.components.coframe.org.dataset.OrgEmployee;
import org.gocom.components.coframe.tools.IConstants;

import com.eos.das.entity.ExpressionHelper;
import com.eos.das.entity.IDASCriteria;
import com.eos.spring.DASDaoSupport;

/**
 * 员工信息管理，提供对员工数据实体的数据库操作（持久化）
 *
 * @author yangzhou (mailto:yangzhou@primeton.com)
 */
public class DefaultEmpManager extends DASDaoSupport {

	public static final String SPRING_BEAN_NAME = "DefaultEmpManagerBean";
	
	/**
	 * 根据租户ID获取所有员工
	 * @param tenantID
	 * @return
	 */
	public OrgEmployee[] getAllEmps(String tenantID) {
		IDASCriteria criteria = getDASTemplate().createCriteria(OrgEmployee.QNAME);
		criteria.add(ExpressionHelper.eq(IConstants.TENANT_PROPERTY, tenantID));
		return getDASTemplate().queryEntitiesByCriteriaEntity(OrgEmployee.class, criteria);
	}

	/**
	 * 根据员工ID和租户ID获取员工
	 * @param empid
	 * @param tenantID
	 * @return
	 */
	public OrgEmployee getEmpById(String empid, String tenantID) {
		IDASCriteria criteria = getDASTemplate().createCriteria(OrgEmployee.QNAME);
		criteria.add(ExpressionHelper.eq(IConstants.TENANT_PROPERTY, tenantID));
		criteria.add(ExpressionHelper.eq(EMPID_PROPERTY, empid));
		OrgEmployee[] empArray = getDASTemplate().queryEntitiesByCriteriaEntity(OrgEmployee.class, criteria);
		if (empArray != null && empArray.length == 1) {
			return empArray[0];
		}
		return null;
	}
}
