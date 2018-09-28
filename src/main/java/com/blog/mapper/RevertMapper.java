package com.blog.mapper;

import java.util.List;

import com.blog.pojo.Revert;
import com.blog.pojo.RevertCustom;

/**
 * @ClassName revertMapper
 * @Description TODO(评论mapper接口)
 * @author Perfree
 * @Date 2018年9月10日 下午10:02:40
 * @version 1.0.0
 */
public interface RevertMapper {

	/**
	 * @Description (根据文章id获取评论列表)
	 * @param articleId
	 * @return
	 */
	List<RevertCustom> getRevertList(String articleId);

	/**
	 * @Description (删除评论)
	 * @param id
	 */
	void deleteRevert(Long id);

	/**
	 * @Description (添加评论)
	 * @param revert
	 */
	void addRevert(Revert revert);

}
