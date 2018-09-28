package com.blog.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.blog.common.BlogResult;
import com.blog.common.PageResult;
import com.blog.pojo.Revert;
import com.blog.pojo.RevertCustom;
import com.blog.pojo.User;
import com.blog.service.RevertService;

/**
 * @ClassName RevertControlle
 * @Description TODO(评论controller)
 * @author Perfree
 * @Date 2018年9月10日 下午9:42:50
 * @version 1.0.0
 */
@Controller
public class RevertControlle {

	@Autowired
	private RevertService revertService;
	
	/**
	 * 
	 * @Description (根据文章id返回评论列表)
	 * @param articleId
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/revert-list/{articleId}")
	public String toRevertList(@PathVariable String articleId,Model model) {
		List<RevertCustom> list = revertService.getRevertList(articleId);
		model.addAttribute("reverts", list);
		return "admin/revert-list";
	}
	
	/**
	 * 
	 * @Description (删除评论)
	 * @param id
	 * @return
	 */
	@RequestMapping("/revert/del")
	@ResponseBody
	public BlogResult deleteRevert(Long id) {
		BlogResult result = revertService.deleteRevert(id);
		return result;
	}
	
	/**
	 * 
	 * @Description (分页获取某文章评论列表)
	 * @param page
	 * @param pageSize
	 * @param id
	 * @return
	 */
	@RequestMapping("/protal/getReverts")
	@ResponseBody
	public PageResult<RevertCustom> getReverts(Integer page,Integer pageSize,String id){
		PageResult<RevertCustom> result = revertService.getReverts(page,pageSize,id);
		return result;
	}
	
	/**
	 * 
	 * @Description (发表评论)
	 * @param revert
	 * @return
	 */
	@RequestMapping("/sendRevert")
	@ResponseBody
	public BlogResult sendRevert(Revert revert,HttpSession session) {
		User user = (User) session.getAttribute("userSession");
		revert.setUserId(user.getId());
		BlogResult result = revertService.addRevert(revert);
		return result;
	}
}
