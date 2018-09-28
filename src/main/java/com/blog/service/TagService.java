package com.blog.service;

import java.util.List;

import com.blog.common.BlogResult;
import com.blog.pojo.ArticleTag;
import com.blog.pojo.Tag;

/**
 * @ClassName TagService
 * @Description TODO(标签service接口)
 * @author Perfree
 * @Date 2018年9月5日 上午11:24:16
 * @version 1.0.0
 */
public interface TagService {
	
	/**
	 * 
	 * @Description (获取所有标签)
	 * @return list
	 */
	public List<Tag> getTags();
	
	
	/**
	 * 
	 * @Description (添加标签)
	 * @param name
	 */
	public BlogResult addTag(String name);
	

	/**
	 * @Description (编辑标签)
	 * @param tag
	 */
	public BlogResult updateTag(Tag tag);
	
	/**
	 * @Description (删除标签)
	 * @param id
	 */
	public BlogResult deleteTag(Long id);
	/**
	 * @Description (批量删除标签)
	 * @param ids
	 */
	public BlogResult deleteTags(String ids);


	/**
	 * @Description (获取文章标签id)
	 * @return
	 */
	public List<ArticleTag> getTagsByArticleId(String id);


	/**
	 * @Description (根据id获取标签信息)
	 * @param id
	 * @return
	 */
	public Tag getTagById(Long id);


	/**
	 * @Description (根据文章id获取标签)
	 * @param id
	 * @return
	 */
	public BlogResult getArticleTags(String id);
	
}
