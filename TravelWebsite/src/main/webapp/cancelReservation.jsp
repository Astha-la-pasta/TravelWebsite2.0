<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Cancel Flight</title>
</head>
<body>
    <%
        try {
            // Get the database connection
            ApplicationDB db = new ApplicationDB();    
            Connection con = db.getConnection();

            int ticketNum = Integer.parseInt(request.getParameter("ticketnum"));

            // Update the ticket to mark it as cancelled
            String updateQuery = "UPDATE ticket SET is_cancelled = 1 WHERE ticketNum=?";
            PreparedStatement updateStmt = con.prepareStatement(updateQuery);
            updateStmt.setInt(1, ticketNum);
            int rowsAffected = updateStmt.executeUpdate();

            // Check if the ticket was found and updated
            if (rowsAffected > 0) {
                // Retrieve the class type
                String selectQuery = "SELECT classtype FROM ticket WHERE ticketNum=?";
                PreparedStatement selectStmt = con.prepareStatement(selectQuery);
                selectStmt.setInt(1, ticketNum);
                ResultSet result = selectStmt.executeQuery();

                if (result.next()) {
                    // There is at least one row in the result set
                    String classname = result.getString("classtype");

                    // Display cancellation information
                    if ("BUSINESS".equals(classname)) {
                        out.print("Your ticket has been cancelled. No cancellation fee applied.");
                        out.print("<p><a href=\"success.jsp\">Back to Customer Page</a></p>");
                    } else {
                        out.print("Your ticket has been cancelled. Cancellation fee applied.");
                        out.print("<p><a href=\"success.jsp\">Back to Customer Page</a></p>");
                    }
                } else {
                    // The result set is empty, handle accordingly
                    out.print("Invalid ticket number or no results found.");
                    out.print("<p><a href=\"success.jsp\">Back to Customer Page</a></p>");
                }

                // Close resources
                result.close();
                selectStmt.close();
            } else {
                out.print("Ticket not found or already cancelled.");
                out.print("<p><a href=\"success.jsp\">Back to Customer Page</a></p>");
            }

            // Close resources
            updateStmt.close();
            con.close();
        } catch (Exception e) {
            out.print(e);
        }
    %>
</body>
</html>
