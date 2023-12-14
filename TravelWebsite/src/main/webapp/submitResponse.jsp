<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*, java.util.*, java.sql.*"%>
<%@ page import="javax.servlet.http.*, javax.servlet.*"%>

<%
    if (session.getAttribute("user") == null) {
%>
    You are not logged in<br/>
    <a href="index.jsp">Please Login</a>
<%
    } else {
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        // Get form parameters
        int questionId = Integer.parseInt(request.getParameter("questionId"));
        String responseText = request.getParameter("responseText");

        // Retrieve the employee ID from the session
        String eidString = (String) session.getAttribute("eid");
        int eid = 0; // default value or handle differently based on your requirement

        if (eidString != null) {
            try {
                eid = Integer.parseInt(eidString);
            } catch (NumberFormatException e) {
                // Handle the exception (e.g., log it, set a default value, etc.)
            }
        }

        try {
            // Insert the response into the database
            PreparedStatement pst = con.prepareStatement("INSERT INTO employee_responses (question_id, eid, response_text, response_date) VALUES (?, ?, ?, ?)");
            pst.setInt(1, questionId);
            pst.setInt(2, eid);
            pst.setString(3, responseText);
            pst.setDate(4, new java.sql.Date(System.currentTimeMillis()));
            pst.executeUpdate();
%>
    Response submitted successfully. <a href="successemp.jsp">Back to Home</a>
<%
        } catch (SQLException e) {
            e.printStackTrace();
%>
    Error submitting the response. Please try again. <a href="respondToQuestion.jsp">Back to Response</a>
<%
        } finally {
            // Close the database connection
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
%>
