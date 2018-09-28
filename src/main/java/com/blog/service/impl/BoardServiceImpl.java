package com.blog.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.blog.common.BlogResult;
import com.blog.common.BoardResult;
import com.blog.common.PictureUtils;
import com.blog.mapper.ArticleMapper;
import com.blog.mapper.BoardMapper;
import com.blog.pojo.ArticleCustom;
import com.blog.pojo.Board;
import com.blog.pojo.BoardCustom;
import com.blog.service.BoardService;

/**
 * @ClassName BoardServiceImpl
 * @Description TODO(这里用一句话描述这个类的作用)
 * @author Perfree
 * @Date 2018年9月7日 上午10:58:36
 * @version 1.0.0
 */
@Service
public class BoardServiceImpl implements BoardService {

	@Value("${image_server}")
	private String image_server;
	
	@Autowired
	private BoardMapper boardMapper;
	
	@Autowired
	private ArticleMapper articleMapper;
	
	/* Description:获取父分类
	 */
	@Override
	public List<Board> getBoardParent() {
		List<Board> list = boardMapper.getBoardParent();
		return list;
	}
	/* Description:根据一级分类id获取二级分类
	 */
	@Override
	public List<Board> getchildBoard(String pid) {
		List<Board> list = boardMapper.getchildBoard(pid);
		return list;
	}
	/* (非 Javadoc)
	 * Description:
	 * @see com.blog.service.BoardService#addBoard(com.blog.pojo.Board)
	 */
	@Override
	public BlogResult addBoard(Board board) {
		BlogResult result = new BlogResult();
		try {
			boardMapper.addBoard(board);
			result.setStatus(200);
		} catch (Exception e) {
			result.setStatus(500);
			result.setMsg("添加失败");
		}
		return result;
	}
	/* (非 Javadoc)
	 * Description:
	 * @see com.blog.service.BoardService#getBoardCount(long)
	 */
	@Override
	public Long getBoardCount(long parentId) {
		Long count = boardMapper.getBoardCount(parentId);
		return count;
	}
	/* (非 Javadoc)
	 * Description:
	 * @see com.blog.service.BoardService#getBoardById(java.lang.Long)
	 */
	@Override
	public Board getBoardById(Long id) {
		Board board = boardMapper.getBoardById(id);
		return board;
	}
	/* (非 Javadoc)
	 * Description:
	 * @see com.blog.service.BoardService#updateBoard(com.blog.pojo.Board)
	 */
	@Override
	public BlogResult updateBoard(Board board) {
		BlogResult result = new BlogResult();
		try {
			boardMapper.updateBoard(board);
			result.setStatus(200);
		} catch (Exception e) {
			result.setStatus(500);
			result.setMsg("编辑失败!");
		}
		
		return result;
	}
	/* (非 Javadoc)
	 * Description:
	 * @see com.blog.service.BoardService#deleteChildBoard(java.lang.Long)
	 */
	@Override
	public BlogResult deleteChildBoard(Long id,String imageUrl) {
		BlogResult result = new BlogResult();
		try {
			List<ArticleCustom> articleList = articleMapper.getArticleList(id);
			StringBuffer imageUrls = new StringBuffer();
			imageUrls.append(imageUrl);
			for (ArticleCustom articleCustom : articleList) {
				imageUrls.append(articleCustom.getImageUrl()+",");
			}
			List<Long> ids = new ArrayList<>();
			ids.add(id);
			boardMapper.deleteChildBoard(ids);
			PictureUtils.imageDelete(imageUrls.toString(), image_server);
			result.setStatus(200);
		} catch (Exception e) {
			result.setMsg("删除失败");
			result.setStatus(500);
		}
		return result;
	}
	/* (非 Javadoc)
	 * Description:
	 * @see com.blog.service.BoardService#deleteParentBoard(java.lang.Long)
	 */
	@Override
	public BlogResult deleteParentBoard(Long id) {
		BlogResult result = new BlogResult();
		try {
			List<Board> childBoard = boardMapper.getchildBoard(id.toString());
			if(childBoard != null && childBoard.size() > 0) {
				List<Long> ids = new ArrayList<>();
				for (Board board : childBoard) {
					ids.add(board.getId());
				}
				boardMapper.deleteChildBoard(ids);
			}
			boardMapper.deleteParentBoard(id);
			result.setStatus(200);
		} catch (Exception e) {
			result.setMsg("删除失败");
			result.setStatus(500);
		}
		return result;
	}
	/* (非 Javadoc)
	 * Description:
	 * @see com.blog.service.BoardService#getChildBoardsById(java.lang.Long)
	 */
	@Override
	public List<Board> getChildBoardsById(Long boardId) {
		List<Board> list = boardMapper.getChildBoardsById(boardId);
		return list;
	}
	/* (非 Javadoc)
	 * Description:
	 * @see com.blog.service.BoardService#getAllBoards()
	 */
	@Override
	public List<BoardResult> getAllBoards() {
		List<Board> boardParent = boardMapper.getBoardParent();
		List<BoardResult> result = new ArrayList<>();
		for (Board board : boardParent) {
			BoardResult boardResult = new BoardResult();
			boardResult.setParentName(board.getName());
			List<Board> childBoards = boardMapper.getchildBoard(board.getId().toString());
			List<BoardCustom> resultList = new ArrayList<>();
			for (Board board2 : childBoards) {
				Long count = boardMapper.getCountArticleByBoard(board2.getId());
				BoardCustom boardCustom = new BoardCustom();
				boardCustom.setCount(count);
				boardCustom.setAbs(board2.getAbs());
				boardCustom.setId(board2.getId());
				boardCustom.setImage(board2.getImage());
				boardCustom.setName(board2.getName());
				boardCustom.setParentId(board2.getParentId());
				resultList.add(boardCustom);
			}
			boardResult.setList(resultList);
			result.add(boardResult);
		}
		return result;
	}


}
