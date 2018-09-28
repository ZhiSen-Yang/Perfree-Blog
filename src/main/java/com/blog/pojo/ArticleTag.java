package com.blog.pojo;

import java.io.Serializable;

/**
 * @ClassName ArticleTag
 * @Description TODO(文章标签中间表实体类)
 * @author Perfree
 * @Date 2018年9月6日 下午10:05:49
 * @version 1.0.0
 */
public class ArticleTag implements Serializable{

	private String articleId;
	private Long tagId;
	/**
	 * @return the articleId
	 */
	public String getArticleId() {
		return articleId;
	}
	/**
	 * @param articleId the articleId to set
	 */
	public void setArticleId(String articleId) {
		this.articleId = articleId;
	}
	/**
	 * @return the tagId
	 */
	public Long getTagId() {
		return tagId;
	}
	/**
	 * @param tagId the tagId to set
	 */
	public void setTagId(Long tagId) {
		this.tagId = tagId;
	}
	
}
