<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Top Customer Revenue</title>
</head>
<body>
    <%
        try {
            // Get the database connection
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();
            
            // Create a SQL statement
            Statement stmt = con.createStatement();
            String str = "SELECT c.cid, c.lastname, c.firstname, " +
                         "SUM(CASE WHEN t.isflexible = 0 THEN (t.bookingcost + t.fare) ELSE (t.bookingcost + t.cancelfee) END) AS revenue " +
                         "FROM ticket t JOIN users c ON (c.cid = t.cid) " +
                         "GROUP BY c.cid, c.lastname, c.firstname ORDER BY revenue DESC LIMIT 1";
            
            // Run the query against the database
            ResultSet result = stmt.executeQuery(str);

            // Display the HTML table header
            out.print("<table>");
            out.print("<tr><th>CID</th><th>Last Name</th><th>First Name</th><th>Total Revenue</th></tr>");

            // Parse out the results and display in the table
            while (result.next()) {
                out.print("<tr>");
                out.print("<td>" + result.getString("cid") + "</td>");
                out.print("<td>" + result.getString("lastname") + "</td>");
                out.print("<td>" + result.getString("firstname") + "</td>");
                out.print("<td>" + result.getString("revenue") + "</td>");
                out.print("</tr>");
            }

            out.print("</table>");

            // Close the connection
            con.close();
        } catch (Exception e) {
            out.print("An error occurred: " + e.getMessage());
            e.printStackTrace(); // Print the stack trace for debugging
        }
    %>
</body>
</html>
