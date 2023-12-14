<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
try {
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();

    String customerId = request.getParameter("customerId");

    // Delete related records in the employee_responses table
    String deleteEmployeeResponsesQuery = "DELETE FROM employee_responses WHERE question_id IN (SELECT question_id FROM user_questions WHERE cid=?)";
    PreparedStatement deleteEmployeeResponsesStmt = con.prepareStatement(deleteEmployeeResponsesQuery);
    deleteEmployeeResponsesStmt.setString(1, customerId);
    deleteEmployeeResponsesStmt.executeUpdate();

    // Delete related records in the user_questions table
    String deleteUserQuestionsQuery = "DELETE FROM user_questions WHERE cid=?";
    PreparedStatement deleteUserQuestionsStmt = con.prepareStatement(deleteUserQuestionsQuery);
    deleteUserQuestionsStmt.setString(1, customerId);
    deleteUserQuestionsStmt.executeUpdate();

    // Delete related records in the ticket table
    String deleteTicketQuery = "DELETE FROM ticket WHERE cid=?";
    PreparedStatement deleteTicketStmt = con.prepareStatement(deleteTicketQuery);
    deleteTicketStmt.setString(1, customerId);
    deleteTicketStmt.executeUpdate();

    // Now, delete the customer
    String deleteCustomerQuery = "DELETE FROM users WHERE cid=?";
    PreparedStatement deleteCustomerStmt = con.prepareStatement(deleteCustomerQuery);
    deleteCustomerStmt.setString(1, customerId);
    deleteCustomerStmt.executeUpdate();

    out.print("The customer and related records have been deleted.");
    out.print("<p><a href=\"successadmin.jsp\">Admin page</a></p>");

    con.close();
} catch (Exception e) {
    out.print("Error in delete: " + e.getMessage());
    out.print("<p><a href=\"successadmin.jsp\">Admin page</a></p>");
}
%>
