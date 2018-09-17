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
package org.gocom.components.coframe.framework;

import org.gocom.components.coframe.framework.application.AppFunction;

import com.eos.das.entity.criteria.CriteriaType;
import com.eos.foundation.PageCond;

/**
 * TODO 此处填写 class 信息
 *
 * @author fangwl (mailto:fangwl@primeton.com)
 */
public interface IAppFunctionService{

	/**
	 * 新增功能
	 * @param appFunction
	 */
	void addAppFunction(AppFunction appFunction);

	/**
	 * 删除功能
	 * @param appFunctions
	 */
	void deleteAppFunction(AppFunction[] appFunctions);

	/**
	 * 根据模板查询功能
	 * @param appFunction
	 */
	void getAppFunction(AppFunction appFunction);

	/**
	 * 分页查询
	 * @param criteria
	 * @param pageCond
	 * @return
	 */
	AppFunction[] queryAppFunctions(CriteriaType criteria,
			PageCond pageCond);

	/**
	 * 修改功能
	 * @param appFunction
	 */
	void updateAppFunction(AppFunction appFunction);
	
	/**
	 * 查询功能记录数
	 * @param criteria
	 * @return
	 */
	int countAppFunction(CriteriaType criteria);
	
	/**
	 * 根据查询条件查询功能
	 * @param criteria
	 * @return
	 */
	AppFunction[]  queryAppFunctions(CriteriaType criteria);
	
	/**
	 * 根据功能id删除功能
	 * @param id
	 */
	void deleteFunctionById(String id);
	
	
	/**
	 * 
	 * 初始化功能，server启动时候调用 
	 */
	void initFunctions();
	
	/**
	 * 批量更新功能资源
	 * @param appfunctions
	 */
	void updateResoucesBatch(AppFunction[] appfunctions);
	
	/**
	 * 查询所有应用
	 * @return
	 */
	AppFunction[] queryAllFunctions();
	
	
	/**
	 * 查询应用下所有的功能
	 * @param appid
	 * @return
	 */
	AppFunction[] getFunctionsByAppId(String appid);
	
	/**
	 * 查询功能组下所有的功能
	 * @param funcGroupIds
	 * @return
	 */
	AppFunction[] getFunctionsByFuncGroupIds(String[] funcGroupIds);
	
	/**
	 * 验证是否存在，0不存在，1存在
	 * @param appFunction
	 * @return
	 */
	int validateAppFunction(AppFunction appFunction);
}