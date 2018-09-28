package com.blog.service;

import java.util.List;

import com.blog.common.BlogResult;
import com.blog.common.BoardResult;
import com.blog.pojo.Board;

/**
 * @ClassName BoardService
 * @Description TODO(分类service接口)
 * @author Perfree
 * @Date 2018年9月7日 上午10:57:29
 * @version 1.0.0
 */
public interface BoardService {
	/**
	 * 
	 * @Description (获取父分类)
	 * @return
	 */
	public List<Board> getBoardParent();
	
	/**
	 * 
	 * @Description (根据一级分类id获取二级分类)
	 * @param pid
	 * @return
	 */
	public List<Board> getchildBoard(String pid);

	/**
	 * @Description (添加分类)
	 * @param board
	 * @return
	 */
	public BlogResult addBoard(Board board);

	/**
	 * @Description (根据父id计算子分类数量)
	 * @param parentId
	 * @return
	 */
	public Long getBoardCount(long parentId);

	/**
	 * @Description (根据id获取分类信息)
	 * @param id
	 * @return
	 */
	public Board getBoardById(Long id);

	/**
	 * @Description (更新分类)
	 * @param board
	 * @return
	 */
	public BlogResult updateBoard(Board board);

	/**
	 * @Description (删除子分类)
	 * @param id
	 * @return
	 */
	public BlogResult deleteChildBoard(Long id,String imageUrl);

	/**
	 * @Description (删除一级分类)
	 * @param id
	 * @return
	 */
	public BlogResult deleteParentBoard(Long id);

	/**
	 * @Description (根据子分类id获取该子分类所属父分类下所有分类)
	 * @param boardId
	 * @return
	 */
	public List<Board> getChildBoardsById(Long boardId);

	/**
	 * @Description (获取所有分类)
	 * @return
	 */
	public List<BoardResult> getAllBoards();

}
