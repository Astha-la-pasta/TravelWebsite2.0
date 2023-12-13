<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*, java.util.*, java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Flight Information</title>
</head>
<body>
<%
    Connection con = null;
    PreparedStatement preparedStatement = null;
    ResultSet result = null;

    try {
        // Get the database connection
        ApplicationDB db = new ApplicationDB();
        con = db.getConnection();

        // Create a SQL statement with prepared statement to prevent SQL injection
        String query = "SELECT t.ticketNum, f.stops, f.flightNum, f.departuredate, f.destinationdate, f.price, t.is_cancelled, t.waitlist " +
                "FROM flight f JOIN ticket t ON f.flightNum = t.flightNum " +
                "WHERE f.stops = ? " +
                "ORDER BY f.flightNum";
        preparedStatement = con.prepareStatement(query);

        // Get the number of stops from the request
        int entity = Integer.parseInt(request.getParameter("stops"));
        preparedStatement.setInt(1, entity);

        // Run the query against the database.
        result = preparedStatement.executeQuery();
%>
        <table>
            <tr>
                <td>Number of Stops</td>
                <td>Flight Number</td>
                <td>Departure Date</td>
                <td>Destination Date</td>
                <td>Price</td>
                <td>Cancellation Status</td>
                <td>Waitlist Status</td>
            </tr>
<%
        // Parse out the results
        while (result.next()) {
%>
            <tr>
                <td><%= result.getString("stops") %></td>
                <td><%= result.getString("flightNum") %></td>
                <td><%= result.getString("departuredate") %></td>
                <td><%= result.getString("destinationdate") %></td>
                <td><%= result.getString("price") %></td>
                <td><%= result.getBoolean("is_cancelled") ? "Cancelled" : "Not Cancelled" %></td>
                <td><%= result.getBoolean("waitlist") ? "On Waitlist" : "Not on Waitlist" %></td>
            </tr>
<%
        }
%>
        </table>
<%
    } catch (SQLException e) {
        // Handle database-related exceptions
        out.println("An error occurred: " + e.getMessage());
    } catch (Exception e) {
        // Handle other exceptions
        out.println("An error occurred: " + e.getMessage());
    } finally {
        // Close resources in the reverse order of their creation
        if (result != null) {
            try {
                result.close();
            } catch (SQLException ignored) {
            }
        }
        if (preparedStatement != null) {
            try {
                preparedStatement.close();
            } catch (SQLException ignored) {
            }
        }
        if (con != null) {
            try {
                con.close();
            } catch (SQLException ignored) {
            }
        }
    }
%>
</body>
</html>
