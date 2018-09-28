package com.blog.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.blog.common.BlogResult;
import com.blog.common.PageResult;
import com.blog.pojo.Article;
import com.blog.pojo.ArticleCustom;
import com.blog.pojo.ArticleTag;
import com.blog.pojo.Board;
import com.blog.pojo.Tag;
import com.blog.service.ArticleService;
import com.blog.service.BoardService;
import com.blog.service.TagService;

/**
 * @ClassName SelectController
 * @Description TODO(发表文章)
 * @author Administrator
 * @Date 2018年9月4日 下午2:35:08
 * @version 1.0.0
 */
@Controller
public class ArticleController {
	
	@Value("${image_server}")
	private String image_server;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private TagService tagService;
	
	@Autowired
	private ArticleService articleService;
	
	/**
	 * 
	 * @Description (发表文章时选择分类的下拉框)
	 * @return
	 */
	@RequestMapping("/admin/sendArticle")
	public String getBoardParent(Model model) {
		List<Board> boardParent = boardService.getBoardParent();
		List<Tag> tags = tagService.getTags();
		model.addAttribute("parent", boardParent);
		model.addAttribute("tags", tags);
		return "admin/sendArticle";
	}
	
	
	/**
	 * 
	 * @Description (根据一级分类id获取二级分类名称加载到下拉框中)
	 * @return
	 */
	@RequestMapping("/getchildBoard")
	@ResponseBody
	public List<Board> getchildBoard(String pid) {
		List<Board> child = boardService.getchildBoard(pid);
		return child;
	}
	
	/**
	 * 
	 * @Description (文章发表)
	 * @param article
	 * @param tagId
	 * @return
	 */
	@RequestMapping("/article/send")
	@ResponseBody
	public BlogResult addArticle(Article article,String tagId) {
		BlogResult blogResult = articleService.addArticle(article,tagId);
		return blogResult;
	}	
	
	/**
	 * 
	 * @Description (文章列表中的分类下拉框)
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/article-list")
	public String getListBoardParent(Model model) {
		List<Board> boardParent = boardService.getBoardParent();
		model.addAttribute("parents", boardParent);
		return "admin/article-list";
	}
	
	/**
	 * 
	 * @Description (根据分类id返回文章列表)
	 * @param boardId
	 * @return
	 */
	@RequestMapping("/article/list")
	@ResponseBody
	public Map<String,Object> getArticleList(Long boardId) {
		List<ArticleCustom> list = articleService.getArticleList(boardId);
		Map<String,Object> map = new HashMap<>();
		map.put("data", list);
		map.put("recordsFiltered", list.size());
		return map;
	}
	
	/**
	 * 
	 * @Description (删除/批量删除文章)
	 * @param id
	 * @return
	 */
	@RequestMapping("/article/del")
	@ResponseBody
	public BlogResult deleteArticle(String id,String imageUrl) {
		BlogResult result = new BlogResult();
		String[] split = id.split(",");
		if(split != null && split.length > 0) {
			List<String> ids = new ArrayList<>();
			for (String str : split) {
				ids.add(str);
			}
			result = articleService.deleteArticle(ids,imageUrl,image_server);
		}
		return result;
	}
	
	/**
	 * 
	 * @Description (置顶文章)
	 * @param id
	 * @param stick
	 * @return
	 */
	@RequestMapping("/article/stick")
	@ResponseBody
	public BlogResult articleStick(String id,Integer stick) {
		BlogResult result = new BlogResult();
		if(stick == 0) {
			result = articleService.updateArticleStick(id,1);
		}else {
			result = articleService.updateArticleStick(id,0);
		}
		return result;
	}
	
	/**
	 * 
	 * @Description (前往文章编辑页面,这应该是最垃圾的代码了)
	 * @return
	 */
	@RequestMapping("/article/toEdit/{id}/{boardId}")
	public String toArticleEdit(@PathVariable String id,@PathVariable Long boardId,Model model) {
		//获取一级分类列表
		List<Board> boardParent = boardService.getBoardParent();
		//获取标签列表
		List<Tag> tags = tagService.getTags();
		//获取初始二级分类列表
		List<Board> childBoard = boardService.getChildBoardsById(boardId);
		//获取文章标签id
		List<ArticleTag> articleTags = tagService.getTagsByArticleId(id);
		//根据id获取文章信息
		Article article = articleService.getArticleById(id);
		model.addAttribute("parent", boardParent);
		model.addAttribute("tags", tags);
		model.addAttribute("child", childBoard);
		model.addAttribute("articleTags", articleTags);
		model.addAttribute("article", article);
		return "admin/article-edit";
	}
	
	/**
	 * 
	 * @Description (更新文章)
	 * @param article
	 * @param tagId
	 * @return
	 */
	@RequestMapping("/article/edit")
	@ResponseBody
	public BlogResult updateArticle(Article article,String tagId) {
		BlogResult result = articleService.updateArticle(article,tagId);
		return result;
	}
	
	/**
	 * 
	 * @Description (获取所有置顶文章)
	 * @return
	 */
	@RequestMapping("/protal/getStickArticles")
	@ResponseBody
	public BlogResult getStickArticles() {
		BlogResult result = articleService.getStickArticles();
		return result;
	}
	
	/**
	 * 
	 * @Description (分页获取最新文章)
	 * @return
	 */
	@RequestMapping("/protal/getNewArticles")
	@ResponseBody
	public PageResult<ArticleCustom> getNewArticles(Integer page,Integer pageSize) {
		PageResult<ArticleCustom> result = articleService.getNewArticles(page,pageSize);
		return result;
	}
	
	/**
	 * 
	 * @Description (获取前五浏览量最高的文章)
	 * @return
	 */
	@RequestMapping("/protal/getHotArticles")
	@ResponseBody
	public BlogResult getHotArticles() {
		BlogResult result = articleService.getHotArticles();
		return result;
	}
	
	/**
	 * 
	 * @Description (文章页获取文章及板块信息)
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/toArticle/{id}")
	public String toArticle(@PathVariable String id,Model model) {
		ArticleCustom articleCustom = articleService.getArticle(id);
		model.addAttribute("article", articleCustom);
		return "/article";
	}
	
	/**
	 * 
	 * @Description (根据板块id返回文章列表)
	 * @param page
	 * @param pageSize
	 * @param id
	 * @return
	 */
	@RequestMapping("/protal/getArticlesByBoardId")
	@ResponseBody
	public PageResult<ArticleCustom> getArticlesByBoardId(Integer page,Integer pageSize,Long id){
		PageResult<ArticleCustom> list = articleService.getArticlesByBoardId(page,pageSize,id);
		return list;
	}
	
	/**
	 * 
	 * @Description (根据标签id分页返回该标签下文章)
	 * @param page
	 * @param pageSize
	 * @param id
	 * @return
	 */
	@RequestMapping("/protal/getArticlesByTagId")
	@ResponseBody
	public PageResult<ArticleCustom> getArticlesByTagId(Integer page,Integer pageSize,Long id){
		PageResult<ArticleCustom> list = articleService.getArticlesByTagId(page,pageSize,id);
		return list;
	}
	
	/**
	 * 
	 * @Description (首次加载时间流页面,获取20条根据时间排序的文章信息)
	 * @param model
	 * @return
	 */
	@RequestMapping("/times")
	public String getNewArticlesByTime(Model model) {
		PageResult<ArticleCustom> newArticles = articleService.getNewArticles(1, 20);
		List<ArticleCustom> list = newArticles.getList();
		model.addAttribute("articles", list);
		return "times";
	}
	
	/**
	 * 
	 * @Description (时间流页面动态加载文章)
	 * @param page
	 * @param pageSize
	 * @return
	 */
	@RequestMapping("/protal/getNewArticlesByAjax")
	@ResponseBody
	public List<ArticleCustom> getNewArticlesByAjax(Integer page,Integer pageSize){
		PageResult<ArticleCustom> newArticles = articleService.getNewArticles(page, pageSize);
		List<ArticleCustom> list = newArticles.getList();
		return list;
	}
	/**
	 * 
	 * @Description (前往搜索文章)
	 * @param search
	 * @return
	 */
	@RequestMapping("/protal/toSearchArticle")
	public String toSearchArticle(String search,Model model) {
		BlogResult stickArticles = articleService.getStickArticles();
		model.addAttribute("stickArtices", stickArticles.getData());
		model.addAttribute("webTitle", search);
		model.addAttribute("webUrl", -1);
		model.addAttribute("searchName", search);
		model.addAttribute("attr", 2);
		return "articles";
	}
	
	/**
	 * 
	 * @Description (搜索文章并分页返回结果)
	 * @param page
	 * @param pageSize
	 * @param id
	 * @return
	 */
	@RequestMapping("/protal/searchArticle")
	@ResponseBody
	public PageResult<ArticleCustom> searchArticle(Integer page,Integer pageSize,String id){
		PageResult<ArticleCustom> list = articleService.searchArticle(page,pageSize,id);
		return list;
	}
}
