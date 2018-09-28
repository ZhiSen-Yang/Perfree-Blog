package com.blog.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.blog.common.BlogResult;
import com.blog.common.PageResult;
import com.blog.mapper.ArticleMapper;
import com.blog.mapper.RevertMapper;
import com.blog.pojo.Revert;
import com.blog.pojo.RevertCustom;
import com.blog.service.RevertService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * @ClassName RevertServiceImpl
 * @Description TODO(评论service实现类)
 * @author Perfree
 * @Date 2018年9月10日 下午10:00:08
 * @version 1.0.0
 */
@Service
public class RevertServiceImpl implements RevertService {

	@Autowired
	private RevertMapper revertMapper;
	
	@Autowired
	private ArticleMapper articleMapper;
	
	/* (非 Javadoc)
	 * Description:
	 * @see com.blog.service.RevertService#getRevertList(java.lang.String)
	 */
	@Override
	public List<RevertCustom> getRevertList(String articleId) {
		List<RevertCustom> list = revertMapper.getRevertList(articleId);
		return list;
	}

	/* (非 Javadoc)
	 * Description:
	 * @see com.blog.service.RevertService#deleteRevert(java.lang.Long)
	 */
	@Override
	public BlogResult deleteRevert(Long id) {
		BlogResult result = new BlogResult();
		try {
			revertMapper.deleteRevert(id);
			result.setStatus(200);
		} catch (Exception e) {
			result.setStatus(500);
			result.setMsg("删除失败!");
		}
		
		return result;
	}

	/* (非 Javadoc)
	 * Description:
	 * @see com.blog.service.RevertService#getReverts(java.lang.Integer, java.lang.Integer, java.lang.String)
	 */
	@Override
	public PageResult<RevertCustom> getReverts(Integer page, Integer pageSize, String id) {
		PageResult<RevertCustom> result = new PageResult<>();
		try {
			PageHelper.startPage(page, pageSize);
			List<RevertCustom> list = revertMapper.getRevertList(id);
			PageInfo<RevertCustom> pageInfo = new PageInfo<>(list);
			result.setList(pageInfo.getList());
			result.setPageNum(page);
			result.setPageSize(pageSize);
			result.setTotal(pageInfo.getTotal());
			result.setTotalPage(pageInfo.getPages());
		} catch (Exception e) {
			// TODO: handle exception
		}
		return result;
	}

	/* (非 Javadoc)
	 * Description:
	 * @see com.blog.service.RevertService#addRevert(com.blog.pojo.Revert)
	 */
	@Override
	public BlogResult addRevert(Revert revert) {
		BlogResult result = new BlogResult();
		try {
			revert.setCreateTime(new Date());
			String replace = revert.getContext().replace("\"", "'");
			revert.setContext(replace);
			revertMapper.addRevert(revert);
			articleMapper.updateRevertNum(revert.getArticleId());
			result.setStatus(200);
		} catch (Exception e) {
			result.setStatus(500);
			result.setMsg("发表失败~请重试~");
		}
		return result;
	}

}
