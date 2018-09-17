/*
 * Copyright 2013 Primeton.
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
package org.gocom.components.coframe.rights.user;

import com.eos.das.entity.criteria.CriteriaType;
import com.eos.foundation.PageCond;

import org.gocom.components.coframe.rights.dataset.CapUser;

/**
 * 用户管理服务接口
 *
 * @author shitf (mailto:shitf@primeton.com)
 */
public interface ICapUserService{

	/**
	 *
	 * @param capUser CapUser
	 */
	void addCapUser(CapUser capUser);

	/**
	 *
	 * @param capUsers CapUser[]
	 */
	void deleteCapUser(CapUser[] capUsers);

	/**
	 *
	 * @param capUser CapUser
	 */
	void getCapUser(CapUser capUser);

	/**
	 *
	 * @param criteria CriteriaType
	 * @param page PageCond
	 * @return CapUser[]
	 */
	CapUser[] queryCapUsers(CriteriaType criteria, PageCond page);

	/**
	 *
	 * @param capUser CapUser
	 */
	void updateCapUser(CapUser capUser);

	/**
	 * 统计所有用户总数
	 * @param criteria 查询实体
	 * @return 用户数量
	 */
	int countCapUser(CriteriaType criteria);

	/**
	 * 检测用户是否存在
	 * @param userId 登录用户名
	 * @return true 已存在 false 不存在
	 */
	Boolean checkUser(String userId);
	
	/**
	 * 根据模板删除用户
	 * @param capUser
	 */
	void deleteCapUserByTemplate(CapUser capUser);
	
	/**
	 * 根据查询模板查询用户信息
	 * @param template 查询模板
	 * @param capUser 用户对象
	 */
	void getCapUserByTemplate(CapUser template, CapUser capUser);

	/**根据用户ID查询用户
	 * @param userId
	 * @return 不存在则返回null
	 */
	CapUser getCapUserByUserId(String userId);

	/**
	 * 校验用户名唯一性
	 * @param user
	 * @return 
	 */
	boolean validateUserId(CapUser user);
	
	/**
	 * 更新用户密码
	 * @param capUsers
	 */
	void updatePasswords(CapUser[] capUsers);
	
	/**
	 * 根据用户名、密码校验用户
	 * @param userId
	 * @param password
	 * @return
	 */
	boolean authentication(String userId,String password);
	
	/**
	 * 密码加密
	 * @param capUser
	 * @return
	 */
	String encodePassword(String password);

}

