package com.blog.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.blog.pojo.Content;
import com.blog.service.ContentService;

@Controller
public class PageController {
	
	@Autowired
	private ContentService contentService;
	
	@RequestMapping("/{page}")
	public String toPage(@PathVariable String page) {
		return page;
	}
	
	/**
	 * 
	 * @Description (跳转至首页)
	 * @param model
	 * @return
	 */
	@RequestMapping("/index")
	public String toProtalIndex(Model model) {
		List<Content> list = contentService.getAllContents();
		model.addAttribute("contents", list);
		return "index";
	}
	@RequestMapping("/admin/{page}")
	public String toAdminPage(@PathVariable String page) {
		return "admin/"+page;
	}
}
