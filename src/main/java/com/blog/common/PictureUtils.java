package com.blog.common;


import org.springframework.web.multipart.MultipartFile;

/**
 * 
 * @ClassName PictureUtils
 * @Description TODO(图片上传工具类  上传图片并返回状态以及路径)
 * @author perfree
 * @Date 2018年9月5日 下午7:46:20
 * @version 1.0.0
 */
public class PictureUtils {
	public static UploadResult uploadImages(MultipartFile file) {
		UploadResult picture = new UploadResult();
		if(file != null) {
			String filename=file.getOriginalFilename();
			//System.out.println("filename:"+filename);
			//判断文件名是否为空
			if(filename.trim().length()>0) {
				//获取后缀名称，通过分隔符点
				String substring = filename.substring(filename.lastIndexOf(".")+1);
			//	System.out.println("后缀名是："+substring);
				try {
					FastDFSClient dfClient=new FastDFSClient("classpath:client.conf");
					//返回上传路径,把图片序列化到字节
					String uploadFile = dfClient.uploadFile(file.getBytes(),substring);

				//	System.out.println("图片上传全路径"+uploadFile);

					System.out.println("图片上传全路径"+uploadFile);
			System.out.println("filename:"+filename);
			//判断文件名是否为空
					picture.setUrl(uploadFile);
					picture.setSuccess(1);
					picture.setMessage("图片上传成功");
				} catch (Exception e) {
					picture.setSuccess(0);;
					picture.setMessage("图片上传失败");
				}
			}
			
		}else {
			picture.setSuccess(0);
			picture.setMessage("图片为空");
		}
		return picture;		
	}

	public static int imageDelete(String oldUrl,String image_server) {
		Integer delete_file = null;
		try {
			FastDFSClient client = new FastDFSClient("classpath:client.conf");
			String[] split = oldUrl.split(",");
			for (String string : split) {
				String replace = string.replace(image_server,"");
				delete_file = client.delete_file(replace);
				System.out.println(delete_file);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return delete_file;
	}
}
