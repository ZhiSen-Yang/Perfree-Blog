package com.blog.pojo;

import java.io.Serializable;
import java.util.Date;

/**
 * @ClassName Article
 * @Description TODO(文章表实体类)
 * @author Perfree
 * @Date 2018年9月6日 下午9:57:44
 * @version 1.0.0
 */
public class Article implements Serializable{

	private String id;
	private String title;
	private String imageUrl;
	private String context;
	private Date createTime;
	private Date updateTime;
	private Long boardId;
	private Long pageView;
	private Long revertNum;
	private Integer stick;
	
	/**
	 * @return the revertNum
	 */
	public Long getRevertNum() {
		return revertNum;
	}
	/**
	 * @param revertNum the revertNum to set
	 */
	public void setRevertNum(Long revertNum) {
		this.revertNum = revertNum;
	}
	/**
	 * @return the id
	 */
	public String getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(String id) {
		this.id = id;
	}
	/**
	 * @return the title
	 */
	public String getTitle() {
		return title;
	}
	/**
	 * @param title the title to set
	 */
	public void setTitle(String title) {
		this.title = title;
	}
	/**
	 * @return the imageUrl
	 */
	public String getImageUrl() {
		return imageUrl;
	}
	/**
	 * @param imageUrl the imageUrl to set
	 */
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	/**
	 * @return the context
	 */
	public String getContext() {
		return context;
	}
	/**
	 * @param context the context to set
	 */
	public void setContext(String context) {
		this.context = context;
	}
	/**
	 * @return the createTime
	 */
	public Date getCreateTime() {
		return createTime;
	}
	/**
	 * @param createTime the createTime to set
	 */
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	/**
	 * @return the updateTime
	 */
	public Date getUpdateTime() {
		return updateTime;
	}
	/**
	 * @param updateTime the updateTime to set
	 */
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	/**
	 * @return the boardId
	 */
	public Long getBoardId() {
		return boardId;
	}
	/**
	 * @param boardId the boardId to set
	 */
	public void setBoardId(Long boardId) {
		this.boardId = boardId;
	}
	/**
	 * @return the pageView
	 */
	public Long getPageView() {
		return pageView;
	}
	/**
	 * @param pageView the pageView to set
	 */
	public void setPageView(Long pageView) {
		this.pageView = pageView;
	}
	/**
	 * @return the stick
	 */
	public Integer getStick() {
		return stick;
	}
	/**
	 * @param stick the stick to set
	 */
	public void setStick(Integer stick) {
		this.stick = stick;
	}
	
}
