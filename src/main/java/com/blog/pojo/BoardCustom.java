package com.blog.pojo;

import java.io.Serializable;

/**
 * @ClassName BoardCustom
 * @Description TODO(分类自定义实体类)
 * @author Perfree
 * @Date 2018年9月16日 下午6:08:39
 * @version 1.0.0
 */
public class BoardCustom extends Board implements Serializable{
	private Long count;

	/**
	 * @return the count
	 */
	public Long getCount() {
		return count;
	}

	/**
	 * @param count the count to set
	 */
	public void setCount(Long count) {
		this.count = count;
	}
	
}
