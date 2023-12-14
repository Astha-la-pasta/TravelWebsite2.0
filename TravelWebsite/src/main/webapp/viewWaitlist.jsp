<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*, java.util.*"%>
<%@ page import="com.cs336.pkg.ApplicationDB"%>

<%
    // Retrieve the selected flight number from the form
    String selectedFlightNum = request.getParameter("flightNum");

    // Perform database operations to retrieve passengers on the waitlist
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();

    // Use a PreparedStatement to prevent SQL injection
    PreparedStatement ps = con.prepareStatement("SELECT * FROM ticket WHERE flightNum = ? AND waitlist = true");
    ps.setInt(1, Integer.parseInt(selectedFlightNum));

    ResultSet rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>View Waitlist</title>
</head>
<body>

<h2>Passengers on Waitlist for Flight <%= selectedFlightNum %></h2>

<%
    // Display the waitlist information
    while (rs.next()) {
%>
    <p>
        Passenger ID: <%= rs.getInt("cid") %><br/>
        Ticket Number: <%= rs.getInt("ticketNum") %><br/>
        Seat Number: <%= rs.getInt("seatnum") %><br/>
        Class Type: <%= rs.getString("classtype") %><br/>
        <!-- Add more information as needed -->
    </p>
<%
    }
%>

<%
    // Close the database resources
    rs.close();
    ps.close();
    con.close();
%>

</body>
</html>
