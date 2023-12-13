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

// Get the user's question from the form submission
String userQuestion = request.getParameter("userQuestion");

if (userCID != null && !userCID.isEmpty() && userQuestion != null && !userQuestion.isEmpty()) {
    // Insert the user's question into the user_questions table
    String insertQuestionQuery = "INSERT INTO user_questions (cid, question_text) VALUES (?, ?)";
    try (PreparedStatement insertQuestionStmt = con.prepareStatement(insertQuestionQuery)) {
        insertQuestionStmt.setString(1, userCID);
        insertQuestionStmt.setString(2, userQuestion);
        int rowsAffected = insertQuestionStmt.executeUpdate();

        if (rowsAffected > 0) {
            // Successful insertion
            out.println("<h3>Your question has been submitted successfully!</h3>");
        } else {
            // Failed insertion
            out.println("<h3>Failed to submit your question. Please try again.</h3>");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<h3>An error occurred. Please try again.</h3>");
    }
} else {
    out.println("<h3>Invalid user or question. Please try again.</h3>");
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Ask Question Result</title>
</head>
<body>
    <p><a href="userSearchesQuestions.jsp">Back to Question Page</a></p>
</body>
</html>
