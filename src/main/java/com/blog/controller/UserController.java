package com.blog.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.session.HttpServletSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.blog.common.BlogResult;
import com.blog.common.PictureUtils;
import com.blog.pojo.User;
import com.blog.pojo.UserCustom;
import com.blog.service.UserService;
/**
 * @ClassName UserController
 * @Description TODO(用户表现层)
 * @author Administrator
 * @Date 2018年9月10日 下午4:35:10
 * @version 1.0.0
 */
@Controller
public class UserController {
	
	@Value("${image_server}")
	private String image_server;
	
	@Autowired
	private UserService userService;
	
	
	/**
	 * 
	 * @Description (用户分页列表)
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/user-list")
	public String getUsers(Model model){
		List<UserCustom> list = userService.getUsers();
		model.addAttribute("users", list);
		model.addAttribute("length", list.size());
		return "admin/user-list";
	}
	
	
	
	/**
	 * 
	 * @Description (删除用户)
	 * @param id
	 * @return
	 */
	@RequestMapping("/delUser")
	@ResponseBody
	public BlogResult deleteUser(Long id,String imageUrl) {
		BlogResult result = userService.deleteUser(id);
		PictureUtils.imageDelete(imageUrl, image_server);
		return result;
	}
	
	
	
	@RequestMapping("/deleteUsers")
	@ResponseBody
	public BlogResult deleteUsers(String ids,String imageUrl) {
		BlogResult result = userService.deleteUsers(ids);
		PictureUtils.imageDelete(imageUrl, image_server);
		return result;
	}
	
	/**
	 * 
	 * @Description (后台登录)
	 * @param user
	 * @param req
	 * @return
	 */
	@RequestMapping("/admin/subLogin")
	public String adminSubLogin(User user,HttpServletRequest req) {
		Subject subject = SecurityUtils.getSubject();
		UsernamePasswordToken token = new UsernamePasswordToken(user.getPhone(),user.getPassword());
		try {
			subject.login(token);
		} catch (Exception e) {
			req.setAttribute("error", "账号或密码错误");
			return "admin/login";
		}
		if(subject.hasRole("admin")) {
			return "redirect:index.html";
		}
		req.setAttribute("error", "请使用管理员账号");
		return "admin/login";
	}
	
	/**
	 * 
	 * @Description (后台登出)
	 * @return
	 */
	@RequestMapping("/admin/logout")
	public String adminLogout() {
		Subject subject = SecurityUtils.getSubject();
		subject.logout();
		return "redirect:/index.html";
	}
	
	/**
	 * 
	 * @Description (前台登录)
	 * @param user
	 * @param req
	 * @return
	 */
	@RequestMapping("/subLogin")
	public String subLogin(User user,HttpServletRequest req) {
		Subject subject = SecurityUtils.getSubject();
		UsernamePasswordToken token = new UsernamePasswordToken(user.getPhone(),user.getPassword());
		try {
			subject.login(token);
		} catch (Exception e) {
			req.setAttribute("error", "账号或密码错误");
			return "login";
		}
		if(subject.hasRole("user") || subject.hasRole("admin")) {
			return "redirect:index.html";
		}
		req.setAttribute("error", "账号校验出错,请联系管理员");
		return "login";
	}
	
	/**
	 * 
	 * @Description (前台登出)
	 * @return
	 */
	@RequestMapping("/logout")
	public String protalLogout() {
		Subject subject = SecurityUtils.getSubject();
		subject.logout();
		return "redirect:/index.html";
	}
	/**
	 * 
	 * @Description (用户注册)
	 * @param user
	 * @return BlogResult
	 */
	@RequestMapping("/subRegister")
	@ResponseBody
	public BlogResult subRegister(User user) {
		Md5Hash md5Hash = new Md5Hash(user.getPassword(),"perfree");
		String password = md5Hash.toString();
		user.setPassword(password);
		BlogResult result = userService.addUser(user);
		return result;
	}
	/**
	 * 
	 * @Description (ajax校验手机号是否存在)
	 * @param phone
	 * @return
	 */
	@RequestMapping("/regxPhone")
	@ResponseBody
	public BlogResult regxPhone(String phone) {
		BlogResult result = userService.findUserByPhone(phone);
		return result;
	}
	/**
	 * 
	 * @Description (ajax校验用户名)
	 * @param nickname
	 * @return
	 */
	@RequestMapping("/checkNick")
	@ResponseBody
	public BlogResult checkNick(String nickname) {
		BlogResult result = userService.findUserByNickName(nickname);
		return result;
	}
}
