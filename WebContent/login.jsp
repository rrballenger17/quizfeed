<%@ page import="quiz.Constants"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet" type="text/css" href="stylesheet.css">
</head>
<body>
	<jsp:include page="<%=Constants.HEADER_FILE%>">
		<jsp:param value="Login" name="title" />
	</jsp:include>
	<%
		// TODO this error message will show up for ANY user
		String message = (String) request.getAttribute("error");
		if (message != null) {
	%>
	<p>
		<%=message%>
	</p>
	<%
		}
	%>


	<form action="login" method="post">
		<p>
			Username: <input type="text" name="username">
		</p>
		<p>
			Password: <input type="password" name="password">
		</p>
		<p>
			<input type="submit" name="Enter">
		</p>
	</form>

	<p>
		<a href="LoginCreate.jsp">Create Username</a>
	</p>
</body>
</html>