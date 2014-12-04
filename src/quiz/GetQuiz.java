package quiz;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class GetQuiz
 */
@WebServlet("/GetQuiz")
public class GetQuiz extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GetQuiz() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		session.setAttribute("timeTaken",new Date().getTime());
		int quizNumber = Integer.parseInt(request.getParameter("num"));
		session.setAttribute("zID", quizNumber);
		Quiz q = null;
		try {
			q = new Quiz(quizNumber);
		}
		catch (SQLException e){
			//bad news
		}
		boolean multiple = q.getMultiple(); 
		if (multiple) {
			ArrayList<String> answers = new ArrayList<String>();
			session.setAttribute("answers", answers);
			request.setAttribute("qNumber", 0);
			RequestDispatcher dispatch = request.getRequestDispatcher("singlePageQuiz.jsp");
			dispatch.forward(request, response);
		}
		else {
			RequestDispatcher dispatch = request.getRequestDispatcher("quiz.jsp");
			dispatch.forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}

/*} catch (SQLException e) {
e.printStackTrace();
} finally {
Database.closeConnections(con, statement, rs);
}*/

/*Connection con = null;
Statement statement = null;
ResultSet rs = null;
try {
	con = Database.openConnection();
	statement = Database.getStatement(con);


	// Query for questions
	ArrayList<String> questions = new ArrayList<String>();
	ArrayList<Integer> types = new ArrayList<Integer>();

	rs = statement.executeQuery("SELECT * FROM questions WHERE zID='" + quizNumber + "' ORDER BY sID");
	while (rs.next()) {
		questions.add(rs.getString("question"));
		types.add(rs.getInt("type"));
	}

	request.setAttribute("questions", questions);
	request.setAttribute("types", types);
	session.setAttribute("types", types);

	// Query for choices
	ArrayList<String> choices = new ArrayList<String>();
	ArrayList<Integer> choicesTo = new ArrayList<Integer>();

	rs = statement.executeQuery("SELECT * FROM choices WHERE zID=" + quizNumber + " ORDER BY sID");
	while(rs.next()){
		choices.add(rs.getString("choice"));
		choicesTo.add(rs.getInt("sID"));
	}

	request.setAttribute("choices", choices);
	request.setAttribute("choicesTo", choicesTo);		

	// Query for answers
	ArrayList<String> answers = new ArrayList<String>();
	ArrayList<Integer> answersTo = new ArrayList<Integer>();

	rs = statement.executeQuery("SELECT * FROM answers WHERE zID='" + quizNumber + "' ORDER BY sID");
	while(rs.next()){
		answers.add(rs.getString("answer"));
		answersTo.add(rs.getInt("sID"));
	}

	session.setAttribute("answers", answers);
	session.setAttribute("answersTo", answersTo);

 */