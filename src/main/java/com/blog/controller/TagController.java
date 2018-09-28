package com.blog.controller;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.blog.common.BlogResult;
import com.blog.pojo.ArticleTag;
import com.blog.pojo.Tag;
import com.blog.service.ArticleService;
import com.blog.service.TagService;

/**
 * @ClassName TagController
 * @Description TODO(后台添加标签controller)
 * @author Administrator
 * @Date 2018年9月7日 上午11:07:56
 * @version 1.0.0
 */
@Controller
public class TagController {

	@Autowired
	private ArticleService articleService;
	
	@Autowired
	private TagService tagService;
	
	/**
	 * description：后台添加标签
	 * @param name
	 * @return
	 */
	@RequestMapping("/tag/add")
	@ResponseBody
	public BlogResult addTag(String name) {
		BlogResult addTag = tagService.addTag(name);
		return addTag;
	}
	
	
	
	/**
	 *description：获取分页标签列表
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/tag-list")
	public String getTagsPage(Model model){
		List<Tag> list = tagService.getTags();
		model.addAttribute("tags",list);
		model.addAttribute("length", list.size());
		return "admin/tag-list";
	}
	
	
	/**
	 * description：编辑 标签
	 * 
	 */
	@RequestMapping("/tag/edit")
	@ResponseBody
	public BlogResult updateTag(Tag tag) {
		BlogResult result = tagService.updateTag(tag);
		return result;
	}
	
	/**
	 * description:删除标签
	 */
	@RequestMapping("/delTag")
	@ResponseBody
	public BlogResult deleteTag(Long id) {
		BlogResult result = tagService.deleteTag(id);
		return result;
	}
	
	
	/**
	 * description:批量删除标签
	 */
	@RequestMapping("/deleteTags/{ids}")
	@ResponseBody
	public BlogResult deleteTags(@PathVariable String ids) {
		BlogResult result = tagService.deleteTags(ids);
		return result;
	}
	/**
	 * 
	 * @Description (跳转至前台标签页)
	 * @param model
	 * @return
	 */
	@RequestMapping("/tags")
	public String toProtalTags(Model model) {
		List<Tag> tags = tagService.getTags();
		model.addAttribute("tags", tags);
		return "tags";
	}
	/**
	 * 
	 * @Description (跳转至该标签对应的文章列表页)
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/protal/toTag/{id}")
	public String toTagArticles(@PathVariable Long id,Model model) {
		Tag tag = tagService.getTagById(id);
		BlogResult stickArticles = articleService.getStickArticles();
		model.addAttribute("stickArtices", stickArticles.getData());
		model.addAttribute("webTitle", tag.getName());
		model.addAttribute("webUrl", "/toTag/"+tag.getId()+".html");
		model.addAttribute("tag", tag);
		model.addAttribute("attr", 1);
		return "articles";
	}
	
	/**
	 * 
	 * @Description (根据文章id返回文章标签)
	 * @param id
	 * @return
	 */
	@RequestMapping("/protal/getArticleTags")
	@ResponseBody
	public BlogResult getArticleTags(String id) {
		BlogResult result = tagService.getArticleTags(id);
		return result;
		
	}
}
