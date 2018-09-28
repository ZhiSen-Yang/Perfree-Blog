package com.blog.mapper;

import java.util.List;

import com.blog.pojo.Content;

public interface ContentMapper {

	
	/**
	 * description：添加轮播图
	 * @param imageUrl
	 */
	public void addContent(String imageUrl);
	
	
	/**
	 * description：获取所有轮播图列表
	 */
	public List<Content> getAllContents();
	
	/**
	 * description:删除轮播图
	 */
	public void deleteContent(Integer id);
	
	/**
	 * description:批量删除轮播图
	 */
	public void deleteContents(List<Integer> ids);
}
