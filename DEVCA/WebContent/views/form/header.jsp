<%@page import="com.devca.model.dto.member.MEMBER"%>
<%@page import="org.apache.catalina.SessionListener"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	response.setContentType("text/html; charset=UTF-8");
%>

<!-- bootstrap -->
   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
   
   <!--Fontawesome CDN-->
   <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
   
<!-- end bootstrap --!>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- START :: css -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link href="/DEVCA/resources/css/master.css" rel="stylesheet" type="text/css">
<link href="/DEVCA/resources/css/kakaomap.css" rel="stylesheet" type="text/css">

<style type="text/css">
#headerSearchSubmitButton{
	cursor: pointer;
}
#profile_img_container{
	position: relative;
	width: 30%;
	float: left;
}
#profile_container{	
	position: relative;
	width: 50%;
	float: left;
}
#profile_img{
	widht: 50px;
	height: 50px;
	border-radius: 10px;
}
.ui-menu-item .ui-menu-item-wrapper.ui-state-active {
	background: #862d86 !important;
	font-weight: bold !important;
	color: #ffffff !important;
	border: none;
}
</style>
<!-- END :: css -->

<!-- START :: set JSTL variable -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="sessionLoginMember" value="${sessionScope.loginMember}"></c:set>
<c:set var="sessionLoginKakao" value="${sessionScope.loginKakao}"></c:set>
<c:set var="sessionLoginNaver" value="${sessionScope.loginNaver}"></c:set>
<c:set var="sessionMember_profile" value="${sessionScope.member_profile}"></c:set>
<!-- END :: set JSTL variable -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="../resources/js/autocomplete/headerSearchAutoComplete.js"></script>

<script type="text/javascript">
// jquery-ui 가 load 되면 autocomplete 실행
$.getScript("https://code.jquery.com/ui/1.12.1/jquery-ui.js", function(){
	$.getScript("../resources/js/autocomplete/headerSearchAutoComplete.js", function(){
		headerSearchAutoComplete();
	})	
})

function searchSubmit(){
	$("#headerSearch").submit();
}
</script>

<!-- END :: JAVASCRIPT -->

</head>
<body>
	<header>
		<nav class="navbar bg-dark navbar-dark">
			<a class="navbar-brand" href="/DEVCA/main/mainpage.do"><h3 style="color: #862d86; font-weight: 500;">DEVCA</h3></a>

			<button class="navbar-toggler nav-link mr-auto" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
				<span class="navbar-toggler-icon"></span>
			</button>				

			<form id="headerSearch" class="form-inline nav-link mr-auto" action="/DEVCA/lecture/lecturelistpage.do" method="post" style="width: 80%;">
				<div class="input-group" style="width: 100%">
					<input class="form-control" type="text" name="search" value="${search}"	placeholder="Ask 'What course do you need?'">
					<div class="input-group-append">	
						<span id="headerSearchSubmitButton" class="input-group-text"><i class="fas fa-search" onclick="searchSubmit();"></i></span>						
					</div>
				</div>
			</form>				

			<div class="btn-group">
				<button type="button" class="btn dropdown-toggle" data-toggle="dropdown">
					<i class="fas fa-user"></i>
				</button>
		    			
				<div class="dropdown-menu dropdown-menu-right">
					<c:choose>
					
						<c:when test="${not empty sessionLoginMember || not empty sessionLoginKakao || not empty sessionLoginNaver}">
							<div class="dropdown-item" style="width: 300px;">
								<div id="profile_img_container">
									<img id="profile_img" src="
																<c:choose>
																	<c:when test="${not empty sessionMember_profile.MEMBER_PROFILE_IMAGE_S_NAME}">../resources/images/profileupload/${sessionMember_profile.MEMBER_PROFILE_IMAGE_S_NAME }</c:when>
																	<c:otherwise>../resources/images/add.png</c:otherwise>
																</c:choose>	
																">
								</div>
								<div id="profile_container">
									<h6><c:out value="${sessionMember_profile.MEMBER_NAME }"></c:out></h6>
									<h6><c:out value="${sessionMember_profile.MEMBER_EMAIL }"></c:out></h6>								
								</div>
							</div>
									
							<a class="dropdown-item" style="visibility: hidden;"></a>
							<div class="dropdown-divider"></div>
							<a class="dropdown-item" href="/DEVCA/portfolio/portfoliopage.do">프로필</a>
							<a class="dropdown-item" href="/DEVCA/member/privacyprofilepage.do">계정관리</a>
							<a class="dropdown-item" href="/DEVCA/member/logout.do">로그아웃</a>
									
						</c:when>
					
					
						<c:otherwise>
							<a class="dropdown-item" href="/DEVCA/member/joinpage.do">회원가입</a>
							<a class="dropdown-item" href="/DEVCA/member/loginpage.do">로그인</a>							
						</c:otherwise>
					</c:choose>
				</div>
			</div>				


		</nav>

	</header>

	<!-- Navbar links -->			  
	<div class="collapse navbar-collapse bg-dark" id="collapsibleNavbar">
		<ul class="navbar-nav list-group-horizontal">
			<li class="nav-item">
				<strong><a class="nav-link px-5 py-4" href="/DEVCA/lecture/lecturelistpage.do">LECTURE</a></strong>
			</li>
			<c:if test="${not empty sessionLoginMember || not empty sessionLoginKakao || not empty sessionLoginNaver}">
				<li class="nav-item">
		        	<a class="nav-link mx-5 px-5 py-4" href="/DEVCA/lecture/mylecturelistpage.do">MY LECTURE</a>
		     	</li>
	      	</c:if>
	      	<li class="nav-item">
	        	<a class="nav-link mx-5 px-5 py-4" href="/DEVCA/study/studylistpage.do">STUDY</a>
	      	</li>
	      	<li class="nav-item">
	        	<a class="nav-link mx-5 px-5 py-4" href="/DEVCA/qnapage/qnalist.do">Q&A</a>
	      	</li>
	      	<li class="nav-item">
	        	<a class="nav-link mx-5 px-5 py-4" href="/DEVCA/qnapage/faqpage.do">FAQ</a>
	      	</li>
	    </ul>
	</div>
	
	
</body>

</html>