package com.blog.mapper;

import java.util.List;

import com.blog.pojo.Tag;

/**
 * @ClassName TagMapper
 * @Description TODO(标签mapper接口)
 * @author Perfree
 * @Date 2018年9月5日 上午11:18:52
 * @version 1.0.0
 */
public interface TagMapper {
	
	/**
	 * 
	 * @Description (获取所有tag标签)
	 * @return list
	 */
	public List<Tag> getTags();
	
	/**
	 * 
	 * @Description (添加标签)
	 * @param name
	 */
	public void addTag(String name);
	
	/**
	 * @Description (编辑标签)
	 * @param tag
	 */
	public void updateTag(Tag tag);
	
	/**
	 * @Description (删除标签)
	 * @param id
	 */
	public void deleteTag(Long id);
	
	/**
	 * @Description (批量删除标签)
	 * @param ids
	 */
	public void deleteTags(List<Long> ids);

	/**
	 * @Description (根据id获取标签信息)
	 * @param id
	 * @return
	 */
	public Tag getTagById(Long id);

	/**
	 * @Description (根据文章id返回标签列表)
	 * @param id
	 * @return
	 */
	public List<Tag> getArticleTags(String id);
}
