package com.blog.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.blog.common.BlogResult;
import com.blog.common.BoardResult;
import com.blog.pojo.Board;
import com.blog.service.ArticleService;
import com.blog.service.BoardService;

/**
 * @ClassName BoardController
 * @Description TODO(分类controller)
 * @author Perfree
 * @Date 2018年9月7日 下午6:07:22
 * @version 1.0.0
 */
@Controller
public class BoardController {

	@Autowired
	private BoardService boardService;
	
	@Autowired
	private ArticleService articleService;
	
	/**
	 * 
	 * @Description (加载一级分类)
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/board-list")
	public String getBoardParent(Model model) {
		List<Board> boardParent = boardService.getBoardParent();
		Long count = boardService.getBoardCount(0L);
		model.addAttribute("parent", boardParent);
		model.addAttribute("count", count);
		return "admin/board-list";
	}
	
	/**
	 * 
	 * @Description (添加分类)
	 * @param board
	 * @return
	 */
	@RequestMapping("/board/add")
	@ResponseBody
	public BlogResult addBoard(Board board) {
		BlogResult result = boardService.addBoard(board);
		return result;
	}
	
	/**
	 * 
	 * @Description (前往一级分类编辑页面)
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/toBoard_parentEdit/{id}")
	public String toEditParentBoard(@PathVariable Long id,Model model) {
		Board board = boardService.getBoardById(id);
		model.addAttribute("board", board);
		return "admin/board-parentAdd";
	}
	
	/**
	 * 
	 * @Description (更新分类)
	 * @param board
	 * @return
	 */
	@RequestMapping("/board/edit")
	@ResponseBody
	public BlogResult updateBoard(Board board) {
		BlogResult result = boardService.updateBoard(board);
		return result;
	}
	
	/**
	 * 
	 * @Description (根据父id查看子分类列表)
	 * @param parentId
	 * @param model
	 * @return
	 */
	@RequestMapping("/toBoard_childList/{parentId}")
	public String getChildBoard(@PathVariable String parentId,Model model) {
		List<Board> list = boardService.getchildBoard(parentId);
		Long count = boardService.getBoardCount(Long.parseLong(parentId));
		model.addAttribute("childBoards", list);
		model.addAttribute("count", count);
		model.addAttribute("parentId", parentId);
		return "admin/board-childList";
	}
	
	/**
	 * 
	 * @Description (前往子分类编辑页面)
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/toBoard_childEdit/{id}")
	public String toEditChildBoard(@PathVariable Long id,Model model) {
		Board board = boardService.getBoardById(id);
		model.addAttribute("board", board);
		return "admin/board-childAdd";
	}
	
	/**
	 * 
	 * @Description (删除子分类,懒得递归了,直接sql语句实现,练习sql吧)
	 * @return
	 */
	@RequestMapping("/childBoard/del")
	@ResponseBody
	public BlogResult childBoarddel(Long id,String imageUrl) {
		BlogResult result = boardService.deleteChildBoard(id,imageUrl);
		return result;
	}
	
	/**
	 * 
	 * @Description (删除一级分类)
	 * @return
	 */
	@RequestMapping("/parentBoard/del")
	@ResponseBody
	public BlogResult parentBoarddel(Long id) {
		BlogResult result = boardService.deleteParentBoard(id);
		return result;
	}
	
	/**
	 * 
	 * @Description (获取所有分类)
	 * @return
	 */
	@RequestMapping("/protal/getAllBoards")
	@ResponseBody
	public List<BoardResult> getAllBoards(){
		List<BoardResult> list = boardService.getAllBoards();
		return list;
	}
	
	/**
	 * 
	 * @Description (前往分类下的文章列表页面)
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/protal/toBoard/{id}")
	public String toBoard(@PathVariable Long id ,Model model) {
		Board board = boardService.getBoardById(id);
		BlogResult stickArticles = articleService.getStickArticles();
		model.addAttribute("stickArtices", stickArticles.getData());
		model.addAttribute("webTitle", board.getName());
		model.addAttribute("webUrl", "/toBoard/"+board.getId()+".html");
		model.addAttribute("board", board);
		model.addAttribute("attr", 0);
		return "articles";
	}
}
