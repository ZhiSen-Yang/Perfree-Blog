package com.blog.mapper;

import java.util.List;

import com.blog.pojo.User;

/**
 * @ClassName UserMapper
 * @Description TODO(用户mapper)
 * @author Administrator
 * @Date 2018年9月10日 下午4:26:01
 * @version 1.0.0
 */
public interface UserMapper {

	
	/**
	 * 
	 * @Description (查询所有用户信息)
	 * @return
	 */
	public List<User> getUsers();
	
	/**
	 * 
	 * @Description (删除用户)
	 * @param id
	 */
	public void deleteUser(Long id);
	
	/**
	 * 
	 * @Description (批量删除用户)
	 * @param ids
	 */
	public void deleteUsers(List<Long> ids);

	/**
	 * @Description (根据手机号查询用户信息)
	 * @return
	 */
	public User getUserByPhone(String phone);

	/**
	 * @Description (根据手机号查询角色信息)
	 * @param phone
	 * @return
	 */
	public List<String> getUserRoleByPhone(String phone);

	/**
	 * @Description (添加用户)
	 * @param user
	 */
	public void addUser(User user);

	/**
	 * @Description (添加角色)
	 */
	public void addUser_role(Long userId);

	/**
	 * @Description (根据用户昵称获取用户信息)
	 * @param nickname
	 * @return
	 */
	public User getUserByNickName(String nickname);
}
