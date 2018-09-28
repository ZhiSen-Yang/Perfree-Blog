package com.blog.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.blog.common.BlogResult;
import com.blog.mapper.ArticleTagMapper;
import com.blog.mapper.TagMapper;
import com.blog.pojo.ArticleTag;
import com.blog.pojo.Tag;
import com.blog.service.TagService;

/**
 * @ClassName TagServiceImpl
 * @Description TODO(这里用一句话描述这个类的作用)
 * @author Perfree
 * @Date 2018年9月5日 上午11:26:31
 * @version 1.0.0
 */
@Service
public class TagServiceImpl implements TagService {

	@Autowired
	private TagMapper tagMapper;
	
	@Autowired
	private ArticleTagMapper articleTagMapper;

	 /* Description:添加标签
	 */
	@Override
	public BlogResult addTag(String name) {
		try {
			tagMapper.addTag(name);
			return BlogResult.ok(200, "添加成功", null);
		} catch (Exception e) {
			return BlogResult.build(500, "添加失败");
		}
		
	}

	
	/* (非 Javadoc)
	 * Description:获取所有标签
	 */
	@Override
	public List<Tag> getTags() {
		List<Tag> tags = tagMapper.getTags();
		return tags;
	}


	/**
	 * description:编辑标签
	 */
	@Override
	public BlogResult updateTag(Tag tag) {
		try {
			tagMapper.updateTag(tag);
			return BlogResult.ok(200, "更新成功", null);
		} catch (Exception e) {
			return BlogResult.build(500, "更新失败");
		}
	}


	/**
	 * description:删除标签
	 */
	@Override
	public BlogResult deleteTag(Long id) {
		try {
			tagMapper.deleteTag(id);
			return BlogResult.ok(200, "删除成功", null);
		} catch (Exception e) {
			return BlogResult.build(500, "删除失败");
		}
	}
	
	/**
	 * description:批量删除标签
	 */
	public BlogResult deleteTags(String ids) {
		String string2 = ids.substring(4);
		String [] s = string2.split(",");
		//将String类型的List转为Long类型
		List<String> list = Arrays.asList(s);
		List<Long> idss = new ArrayList<Long>();
		for (String string : list) {
			long id = Long.parseLong(string);
			idss.add(id);
		}
		try {
			tagMapper.deleteTags(idss);
			return BlogResult.ok(200, "删除成功", null);
		} catch (Exception e) {
			return BlogResult.build(500, "删除失败");
		}
	}


	/* (非 Javadoc)
	 * Description:
	 * @see com.blog.service.TagService#getTagsByArticleId(java.lang.String)
	 */
	@Override
	public List<ArticleTag> getTagsByArticleId(String id) {
		List<ArticleTag> list = articleTagMapper.getTagsByArticleId(id);
		return list;
	}


	/* (非 Javadoc)
	 * Description:
	 * @see com.blog.service.TagService#getTagById(java.lang.Long)
	 */
	@Override
	public Tag getTagById(Long id) {
		Tag tag = new Tag();
		try {
			tag=tagMapper.getTagById(id);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return tag;
	}


	/* (非 Javadoc)
	 * Description:
	 * @see com.blog.service.TagService#getArticleTags(java.lang.String)
	 */
	@Override
	public BlogResult getArticleTags(String id) {
		BlogResult result = new BlogResult();
		try {
			List<Tag> tags = tagMapper.getArticleTags(id);
			result.setStatus(200);
			result.setData(tags);
		} catch (Exception e) {
			result.setStatus(500);
			result.setMsg("系统错误");
		}
		return result;
	}

}
