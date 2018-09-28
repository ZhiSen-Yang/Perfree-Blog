package com.blog.pojo;

/**
 * @ClassName UserCustom
 * @Description TODO(将注册日期格式化为string类型后封装为此类)
 * @author Administrator
 * @Date 2018年9月10日 下午4:55:22
 * @version 1.0.0
 */
public class UserCustom extends User {

	private String createTime;

	/**
	 * @return the createTime
	 */
	public String getCreateTime() {
		return createTime;
	}

	/**
	 * @param createTime the createTime to set
	 */
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
}
