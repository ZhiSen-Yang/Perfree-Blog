package com.blog.common;

import java.io.Serializable;

/**
 * @ClassName UploadResult
 * @Description TODO(编辑器上传图片结果类)
 * @author Perfree
 * @Date 2018年9月6日 下午1:20:36
 * @version 1.0.0
 */
public class UploadResult implements Serializable{

	private Integer success;
	private String message;
	private String url;
	/**
	 * @return the success
	 */
	public Integer getSuccess() {
		return success;
	}
	/**
	 * @param success the success to set
	 */
	public void setSuccess(Integer success) {
		this.success = success;
	}
	/**
	 * @return the message
	 */
	public String getMessage() {
		return message;
	}
	/**
	 * @param message the message to set
	 */
	public void setMessage(String message) {
		this.message = message;
	}
	/**
	 * @return the url
	 */
	public String getUrl() {
		return url;
	}
	/**
	 * @param url the url to set
	 */
	public void setUrl(String url) {
		this.url = url;
	}
	
}
