<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*, java.util.ArrayList, java.util.List"%>
<%@ page import="com.cs336.pkg.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Flight Information</title>
</head>
<body>
<%
	ApplicationDB db = new ApplicationDB();
    Connection con = null;
    Statement stmt = null;
    ResultSet result = null;

    try {
        // Get the database connection
        con = db.getConnection();

        // Create a SQL statement
        stmt = con.createStatement();

        // Get the price from the request
        int entity = Integer.parseInt(request.getParameter("price"));
        String str;

        if (entity == 300) {
            str = "SELECT f.flightNum, f.destinationdate, f.departuredate, f.price FROM flight f WHERE f.price <= 300 ORDER BY f.price";
        } else if (entity == 500) {
            str = "SELECT f.flightNum, f.destinationdate, f.departuredate, f.price FROM flight f WHERE f.price <= 500 ORDER BY f.price";
        } else {
            str = "SELECT f.flightNum, f.destinationdate, f.departuredate, f.price FROM flight f WHERE f.price >= 501 ORDER BY f.price";
        }

        // Run the query against the database.
        result = stmt.executeQuery(str);

        // Make an HTML table to show the results in:
%>
        <table>
            <tr>
                <td>Flight Number</td>
                <td>Destination Date</td>
                <td>Departure Date</td>
                <td>Price</td>
            </tr>
<%
        // Parse out the results
        while (result.next()) {
%>
            <tr>
                <td><%= result.getString("flightNum") %></td>
                <td><%= result.getString("destinationdate") %></td>
                <td><%= result.getString("departuredate") %></td>
                <td><%= result.getString("price") %></td>
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
        if (stmt != null) {
            try {
                stmt.close();
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
