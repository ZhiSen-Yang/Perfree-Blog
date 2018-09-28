package com.blog.common;

import java.io.Serializable;
import java.util.List;

import com.blog.pojo.BoardCustom;

/**
 * @ClassName BoardResult
 * @Description TODO(分类结果集)
 * @author Perfree
 * @Date 2018年9月16日 下午5:45:00
 * @version 1.0.0
 */
public class BoardResult implements Serializable{
	private String parentName;
	private List<BoardCustom> list;
	/**
	 * @return the parentName
	 */
	public String getParentName() {
		return parentName;
	}
	/**
	 * @param parentName the parentName to set
	 */
	public void setParentName(String parentName) {
		this.parentName = parentName;
	}
	/**
	 * @return the list
	 */
	public List<BoardCustom> getList() {
		return list;
	}
	/**
	 * @param list the list to set
	 */
	public void setList(List<BoardCustom> list) {
		this.list = list;
	}
	
}
