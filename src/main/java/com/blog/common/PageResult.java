package com.blog.common;
import java.io.Serializable;
import java.util.List;

	/**
	 * @ClassName PageResult
	 * @Description TODO(分页展示工具类)
	 * @author Perfree
	 * @Date 2018年8月22日 下午1:38:16
	 * @version 1.0.0
	 * @param <T>
	 */
	public class PageResult<T> implements Serializable{
		
		//当前页
		private Integer pageNum;
		//总页数
		private Integer totalPage;
		//每页显示的数量
		private Integer pageSize = 10;
		//总条数
		private Long total;
		//结果集
		private List<T> list;
		public Integer getPageNum() {
			return pageNum;
		}
		public void setPageNum(Integer pageNum) {
			this.pageNum = pageNum;
		}
		public Integer getTotalPage() {
			return totalPage;
		}
		public void setTotalPage(Integer totalPage) {
			this.totalPage = totalPage;
		}
		public Integer getPageSize() {
			return pageSize = 10;
		}
		public void setPageSize(Integer pageSize) {
			this.pageSize = pageSize;
		}
		public Long getTotal() {
			return total;
		}
		public void setTotal(Long total) {
			this.total = total;
		}
		public List<T> getList() {
			return list;
		}
		public void setList(List<T> list) {
			this.list = list;
		}
		

}
