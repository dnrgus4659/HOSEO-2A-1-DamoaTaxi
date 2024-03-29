<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="Damoa_pro.review_BoardDAO" %>  
<%@ page import="java.io.*"%>
<%@ page import="java.text.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
 
 
<%
    request.setCharacterEncoding("UTF-8");
	String boardID = request.getParameter("boardID");
	if(boardID == null || boardID.equals("")){
		request.getSession().setAttribute("messageType", "오류 메세지");
		request.getSession().setAttribute("messageContent", "접근할 수 없습니다. 존재하지 않는 글입니다.");
		response.sendRedirect("./review_boardView.jsp");
		return;
	}
 
    // 파일 업로드된 경로
    String root = request.getSession().getServletContext().getRealPath("/");
    String savePath = root + "upload";
 	
    review_BoardDAO boardDAO = new review_BoardDAO();
    String filename = "";
	String orgfilename = "";
	filename = boardDAO.getFile(boardID);
	orgfilename = boardDAO.getRealFile(boardID);      
	if(filename.equals("") || orgfilename.equals("")){
		request.getSession().setAttribute("messageType", "오류 메세지");
		request.getSession().setAttribute("messageContent", "접근할 수 없습니다. 존재하지 않는 파일입니다.");
		response.sendRedirect("./review_boardView.jsp");
		return;
	}
    InputStream in = null;
    OutputStream os = null;
    File file = null;
    boolean skip = false;
    String client = "";
    
    try{
        // 파일을 읽어 스트림에 담기
        try{
            file = new File(savePath, filename);
            in = new FileInputStream(file);
        }catch(FileNotFoundException fe){
            skip = true;
        }

        client = request.getHeader("User-Agent");
 
        // 파일 다운로드 헤더 지정
        response.reset() ;
        response.setContentType("application/octet-stream");
        response.setHeader("Content-Description", "JSP Generated Data");
 
        if(!skip){
             
            // IE
            if(client.indexOf("MSIE") != -1){
                response.setHeader ("Content-Disposition", "attachment; filename="+new String(orgfilename.getBytes("KSC5601"),"ISO8859_1"));
 
            }else{
                // 한글 파일명 처리
                orgfilename = new String(orgfilename.getBytes("utf-8"),"iso-8859-1");
 
                response.setHeader("Content-Disposition", "attachment; filename=\"" + orgfilename + "\"");
                response.setHeader("Content-Type", "application/octet-stream; charset=utf-8");
            } 
             
            response.setHeader ("Content-Length", ""+file.length() );
 
 
       
            os = response.getOutputStream();
            byte b[] = new byte[(int)file.length()];
            int leng = 0;
             
            while( (leng = in.read(b)) > 0 ){
                os.write(b,0,leng);
            }
 
        }else{
            response.setContentType("text/html;charset=UTF-8");
            out.println("<script language='javascript'>alert('파일을 찾을 수 없습니다');history.back();</script>");
        }
         
        in.close();
        os.close();
 
    }catch(Exception e){
      e.printStackTrace();
    }
%>