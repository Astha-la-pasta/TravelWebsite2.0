<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Waiting List Confirmation</title>
</head>
<body>
    <%
        try {
            // Get the database connection
            ApplicationDB db = new ApplicationDB();    
            Connection con = db.getConnection();    

            // Get parameters from the request
            String ticketNum = request.getParameter("ticketNum");
            int cid = Integer.parseInt(request.getParameter("cid"));

            // Create a SQL statement
            String insertQuery = "INSERT INTO ticket (waitlist, cid) VALUES (?, ?)";
            
            // Create a Prepared SQL statement
            PreparedStatement ps = con.prepareStatement(insertQuery);

            // Set parameters of the query
            ps.setBoolean(1, true); // Assuming 'waitlist' is a boolean column
            ps.setInt(2, cid);

            // Run the query against the DB
            ps.executeUpdate();

            // Close the connection
            con.close();
            out.print("You have been added to the waiting list");
            out.print("<p><a href=\"success.jsp\">Back to Customer Page</a></p>");
        } catch (SQLException e) {
            out.print("Error: " + e.getMessage());
            out.print("<p><a href=\"success.jsp\">Back to Customer Page</a></p>");
        } catch (Exception e) {
            out.print("An unexpected error occurred.");
            out.print("<p><a href=\"success.jsp\">Back to Customer Page</a></p>");
            e.printStackTrace();
        }
    %>
</body>
</html>
