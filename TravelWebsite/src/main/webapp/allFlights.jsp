<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>View Flights by Airport</title>
</head>
<body>
    <%
        try {
            // Get the database connection
            ApplicationDB db = new ApplicationDB();
            try (Connection con = db.getConnection()) {
                // Create a SQL statement
                String entity = request.getParameter("airport");
                String str = "SELECT airlineid, flightNum, departureairport, destinationairport, departuredate, destinationdate FROM flight WHERE departureairport = ? OR destinationairport = ?";

                try (PreparedStatement pstmt = con.prepareStatement(str)) {
                    pstmt.setString(1, entity);
                    pstmt.setString(2, entity);

                    // Run the query against the database.
                    try (ResultSet result = pstmt.executeQuery()) {
                        // Make an HTML table to show the results in:
                        out.print("<table border='1'>");
                        out.print("<tr>");
                        out.print("<td>Airline ID</td>");
                        out.print("<td>Flight Num</td>");
                        out.print("<td>Departure Airport</td>");
                        out.print("<td>Destination Airport</td>");
                        out.print("<td>Departure Date</td>");
                        out.print("<td>Destination Date</td>");
                        out.print("</tr>");

                        // Parse out the results
                        while (result.next()) {
                            out.print("<tr>");
                            out.print("<td>" + result.getString("airlineid") + "</td>");
                            out.print("<td>" + result.getString("flightNum") + "</td>");
                            out.print("<td>" + result.getString("departureairport") + "</td>");
                            out.print("<td>" + result.getString("destinationairport") + "</td>");
                            out.print("<td>" + result.getString("departuredate") + "</td>");
                            out.print("<td>" + result.getString("destinationdate") + "</td>");
                            out.print("</tr>");
                        }
                        out.print("</table>");
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
</body>
</html>
