package com.blog.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.blog.common.FastDFSClient;
import com.blog.common.JsonUtils;
import com.blog.common.PictureUtils;
import com.blog.common.UploadResult;

/**
 * @ClassName ImageUploadController
 * @Description TODO(图片上传controller)
 * @author Perfree
 * @Date 2018年9月6日 下午1:24:46
 * @version 1.0.0
 */
@Controller
public class ImageUploadController {

	@Value("${image_server}")
	private String image_server;
	
	/**
	 * 
	 * @Description (上传图片)
	 * @param file
	 * @return
	 */
	@RequestMapping(value="/imageUpload",produces=org.springframework.http.MediaType.TEXT_PLAIN_VALUE+";charset=utf-8")
	@ResponseBody
	public String imageUpload(@RequestParam(value = "editormd-image-file", required = false)MultipartFile file) {
		UploadResult result = PictureUtils.uploadImages(file);
		result.setUrl(image_server+result.getUrl());
		String toJson = JsonUtils.objectToJson(result);
		System.out.println("图片存储路径"+result.getUrl());
		return toJson;
	}
	
	/**
	 * 
	 * @Description (删除图片)
	 * @param oldUrl
	 * @return
	 */
	@RequestMapping("/imageUpload/delete")
	@ResponseBody
	public String imageDelete(String oldUrl) {
		PictureUtils.imageDelete(oldUrl, image_server);
		return null;
	}
}
