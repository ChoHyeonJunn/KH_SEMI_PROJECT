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

<link href="/DEVCA/resources/css/master.css" rel="stylesheet" type="text/css">
<style type="text/css">
#dropDownMenuList{
	padding: 0px;
	margin: 0px;
	position: absolute;
	width: 100%;
	z-index: 100;
}
#dropDownMenuList > div{
	margin-left: 100px;
}
#accountList{
	padding: 0px;
	margin: 0px;
	position: absolute;
	width: 400px;
	left: 70%;
	z-index: 100;
}
#profile_img{
	widht: 70px;
	height: 70px;
	border: 1px solid gray;
	border-radius: 30%;	
	position: relative;
	float: left;
	margin: 10px
}
#name_email{	
	position: relative;
	margin-left: 80px;
}
</style>
<!-- END :: css -->

<!-- START :: set JSTL variable -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="sessionLoginMember" value="${sessionScope.loginMember}"></c:set>
<c:set var="sessionLoginKakao" value="${sessionScope.loginKakao}"></c:set>
<c:set var="sessionLoginNaver" value="${sessionScope.loginNaver}"></c:set>
<c:set var="sessionMember_profile" value="${sessionScope.member_profile}"></c:set>
<!-- END :: set JSTL variable -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<script type="text/javascript">
$(function(){
	$("#dropDownMenuList").css("display","none");
	$("#dropDownMenu").click(function(){
		$("#dropDownMenuList").toggle(500);
		$("#accountList").css("display","none");
	})
	
	$("#accountList").css("display","none");
	$("#account").click(function(){
		$("#accountList").toggle();
		if($("#dropDownMenuList").css("display"))
			$("#dropDownMenuList").hide(500);
	})
})
</script>
<!-- END :: JAVASCRIPT -->

</head>
<body>
	<header>	
		<nav class="content">
			
			<span id="home">
				<a href="/DEVCA/main/mainpage.do">HOME</a>
			</span>
			
			<span id="dropDownMenu">
				dropDown		
			</span>
			
			<span id="search">
				<form action="/DEVCA/lecture/lecturelistpage.do" method="post" style="display: inline;">
					<input type="text" name="search" placeholder="Ask 'What course do you need?'" style="width: 800px;">
					<input type="submit" value="검색">
				</form>		
			</span>										
			<span id="account">				
				Account
			</span>	
		</nav>	

	</header>
	<div id="dropDownMenuList">
		<div>
			<a href="/DEVCA/lecture/lecturelistpage.do">강의게시물</a>
		</div>
		<c:if test="${not empty sessionLoginMember || not empty sessionLoginKakao || not empty sessionLoginNaver}">
			<div>
				<a href="/DEVCA/lecture/mylecturelistpage.do">찜한 강의</a>
			</div>
		</c:if>
		<div>
			<a href="/DEVCA/study/studylistpage.do">스터디</a>
		</div>
		<div>	
			<a href="/DEVCA/board/qnapage.do">Q&A</a>
		</div>
	</div>
	<div id="accountList">
		<c:choose>
						
			<c:when test="${not empty sessionLoginMember || not empty sessionLoginKakao || not empty sessionLoginNaver}">
				<div>
					<img id="profile_img" src="
												<c:choose>
													<c:when test="${not empty sessionMember_profile.MEMBER_PROFILE_IMAGE_S_NAME}">../resources/images/profileupload/${sessionMember_profile.MEMBER_PROFILE_IMAGE_S_NAME }</c:when>
													<c:otherwise>../resources/images/add.png</c:otherwise>
												</c:choose>	
												">
					<div id="name_email">
						<p>${sessionMember_profile.MEMBER_NAME }</p>
						<p>${sessionMember_profile.MEMBER_EMAIL }</p>
					</div>
				</div>
				<div>	
					<a href="/DEVCA/portfolio/portfoliopage.do?member_code=${sessionLoginMember.MEMBER_CODE }">프로필</a>
				</div>
				<div>	
					<a href="/DEVCA/member/privacyprofilepage.do">계정관리</a>
				</div>
				<div>
					<a href="/DEVCA/member/logout.do">로그아웃</a>
				</div>	
			</c:when>
			
			
			<c:otherwise>
				<div>
					<a href="/DEVCA/member/joinpage.do">회원가입</a>
				</div>
				<div>	
					<a href="/DEVCA/member/loginpage.do">로그인</a>
				</div>							
			</c:otherwise>			
		</c:choose>
	</div>
</body>
</html>