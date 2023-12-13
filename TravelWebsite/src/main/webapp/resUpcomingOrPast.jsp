<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>View Reservations</title>
</head>
<body>
    <%
        try {
            // Get the database connection
            ApplicationDB db = new ApplicationDB();    
            Connection con = db.getConnection();
            
            // Create a SQL statement
            Statement stmt = con.createStatement();
            String entity = request.getParameter("timing");
            int customerid = Integer.parseInt(request.getParameter("cid"));
            String str = null;

            if (entity.equals("past")) {
                str = "SELECT t.ticketNum, " +
                        "(CASE WHEN t.waitlist = 1 THEN ('On Waiting List') ELSE ('Confirmed') END) AS tStatus, " +
                        "(CASE WHEN t.is_oneway = 1 THEN ('One-way') ELSE ('Round-trip') END) AS resType, " +
                        "f.departuredate, f.destinationdate, f.departureairport, f.destinationairport, " +
                        "f.airlineid, t.seatnum, t.fare, t.is_cancelled " +
                        "FROM ticket t JOIN flight f ON t.flightNum=f.flightNum " +
                        "WHERE f.departuredate < sysdate() AND cid=?";
            } else {
                str = "SELECT t.ticketNum, " +
                        "(CASE WHEN t.waitlist = 1 THEN ('On Waiting List') ELSE ('Confirmed') END) AS tStatus, " +
                        "(CASE WHEN t.is_oneway = 1 THEN ('One-way') ELSE ('Round-trip') END) AS resType, " +
                        "f.departuredate, f.destinationdate, f.departureairport, f.destinationairport, " +
                        "f.airlineid, t.seatnum, t.fare, t.is_cancelled " +
                        "FROM ticket t JOIN flight f ON t.flightNum=f.flightNum " +
                        "WHERE f.departuredate >= sysdate() AND cid=?";
            }

            try (PreparedStatement preparedStatement = con.prepareStatement(str)) {
                preparedStatement.setInt(1, customerid);

                // Run the query against the database
                ResultSet result = preparedStatement.executeQuery();

                // Make an HTML table to show the results in
                out.print("<table>");

                // Make a row for table headers
                out.print("<tr>");
                out.print("<td>Ticket Num</td>");
                out.print("<td>Ticket Status</td>");
                out.print("<td>Reservation Type</td>");
                out.print("<td>Departure Date</td>");
                out.print("<td>Destination Date</td>");
                out.print("<td>Departure Airport</td>");
                out.print("<td>Destination Airport</td>");
                out.print("<td>Airline ID</td>");
                out.print("<td>Seat Num</td>");
                out.print("<td>Fare</td>");
                out.print("<td>Cancellation Status</td>"); //Added column for cancellation status 
                out.print("</tr>");

                // Parse out the results and display in the HTML table
                while (result.next()) {
                    out.print("<tr>");
                    out.print("<td>" + result.getString("ticketNum") + "</td>");
                    out.print("<td>" + result.getString("tStatus") + "</td>");
                    out.print("<td>" + result.getString("resType") + "</td>");
                    out.print("<td>" + result.getString("departuredate") + "</td>");
                    out.print("<td>" + result.getString("destinationdate") + "</td>");
                    out.print("<td>" + result.getString("departureairport") + "</td>");
                    out.print("<td>" + result.getString("destinationairport") + "</td>");
                    out.print("<td>" + result.getString("airlineid") + "</td>");
                    out.print("<td>" + result.getString("seatnum") + "</td>");
                    out.print("<td>" + result.getString("fare") + "</td>");
                    out.print("<td>" + (result.getBoolean("is_cancelled") ? "Cancelled" : "Not Cancelled") + "</td>");
                    out.print("</tr>");
                }
                out.print("</table>");
            } catch (SQLException e) {
                out.print("An error occurred: " + e.getMessage());
            } finally {
                // Close the connection
                con.close();
            }
        } catch (Exception e) {
            out.print("An error occurred: " + e.getMessage());
        }
    %>
</body>
</html>
