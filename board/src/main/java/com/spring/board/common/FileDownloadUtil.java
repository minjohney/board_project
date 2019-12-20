package com.spring.board.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;
 
public class FileDownloadUtil extends AbstractView {
 
    public FileDownloadUtil() {
        setContentType("application/download; charset=utf-8");
    }
 
    @Override
    protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
         
        @SuppressWarnings("unchecked")
		Map<String, Object> fileInfo = (Map<String, Object>) model.get("fileInfo"); //파일 정보를 전송받음
        
        String fileNameKey 	= (String) fileInfo.get("fileNameKey");	//파일명_암호화
        String fileName 	= (String) fileInfo.get("fileName");	//원본 파일명
        String filePath 	= (String) fileInfo.get("filePath");	//파일 경로_input box에 담깁니다
         
        File file = new File(filePath, fileNameKey);
         
        response.setContentType(getContentType());
        response.setContentLength((int) file.length());

    /*운영체제 정보를 확인하여 인코딩합니다*/
        String userAgent = request.getHeader("User-Agent");
        

        if (userAgent.indexOf("MSIE") > -1) {
        	
        	fileName = URLEncoder.encode(fileName, "UTF-8");
        }
		 
        // IE 11
        if (userAgent.indexOf("Trident") > -1) {
        	fileName = URLEncoder.encode(fileName, "UTF-8");
		}
		
        else {
        	fileName = new String( fileName.getBytes("UTF-8"), "8859_1");
		}
 
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
        response.setHeader("Content-Transfer-Encoding", "binary");
        
        OutputStream out = response.getOutputStream();
 
        FileInputStream fis = null;
        
        /*파일이 없는 경우에는 파일을 업로드 하고, 있는 경우에는 종료합니다*/
 
        try {
        	
            fis = new FileInputStream(file);
            FileCopyUtils.copy(fis, out);
            
        } finally {
        	
            if(fis != null) {
            	fis.close();
            }
        }
        
        out.flush();
    }
}