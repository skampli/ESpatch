<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>


<title>CSV Automation Tool</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<style type="text/css">
.error {
	padding: 15px;
	margin-bottom: 20px;
	border: 1px solid transparent;
	border-radius: 4px;
	color: #a94442;
	background-color: #f2dede;
	border-color: #ebccd1;
}

.msg {
	padding: 15px;
	margin-bottom: 20px;
	border: 1px solid transparent;
	border-radius: 4px;
	color: #31708f;
	background-color: #d9edf7;
	border-color: #bce8f1;
}

#login-box {
	width: 300px;
	padding: 20px;
	margin: 100px auto;
	background: #fff;
	-webkit-border-radius: 2px;
	-moz-border-radius: 2px;
	border: 1px solid #000;
}
</style>

  <link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
   
    <script src="<c:url value="/resources/js/jquery.min.js" />"></script>
    <script src="<c:url value="/resources/js/bootstrap.js" />"></script>
     <script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
</head>

<body onload='document.loginForm.username.focus();'>
	<!--   <jsp:include page="header.jsp"></jsp:include>-->
	<div id="login-box">
		<h2>Login with Username and Password</h2>

		<c:if test="${not empty error}">
			<div class="error">${error}</div>
		</c:if>
		<c:if test="${not empty msg}">
			<div class="msg">${msg}</div>
		</c:if>

		<form name='loginForm'
			action="<c:url value='j_spring_security_check' />" method='POST'>

			<table>
				<tr>
					<td>User:</td>
					<td><input class="form-control" type='text' name='username' value=''><br/></td>
				</tr>
				<tr>
					<td>Password:</td>
					<td><input class="form-control" type='password' name='password' /><br/></td>
				</tr>
				<tr>
					<td></td>
					<td align="right">
					<input  class="btn btn-info" name="submit" type="submit" value="Login" /></td>
				</tr>
			</table>
		</form>
	</div>
	<!--  <jsp:include page="footer.jsp"></jsp:include>   -->
</body>
</html>
