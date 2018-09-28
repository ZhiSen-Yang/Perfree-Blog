package com.blog.pojo;

import java.io.Serializable;

/**
 * @ClassName ArticleCustom
 * @Description TODO(文章自定义实体类)
 * @author Perfree
 * @Date 2018年9月10日 上午11:59:20
 * @version 1.0.0
 */
public class ArticleCustom extends Article implements Serializable{
	private String boardName;
	/**
	 * @return the boardName
	 */
	public String getBoardName() {
		return boardName;
	}
	/**
	 * @param boardName the boardName to set
	 */
	public void setBoardName(String boardName) {
		this.boardName = boardName;
	}
}
