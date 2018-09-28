package com.blog.service;

import java.util.List;

import com.blog.common.BlogResult;
import com.blog.pojo.Content;

public interface ContentService {

	/*
	 * 添加轮播图
	 */
	public BlogResult addContent(String imageUrl);
	
	/**
	 * 获取所有轮播图列表
	 */
	public List<Content> getAllContents();
	
	/**
	 * 删除轮播图
	 */
	public BlogResult deleteContent(Integer id,String imageUrl);
	
	/**
	 * 批量删除轮播图
	 */
	public BlogResult deleteContents(String ids,String imageUrl);
}
