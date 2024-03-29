<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="reservation.cartDTO" %>
<%@ page import="reservation.cartDAO" %>
<%@ page import="Damoa_pro.UserDAO" %>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
  <head>
    <title>DamoaTaxi</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    
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
    <link rel="stylesheet" href="css/style.css">
  </head>
  <body>
    <jsp:include page="nav.jsp" flush="false"></jsp:include>
    
	<% 		
		String id=(String)session.getAttribute("id");
		if(id==null || id.equals("")){
	%>
			<script>
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

    <section class="ftco-cover overlay custom_height" style="background-image: url(images/review_boardMain.jpg);" id="section-home" data-aos="fade"  data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row align-items-center justify-content-center ftco-vh-75">
          <div class="col-md-9 text-center">
            <h1 class="ftco-heading mb-4" data-aos="fade-up" data-aos-delay="500">결제</h1>
          </div>
        </div>
      </div>
    </section>
    <!-- END section -->

    <div class="ftco-section">
      <div class="container">
        <div class="row">
          <div class="col">
          	<h3>예약확인</h3>
            <%
	        	List<cartDTO> cartLists = null;
	            cartDTO cartList = null;
	            int count = 0;
	            int total_price = 0;
	            cartDAO cart = cartDAO.getInstance();
	            cartLists = cart.getCart(id);
            %>
            <table class="table table-hover" cellspacing="0" style="text-align: center; table-layout: fixed;">
            	<thead>
	                <tr>
	                    <th>이름</th>
	                    <th>날짜</th>
	                    <th>승차</th>
	                    <th>하차</th>
	                    <th>시간</th>
	                    <th>전화번호</th>
	                    <th>인원</th>
	                    <th>기사</th>
	                    <th>요청사항</th>
	                    <th>차종</th>
	                    <th>결제금액</th>
	                </tr>
            	</thead>
            	<tbody>
            	<%
					for(int i=0;i<cartLists.size();i++){
					cartList = (cartDTO)cartLists.get(i);
				%>
	            	<tr>
	                    <td><%=cartList.getName() %></td>
                        <td><%=cartList.getDate() %></td>
                        <td style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;" title="<%=cartList.getGetIn() %>"><%=cartList.getGetIn() %></td>
                        <td style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;" title="<%=cartList.getGetOut() %>"><%=cartList.getGetOut() %></td>
                        <td><%=cartList.getTime() %></td>
                        <td><%=cartList.getPhone() %></td>
                        <td><%=cartList.getPerson() %></td>
                        <td><%=cartList.getDriver() %></td>
                        <td style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;" title="<%=cartList.getRequestContent() %>"><%=cartList.getRequestContent() %></td>
                        <td><%=cartList.getCar() %></td>
                        <td><%=cartList.getPrice() %></td>
	                </tr>
            	<%
					total_price+=cartList.getPrice();            	
					}
            	%>
            </tbody>
          </table>
          <form action="../buyInsert" method="post" name="buyForm">
          	<input type="hidden" name="id" value="<%=id %>">
            <table class="table table-borderless" cellspacing="0" style="text-align: left;">
              <tr>
              	<td>결제방법</td>
              </tr>
              <tr>
             	<td>
					<select id="paymentMethod" name="paymentMethod" class="form-control">
						<option disabled="" selected=""></option>
	                    <option value="현장결제"> 현장결제 </option>
	                    <option value="계좌이체"> 계좌이체 </option>
	                    <option value="신용카드"> 신용카드 </option>
		            </select>
				</td>
              </tr>
              <tr class="is계좌이체">
              	<td>계좌번호</td>
              </tr>
              <tr class="is계좌이체">
              	<td><input type="text" id="계좌이체" class="form-control"></td>
              </tr>
              <tr class="is신용카드">
              	<td>카드번호</td>
              </tr>
              <tr class="is신용카드">
              	<td><input type="text" id="신용카드" class="form-control"></td>
              </tr>
              <%
              	int currentPoint = 0;
              	UserDAO userDAO = UserDAO.getInstance();
              	currentPoint = userDAO.getPoint(id);
              %>
              <tr>
              	<td><input type="checkbox" id="point" name="point"> 포인트 사용(보유 : <span id="currentPoint"><%= currentPoint %></span>dp)</td>
              </tr>
              <tr>
              	<td><input type="text" id="usePoint" name="usePoint" class="form-control" placeholder="사용하실 포인트를 적어주세요"></td>
              </tr>
              <tr>
              	<td>총 결제금액 : <span id="price"><%=total_price %></span> (적립 예정 포인트 : <%= (int) (total_price*0.01) %>dp)</td>
              </tr>
          	</table>
          	<div style="float: right;">
          		<input type="hidden" id="total_price" value="<%=total_price %>">
		    	<input type="submit" class="btn btn-finish btn-fill btn-warning btn-wd" value="결제하기">
		    </div>
          </form>
          </div> 
        </div>
      </div>
    </div> 
    <!-- .section -->
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
							<span aria-hidden="ture">X</span>
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
  <script src="js/jquery.easing.1.3.js"></script>
  <script src="js/jquery.waypoints.min.js"></script>
  <script src="js/jquery.stellar.min.js"></script>
  <script src="js/owl.carousel.min.js"></script>
  <script src="js/jquery.magnific-popup.min.js"></script>
  <script src="js/aos.js"></script>
  <script src="js/jquery.animateNumber.min.js"></script>
  <script src="js/google-map.js"></script>
  <script src="js/main.js"></script>
  <script src="js/reviewboard.js?ver=1"></script>
  <script src="js/payment.js"></script>
  </body>
</html>