package com.blog.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.blog.common.BlogResult;
import com.blog.mapper.UserMapper;
import com.blog.pojo.User;
import com.blog.pojo.UserCustom;
import com.blog.service.UserService;

/**
 * @ClassName UserServiceImpl
 * @Description TODO(用户业务层实现类)
 * @author Administrator
 * @Date 2018年9月10日 下午4:32:22
 * @version 1.0.0
 */
@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserMapper userMapper;
	
	
	/* 
	 * Description:查询所有用户信息
	 */
	@Override
	public List<UserCustom> getUsers() {
			List<User> list = userMapper.getUsers();
			List<UserCustom> list2 = new ArrayList<UserCustom>();
			for (User user : list) {
				Date date = user.getCreatetime();
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String createTime = df.format(date);
				UserCustom us = new UserCustom();
				us.setCreateTime(createTime);
				us.setId(user.getId());
				us.setImage(user.getImage());
				us.setNickname(user.getNickname());
				us.setPhone(user.getPhone());
				list2.add(us);
			}
			return list2;
	}


	/* 
	 * Description:删除用户
	 */
	@Override
	public BlogResult deleteUser(Long id) {
		try {
			userMapper.deleteUser(id);
			return BlogResult.ok(200, "删除成功", null);
		} catch (Exception e) {
			return BlogResult.build(500, "删除失败");
		}
	}


	/*
	 * Description:批量删除用户
	 */
	@Override
	public BlogResult deleteUsers(String ids) {
		String [] s = ids.split(",");
		//将String类型的List转为Long类型
		List<Long> idss = new ArrayList<Long>();
		for (String string : s) {
			long id = Long.parseLong(string);
			idss.add(id);
		}
		try {
			userMapper.deleteUsers(idss);
			return BlogResult.ok(200, "删除成功", null);
		} catch (Exception e) {
			return BlogResult.build(500, "删除失败");
		}
	}


	/* (非 Javadoc)
	 * Description:
	 * @see com.blog.service.UserService#addUser(com.blog.pojo.User)
	 */
	@Override
	public BlogResult addUser(User user) {
		BlogResult result = new BlogResult();
		try {
			user.setCreatetime(new Date());
			user.setImage("/images/user.jpg");
			userMapper.addUser(user);
			userMapper.addUser_role(user.getId());
			result.setStatus(200);
		} catch (Exception e) {
			result.setStatus(500);
			result.setMsg("注册失败!");
		}
		return result;
	}


	/* (非 Javadoc)
	 * Description:
	 * @see com.blog.service.UserService#findUserByPhone(java.lang.String)
	 */
	@Override
	public BlogResult findUserByPhone(String phone) {
		BlogResult result = new BlogResult();
		try {
			User user = userMapper.getUserByPhone(phone);
			if(user==null) {
				result.setStatus(200);
			}else {
				result.setStatus(300);
			}
		} catch (Exception e) {
			result.setStatus(500);
			result.setMsg("系统错误");
		}
		return result;
	}


	/* (非 Javadoc)
	 * Description:
	 * @see com.blog.service.UserService#findUserByNickName(java.lang.String)
	 */
	@Override
	public BlogResult findUserByNickName(String nickname) {
		BlogResult result = new BlogResult();
		try {
			User user = userMapper.getUserByNickName(nickname);
			if(user==null) {
				result.setStatus(200);
			}else {
				result.setStatus(300);
			}
		} catch (Exception e) {
			result.setStatus(500);
			result.setMsg("系统错误");
		}
		return result;
	}

}
