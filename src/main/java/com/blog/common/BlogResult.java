package com.blog.common;

import java.io.Serializable;
import java.util.List;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * @ClassName BlogResult
 * @Description TODO(自定义返回结果集)
 * @author Perfree
 * @Date 2018年8月22日 下午5:07:08
 * @version 1.0.0
 */
public class BlogResult implements Serializable {
	// 响应的状态，200成功
	private Integer status;
	// 响应的消息
	private String msg;
	// 响应的结果数据
	private Object data;

	// 定义jackson对象
	private static final ObjectMapper MAPPER = new ObjectMapper();

	public BlogResult() {
	}

	public BlogResult(int status) {
		this.status = status;
	}

	public BlogResult(int status, String msg) {
		this.status = status;
		this.msg = msg;
	}

	public BlogResult(int status, String msg, Object data) {
		this.status = status;
		this.msg = msg;
		this.data = data;
	}

	public static BlogResult ok() {
		return new BlogResult(200);
	}

	public static BlogResult ok(int status, Object data) {
		return new BlogResult(status, "", data);
	}

	public static BlogResult ok(int status, String msg, Object data) {
		return new BlogResult(status, msg, data);
	}

	public static BlogResult build(int status, String msg) {
		return new BlogResult(status, msg);
	}

	public static BlogResult build(int status, String msg, Object data) {
		return new BlogResult(status, msg, data);
	}

	/**
	 * 将json结果集转化为HGResult对象
	 * 
	 * @param jsonData
	 *            json数据
	 * @param clazz
	 *            XiafeiResult中的object类型
	 * @return
	 */
	public static BlogResult formatToPojo(String jsonData, Class<?> clazz) {
		try {
			if (clazz == null) {
				return MAPPER.readValue(jsonData, BlogResult.class);
			}
			JsonNode jsonNode = MAPPER.readTree(jsonData);
			JsonNode data = jsonNode.get("data");
			Object obj = null;
			if (clazz != null) {
				if (data.isObject()) {
					obj = MAPPER.readValue(data.traverse(), clazz);
				} else if (data.isTextual()) {
					obj = MAPPER.readValue(data.asText(), clazz);
				}
			}
			return build(jsonNode.get("status").intValue(), jsonNode.get("msg").asText(), obj);
		} catch (Exception e) {
			return null;
		}
	}

	/**
	 * 没有object对象的转化
	 * 
	 * @param json
	 * @return
	 */
	public static BlogResult format(String json) {
		try {
			return MAPPER.readValue(json, BlogResult.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * Object是集合转化
	 * 
	 * @param jsonData
	 *            json数据
	 * @param clazz
	 *            集合中的类型
	 * @return
	 */
	public static BlogResult formatToList(String jsonData, Class<?> clazz) {
		try {
			JsonNode jsonNode = MAPPER.readTree(jsonData);
			JsonNode data = jsonNode.get("data");
			Object obj = null;
			if (data.isArray() && data.size() > 0) {
				obj = MAPPER.readValue(data.traverse(),
						MAPPER.getTypeFactory().constructCollectionType(List.class, clazz));
			}
			return ok(jsonNode.get("status").intValue(), jsonNode.get("msg").asText(), obj);
		} catch (Exception e) {
			return null;
		}
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	/**
	 * @return the msg
	 */
	public String getMsg() {
		return msg;
	}

	/**
	 * @param msg
	 *            the msg to set
	 */
	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}
}
