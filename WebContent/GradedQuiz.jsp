<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Your Quiz Score</title>
</head>
<body>

	Your Score: <%= request.getAttribute("score") %>
	<br>
	Total Points Possible: <%= request.getAttribute("possible") %>
	<br>
	<form action="index.jsp" method="post">
		<input type="submit" value="Back to Homepage">
	</form>



</body>
</html>