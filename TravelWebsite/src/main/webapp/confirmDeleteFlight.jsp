<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Confirm delete flight</title>
</head>
<body>
    <%
        try {
            // Get the database connection
            ApplicationDB db = new ApplicationDB();    
            Connection con = db.getConnection();
            
            // Validate and sanitize input
            String flightNumParam = request.getParameter("flightNum");
            if (flightNumParam == null || flightNumParam.isEmpty()) {
                throw new IllegalArgumentException("Flight number is required.");
            }

            // Check if there are associated tickets
            String ticketCheckQuery = "SELECT COUNT(*) FROM ticket WHERE flightNum=?";
            try (PreparedStatement ticketCheckStmt = con.prepareStatement(ticketCheckQuery)) {
                int flightNum = Integer.parseInt(flightNumParam);
                ticketCheckStmt.setInt(1, flightNum);
                
                try (ResultSet ticketCheckResult = ticketCheckStmt.executeQuery()) {
                    if (ticketCheckResult.next() && ticketCheckResult.getInt(1) > 0) {
                        // Delete associated tickets
                        String deleteTicketsQuery = "DELETE FROM ticket WHERE flightNum=?";
                        try (PreparedStatement deleteTicketsStmt = con.prepareStatement(deleteTicketsQuery)) {
                            deleteTicketsStmt.setInt(1, flightNum);
                            deleteTicketsStmt.executeUpdate();
                        }
                    }
                }
            }

            // Delete the flight
            String deleteQuery = "DELETE FROM flight WHERE flightNum=?";
            try (PreparedStatement deleteStmt = con.prepareStatement(deleteQuery)) {
                int flightNum = Integer.parseInt(flightNumParam);
                deleteStmt.setInt(1, flightNum);
                
                // Run the query against the database.
                int rowsAffected = deleteStmt.executeUpdate();
                
                if (rowsAffected > 0) {
                    out.print("The flight has been deleted.");
                    out.print("<p><a href=\"successemp.jsp\">Customer Rep Home</a></p>");
                } else {
                    out.print("Flight not found or already deleted.");
                    out.print("<p><a href=\"successemp.jsp\">Customer Rep Home</a></p>");
                }
            }

            // Close the connection.
            con.close();
        } catch (Exception e) {
            // Log the exception
            e.printStackTrace();
            out.print("Error in delete: " + e.getMessage());
            out.print("<p><a href=\"successemp.jsp\">Customer Rep Home</a></p>");
        }
    %>

</body>
</html>
