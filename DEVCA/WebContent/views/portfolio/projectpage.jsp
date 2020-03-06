<%@page import="com.devca.model.dto.profile.PROJECT"%>
<%@page import="com.devca.model.dto.profile.CAREER"%>
<%@page import="com.devca.model.dto.profile.CAREER_DETAIL"%>
<%@page import="java.util.List"%>
<%@page import="com.devca.model.dto.member.MEMBER"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	response.setContentType("text/html; charset=UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- HEADER FORM -->
<%@ include file="/views/form/header.jsp"%>

<!-- START :: css -->
<style type="text/css">
    .toggleBG{background: #CCCCCC; width: 35px; height: 15px; border: 1px solid #CCCCCC; border-radius: 15px; float:right;}
    .toggleFG{background: #FFFFFF; width: 15px; height: 15px; top: -4px; border: none; border-radius: 15px; position: relative; left: 0px;}

</style>
<!-- END :: css -->

<!-- START :: set JSTL variable -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- END :: set JSTL variable -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	function inNumber(){
	  if(event.keyCode<48 || event.keyCode>57){
	     event.returnValue=false;
	  }
	}
	
	$(document).on('click', '.toggleBG', function () {
		if($("#opener").css('display')=='none'){
			$('#opener').show();
		} else {
			$('#opener').hide();
		}
	    var toggleBG = $(this);
	    var toggleFG = $(this).find('.toggleFG');
	    var left = toggleFG.css('left');
	    if(left == '20px') {
	        toggleBG.css('background', '#CCCCCC');
	        toggleActionStart(toggleFG, 'TO_LEFT');
	    }else if(left == '0px') {
	        toggleBG.css('background', '#7277a1');
	        toggleActionStart(toggleFG, 'TO_RIGHT');
	    }
		
	});
	 
	// 토글 버튼 이동 모션 함수
	function toggleActionStart(toggleBtn, LR) {
	    // 0.01초 단위로 실행
	    var intervalID = setInterval(
	        function() {
	            // 버튼 이동
	            var left = parseInt(toggleBtn.css('left'));
	            left += (LR == 'TO_RIGHT') ? 5 : -5;
	            if(left >= 0 && left <= 20) {
	                left += 'px';
	                toggleBtn.css('left', left);
	            }
	        }, 10);
	    setTimeout(function(){
	        clearInterval(intervalID);
	    }, 201);
	}

</script>
<!-- END :: JAVASCRIPT -->

<!-- START :: 비회원이 잘못된 경로를 통해 접근했을 때 block -->
<c:if
	test="${empty sessionLoginMember && empty sessionLoginKakao && empty sessionLoginNaver}">
	<jsp:forward page="/DEVCA/main/mainpage.do"></jsp:forward>
</c:if>
<!-- END :: 비회원이 잘못된 경로를 통해 접근했을 때 block -->
</head>
<body>
	<section class="container-fluid">
		<div class="row">	
			<%@ include file="/views/form/portfoliosidebar.jsp"%>
			<!-- START :: profile content -->
			<article class="col-md-10">
			<div class="card p-4 my-3 bg-white">
				<h1>개인적으로 진행한 프로젝트를 등록하세요.</h1>
				<fieldset>
					<form action="/DEVCA/portfolio/skillpage.do" method="post">
					<input type="hidden" name="member_code" value="${sessionLoginMember.MEMBER_CODE }"/>
					
					
					<c:set var="year" value="2020"/>
					<c:forEach items="${projectList }" var="projectdto">
						<input type="hidden" name="project_seq" value="${projectdto.PROJECT_SEQ }"/>
					<div class="project-item">
						
						
						<label for="project_name">프로젝트 이름</label>	
						<div class="input-group mb-3">
							<input type="text" name="project_name" id="project_name" placeholder="입력" value="${projectdto.PROJECT_NAME }"/>
							<span class="input-group-text"><i class="fas fa-phone"></i></span>
						</div>
						
						
						<div class="input-group mb-3">
							<select class="form-control" name="create_year">
								<option value="0">제작 연도</option>
								<c:forEach begin="0" end="19">
									<option value="${year }" <c:if test="${year eq projectdto.PROJECT_YEAR}">selected</c:if>>${year }</option>
									<c:set var="year" value = "${year - 1 }"/>
								</c:forEach>
							</select>
						</div>
						
						
						<label for="project_one_ex">프로젝트 1줄 설명</label>
						<div class="input-group mb-3">
							<input type="text" name="project_oneline_ex" id="project_one_ex" placeholder="입력" value="${projectdto.PROJECT_ONELINE_EX }"/>
							<span class="input-group-text"><i class="fas fa-phone"></i></span>
						</div>
						
						
						<div class="project-items">
							<label>팀 구성</label>
							<div class="input-group mb-3">
								<select class="form-control" name="project_team">
									<option value="team" <c:if test="${projectdto.PROJECT_TEAM eq 'team' }">selected</c:if>>팀</option>
									<option value="single" <c:if test="${projectdto.PROJECT_TEAM eq 'single' }">selected</c:if>>개인</option>
								</select>
							</div>
							
							
							<label for="member">팀 구성원</label>
							<div class="input-group mb-3">
								<input type="text" name="project_member" id="member" placeholder="입력" value="${projectdto.PROJECT_MEMBER }"/>
								<span class="input-group-text"><i class="fas fa-phone"></i></span>
							</div>
						</div>
						
						
						<label for="usestack">사용 스택</label>
						<div class="input-group mb-3">
							<input type="text" name="project_usestack" id="usestack" placeholder="스택 입력" value="${projectdto.PROJECT_USE_STACK }"/>
							<span class="input-group-text"><i class="fas fa-phone"></i></span>
						</div>
						
						
						<label for="detail_work">상세 업무 및 성과</label>
						<div class="input-group mb-3">
							<textarea class="form-control"  id="detail_work" name="project_detail" rows="2" cols="50">${projectdto.PROJECT_DETAIL }</textarea>
						</div>
						
						
						<label for="storage_link">저장소 링크</label>
						<div class="input-group mb-3">
							<input type="text" name="project_storage_link" id="storage_link" placeholder="https://github.com/project"value="${projectdto.PROJECT_STORAGE_LINK }"/>
							<span class="input-group-text"><i class="fas fa-phone"></i></span>
						</div>
						
						
						<div class="input-group mb-3">
							<label>오픈 여부</label><br/>
							<div>
								<a>"프로젝트가 웹/마켓에 오픈 되었습니까?"</a>
								<div style="position:relative; top: -1px;" class='toggleBG'>
		    						<input type="button" class='toggleFG'/>
								</div>
							</div>
						</div>
						
						
						
						<div class="input-group mb-3">
							<div id ="opener" style="border:none; display : none;">
								
								<div class="row">
									<div class="col-md-4">
										<label for="Website">Website</label>
										<div class="input-group mb-3">
											<input type="text" id="Website" name ="Website" placeholder="http://" value="${projectdto.PROJECT_WEBSITE }"/>
											<span class="input-group-text"><i class="fas fa-phone"></i></span>
										</div>
									</div>
									
									
									<div class="col-md-4">
										<label for="Android">Android</label>
										<div class="input-group mb-3">
											<input type="text" id="Android" name ="Android" placeholder="http://" value="${projectdto.PROJECT_ANDROID }"/>
											<span class="input-group-text"><i class="fas fa-phone"></i></span>
										</div>
									</div>
									
									
									<div class="col-md-4">
										<label for="iOS">iOS</label>
										<div class="input-group mb-3">
											<input type="text" id="iOS" name ="iOS" placeholder="http://" value="${projectdto.PROJECT_IOS }"/>
											<span class="input-group-text"><i class="fas fa-phone"></i></span>
										</div>	
									</div>
									
									
								</div>
							</div>
						</div>
					</div>
					</c:forEach>
					<div>
						<a href="#" class="btn btn-primary btn-lg" onclick="location.href='/DEVCA/portfolio/sideportfoliopage.do?member_code=${sessionLoginMember.MEMBER_CODE }'">이전</a>
						<input class="btn btn-primary btn-lg" type="submit" value="다음" style="float: right;"/>
					</div>
					</form>
				</fieldset>
			</div>
			</article>
		<!-- END :: profile content -->
		</div>
	</section>
	<!-- FOOTER FORM -->
	<%@ include file="/views/form/footer.jsp"%>
</body>
</html>
