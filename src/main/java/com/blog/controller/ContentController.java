package com.blog.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.blog.common.BlogResult;
import com.blog.pojo.Content;
import com.blog.service.ContentService;

/**
 * 
 * @author wyh
 * description:轮播图controller
 *
 */
@Controller
public class ContentController {

	
	@Autowired
	private ContentService contentService;
	
	/**
	 * description:添加轮播图
	 * @param imageUrl
	 * @return
	 */
	@RequestMapping("/content/add")
	@ResponseBody
	public BlogResult addContent(String imageUrl) {
		BlogResult result = contentService.addContent(imageUrl);
		return result;
	}
	
	/**
	 * description:后台轮播图列表
	 */
	@RequestMapping("/admin/content")
	public String getAllContents(Model model){
		List<Content> list = contentService.getAllContents();
		model.addAttribute("contents", list);
		model.addAttribute("total", list.size());
		return "admin/content";
	}
	
	
	
	/**
	 * description:删除轮播图
	 * @param id
	 * @return
	 */
	@RequestMapping("/delContent")
	@ResponseBody
	public BlogResult deleteContent(Integer id,String imageUrl) {
		BlogResult result = contentService.deleteContent(id,imageUrl);
		return result;
	}
	
	/**
	 *description:批量删除轮播图
	 * @param ids
	 * @return 
	 */
	@RequestMapping("/deleteContents")
	@ResponseBody
	public BlogResult deleteContents(String ids,String imageUrl) {
		BlogResult result = contentService.deleteContents(ids,imageUrl);
		return result;
	}
	
}
