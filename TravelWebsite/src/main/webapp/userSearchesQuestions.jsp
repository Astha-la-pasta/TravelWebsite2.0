<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.cs336.pkg.*" %>

<%
    // Your existing code above this line
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();

    // Retrieve user's CID from the session attribute
    String userCID = (String) session.getAttribute("userCID");

    // Code to handle searching for user questions and predefined questions
    String keyword = request.getParameter("keyword");

    // Search predefined questions
    String predefinedQuestionQuery;
    if (keyword != null && !keyword.isEmpty()) {
        predefinedQuestionQuery = "SELECT * FROM predefined_questions WHERE question_text LIKE ?";
    } else {
        predefinedQuestionQuery = "SELECT * FROM predefined_questions";
    }

    try (PreparedStatement predefinedQuestionStmt = con.prepareStatement(predefinedQuestionQuery)) {
        if (keyword != null && !keyword.isEmpty()) {
            predefinedQuestionStmt.setString(1, "%" + keyword + "%");
        }

        ResultSet predefinedQuestionResult = predefinedQuestionStmt.executeQuery();

        // Display predefined questions and corresponding answers
        if (predefinedQuestionResult.next()) {
        	predefinedQuestionResult.beforeFirst();
        	out.println("<h3>Common Questions</h3>");
        	
        }
        while (predefinedQuestionResult.next()) {
            String questionText = predefinedQuestionResult.getString("question_text");
            int questionId = predefinedQuestionResult.getInt("question_id");

            // Fetch and display the corresponding answer
            String answerQuery = "SELECT response_text FROM predefined_responses WHERE question_id = ?";
            try (PreparedStatement answerStmt = con.prepareStatement(answerQuery)) {
                answerStmt.setInt(1, questionId);
                ResultSet answerResult = answerStmt.executeQuery();

                // Display question and answer
                out.println(questionText + "<br/>");
                while (answerResult.next()) {
                    out.println("<b>Answer:</b> " + answerResult.getString("response_text") + "<br/>" + "<br/>");
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    // Search user questions
    String userQuestionQuery;
    if (keyword != null && !keyword.isEmpty()) {
        userQuestionQuery = "SELECT * FROM user_questions WHERE question_text LIKE ?";
    } else {
        userQuestionQuery = "SELECT * FROM user_questions";
    }

    try (PreparedStatement userQuestionStmt = con.prepareStatement(userQuestionQuery)) {
        if (keyword != null && !keyword.isEmpty()) {
            userQuestionStmt.setString(1, "%" + keyword + "%");
        }

        ResultSet userQuestionResult = userQuestionStmt.executeQuery();

        // Display user questions and corresponding answers
        if (userQuestionResult.next()) {
            out.println("<h3>Customer Questions</h3>");
            userQuestionResult.beforeFirst();

            while (userQuestionResult.next()) {
                String userQuestionText = userQuestionResult.getString("question_text");
                int userQuestionId = userQuestionResult.getInt("question_id");

                // Fetch and display the corresponding answer from employee_responses
                String answerQuery = "SELECT response_text FROM employee_responses WHERE question_id = ?";
                try (PreparedStatement answerStmt = con.prepareStatement(answerQuery)) {
                    answerStmt.setInt(1, userQuestionId);
                    ResultSet answerResult = answerStmt.executeQuery();

                    // Display question and answer
                    out.println(userQuestionText + "<br/>");
                    while (answerResult.next()) {
                        out.println("<b>Answer:</b> " + answerResult.getString("response_text") + "<br/>" + "<br/>");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } else {
            out.println("<p>No user questions asked yet.</p>");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    
 // Search user questions with matching CID
    String myQuestionQuery;
    if (keyword != null && !keyword.isEmpty()) {
        myQuestionQuery = "SELECT * FROM user_questions WHERE cid = ? AND question_text LIKE ?";
    } else {
        myQuestionQuery = "SELECT * FROM user_questions WHERE cid = ?";
    }

    try (PreparedStatement myQuestionStmt = con.prepareStatement(myQuestionQuery)) {
        myQuestionStmt.setString(1, userCID);

        if (keyword != null && !keyword.isEmpty()) {
            myQuestionStmt.setString(2, "%" + keyword + "%");
        }

        ResultSet myQuestionResult = myQuestionStmt.executeQuery();

        // Display user questions and corresponding answers
        if (myQuestionResult.next()) {
            out.println("<h3>My Questions</h3>");
            myQuestionResult.beforeFirst();

            while (myQuestionResult.next()) {
                String myQuestionText = myQuestionResult.getString("question_text");
                int myQuestionId = myQuestionResult.getInt("question_id");

                // Fetch and display the corresponding answer from employee_responses
                String answerQuery = "SELECT response_text FROM employee_responses WHERE question_id = ?";
                try (PreparedStatement answerStmt = con.prepareStatement(answerQuery)) {
                    answerStmt.setInt(1, myQuestionId);
                    ResultSet answerResult = answerStmt.executeQuery();

                    // Display question and answer
                    out.println(myQuestionText + "<br/>");
                    while (answerResult.next()) {
                        out.println("<b>Answer:</b> " + answerResult.getString("response_text") + "<br/>" + "<br/>");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } else {
            out.println("<p>You have not asked any questions yet.</p>");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Questions</title>
</head>
<body>

    <!-- Add a section for searching user and predefined questions by keyword -->
    <br>
    <br>
    <form method="get" action="userSearchesQuestions.jsp" style="margin-top: 10px;">
        <label for="keyword">Search User and Predefined Questions:</label>
        <input type="text" id="keyword" name="keyword">
        <input type="submit" value="Search">
    </form>

    <!-- Form to allow the user to ask a question -->
    <h3>Ask a Question</h3>
    <form method="post" action="askQuestion.jsp">
        <label for="userQuestion">Your Question:</label>
        <textarea id="userQuestion" name="userQuestion" rows="4" cols="50"></textarea><br/>
        <input type="submit" value="Ask">
    </form>

	<p>
		User:
		<%=session.getAttribute("user")%>
		CID:
		<%=session.getAttribute("userCID")%></p>
	<p>
		<a href="success.jsp">Home</a>
	</p>

</body>
</html>
