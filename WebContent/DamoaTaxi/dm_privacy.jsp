<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
  <head>
    <title>DamoaTaxi</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="Author" content="http://pablogarciafernandez.com" />
    <meta name="description" content="Table Responsive" />
    <meta name="keywords" content="table, responsive" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    
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
    <link rel="stylesheet" href="css/style.css?ver=3">
    <link rel="stylesheet" type="text/css" href="css/dm_privacy.css">
  </head>
  <body>
<jsp:include page="nav.jsp" flush="false"></jsp:include>
    
	<% 		
		String id=(String)session.getAttribute("id");
		String category=(String)session.getAttribute("category");
		if(id==null || id.equals("")){
	%>
			<script>
				alert("로그인이 필요합니다.");
				document.getElementById("logout").style.display='none';
				history.go(-1);
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

    <section class="ftco-cover overlay custom_height" style="background-image: url(images/image_5.jpg);" id="section-home" data-aos="fade"  data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row align-items-center justify-content-center ftco-vh-75">
          <div class="col-md-9 text-center">
            <h1 class="ftco-heading mb-4" data-aos="fade-up" data-aos-delay="500">회원 정보</h1>
          </div>
        </div>
      </div>
    </section>
    <!-- END section -->

    <div class="ftco-section bg-light">
    <div class="container">
      <div class="row block-9 justify-content-center" data-aos="fade-up">
        <div class="col-md-11 pr-md-1">
          <center>
          <table class="type10">
    <thead>
    <tr>
        <th scope="cols">회원정보</th>
        <th scope="cols"></th>
    </tr>
    </thead>
    <%
    	Connection conn=null;
    	PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	
    	
    	try{
    		String jdbcUrl="jdbc:mysql://damoataxi.ga/2019_2A01_DamoaTaxi";
    		String dbId="jspid";
    		String dbPass="jsppass";
    		
    		Class.forName("com.mysql.jdbc.Driver");
    		conn=DriverManager.getConnection(jdbcUrl,dbId,dbPass);
    		if(category.equals("I")){
    			String sql = "select * from impairment_member where impairment_ID=?";
    			pstmt=conn.prepareStatement(sql);
    			pstmt.setString(1, id);
    			rs=pstmt.executeQuery();
    			String impairment_category = "장애인 택시 고객";
    			while(rs.next()){
    				String impairment_ID = rs.getString("impairment_ID");
    				String impairment_Password = rs.getString("impairment_Password");
    				String impairment_Password_check = rs.getString("impairment_Password_check");
    				String impairment_name = rs.getString("impairment_name");
    				String impairment_phone_number = rs.getString("impairment_phone_number");
    				String impairment_email = rs.getString("impairment_email");
    				String impairment_certificate = rs.getString("impairment_certificate");
    				String impairment_point = rs.getString("impairment_point");
    				String impairment_zipcode = rs.getString("impairment_zipcode");
    				String impairment_address = rs.getString("impairment_address");
    			%>
    				<tbody>
    			    <tr>
    			        <th scope="row">회원유형</th>
    			        <td><%=impairment_category %></td>
    			    </tr>
    			    <tr>
    			        <th scope="row">회원명</th>
    			        <td><%=impairment_name %></td>
    			    </tr>
    			    <tr>
    			        <th scope="row">아이디</th>
    			        <td><%=impairment_ID %><button type="button" class="btn btn-info" style="float:right;" data-toggle="modal" data-target="#ID_modi_Modal">변경하기</button></td>
    			    </tr>
    			    <tr>
    			        <th scope="row">비밀번호</th>
    			        <td>********<button type="button" class="btn btn-info" style="float:right;" data-toggle="modal" data-target="#password_modi_Modal">변경하기</button></td>
    			    </tr>
    			    <tr>
    			        <th scope="row">연락처</th>
    			        <td><%=impairment_phone_number %><button type="button" class="btn btn-info" style="float:right;" data-toggle="modal" data-target="#Phone_modi_Modal">변경하기</button></td>
    			    </tr>
    			    <tr>
    			        <th scope="row">이메일</th>
    			        <td><%=impairment_email %><button type="button" class="btn btn-info" style="float:right;" data-toggle="modal" data-target="#email_modi_Modal">변경하기</button></td>
    			    </tr>
    			    <tr>
    			        <th scope="row">우편번호</th>
    			        <td><%=impairment_zipcode %><button type="button" class="btn btn-info" style="float:right;" data-toggle="modal" data-target="#zipcode_modi_Modal">변경하기</button></td>
    			    </tr>
    			    <tr>
    			        <th scope="row">주소</th>
    			        <td><%=impairment_address %></td>
    			    </tr>
    			    <tr>
    			        <th scope="row">포인트</th>
    			        <td><%=impairment_point %>dp</td>
    			    </tr>
    			    </tbody>
    			<%
    			}
    		}else{
    			String sql = "select * from travel_member where travel_ID=?";
    			pstmt=conn.prepareStatement(sql);
    			pstmt.setString(1, id);
    			rs=pstmt.executeQuery();
    			String travel_category = "관광 택시 고객";
    			while(rs.next()){
    				String travel_ID = rs.getString("travel_ID");
    				String travel_Password = rs.getString("travel_Password");
    				String travel_Password_check = rs.getString("travel_Password_check");
    				String travel_name = rs.getString("travel_name");
    				String travel_phone_number = rs.getString("travel_phone_number");
    				String travel_email = rs.getString("travel_email");
    				String travel_point = rs.getString("travel_point");
    				String travel_zipcode = rs.getString("travel_zipcode");
    				String travel_address = rs.getString("travel_address");
    			%>	
    				<tbody>
    			    <tr>
    			        <th scope="row">회원유형</th>
    			        <td><%=travel_category %></td>
    			    </tr>
    			    <tr>
    			        <th scope="row">회원명</th>
    			        <td><%=travel_name %></td>
    			    </tr>
    			    <tr>
    			        <th scope="row">아이디</th>
    			        <td><%=travel_ID %><button type="button" class="btn btn-info" style="float:right;" data-toggle="modal" data-target="#ID_modi_Modal">변경하기</button></td>
    			    </tr>
    			    <tr>
    			        <th scope="row">비밀번호</th>
    			        <td>********<button type="button" class="btn btn-info" style="float:right;" data-toggle="modal" data-target="#password_modi_Modal">변경하기</button></td>
    			    </tr>
    			    <tr>
    			        <th scope="row">연락처</th>
    			        <td><%=travel_phone_number %><button type="button" class="btn btn-info" style="float:right;"  data-toggle="modal" data-target="#Phone_modi_Modal">변경하기</button></td>
    			    </tr>
    			    <tr>
    			        <th scope="row">이메일</th>
    			        <td><%=travel_email %><button type="button" class="btn btn-info" style="float:right;" data-toggle="modal" data-target="#email_modi_Modal">변경하기</button></td>
    			    </tr>
    			    <tr>
    			        <th scope="row">우편번호</th>
    			        <td><%=travel_zipcode %><button type="button" class="btn btn-info" style="float:right;" data-toggle="modal" data-target="#zipcode_modi_Modal">변경하기</button></td>
    			    </tr>
    			    <tr>
    			        <th scope="row">주소</th>
    			        <td><%=travel_address %></td>
    			    </tr>
    			    <tr>
    			        <th scope="row">포인트</th>
    			        <td><%=travel_point %>dp</td>
    			    </tr>
    			    </tbody>
    			<%
    			}
    		}
    	}catch(Exception e){
    		e.printStackTrace();
    	}finally{
    		if(rs!=null)
    			try{rs.close();}catch(SQLException sqle){}
    		if(pstmt!=null)
    			try{pstmt.close();}catch(SQLException sqle){}
    		if(conn!=null)
    			try{conn.close();}catch(SQLException sqle){}
    	}
    		%>    
    
</table>
  <a href="delete_privacy.jsp"><button class="btn btn-primary">회원탈퇴</button></a>
        </div>
      </div>
    </div>
  </div>
	<!-- Modal -->
	<div id="ID_modi_Modal" class="modal fade" role="dialog" tabindex="-1" aria-hidden="true">
		<div class="vertical-alignment-helper">
			<div class="modal-dialog vertical-align-center">
				<div class="modal-content panel-success">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times;</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">아이디 변경하기</h4>
					</div>	
					<div class="modal-body">
						<div class="input-group" style="display: flex;">
							<input type="hidden" id="category" value="<%=category %>">
						    <input type="text" class="form-control" id="New_id" name="New_id" placeholder="바꿀아이디">
						    <button type="button" class="btn btn-info ml-2" onclick="ID_check()">중복확인</button>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" id="modifySubmit" class="btn btn-primary" onclick="Modify_id()">변경하기</button>
					</div>				
				</div>
			</div>
		</div>
	</div>
	<!-- end Modal -->
	<!-- Modal -->
	<div id="password_modi_Modal" class="modal fade" role="dialog" tabindex="-1" aria-hidden="true">
		<div class="vertical-alignment-helper">
			<div class="modal-dialog vertical-align-center">
				<div class="modal-content panel-success">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times;</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">비밀번호 변경하기</h4>
					</div>	
					<div class="modal-body">
						<input type="hidden" id="category" value="<%=category %>">
						<input type="password" class="form-control width100" id="current_password" name="current_password" placeholder="현재 비밀번호">
						<input type="password" class="form-control width100 mt-2" id="new_password" name="new_password" placeholder="바꿀 비밀번호">
						<input type="password" class="form-control width100 mt-2" id="new_password_chk" name="new_password_chk" placeholder="비밀번호 확인">
					</div>
					<div class="modal-footer">
						<button type="button" id="modifySubmit" class="btn btn-primary" onclick="Modify_password()">변경하기</button>
					</div>				
				</div>
			</div>
		</div>
	</div>
	<!-- end Modal -->
	<!-- Modal -->
	<div id="Phone_modi_Modal" class="modal fade" role="dialog" tabindex="-1" aria-hidden="true">
		<div class="vertical-alignment-helper">
			<div class="modal-dialog vertical-align-center">
				<div class="modal-content panel-success">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times;</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">연락처 변경하기</h4>
					</div>	
					<div class="modal-body">
						<input type="hidden" id="category" value="<%=category %>">
						<input type="text" class="form-control" id="form_num" name="form_num" placeholder="바꿀 연락처" style="display:block;">
					</div>
					<div class="modal-footer">
						<button type="button" id="modifySubmit" class="btn btn-primary" onclick="Modify_phone()">변경하기</button>
					</div>				
				</div>
			</div>
		</div>
	</div>
	<!-- end Modal -->
	<!-- Modal -->
	<div id="email_modi_Modal" class="modal fade" role="dialog" tabindex="-1" aria-hidden="true">
		<div class="vertical-alignment-helper">
			<div class="modal-dialog vertical-align-center">
				<div class="modal-content panel-success">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times;</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">이메일 변경하기</h4>
					</div>	
					<div class="modal-body">
						<input type="hidden" id="category" value="<%=category %>">
						<input type="text" class="form-control" id="form_email" name="form_email" placeholder="바꿀 이메일" style="display:block;">
					</div>
					<div class="modal-footer">
						<button type="button" id="modifySubmit" class="btn btn-primary" onclick="Modify_email()">변경하기</button>
					</div>				
				</div>
			</div>
		</div>
	</div>
	<!-- end Modal -->
	<!-- Modal -->
	<div id="zipcode_modi_Modal" class="modal fade" role="dialog" tabindex="-1" aria-hidden="true">
		<div class="vertical-alignment-helper">
			<div class="modal-dialog vertical-align-center">
				<div class="modal-content panel-success">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times;</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">주소 변경하기</h4>
					</div>	
					<div class="modal-body">
						<div class="input-group mt-2">
							<input type="hidden" id="category" value="<%=category %>">
						    <input type="text" class="form-control width100" id="New_id" name="New_id" placeholder="우편번호" readonly>
						    <span class="input-group-btn">
						        <button type="button" class="btn btn-info mt-2 ml-2" onclick="search_address()">주소검색</button>
						    </span>
						    <input type="text" class="form-control width100" id="New_id" name="New_id" placeholder="주소검색 후 상세주소 입력">
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" id="modifySubmit" class="btn btn-primary" onclick="Modify_id()">변경하기</button>
					</div>				
				</div>
			</div>
		</div>
	</div>
	<!-- end Modal -->
	
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
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
  <script src="js/google-map.js"></script>
  <script src="js/main.js"></script>
  <script src="js/privacy.js?ver=2"></script>
  </body>
</html>
