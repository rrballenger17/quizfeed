<%@ page import="java.util.*"%>
<%@ page import="quiz.*"%>

<jsp:include page="<%=Constants.HEADER_FILE%>">
	<jsp:param value="Search Results" name="title" />
</jsp:include>

<%
	HashMap<Integer, User> users = (HashMap<Integer, User>) request
			.getAttribute("users");
	if (users != null && !users.isEmpty()) {
%>
<h1>Users</h1>
<ul>
	<%
		for (Integer uID : users.keySet()) {
	%>
	<li><a href="user?uid=<%=uID%>"><%=users.get(uID).getUsername()%></a></li>
	<%
		}
		}
	%>
</ul>

<%
	ArrayList<Quiz> quizzes = (ArrayList<Quiz>) request
			.getAttribute("quizzes");
	if (quizzes != null && !quizzes.isEmpty()) {
%>
<h1>Quizzes</h1>
<ul>
	<%
		for (Quiz quiz : quizzes) {
	%>
	<li><a href="quiz?uid=<%=quiz.getID()%>"><b> <%=quiz.getName()%>
		</b></a> - <%=quiz.getDescription()%></li>
	<%
		}
		}
	%>
</ul>

<jsp:include page="<%=Constants.FOOTER_FILE%>"></jsp:include>