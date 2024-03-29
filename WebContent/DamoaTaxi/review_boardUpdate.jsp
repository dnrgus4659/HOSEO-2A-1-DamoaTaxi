<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Damoa_pro.review_BoardDAO" %>
<%@ page import="Damoa_pro.review_BoardDTO" %>
<!DOCTYPE html>
<html>
  <head>
    <title>DamoaTaxi</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link href="https://fonts.googleapis.com/css?family=Rubik:300,400,500" rel="stylesheet">
    <link rel="stylesheet" href="css/open-iconic-bootstrap.min.css">
    <link rel="stylesheet" href="css/animate.css">

    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="css/owl.theme.default.min.css">
    <link rel="stylesheet" href="css/magnific-popup.css">

    <link rel="stylesheet" href="css/aos.css">

    <link rel="stylesheet" href="css/ionicons.min.css">

    <link rel="stylesheet" href="css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="css/jquery.timepicker.css">


    <link rel="stylesheet" href="css/flaticon.css">
    <link rel="stylesheet" href="css/icomoon.css">
    <link rel="stylesheet" href="css/style.css?ver=4">
  </head>
  <body>
<jsp:include page="nav.jsp" flush="false"></jsp:include>
    
	<% 		
		String id=(String)session.getAttribute("id");
		if(id==null || id.equals("")){
	%>
			<script>
				alert("로그인 후 이용하실 수 있습니다.");
				location.href('dmlogin_form.jsp');
				document.getElementById("logout").style.display='none';
			</script>
	<%		
		}else{
	%>
			<script>
				document.getElementById("login").style.display='none';
			</script>
	<%
		}
	%>
	<!-- END nav -->
	
	
	<%
		String boardID = request.getParameter("boardID");
		if(boardID == null || boardID.equals("")){
			session.setAttribute("messageType","오류 메세지");
			session.setAttribute("messageContent","접근할 수 없습니다.");
			response.sendRedirect("review_boardView.jsp");
			return;
		}
		review_BoardDAO boardDAO = new review_BoardDAO();
		review_BoardDTO board = boardDAO.getBoard(boardID);
		if(!id.equals(board.getUserID())){
			session.setAttribute("messageType","오류 메세지");
			session.setAttribute("messageContent","접근할 수 없습니다.");
			response.sendRedirect("review_boardView.jsp");
			return;
		}
	%>
	<section class="ftco-cover overlay custom_height" style="background-image: url(images/review_boardMain.jpg);" id="section-home" data-aos="fade"  data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row align-items-center justify-content-center ftco-vh-75">
          <div class="col-md-9 text-center">
            <h1 class="ftco-heading mb-4" data-aos="fade-up" data-aos-delay="500">후기 게시판</h1>
            <h2 class="h5 ftco-subheading mb-5" data-aos="fade-up"  data-aos-delay="600">후기 작성</h2>
          </div>
        </div>
      </div>
    </section>
    <div class="ftco-section">
    	<div class="container">
    		<div class="row">
    			<form action="../review_boardUpdate" method="post" enctype="multipart/form-data" style="width:100%;">
    				<table class="table table-bordered table-hover" style="text-align:center; border:1px solid #dddddd">
    					<thead>
			  			<tr>
			  				<th colspan="3"><h4>게시물 수정 양식</h4></th>
			  			</tr>
			  		</thead>
			  		<tbody>
			  			<tr>
			  				<td style="width:150px;"><h5>아이디</h5></td>
			  				<td><%= id %>
			  				<input type="hidden" name="userID" value="<%= id %>"></td>
			  				<input type="hidden" name="boardID" value="<%= boardID %>"></td>
			  			</tr>
			  			<tr>
			  				<td style="width:150px;"><h5>글 제목</h5></td>
			  				<td><input type="text" class="form-control" maxlength="50" id="boardTitle" name="boardTitle" placeholder="글 제목을 입력하세요." value="<%= board.getBoardTitle() %>"></td>
			  			</tr>
			  			<tr>
			  				<td style="width:150px;"><h5>글 내용</h5></td>
			  				<td>
			  					<textarea class="form-control" rows="10" id="boardContent" name="boardContent" maxlength="2048" placeholder="글 내용을 입력하세요"><%= board.getBoardContent() %></textarea>
							</td>
			  			</tr>
			  			<tr>
			  				<td style="width:150px;" align="center"><h5>후기 사진</h5><h5>업로드</h5></td>
			  				<td colspan="2">					  
						        <div class="input-group js-input-file" style="display: flex;">
                                    <input class="input-file" type="file" name="file" id="file">
                                    <label class="label--file" for="file">파일 선택</label>
                                    <span class="input-file__info"><%= board.getBoardFile()%></span>
                                </div>
                                <div class="label--desc">최대 용량 10 MB</div>
			  				</td>
			  			</tr>
			  			<tr>
			  				<td colspan="3" align="right"><h5 style="color:red;"></h5><input class="btn btn-primary" type="submit" value="수정"></td>
			  			</tr>
			  		</tbody>
    				</table>
    			</form>
    		</div>
    	</div>
    </div>
	<%
		String messageContent=null;
		if(session.getAttribute("messageContent") != null){
			messageContent = (String) session.getAttribute("messageContent");
		}
		String messageType = null;
		if(session.getAttribute("messageType") != null){
			messageType = (String) session.getAttribute("messageType");
		}
		if(messageContent != null){
	%>
	<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-hidden="ture">
		<div class="vertical-alignment-helper">
			<div class="modal-dialog vertical-align-center">
				<div class="modal-content <% if(messageType.equals("오류 메세지")) out.println("panel-warning"); else out.println("panel-success");%>">
					<div class="modal-header panel-heading">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="ture">&</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">
							<%= messageType %>
						</h4>
					</div>
					<div class="modal-body">
						<%=messageContent %>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$('#messageModal').modal('show');
	</script>
	<%
		session.removeAttribute("messageContent");
		session.removeAttribute("messageType");
		}
	%>
	
   <footer class="ftco-footer ftco-bg-dark ftco-section"> 
    <div class="container">  
     <div class="asd">이용약관 &nbsp &nbsp 개인정보 처리방침 
     </div> 
     <div>다모아 택시 | 대표:권욱현<br></div> 
     <div>서울특별시 강서구 발산점<br></div> 
     <div>고객문의:DamoaTaxi1234@naver.com<br></div> 
     <div>연락문의:010-0000-0000 | 02-000-0000<br></div> 
         </div>                
   </footer> 

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>
  <script src="js/jquery.min.js"></script>
  <script src="js/jquery-migrate-3.0.1.min.js"></script>
  <script src="js/popper.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/jquery.easing.1.3.js"></script>
  <script src="js/jquery.waypoints.min.js"></script>
  <script src="js/jquery.stellar.min.js"></script>
  <script src="js/owl.carousel.min.js"></script>
  <script src="js/jquery.magnific-popup.min.js"></script>
  <script src="js/aos.js"></script>
  <script src="js/jquery.animateNumber.min.js"></script>
  <script src="js/main.js"></script>
  <script type="text/javascript">
  (function ($) {
	    'use strict';	    
	    try {
	        var file_input_container = $('.js-input-file');
	        if (file_input_container[0]) {
	            file_input_container.each(function () {
	                var that = $(this);
	                var fileInput = that.find(".input-file");
	                var info = that.find(".input-file__info");
	                fileInput.on("change", function () {
	                    var fileName;
	                    fileName = $(this).val();
	                    if (fileName.substring(3,11) == 'fakepath') {
	                        fileName = fileName.substring(12);
	                    }
	                    if(fileName == "") {
	                        info.text("No file chosen");
	                    } else {
	                        info.text(fileName);
	                    }
	                })
	            });
	        }
	    }
	    catch (e) {
	        console.log(e);
	    }
	})(jQuery);
  </script>
  </body>
</html>
