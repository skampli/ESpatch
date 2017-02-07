<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>ES patch Automation Tool</title>

<link href="<c:url value="/resources/css/bootstrap.min.css" />"
	rel="stylesheet">
<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
<script src="<c:url value="/resources/js/jquery.min.js" />"></script>
<script src="<c:url value="/resources/js/bootstrap.js" />"></script>

</head>

<body>
<jsp:include page="header.jsp"></jsp:include>
<br/><br/><br/><br/><br/>
	<div align="center">
	<h2 class="text-info"> Welcome ESpatching Tool</h2><br/><br/>
	<a href="/ESpatch/user" ><p class="text-warning">Go to the Login Page</p></a>
	</div>
	<br/><br/><br/><br/><br/>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
