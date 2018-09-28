package com.blog.service;

import java.util.List;

import com.blog.common.BlogResult;
import com.blog.pojo.User;
import com.blog.pojo.UserCustom;

/**
 * @ClassName UserService
 * @Description TODO(用户业务层)
 * @author Administrator
 * @Date 2018年9月10日 下午4:30:14
 * @version 1.0.0
 */
public interface UserService {

	
	/**
	 * 
	 * @Description (获取所有用户信息)
	 * @return
	 */
	public List<UserCustom> getUsers();
	
	
	/**
	 * 
	 * @Description (删除用户)
	 * @param id
	 * @return
	 */
	public BlogResult deleteUser(Long id);
	
	
	/**
	 * 
	 * @Description (批量删除用户)
	 * @param ids
	 * @return
	 */
	public BlogResult deleteUsers(String ids);


	/**
	 * @Description (添加用户)
	 * @param user
	 * @return
	 */
	public BlogResult addUser(User user);


	/**
	 * @Description (验证手机号是否存在)
	 * @param phone
	 * @return
	 */
	public BlogResult findUserByPhone(String phone);


	/**
	 * @Description (校验用户名)
	 * @param nickname
	 * @return
	 */
	public BlogResult findUserByNickName(String nickname);
}
