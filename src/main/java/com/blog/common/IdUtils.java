package com.blog.common;


import java.util.Random;

/**
 * 
 * @ClassName IdUtils
 * @Description TODO(id生成工具)
 * @author Perfree
 * @Date 2018年8月22日 上午10:55:15
 * @version 1.0.0
 */
public class IdUtils {
	public static Long genId(){
		long ct = System.currentTimeMillis();
		String currentTime = ct +"";
		Random r =  new Random();
		int num = r.nextInt(99);
		String tmp = String.format("%02d",num);
		tmp = currentTime + tmp;
		return Long.parseLong(tmp);
	}
	
	public static void main(String[] args) {
		for (int i = 0; i < 15; i++) {
			System.out.println(genId());
			
		}
		
	}
}
