package com.blog.mapper;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import com.blog.pojo.User;
/**
 * @ClassName CustomRealmEnc
 * @Description TODO(shiro加密)
 * @author Perfree
 * @Date 2018年9月19日 下午6:30:55
 * @version 1.0.0
 */
public class CustomRealmEnc extends AuthorizingRealm {
	
	@Autowired
	private UserMapper userMapper;
	
	
	{
		//设置realmname
		super.setName("customRealmEnc");
		
	}
	//自定义授权
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		//得到用户名称
		String userName = (String) principals.getPrimaryPrincipal();
		//从数据或者缓存中获取角色数据
		Set<String> roles = getRolesByUserPhone(userName);
		//创建simpleAuthorizationInfo
		SimpleAuthorizationInfo simpleAuthorizationInfo = new SimpleAuthorizationInfo();
		//设置角色数据
		simpleAuthorizationInfo.setRoles(roles);
		return simpleAuthorizationInfo;
	}
	
	//模拟从数据库取出用户角色信息
	private Set<String> getRolesByUserPhone(String phone) {
		List<String>list = userMapper.getUserRoleByPhone(phone);
		Set<String> sets = new HashSet<>(list);
		return sets;
	}


	//自定义认证
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		//从主体传过来的认证信息中,获得用户名
		String userName = (String) token.getPrincipal();
		
		//通过用户名到数据库中获取凭证
		User user = getPassWordByUserPhone(userName);
		
		if(user== null) {
			return null;
		}
		SimpleAuthenticationInfo simpleAuthenticationInfo = new SimpleAuthenticationInfo(user.getPhone(),user.getPassword(),"customRealmEnc");
		
		//将盐设置进去
		simpleAuthenticationInfo.setCredentialsSalt(ByteSource.Util.bytes("perfree"));
		Subject subject = SecurityUtils.getSubject();
		user.setPassword(null);
		subject.getSession().setAttribute("userSession", user);
		return simpleAuthenticationInfo;
	}
	
	
	//模拟从数据库得到用户密码
	private User getPassWordByUserPhone(String phone) {
		User user = userMapper.getUserByPhone(phone);
		if(user!=null) {
			if(user.getPassword()!=null) {
				return user;
				
			}
		}
		return null;
	}
	
	//查看123456加盐后的md5值
	public static void main(String[] args) {
		Md5Hash md5Hash = new Md5Hash("1212","perfree");
		System.out.println(md5Hash);
	}

}

