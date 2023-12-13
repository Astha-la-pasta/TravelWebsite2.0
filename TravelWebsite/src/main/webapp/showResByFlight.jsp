<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Flight and Ticket Information</title>
</head>
<body>
    <%
        try {
            // Get the database connection
            ApplicationDB db = new ApplicationDB();    
            Connection con = db.getConnection();
            
            // Create a SQL statement
            Statement stmt = con.createStatement();
            
            // Get the flight number from the request parameter
            int flightNum = Integer.parseInt(request.getParameter("entity"));
            
            // Query to get all ticket and flight information for a specific flight number
            String query = "SELECT f.flightNum, t.ticketNum, t.cid, t.isflexible, t.bookingcost, t.cancelfee, t.seatnum, t.fare, t.datebought, t.is_oneway, t.waitlist, t.is_roundtrip, t.classtype, t.is_cancelled, f.departuredate, f.destinationdate, f.departureairport, f.destinationairport, f.isinternational, f.isdomestic, f.price, f.stops, f.aircraftid, f.airlineid FROM ticket t JOIN flight f ON (f.flightNum = t.flightNum) WHERE f.flightNum=" + flightNum;
            
            // Run the query against the database
            ResultSet result = stmt.executeQuery(query);

            // Make an HTML table to show the results
            out.print("<table border='1'>");

            // Header row
            out.print("<tr>");
            ResultSetMetaData metaData = result.getMetaData();
            int columnCount = metaData.getColumnCount();
            for (int i = 1; i <= columnCount; i++) {
                out.print("<th>" + metaData.getColumnName(i) + "</th>");
            }
            out.print("</tr>");

            // Data rows
            while (result.next()) {
                out.print("<tr>");
                for (int i = 1; i <= columnCount; i++) {
                    out.print("<td>" + result.getString(i) + "</td>");
                }
                out.print("</tr>");
            }

            out.print("</table>");

            // Close the connection
            con.close();
        } catch (Exception e) {
            out.print(e);
        }
    %>
</body>
</html>
