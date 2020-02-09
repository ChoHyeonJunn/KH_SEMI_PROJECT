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
<!-- START :: css -->
	<link href="/DEVCA/resources/css/master.css" rel="stylesheet" type="text/css">
<!-- END :: css -->

<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type='text/javascript'>
      //<![CDATA[
        // 사용할 앱의 JavaScript 키를 설정해 주세요.
        Kakao.init('dde3d6a6f398e8afdf7600f84f211532');
        
        // 카카오 로그인 버튼을 생성합니다.
        Kakao.Auth.createLoginButton({
          container: '#kakao-login-btn',
          success: function(authObj) {
            alert(JSON.stringify(authObj));
            Kakao.API.request({
            	url: '/v1/user/me',
            	success: function(res){
            		alert(JSON.stringify(res));
            		console.log(res.properties['nickname']);
       				console.log(res.id);
       				console.log(res.kaccount_email);
       				
       				console.log(authObj.access_token);
            	}
            })
          },
          fail: function(err) {
             alert(JSON.stringify(err));
          }
        });
        
        function klogout(){
        	Kakao.Auth.logout(function(){
        		setTimeout(function(){
        			location.href="/DEVCA/main/mainpage.do"
        		}, 1000);
        	})
        }
      //]]>
</script>
</head>
<body>
	
	<h1><a href="/DEVCA/main/mainpage.do">DEVCA</a></h1>
	
	<a id="kakao-login-btn">카카오</a>
    <a href="javascript:klogout();">LOGOUT</a>
    <a href="https://developers.kakao .com/logout"></a>
    
    
</body>
</html>