package com.blog.pojo;

import java.io.Serializable;

/**
 * @ClassName Board
 * @Description TODO(标签表对应的实体)
 * @author perfree
 * @Date 2018年9月4日 下午2:45:02
 * @version 1.0.0
 */
public class Tag implements Serializable{
	private Long id;
	private String name;
	/**
	 * @return the id
	 */
	public Long getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(Long id) {
		this.id = id;
	}
	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}
	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}
	
}
