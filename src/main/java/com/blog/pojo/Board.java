package com.blog.pojo;

/**
 * @ClassName Board
 * @Description TODO(分类表对应的实体)
 * @author Administrator
 * @Date 2018年9月4日 下午2:45:02
 * @version 1.0.0
 */
public class Board {

	
	private Long id;
	private Long parentId;
	private String name;
	private String abs;
	private String image;
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
	 * @return the parentId
	 */
	public Long getParentId() {
		return parentId;
	}
	/**
	 * @param parentId the parentId to set
	 */
	public void setParentId(Long parentId) {
		this.parentId = parentId;
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
	/**
	 * @return the abs
	 */
	public String getAbs() {
		return abs;
	}
	/**
	 * @param abs the abs to set
	 */
	public void setAbs(String abs) {
		this.abs = abs;
	}
	/**
	 * @return the image
	 */
	public String getImage() {
		return image;
	}
	/**
	 * @param image the image to set
	 */
	public void setImage(String image) {
		this.image = image;
	}
}
