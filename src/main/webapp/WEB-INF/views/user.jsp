<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" session="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Login</title>

<link href="<c:url value="/resources/css/bootstrap.min.css" />"
	rel="stylesheet">
<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
<script src="<c:url value="/resources/js/jquery.min.js" />"></script>
<script src="<c:url value="/resources/js/bootstrap.js" />"></script>

<script>
	function formSubmit() {
		document.getElementById("logoutForm").submit();
	}
</script>
</head>
<body>
	<span align="center"><jsp:include page="header.jsp"></jsp:include></span>
	<div align="right">
		<table align="right">
			<tr>
				<td><c:url value="/j_spring_security_logout" var="logoutUrl" />
					<form action="${logoutUrl}" method="post" id="logoutForm"></form> <c:if
						test="${pageContext.request.userPrincipal.name != null}">
						<h4>
							Welcome : ${pageContext.request.userPrincipal.name} | <a
								href="javascript:formSubmit()"> Logout</a>
						</h4>
					</c:if></td>
			</tr>
		</table>
	</div>
	<br />
	<br />
	<br />


	<div align="center">
		<table>
			
			<tr>
				<td><h3 class="text-info"> your in User page <br/></h3></td></tr>
				<tr><td align="center"><a href="#"><button class="btn btn-warning"  type="submit" >continue</button> </a><br /> <br /></td> 
			</tr>
			</table>

	</div>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>