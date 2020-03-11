<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8");%>

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

<!-- START :: CSS -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link href="/DEVCA/resources/css/master.css" rel="stylesheet" type="text/css">
<style type="text/css">
.container{
   padding-top: 80px;
}

.card {
   width: 600px;
   margin: 10% auto 100px auto;
   box-shadow: 0 2px 5px 0 rgba(0, 0, 0, 0.16), 0 2px 10px 0 rgba(0, 0, 0, 0.12);
   -webkit-transition: .25s box-shadow;
   transition: .25s box-shadow;
}
.card:focus,
.card:hover {
   box-shadow: 0 20px 40px 0 rgba(0, 0, 0, 0.18), 0 4px 15px 0 rgba(0, 0, 0, 0.15);
}
.card-link{
   color: #862d86;
   font-weight: 800;
}

.btn, .input-group-text{
   color: white;
   font-weight: 800;
   background-color: #862d86; 
}

.social_icon{
   position: absolute;
   right: 20px;
   top: -30px;
}
.social_icon span{
   width: 99px;
   height: 99px;
   margin-left: 10px;
   border-radius: 20px;
}
.social_icon span:hover{
   box-shadow: 0 10px 10px 0 rgba(0, 0, 0, 0.18), 0 4px 15px 0 rgba(0, 0, 0, 0.15);
   cursor: pointer;
}

.list-group li{
   list-style: none;
   margin-right: 20px;
}
</style>
<!-- END :: CSS -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<script type="text/javascript" src="../resources/js/RSA/rsa.js"></script>
<script type="text/javascript" src="../resources/js/RSA/jsbn.js"></script>
<script type="text/javascript" src="../resources/js/RSA/prng4.js"></script>
<script type="text/javascript" src="../resources/js/RSA/rng.js"></script>

<script type="text/javascript" src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>

<script type="text/javascript">

// 이메일 정규식
var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;   


$(function(){
   var rsa = new RSAKey();
   rsa.setPublic("${modulus}", "${exponent}");
   
   $("#SUBMIT").attr("disabled", "disabled");
   $("#email_check").attr("style", "display: none;");
   
   $("#name").keyup(function() {
      
      if($("#name").val() == null || $("#name").val() == "") {
         $("#name_confirm").text("필수 정보입니다.");
         $("#name_confirm").attr("style", "color:red");
      } else {         
         $.ajax({
            
            type: "POST",
            url: "/DEVCA/member/nameconfirm.do",
            data: { MEMBER_NAME : $("#name").val() },
            dataType: "JSON",
            
            success: function(msg) {   
               if(msg.result > 0) {                  
                  $("#name_confirm").text("이미 사용중인 별명입니다.");
                  $("#name_confirm").attr("style", "color:red");
                  
                  $("#SUBMIT").attr("disabled", "disabled");
               } else {
                  $("#name_confirm").text("사용 가능한 별명입니다.");
                  $("#name_confirm").attr("style", "color:blue");
                  
                  $("#SUBMIT").removeAttr("disabled");
               }
            },
            
            error : function() {
               alert("통신 실패");
            }
         })
      }
   })
   
   $("#email").keyup(function() {
      
      if($("#email").val() == null || $("#email").val() == "") {
         $("#email_confirm").text("필수 정보입니다.");
         $("#email_confirm").attr("style", "color:red");
      } else {   
         
         if(regExp.test($("#email").val())){
            $.ajax({
               
               type: "POST",
               url: "/DEVCA/member/emailconfirm.do",
               data: { MEMBER_EMAIL : $("#email").val() },
               dataType: "JSON",
               
               success: function(msg) {   
                  if(msg.result > 0) {                  
                     $("#email_confirm").text("이미 사용중인 이메일입니다.");
                     $("#email_confirm").attr("style", "color:red");
                     
                     $("#SUBMIT").attr("disabled", "disabled");
                  } else {
                     $("#email_confirm").text("사용 가능한 이메일입니다. 이메일 인증을 진행해주세요.");
                     $("#email_confirm").attr("style", "color:blue");
                     $("#email_check_remove").attr("style", "display:none;")
                     $("#email_check").attr("style", "display");
                     $("#SUBMIT").removeAttr("disabled");
                     
                  }
               },
               
               error : function() {
                  alert("통신 실패");
               }
            })
         } else{
            $("#email_confirm").text("이메일 형식이 아닙니다.");
            $("#email_confirm").attr("style", "color:red");
            
            $("#SUBMIT").attr("disabled", "disabled");
         }
      }
   })
   $("#pw,#pwChk").keyup(function() {
      var pw = $("#pw").val();
      var pwChk = $("#pwChk").val();
      
      if(pw != "" && pwChk != "") {
         
         if(pw != pwChk) {
            $("#pw_confirm").text("비밀번호가 일치하지 않습니다.");
            $("#pw_confirm").attr("style", "color:red");                  
         } else {   
            $("#pw_confirm").text("비밀번호가 일치합니다.");
            $("#pw_confirm").attr("style", "color:green");
         }
      } 
   })
   
   $("#email_check").click(function(){
      $("#email_confirm").text("이메일 인증 진행중...");
      $("#email_confirm").attr("style", "color:green");

      if($("#email").val() == null || $("#email").val() == "") {
         $("#email_confirm").text("필수 정보입니다.");
         $("#email_confirm").attr("style", "color:red");
      } else {         
         $.ajax({            
            type: "POST",
            url: "/DEVCA/member/emailAuth.do",
            data: { MEMBER_EMAIL : $("#email").val() },
            dataType: "JSON",
            
            success: function(msg) {   
               $("#emailAuthHiddenForm input[name='authNum']").val(msg.authNum);
                                    
               // 팝업 생성
               var url = "/DEVCA/views/member/joinemailauth.jsp";
               var title = "JOIN DEVCA";
               var prop = "top=200px,left=600px,width=500px,height=500px";
                     
               window.open(url, title, prop);               
            },
            
            error : function() {
               alert("통신 실패");
            }
         })
      }
   })
   
   $("#joinForm").submit(function(e) {            
      e.preventDefault();
               
      var MEMBER_NAME = $(this).find("#name").val();
      var MEMBER_EMAIL = $(this).find("#email").val();
      var MEMBER_PHONE = $(this).find("#phone").val();
      var MEMBER_PW = $(this).find("#pw").val();
   
      $("#joinHiddenForm input[name='MEMBER_NAME']").val(rsa.encrypt(MEMBER_NAME));
      $("#joinHiddenForm input[name='MEMBER_EMAIL']").val(rsa.encrypt(MEMBER_EMAIL));
      $("#joinHiddenForm input[name='MEMBER_PHONE']").val(rsa.encrypt(MEMBER_PHONE));
      $("#joinHiddenForm input[name='MEMBER_PW']").val(rsa.encrypt(MEMBER_PW));
   
      // 임시 출력 alert!!//////////////////////////////////////
      alert("name : " + $("#joinHiddenForm input[name='MEMBER_NAME']").val() + "\n" 
            + "email : " + $("#joinHiddenForm input[name='MEMBER_EMAIL']").val() + "\n"
            + "phone : " + $("#joinHiddenForm input[name='MEMBER_PHONE']").val() + "\n"
            + "pw : " + $("#joinHiddenForm input[name='MEMBER_PW']").val());
      //////////////////////////////////////////////////////
               
      $("#joinHiddenForm").submit();
   })
})

</script>

<!-- END :: JAVASCRIPT -->

</head>

<body class="bg-light">
   <c:if test="${empty SURVEY_LANGUAGE}">
      <script type="text/javascript">
      $(function(){
         $("#JoinPageContainer").hide();
      })
      </script>
      <section class="container">
         <div class="card p-4 my-3 bg-white text-center">         
            
            <h1 class="card-title">
               <a class="card-link" href="/DEVCA/main/mainpage.do">DEVCA</a>
               JOIN
            </h1>
            
            <h5 class="card-title">
               	설문조사를 진행해야 회원가입이 가능합니다.
            </h5>
            
            <div class="input-group mb-3">
               <button class="btn btn-block btn-lg" onclick="location.href='/DEVCA/main/survey.do'">설문조사 하러 가기</button>
            </div>
         </div>
      </section>
   </c:if>
   
   
   <section id="JoinPageContainer" class="container">
      <div class="card p-4 my-3 bg-white">         
         
         <h1 class="card-title">
            <a class="card-link" href="/DEVCA/main/mainpage.do">DEVCA</a>
            JOIN
         </h1>
            
         <div class="d-flex justify-content-end social_icon">
            <span>
               <a id="custom-login-btn" href="javascript:loginWithKakao()">
                  <img src="../resources/images/social/kakaolink_btn_medium.png" width="100px;"/>
               </a>
            </span>
            <span>
               <a id="naver_id_login"></a>
            </span>
         </div>         
         
         <div>
            <hr>
         </div>
            
         <div class="card-body">      
            <form id="joinForm" action="/DEVCA/member/join.do" method="post">
               
               <!-- <label for="name">별명</label> -->
               <div class="input-group mb-3">
                  <input id="name" type="text" class="form-control" name="MEMBER_NAME" required="required" placeholder="nickname" autocomplete="name">
                  <div class="input-group-append">            
                         <span class="input-group-text"><i class="fas fa-user"></i></span>
                  </div>
               </div>
               <div id="name_confirm"></div>   <!-- 경고문이 들어갈 공간 -->
               
               
               <!-- <label for="email">이메일</label> -->
               <div class="input-group mb-3">
                  <input id="email" class="form-control" type="email" name="MEMBER_EMAIL" required="required" placeholder="example@example.com" autocomplete="email">
                  <div class="input-group-append">            
                         <span id="email_check_remove" class="input-group-text"><i class="fas fa-envelope"></i></span>
                  </div>
                  <input id="email_check"  class="btn" type="button" value="email 인증번호 받기" >
               </div>         
               <div id="email_confirm"></div>   <!-- 경고문이 들어갈 공간 -->
               
               
               <!-- <label for="pw">비밀번호</label> -->
               <div class="input-group mb-3">
                  <input id="pw" class="form-control" type="password" name="MEMBER_PW" required="required" placeholder="password">
                  <div class="input-group-prepend">            
                         <span class="input-group-text"><i class="fas fa-key"></i></span>
                  </div>
               </div>
               
               
               <!-- <label for="pwChk">비밀번호 재확인</label> -->
               <div class="input-group mb-3">
                  <input id="pwChk" class="form-control" type="password" required="required" placeholder="password-check">
                  <div class="input-group-prepend">            
                         <span class="input-group-text"><i class="fas fa-check"></i></span>
                  </div>
               </div>         
               <div id="pw_confirm"></div>      <!-- 경고문이 들어갈 공간 -->
               
               
               <!-- <label for="phone">전화번호</label> -->
               <div class="input-group mb-3">   
                  <input id="phone" class="form-control" type="tel" name="MEMBER_PHONE" required="required" placeholder="010-1234-1234" autocomplete="tel">
                  <div class="input-group-append">            
                         <span class="input-group-text"><i class="fas fa-phone"></i></span>
                  </div>               
               </div>
               
      
               <div class="input-group mb-3">
                  <input class="btn btn-block btn-lg" type="submit" value="계정만들기" id="SUBMIT">
               </div>
               
            </form>
            
            <div class="input-group mb-3">
               이미 계정이 있으신가요?
               <a class="card-link" href="/DEVCA/member/loginpage.do">&nbsp;로그인 > </a>
            </div>
            <div class="input-group mb-3">
               <ul class="list-group list-group-horizontal">
                  <li><a class="card-link" href="#">이용약관</a></li>
                  <li><a class="card-link" href="#">개인정보 처리방침</a></li>
                  <li><a class="card-link" href="#">FAQ/문의</a></li>
               </ul>
            </div>
         </div>
      </div>
   </section>
   
   <form id="emailAuthHiddenForm"action="#">
      <input type="hidden" name="authNum">
   </form>

   <!-- 실제 서버로 전송되는 FORM -->
   <form id="joinHiddenForm" action="/DEVCA/member/join.do" method="post" >
      <fieldset>
         <input type="hidden" name="MEMBER_NAME">
         <input type="hidden" name="MEMBER_EMAIL">
         <input type="hidden" name="MEMBER_PHONE">
         <input type="hidden" name="MEMBER_PW">
      </fieldset>
   </form>
   
   <!-- START :: SNSJOIN 팝업창으로 전송되는 form -->
      <form id="snsHiddenForm" action="" method="post">
         <input type="hidden" name="snsType">
         <input type="hidden" name="SNS_ID" /> 
         <input type="hidden" name="SNS_NICKNAME" />          
         <input type="hidden" name="SNS_EMAIL" />
         <input type="hidden" name="access_token" />
      </form>
   <!-- END :: SNSJOIN 팝업창으로 전송되는 form -->
   
   <!-- START :: SNSJOIN 시 실제 서버로 전송되는 form -->
      <form id="snsJoinHiddenForm" action="/DEVCA/member/snsjoin.do" method="post">
         <input type="hidden" name="snsType">
         
         <input type="hidden" name="MEMBER_NAME">
         <input type="hidden" name="MEMBER_EMAIL">
         <input type="hidden" name="MEMBER_PHONE">
         
         <input type="hidden" name="SNS_ID" /> 
         <input type="hidden" name="SNS_NICKNAME" />    
         <input type="hidden" name="access_token" />
      </form>
   <!-- END :: SNSJOIN 시 실제 서버로 전송되는 form -->
   
   <!-- START :: SNSLOGIN 시 실제 서버로 전송되는 form -->
   <form id="snsLoginHiddenForm" action="/DEVCA/member/loginsns.do" method="post">
      <input type="hidden" name="snsType">
      
      <input type="hidden" name="SNS_ID">
      <input type="hidden" name="access_token">
   </form>
   <!-- END :: SNSLOGIN 시 실제 서버로 전송되는 form -->
   
</body>

<!-- START :: NAVER LOGIN -->
<script type="text/javascript">
   var naver_id_login = new naver_id_login("irD1NHw9tD2Loycjai2X", "http://qclass.iptime.org:8787/DEVCA/views/member/navercallback.jsp");
   var state = naver_id_login.getUniqState();
   
   naver_id_login.setButton("green", 1, 100);
   naver_id_login.setDomain("http://qclass.iptime.org:8787/DEVCA");
   naver_id_login.setState(state);
   naver_id_login.setPopup();
   naver_id_login.init_naver_id_login();
</script>
<!-- END :: NAVER LOGIN -->

<!-- START :: KAKAO LOGIN -->
<script type="text/javascript">

// 사용할 앱의 JavaScript 키를 설정해 주세요.
Kakao.init('dde3d6a6f398e8afdf7600f84f211532');

function loginWithKakao(){
    Kakao.Auth.login({
        success: function(authObj) {
            /* alert(JSON.stringify(authObj)); */
        
       Kakao.API.request({
          url: '/v2/user/me',
          success: function(res){
            console.log(res.id);
             console.log(res.properties['nickname']);
            console.log(res.kaccount_email);            
            console.log(authObj.access_token);
            
            // 가입된 이메일이 존재하는지 체크
            $.ajax({
               type : "POST",
               url : "/DEVCA/member/issnsmember.do",
               data : {
                  SNS_ID : res.id, 
                  snsType : "KAKAO"
               },
               dataType : "JSON",
   
               success : function(msg) {
                  /* alert(msg.iskakao); */
                  
                  if(msg.issns > 0){
                     //kakao id로 회원가입이 되어 있음   -> 로그인
                     $("#snsLoginHiddenForm input[name='snsType']").val("KAKAO");
                     $("#snsLoginHiddenForm input[name='SNS_ID']").val(res.id);
                     $("#snsLoginHiddenForm input[name='access_token']").val(authObj.access_token);
                     $("#snsLoginHiddenForm").submit();
                  }else{
                     //kakao id로 회원가입이 안되어 있음 -> 회원가입
                     
                     // 히든 폼에 set
                     $("#snsHiddenForm input[name='snsType']").val("KAKAO");
                     $("#snsHiddenForm input[name='SNS_ID']").val(res.id);
                     $("#snsHiddenForm input[name='SNS_NICKNAME']").val(res.properties['nickname']);
                     $("#snsHiddenForm input[name='SNS_EMAIL']").val(res.kaccount_email);
                     $("#snsHiddenForm input[name='access_token']").val(authObj.access_token);
                     
                     // 팝업 생성
                     var url = "/DEVCA/views/member/snsjoin.jsp";
                     var title = "JOIN DEVCA";
                     var prop = "top=200px,left=600px,width=500px,height=500px";
                        
                     window.open(url, title, prop);
                  }
               },
   
               error : function(request, status, error) {
                  alert("통신 실패");
                  alert("code : " + request.status
                     + "\n" + "message : "
                     + request.responseText
                     + "\n" + "error : " + error);
               }
            })
   
          }
       })
     },
     fail: function(err) {
        alert(JSON.stringify(err));
     }
   });
}
// kakao logout 
function klogout(){
   Kakao.Auth.logout(function(){
      setTimeout(function(){
         location.href="/DEVCA/main/mainpage.do"
      }, 1000);
   })
}
</script>
<!-- END :: KAKAO LOGIN -->

</html>






