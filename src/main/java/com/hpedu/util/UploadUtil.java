package com.hpedu.util;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.web.multipart.MultipartFile;

public class UploadUtil {
	
	public static String uploadThreeToOne(MultipartFile file,HttpServletRequest req)throws Exception{
		String fileName = "";
		// 服务器存储目录 E:\apache-tomcat-7.0.68\webapps\zhaopin\
		String realPath = req.getSession().getServletContext().getRealPath("/");
		//路径为 path:zhaopin
		String path = req.getContextPath().substring(1);
		//路径为E:\apache-tomcat-7.0.68\webapps\ companyThreeToOne\
		realPath = realPath.replace(path, "companyThreeToOne");
		if (file != null) {
			fileName = UUIDUtil.getUUID() + file.getOriginalFilename();
			FileUtils.copyInputStreamToFile(file.getInputStream(), new File(
					realPath, fileName));
			return "\\companyThreeToOne\\"+fileName;
		}
		return null;
	}
	public static String uploadLogo(MultipartFile file,HttpServletRequest req)throws Exception{
		String fileName = "";
		// 服务器存储目录 E:\apache-tomcat-7.0.68\webapps\zhaopin\
		String realPath = req.getSession().getServletContext().getRealPath("/");
		//路径为 path:zhaopin
		String path = req.getContextPath().substring(1);
		//路径为E:\apache-tomcat-7.0.68\webapps\ projectImgs\
		realPath = realPath.replace(path, "companyLogos");
		if (file != null) {
			fileName = UUIDUtil.getUUID() + file.getOriginalFilename();
			FileUtils.copyInputStreamToFile(file.getInputStream(), new File(
					realPath, fileName));
			return "\\companyLogos\\"+fileName;
		}
		return null;
	}
	public static String uploadVideo(MultipartFile file,HttpServletRequest req)throws Exception{
		String fileName = "";
		// 服务器存储目录 E:\apache-tomcat-7.0.68\webapps\zhaopin\
		String realPath = req.getSession().getServletContext().getRealPath("/");
		//路径为 path:zhaopin
		String path = req.getContextPath().substring(1);
		//路径为E:\apache-tomcat-7.0.68\webapps\ projectImgs\
		realPath = realPath.replace(path, "companyVideo");
		if (file != null) {
			fileName = UUIDUtil.getUUID() + file.getOriginalFilename();
			FileUtils.copyInputStreamToFile(file.getInputStream(), new File(
					realPath, fileName));
			return "\\companyVideo\\"+fileName;
		}
		return null;
	}

}
