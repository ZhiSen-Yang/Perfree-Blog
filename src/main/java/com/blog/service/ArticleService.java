package com.blog.service;

import java.util.List;

import com.blog.common.BlogResult;
import com.blog.common.PageResult;
import com.blog.pojo.Article;
import com.blog.pojo.ArticleCustom;

/**
 * @ClassName articleService
 * @Description TODO(文章service接口)
 * @author Perfree
 * @Date 2018年9月6日 下午10:36:23
 * @version 1.0.0
 */
public interface ArticleService {

	/**
	 * @Description (发表文章)
	 * @param article
	 * @param tagId
	 * @return
	 */
	BlogResult addArticle(Article article, String tagId);

	/**
	 * @Description (根据板块id返回文章列表)
	 * @param boardId
	 * @return
	 */
	List<ArticleCustom> getArticleList(Long boardId);

	/**
	 * @Description (删除/批量删除文章)
	 * @param ids
	 * @return
	 */
	BlogResult deleteArticle(List<String> ids,String imageUrl,String image_server);

	/**
	 * @Description (置顶文章)
	 * @param id
	 * @param stick
	 * @return
	 */
	BlogResult updateArticleStick(String id, int stick);

	/**
	 * @Description (根据文章id获取文章信息)
	 * @param id
	 * @return
	 */
	Article getArticleById(String id);

	/**
	 * @Description (更新文章)
	 * @param article
	 * @param tagId
	 * @return
	 */
	BlogResult updateArticle(Article article, String tagId);

	/**
	 * @Description (获取所有置顶文章)
	 * @return
	 */
	BlogResult getStickArticles();

	/**
	 * @Description (分页获取最新文章)
	 * @return
	 */
	PageResult<ArticleCustom> getNewArticles(Integer page,Integer pageSize);

	/**
	 * @Description (获取前五浏览量最高的文章)
	 * @return
	 */
	BlogResult getHotArticles();

	/**
	 * @Description (获取文章和板块信息)
	 * @param id
	 * @return
	 */
	ArticleCustom getArticle(String id);

	/**
	 * @Description (根据板块id分页显示文章列表)
	 * @param page
	 * @param pageSize
	 * @param id
	 * @return
	 */
	PageResult<ArticleCustom> getArticlesByBoardId(Integer page, Integer pageSize, Long id);

	/**
	 * @Description (根据标签id分页返回该标签下文章列表)
	 * @param page
	 * @param pageSize
	 * @param id
	 * @return
	 */
	PageResult<ArticleCustom> getArticlesByTagId(Integer page, Integer pageSize, Long id);

	/**
	 * @Description (搜索文章并分页返回列表)
	 * @param page
	 * @param pageSize
	 * @param id
	 * @return
	 */
	PageResult<ArticleCustom> searchArticle(Integer page, Integer pageSize, String searchName);

}
