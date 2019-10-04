package Damoa_pro;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class review_boardUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		MultipartRequest multi = null;
		int fileMaxSize = 10*1024*1024;
		String savePath = request.getRealPath("/upload").replaceAll("\\\\","/");
		try {
			multi = new MultipartRequest(request, savePath, fileMaxSize, "UTF-8", new DefaultFileRenamePolicy());
		}catch(Exception e) {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "파일 크기는 10MB를 넘을 수 없습니다.");
			response.sendRedirect("./DamoaTaxi/review_boardUpdate.jsp");
			return;
		}
		String userID = multi.getParameter("userID");
		String boardID = multi.getParameter("boardID");
		if(boardID == null || boardID.equals("")) {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "접근할 수 없습니다.");
			response.sendRedirect("./DamoaTaxi/review_boardUpdate.jsp");
			return;
		}
		review_BoardDAO review_boardDAO = new review_BoardDAO();
		review_BoardDTO board = review_boardDAO.getBoard(boardID);
		if(!userID.equals(board.getUserID())) {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "접근할 수 없습니다.");
			response.sendRedirect("./DamoaTaxi/review_boardUpdate.jsp");
			return;
		}
		String boardTitle = multi.getParameter("boardTitle");
		String boardContent = multi.getParameter("boardContent");
		if(boardTitle == null || boardTitle.equals("") || boardContent == null || boardContent.equals("")) {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "내용을 모두 채워주세요.");
			response.sendRedirect("./DamoaTaxi/review_boardUpdate.jsp");
			return;
		}
		String boardFile="";
		String boardRealFile = "";
		File file = multi.getFile("file");
		if(file != null) {
			boardFile = multi.getOriginalFileName("file");
			boardRealFile = file.getName();
			String prev = review_boardDAO.getRealFile(boardID);
			File prevFile = new File(savePath + "/" + prev);
			if(prevFile.exists()) {
				prevFile.delete();
			}
		} else {
			boardFile = review_boardDAO.getFile(boardID);
			boardRealFile = review_boardDAO.getRealFile(boardID);
		}
		
		review_boardDAO.update(boardID, boardTitle, boardContent, boardFile, boardRealFile);
		request.getSession().setAttribute("messageType", "성공 메세지");
		request.getSession().setAttribute("messageContent", "성공적으로 게시물이 수정되었습니다.");
		response.sendRedirect("./DamoaTaxi/review_boardView.jsp");
		return;
	}

}
