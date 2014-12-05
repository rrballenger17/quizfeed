<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.Time" %>    
<%@ page import="java.util.ArrayList" %>    
<%@ page import="java.util.Collections" %> 
<%@ page import="quiz.*" %>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Quiz Time</title>
</head>
<body>
<% 

int i = (Integer)request.getAttribute("qNumber");
Integer zID = (Integer)session.getAttribute("zID");
Quiz q = new Quiz(zID);
String nextPage = "NextPageServlet"; 
if (i == q.getQuestionCount() - 1) {
	nextPage = "GradeQuiz";	
}
%>

<form action = <%=nextPage%> method="post">
	<input type="hidden" name="qNumber" value=<%=i%>>
<%	
	int type = q.getQuestionType(i);
	
	if (type != Constants.PICTURE_RESPONSE){  %>
		<p><%=i + 1%>.<%=q.getQuestion(i) %><br>
	<% } %>

	
	<% if(type == Constants.TEXT_RESPONSE){ %>
		<br><input type="text" value="" name="<%=i%>">			
	<%}else if(type == Constants.FILL_IN_BLANK){ %>
		<input type="text" value="" name="<%=i%>">	
	<%}else if (type == Constants.MULT_CHOICE){%>
		<!--  Cycle through choices and output ones corresponding to the question -->
		<%
		ArrayList<String> choices2 = q.getChoices(i);
		int choicesSize = choices2.size();
		
		for (int j=0; j<choicesSize; j++){ %>
			<!-- Output radio button for multiple choice and choice String-->
			<br>
			<input type="radio" name="<%=i %>" value="<%=choices2.get(j)%>"><%=choices2.get(j)%>
			<% 
		}%>
	<%} else if (type == Constants.PICTURE_RESPONSE){%>
		<!-- Cycle through choices to find picture URL-->
		<% 
		String picture = q.getQuestion(i);
		
		%>
		<!-- Output picture and blank text box-->
		<img src="<%=picture%>" height="300" width="300">
		<br><input type="text" value="" name="<%=i%>">
		
	<!-- Question type 5 multi text response -->	
	<%} else if (type == Constants.MULTI_TEXT_RESPONSE){%>
		<!-- choices contains inputs the number of inputs-->
		<!-- each time a corresponding entry is found in choices, output a text box-->
		<%
		ArrayList<String> choices2 = q.getChoices(i);
		int choicesSize = choices2.size();
		
		int nameNum = 0;
		for (int j=0; j<choicesSize; j++){ 
		%>
			<br><input type="text" value="" name="<%=i + "-" + nameNum%>">	
			<% nameNum++; %>
		<%	
		}
		%>
	<%} else if (type == Constants.MULTI_CHOICE_ANSWER){%>
		<!-- For each choice, output a checkbox and the name of the choice-->
		<%
		ArrayList<String> choices2 = q.getChoices(i);
		int choicesSize = choices2.size();
		int count = 0;
		for (int j=0; j<choicesSize; j++){ 
			%>
			<br><input type="checkbox" name="<%=i+"-"+count%>" value="<%=choices2.get(j)%>"><%=choices2.get(j)%>	
		<%	
			count++;
		}
		%>
	<%} else if (type == Constants.MATCHING){%>
		<!-- Count the number of choices for this question
			Find half that value, which is the number of choices with a selection box
			Either output a number or a selection box with each question.
		 -->
		<%
		ArrayList<String> choices2 = q.getChoices(i);
		int choicesSize = choices2.size();
		int optionsCount = choicesSize;
		int half = optionsCount / 2;
		int count = 0;
		int nameCount = 0;
		for (int j=0; j<choicesSize; j++) {
				count++;
				if(count<=half){ %>
					<br><%=count + ". " + choices2.get(j) %>	
				<%} else { %>
					<br>
					<select name = "<%=i+"-"+nameCount %>">
						<%for(int x=1; x<=half; x++){ %>
							<option value="<%= x%>"><%=x %></option>
						<%} %>
					</select>
					
					<%=choices2.get(j) %>
				<% nameCount++;
				} 
		}
		%>
		
		<%
		}
		%>
		
	 </p>
<input type="submit" value="Submit">
</form>

<script>
checkAnswer = function() {
	var corrAnswer = [];
	<% for (String s : q.getAnswers(i)) { %>
		corrAnswer.push("<%=s%>");
	<%}%>
	console.log(document.getElementsByName("<%=i%>"));
	var userAnswer = document.getElementsByName("<%=i%>")[0].value;
	<%
	if (type == Constants.MULT_CHOICE) { %>
		for (var i = 0; i < document.getElementsByName("<%=i%>").length; i++)  {
			if (document.getElementsByName("<%=i%>")[i].checked) {
				userAnswer = document.getElementsByName("<%=i%>")[i].value;
			}
		}
	<%}%>

	console.log(userAnswer);
	if (corrAnswer[0] === userAnswer) {
		alert("Correct!");
	}
	else {
		alert("Incorrect.");
	}
};

</script>
<%//TODO: only do this if immediate feedback%>
<%if(q.getImmediate()) { %>
	<button onclick="checkAnswer()">Check Answer</button>
<%} %>

<jsp:include page="<%=Constants.FOOTER_FILE%>"></jsp:include>





</body>
</html>