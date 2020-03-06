<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- START :: set JSTL variable -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- END :: set JSTL variable -->

</head>
<<<<<<< HEAD
   <aside class="col-md-2">
      <div class="card p-4 my-3 bg-white">
         
         
         <div class="card-title">
            <h4>계정관리</h4>
         </div>
         
         
         <!-- 사이드바 메뉴목록1 -->
         <ul class="list-group">
            <li class="list-group-item"><a href="/DEVCA/member/privacyprofilepage.do">계정관리</a></li>
               
            <!-- sns 계정 은 pw 가 존재하지 않기 때문에 비밀번호 설정에 들어가지 못한다. -->
            <c:if test="${not empty sessionScope.loginMember }">
                  <li class="list-group-item"><a href="/DEVCA/member/privacypasswordpage.do">비밀번호</a></li>
            </c:if>   
               
               <li class="list-group-item"><a href="/DEVCA/member/privacypaymentpage.do">결제관리</a></li>
         </ul>
         
            
      </div>
   </aside>
=======
	<aside class="col-md-2">
		<div class="card p-4 my-3 bg-white">
			
			
			<div class="card-title">
				<h4>계정관리</h4>
			</div>
			
			
			<!-- 사이드바 메뉴목록1 -->
			<ul class="list-group">
				<li class="list-group-item"><a href="/DEVCA/member/privacyprofilepage.do">계정관리</a></li>
			      
				<!-- sns 계정 은 pw 가 존재하지 않기 때문에 비밀번호 설정에 들어가지 못한다. -->
				<c:if test="${not empty sessionScope.loginMember }">
			   		<li class="list-group-item"><a href="/DEVCA/member/privacypasswordpage.do">비밀번호</a></li>
				</c:if>	
			   	
			   	<li class="list-group-item"><a href="/DEVCA/member/privacypaymentpage.do">결제관리</a></li>
			</ul>
			
				
		</div>
	</aside>
>>>>>>> a
</html>