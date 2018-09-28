package com.blog.mapper;

import java.util.List;

import com.blog.pojo.ArticleTag;
import com.blog.pojo.Tag;

/**
 * @ClassName ArticleTagMapper
 * @Description TODO(文章标签mapper接口)
 * @author Perfree
 * @Date 2018年9月6日 下午10:11:42
 * @version 1.0.0
 */
public interface ArticleTagMapper {

	/**
	 * @Description (添加文章标签)
	 * @param articleTags
	 */
	public void addArticleTag(List<ArticleTag> articleTags);
	
	/**
	 * @Description (获取文章标签id)
	 * @param id
	 * @return
	 */
	public List<ArticleTag> getTagsByArticleId(String id);

	/**
	 * @Description (根据文章id删除关联的标签)
	 * @param articleId
	 */
	public void deleteArtivleTag(String articleId);

}
