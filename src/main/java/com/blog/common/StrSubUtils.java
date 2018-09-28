package com.blog.common;

/**
 * @ClassName StrSubUtils
 * @Description TODO(文章截取工具类)
 * @author Perfree
 * @Date 2018年9月16日 上午10:25:07
 * @version 1.0.0
 */
public class StrSubUtils {

	public static String subArticle(String context,int endIndex) {
		String substring = context;
		if(context.length() > endIndex) {
			substring = context.substring(0, endIndex);
		}
		String replace = substring.replace("#", "");
		String replace2 = replace.replace(" ", "");
		String replace3 = replace2.replace("```bash", "");
		String replace4 = replace3.replace("```", "");
		StringBuffer newContext = new StringBuffer();
		newContext.append(replace4).append("......");
		return newContext.toString();
	}
}
