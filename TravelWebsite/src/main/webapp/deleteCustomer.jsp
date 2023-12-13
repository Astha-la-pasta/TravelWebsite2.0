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
        
        // Delete related records in the ticket table first
        String deleteTicketQuery = "DELETE FROM ticket WHERE cid=?";
        PreparedStatement deleteTicketStmt = con.prepareStatement(deleteTicketQuery);
        deleteTicketStmt.setString(1, customerId);
        deleteTicketStmt.executeUpdate();

        // Now, delete the customer
        String deleteCustomerQuery = "DELETE FROM users WHERE cid=?";
        PreparedStatement deleteCustomerStmt = con.prepareStatement(deleteCustomerQuery);
        deleteCustomerStmt.setString(1, customerId);
        deleteCustomerStmt.executeUpdate();
        
        out.print("The customer and related tickets have been deleted.");

        con.close();
    } catch (Exception e) {
        out.print("Error in delete: " + e.getMessage());
    }
%>
