package com.blog.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.blog.common.BlogResult;
import com.blog.common.PictureUtils;
import com.blog.mapper.ContentMapper;
import com.blog.pojo.Content;
import com.blog.service.ContentService;

/**
 * description：轮播图管理业务层实现类
 * @author wyh
 *
 */
@Service
public class ContentServiceImpl implements ContentService {

	@Value("${image_server}")
	private String image_server;
	
	@Autowired
	private ContentMapper contentMapper;
	
	/**
	 * description：添加轮播图
	 */
	@Override
	public BlogResult addContent(String imageUrl) {
		try {
			contentMapper.addContent(imageUrl);
			return BlogResult.ok(200, "添加成功", null);
		} catch (Exception e) {
			return BlogResult.build(500, "添加失败");
		}
	}

	/**
	 * description：获取所有轮播图列表
	 */
	@Override
	public List<Content> getAllContents() {
		List<Content> list = contentMapper.getAllContents();
		return list;
	}

	
	/**
	 * description：删除轮播图
	 */
	@Override
	public BlogResult deleteContent(Integer id,String imageUrl) {
		try {
			contentMapper.deleteContent(id);
			PictureUtils.imageDelete(imageUrl, image_server);
			return BlogResult.ok(200, "删除成功", null);
		} catch (Exception e) {
			return BlogResult.build(500, "删除失败");
		}
	}

	
	/**
	 * description：批量删除轮播图
	 */
	@Override
	public BlogResult deleteContents(String ids,String imageUrl) {
		String [] s = ids.split(",");
		List<Integer> idss = new ArrayList<Integer>();
		for (String str : s) {
			int id = Integer.parseInt(str);
			idss.add(id);
		}
		try {
			contentMapper.deleteContents(idss);
			PictureUtils.imageDelete(imageUrl, image_server);
			return BlogResult.ok(200, "删除成功", null);
		} catch (Exception e) {
			return BlogResult.build(500, "删除失败");
		}
	}

}
