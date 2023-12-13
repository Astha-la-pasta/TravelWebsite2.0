<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.cs336.pkg.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Results</title>
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
            String lname = request.getParameter("entity");
            String query = "SELECT u.cid, u.lastname, u.firstname, t.ticketNum, f.airlineid, t.datebought, t.fare, f.departuredate, f.destinationdate, f.departureairport, f.destinationairport " +
                           "FROM ticket t JOIN flight f ON (f.flightNum=t.flightNum) JOIN users u ON (t.cid=u.cid) WHERE u.cid='" + lname + "'";

            // Run the query against the database
            result = stmt.executeQuery(query);

            // Display the HTML table header
            out.print("<table border='1'>");
            out.print("<tr><th>CID</th><th>Last Name</th><th>First Name</th><th>Ticket Num</th><th>Airline ID</th><th>Date Bought</th><th>Fare</th><th>Departure Date</th><th>Destination Date</th><th>Departure Airport</th><th>Destination Airport</th></tr>");

            // Parse out the results and display in the table
            while (result.next()) {
                out.print("<tr>");
                out.print("<td>" + result.getString("cid") + "</td>");
                out.print("<td>" + result.getString("lastname") + "</td>");
                out.print("<td>" + result.getString("firstname") + "</td>");
                out.print("<td>" + result.getString("ticketNum") + "</td>");
                out.print("<td>" + result.getString("airlineid") + "</td>");
                out.print("<td>" + result.getString("datebought") + "</td>");
                out.print("<td>" + result.getString("fare") + "</td>");
                out.print("<td>" + result.getString("departuredate") + "</td>");
                out.print("<td>" + result.getString("destinationdate") + "</td>");
                out.print("<td>" + result.getString("departureairport") + "</td>");
                out.print("<td>" + result.getString("destinationairport") + "</td>");
                out.print("</tr>");
            }

            out.print("</table>");
        } catch (Exception e) {
            out.print("An error occurred: " + e.getMessage());
        } finally {
            // Close resources in the reverse order of their creation
            try { if (result != null) result.close(); } catch (SQLException e) { /* ignored */ }
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { /* ignored */ }
            try { if (con != null) con.close(); } catch (SQLException e) { /* ignored */ }
        }
    %>
</body>
</html>
