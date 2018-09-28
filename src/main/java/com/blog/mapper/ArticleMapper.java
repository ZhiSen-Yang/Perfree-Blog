package com.blog.mapper;

import java.util.List;

import com.blog.pojo.Article;
import com.blog.pojo.ArticleCustom;
import com.blog.pojo.Board;

/**
 * @ClassName ArticleMapper
 * @Description TODO(文章mapper接口)
 * @author Perfree
 * @Date 2018年9月6日 下午10:09:09
 * @version 1.0.0
 */
public interface ArticleMapper {

	/**
	 * @Description (添加文章)
	 * @param article
	 */
	public void addArticle(Article article);

	/**
	 * @Description (根据分类id获取文章列表)
	 * @param boardId
	 * @return
	 */
	public List<ArticleCustom> getArticleList(Long boardId);

	/**
	 * @Description (TODO这里用一句话描述这个方法的作用)
	 * @param ids
	 */
	public void deleteArticle(List<String> ids);

	/**
	 * @Description (更新文章信息)
	 * @param article
	 */
	public void updateArticle(Article article);

	/**
	 * @Description (根据文章id获取文章信息)
	 * @param id
	 * @return
	 */
	public Article getArticleById(String id);

	/**
	 * @Description (获取所有置顶文章)
	 * @return
	 */
	public List<Article> getStickArticles();

	/**
	 * @Description (获取最新文章)
	 * @return
	 */
	public List<ArticleCustom> getNewArticles();

	/**
	 * @Description (获取浏览量最高的十篇文章)
	 * @return
	 */
	public List<ArticleCustom> getHotArticles();

	/**
	 * @Description (获取文章和板块信息)
	 * @param id
	 * @return
	 */
	public ArticleCustom getArticle(String id);

	/**
	 * @Description (浏览量+1)
	 */
	public void updateArticlePageView(String id);

	/**
	 * @Description (根据标签id获取文章列表)
	 * @param id
	 * @return
	 */
	public List<ArticleCustom> getArticlesByTagId(Long id);

	/**
	 * @Description (搜索文章)
	 * @param searchName
	 * @return
	 */
	public List<ArticleCustom> searchArticle(String searchName);

	/**
	 * @Description (评论数加1)
	 */
	public void updateRevertNum(String id);

}
