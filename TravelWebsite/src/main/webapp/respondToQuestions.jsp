<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.util.Map.Entry"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%
    if (session.getAttribute("user") == null) {
%>
    You are not logged in<br/>
    <a href="index.jsp">Please Login</a>
<%
    } else {
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
%>
    Welcome <%=session.getAttribute("user")%><br/>
    <a href='logout.jsp'>Log out</a><br/>

    <h2>Respond to User Questions</h2>
    <form action="submitResponse.jsp" method="POST">
        <label for="questionId">Select Question:</label>
        <select name="questionId">
            <%
                Statement stQuestions = con.createStatement();
                ResultSet rsQuestions = stQuestions.executeQuery("SELECT * FROM user_questions");

                while (rsQuestions.next()) {
            %>
                    <option value="<%=rsQuestions.getInt("question_id")%>"><%=rsQuestions.getString("question_text")%></option>
            <%
                }
            %>
        </select><br/>

        <label for="responseText">Your Response:</label><br/>
        <textarea name="responseText" rows="4" cols="50"></textarea><br/>

        <input type="submit" value="Submit Response"/>
    </form>

<%
    }
%>
