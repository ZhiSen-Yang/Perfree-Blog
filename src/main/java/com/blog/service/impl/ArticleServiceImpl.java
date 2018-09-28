package com.blog.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.blog.common.BlogResult;
import com.blog.common.IdUtils;
import com.blog.common.PageResult;
import com.blog.common.PictureUtils;
import com.blog.common.StrSubUtils;
import com.blog.mapper.ArticleMapper;
import com.blog.mapper.ArticleTagMapper;
import com.blog.pojo.Article;
import com.blog.pojo.ArticleCustom;
import com.blog.pojo.ArticleTag;
import com.blog.service.ArticleService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * @ClassName ArticleServiceImpl
 * @Description TODO(文章service实现类)
 * @author Perfree
 * @Date 2018年9月6日 下午10:39:08
 * @version 1.0.0
 */
@Service
public class ArticleServiceImpl implements ArticleService {

	@Autowired
	private ArticleMapper articleMapper;
	
	@Autowired
	private ArticleTagMapper articleTagMapper;
	
	/* (非 Javadoc)
	 * Description:
	 * @see com.blog.service.ArticleService#addArticle(com.blog.pojo.Article, java.lang.String)
	 */
	@Override
	public BlogResult addArticle(Article article, String tagId) {
		BlogResult result = new BlogResult();
		try {
			String articleId = IdUtils.genId().toString();
			article.setCreateTime(new Date());
			article.setUpdateTime(new Date());
			article.setPageView(0L);
			article.setId(articleId);
			article.setStick(0);
			articleMapper.addArticle(article);
			if(tagId != null && tagId != "") {
				String[] split = tagId.split(",");
				if(split != null && split.length > 0) {
					List<ArticleTag> articleTags = new ArrayList<>();
					for (String tag : split) {
						ArticleTag articleTag = new ArticleTag();
						articleTag.setArticleId(articleId);
						articleTag.setTagId(Long.parseLong(tag));
						articleTags.add(articleTag);
					}
					articleTagMapper.addArticleTag(articleTags);
				}
			}
			result.setStatus(200);
		} catch (Exception e) {
			result.setStatus(500);			
			result.setMsg("发表失败");
		}
		return result;
	}

	/* (非 Javadoc)
	 * Description:
	 * @see com.blog.service.ArticleService#getArticleVoter(java.lang.Long)
	 */
	@Override
	public List<ArticleCustom> getArticleList(Long boardId) {
		List<ArticleCustom> list = articleMapper.getArticleList(boardId);
		return list;
	}

	/* (非 Javadoc)
	 * Description:
	 * @see com.blog.service.ArticleService#deleteArticle(java.util.List)
	 */
	@Override
	public BlogResult deleteArticle(List<String> ids,String imageUrl,String image_server) {
		BlogResult result = new BlogResult();
		try {
			articleMapper.deleteArticle(ids);
			PictureUtils.imageDelete(imageUrl, image_server);
			result.setStatus(200);
		} catch (Exception e) {
			result.setStatus(500);
			result.setMsg("删除失败!");
		}
		return result;
	}

	/* (非 Javadoc)
	 * Description:
	 * @see com.blog.service.ArticleService#updateArticleStick(java.lang.String, int)
	 */
	@Override
	public BlogResult updateArticleStick(String id, int stick) {
		BlogResult result = new BlogResult();
		Article article = new Article();
		article.setId(id);
		article.setStick(stick);
		try {
			articleMapper.updateArticle(article);
			result.setStatus(200);
		} catch (Exception e) {
			result.setStatus(500);
			result.setMsg("操作失败!");
		}
		return result;
	}

	/* (非 Javadoc)
	 * Description:
	 * @see com.blog.service.ArticleService#getArticleById(java.lang.String)
	 */
	@Override
	public Article getArticleById(String id) {
		Article article = articleMapper.getArticleById(id);
		return article;
	}

	/* (非 Javadoc)
	 * Description:
	 * @see com.blog.service.ArticleService#updateArticle(com.blog.pojo.Article, java.lang.String)
	 */
	@Override
	public BlogResult updateArticle(Article article, String tagId) {
		BlogResult result = new BlogResult();
		try {
			article.setUpdateTime(new Date());
			articleMapper.updateArticle(article);
			if(tagId != null && tagId != "") {
				String[] split = tagId.split(",");
				if(split != null && split.length > 0) {
					articleTagMapper.deleteArtivleTag(article.getId());
					List<ArticleTag> articleTags = new ArrayList<>();
					for (String tag : split) {
						ArticleTag articleTag = new ArticleTag();
						articleTag.setArticleId(article.getId());
						articleTag.setTagId(Long.parseLong(tag));
						articleTags.add(articleTag);
					}
					articleTagMapper.addArticleTag(articleTags);
				}
			}
			result.setStatus(200);
		} catch (Exception e) {
			result.setStatus(500);
			result.setMsg("更新失败!");
		}
		return result;
	}

	/* (非 Javadoc)
	 * Description:
	 * @see com.blog.service.ArticleService#getStickArticles()
	 */
	@Override
	public BlogResult getStickArticles() {
		BlogResult result = new BlogResult();
		try {
			List<Article> list = articleMapper.getStickArticles();
			result.setData(list);
			result.setStatus(200);
		} catch (Exception e) {
			result.setStatus(500);
			result.setMsg("查询置顶文章异常");
		}
		return result;
	}

	/* (非 Javadoc)
	 * Description:
	 * @see com.blog.service.ArticleService#getNewArticles()
	 */
	@Override
	public PageResult<ArticleCustom> getNewArticles(Integer page,Integer pageSize) {
		PageResult<ArticleCustom> result = new PageResult<>();
		try {
			PageHelper.startPage(page, pageSize);
			List<ArticleCustom> list = articleMapper.getNewArticles();
			PageInfo<ArticleCustom> pageArticle = new PageInfo<>(list);
			List<ArticleCustom> articleList= new ArrayList<>();
			for (ArticleCustom articleCustom : pageArticle.getList()) {
				String context = StrSubUtils.subArticle(articleCustom.getContext(), 100);
				articleCustom.setContext(context);
				articleList.add(articleCustom);
			}
			result.setList(articleList);
			result.setTotal(pageArticle.getTotal());
			result.setPageNum(page);
			result.setTotalPage(pageArticle.getPages());
		} catch (Exception e) {
			
		}
		return result;
	}

	/* (非 Javadoc)
	 * Description:
	 * @see com.blog.service.ArticleService#getHotArticles()
	 */
	@Override
	public BlogResult getHotArticles() {
		BlogResult result = new BlogResult();
		try {
			List<ArticleCustom> list = articleMapper.getHotArticles();
			result.setData(list);
			result.setStatus(200);
		} catch (Exception e) {
			result.setStatus(500);
			result.setMsg("查询最热文章异常");
		}
		return result;
	}

	/* (非 Javadoc)
	 * Description:
	 * @see com.blog.service.ArticleService#getArticle(java.lang.String)
	 */
	@Override
	public ArticleCustom getArticle(String id) {
		ArticleCustom articleCustom = new ArticleCustom();
		try {
			articleMapper.updateArticlePageView(id);
			articleCustom = articleMapper.getArticle(id);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return articleCustom;
	}

	/* (非 Javadoc)
	 * Description:
	 * @see com.blog.service.ArticleService#getArticlesByBoardId(java.lang.Integer, java.lang.Integer, java.lang.Long)
	 */
	@Override
	public PageResult<ArticleCustom> getArticlesByBoardId(Integer page, Integer pageSize, Long id) {
		PageResult<ArticleCustom> result = new PageResult<>();
		try {
				PageHelper.startPage(page, pageSize);
				List<ArticleCustom> list = articleMapper.getArticleList(id);
				PageInfo<ArticleCustom> pageArticle = new PageInfo<>(list);
				List<ArticleCustom> articleList= new ArrayList<>();
				for (ArticleCustom articleCustom : pageArticle.getList()) {
					String context = StrSubUtils.subArticle(articleCustom.getContext(), 100);
					articleCustom.setContext(context);
					articleList.add(articleCustom);
				}
				result.setList(articleList);
				result.setTotal(pageArticle.getTotal());
				result.setPageNum(page);
				result.setTotalPage(pageArticle.getPages());
			} catch (Exception e) {
				
			}
		
		return result;
	}

	/* (非 Javadoc)
	 * Description:
	 * @see com.blog.service.ArticleService#getArticlesByTagId(java.lang.Integer, java.lang.Integer, java.lang.Long)
	 */
	@Override
	public PageResult<ArticleCustom> getArticlesByTagId(Integer page, Integer pageSize, Long id) {
		PageResult<ArticleCustom> result = new PageResult<>();
		try {
				PageHelper.startPage(page, pageSize);
				List<ArticleCustom> list = articleMapper.getArticlesByTagId(id);
				PageInfo<ArticleCustom> pageArticle = new PageInfo<>(list);
				List<ArticleCustom> articleList= new ArrayList<>();
				for (ArticleCustom articleCustom : pageArticle.getList()) {
					String context = StrSubUtils.subArticle(articleCustom.getContext(), 100);
					articleCustom.setContext(context);
					articleList.add(articleCustom);
				}
				result.setList(articleList);
				result.setTotal(pageArticle.getTotal());
				result.setPageNum(page);
				result.setTotalPage(pageArticle.getPages());
			} catch (Exception e) {
				
			}
		
		return result;
	}

	/* (非 Javadoc)
	 * Description:
	 * @see com.blog.service.ArticleService#searchArticle(java.lang.Integer, java.lang.Integer, java.lang.String)
	 */
	@Override
	public PageResult<ArticleCustom> searchArticle(Integer page, Integer pageSize, String searchName) {
		PageResult<ArticleCustom> result = new PageResult<>();
		try {
				PageHelper.startPage(page, pageSize);
				List<ArticleCustom> list = articleMapper.searchArticle(searchName);
				PageInfo<ArticleCustom> pageArticle = new PageInfo<>(list);
				List<ArticleCustom> articleList= new ArrayList<>();
				for (ArticleCustom articleCustom : pageArticle.getList()) {
					String context = StrSubUtils.subArticle(articleCustom.getContext(), 100);
					articleCustom.setContext(context);
					articleList.add(articleCustom);
				}
				result.setList(articleList);
				result.setTotal(pageArticle.getTotal());
				result.setPageNum(page);
				result.setTotalPage(pageArticle.getPages());
			} catch (Exception e) {
				
			}
		
		return result;
	}

}
