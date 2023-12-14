<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Revenue Results</title>
</head>
<body>
    <%
        Connection con = null;
        Statement stmt = null;
        ResultSet result = null;

        try {
            // Get the database connection
            ApplicationDB db = new ApplicationDB();
            con = db.getConnection();

            // Create a SQL statement
            stmt = con.createStatement();
            String airline = request.getParameter("entity");
            String query = "SELECT a.airlineid, a.name, f.flightNum, DATE_FORMAT(t.datebought, '%Y-%m') AS booking_mth, " +
                           "SUM(CASE WHEN t.isflexible = 0 THEN (t.bookingcost + t.fare) ELSE (t.bookingcost + t.cancelfee) END) AS revenue " +
                           "FROM ticket t JOIN flight f ON (t.flightNum = f.flightNum) JOIN airlinecompany a ON (a.airlineid = f.airlineid) " +
                           "WHERE a.airlineid='" + airline + "' GROUP BY a.airlineid, a.name, f.flightNum, booking_mth";

            // Run the query against the database
            result = stmt.executeQuery(query);

            // Display the HTML table header
            out.print("<table>");
            out.print("<tr><th>Airline ID</th><th>Airline Name</th><th>Flight Number</th><th>Booking Month</th><th>Revenue</th></tr>");

            // Parse out the results and display in the table
            while (result.next()) {
                out.print("<tr>");
                out.print("<td>" + result.getString("airlineid") + "</td>");
                out.print("<td>" + result.getString("name") + "</td>");
                out.print("<td>" + result.getString("flightNum") + "</td>");
                out.print("<td>" + result.getString("booking_mth") + "</td>");
                out.print("<td>" + result.getString("revenue") + "</td>");
                out.print("</tr>");
            }

            out.print("</table>");
        } catch (Exception e) {
            out.print("An error occurred: " + e.getMessage());
            e.printStackTrace(); // Print the stack trace for debugging
        } finally {
            // Close resources in the reverse order of their creation
            try { if (result != null) result.close(); } catch (SQLException e) { /* ignored */ }
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { /* ignored */ }
            try { if (con != null) con.close(); } catch (SQLException e) { /* ignored */ }
        }
    %>
</body>
</html>
