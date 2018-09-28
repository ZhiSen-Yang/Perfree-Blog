package com.blog.service;

import java.util.List;

import com.blog.common.BlogResult;
import com.blog.common.PageResult;
import com.blog.pojo.Revert;
import com.blog.pojo.RevertCustom;

/**
 * @ClassName RevertService
 * @Description TODO(评论service接口)
 * @author Perfree
 * @Date 2018年9月10日 下午9:51:57
 * @version 1.0.0
 */
public interface RevertService {

	/**
	 * @Description (根据文章id返回评论列表)
	 * @param articleId
	 * @return
	 */
	List<RevertCustom> getRevertList(String articleId);

	/**
	 * @Description (删除评论)
	 * @param id
	 * @return
	 */
	BlogResult deleteRevert(Long id);

	/**
	 * @Description (分页获取某文章的评论列表)
	 * @param page
	 * @param pageSize
	 * @param id
	 * @return
	 */
	PageResult<RevertCustom> getReverts(Integer page, Integer pageSize, String id);

	/**
	 * @Description (发表评论)
	 * @param revert
	 * @return
	 */
	BlogResult addRevert(Revert revert);

}
