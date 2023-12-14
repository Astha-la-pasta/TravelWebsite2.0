<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.sql.*, java.io.*, java.util.*, com.cs336.pkg.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Update Flight</title>
</head>
<body>
    <h1>Update Flight Information</h1>

    <%
        // Retrieve form parameters
        String flightNum = request.getParameter("flightNum");
        String depDate = request.getParameter("depDate");
        String destDate = request.getParameter("destDate");
        String depAirport = request.getParameter("depAirport");
        String destAirport = request.getParameter("destAirport");
        String isInter = request.getParameter("isInter");
        String numStops = request.getParameter("numStops");
        String price = request.getParameter("price");
        String capacity = request.getParameter("capacity");
        String passengersBooked = request.getParameter("passengersBooked");

        ApplicationDB appdb = new ApplicationDB();
        Connection connection = appdb.getConnection();
        PreparedStatement preparedStatement = null;

        try {
            // Update flight details in the database
            String updateQuery = "UPDATE flight SET departuredate=?, destinationdate=?, departureairport=?, destinationairport=?, isinternational=?, stops=?, price=?, capacity=?, passengers_booked=? WHERE flightNum=?";
            preparedStatement = connection.prepareStatement(updateQuery);

            preparedStatement.setString(1, depDate);
            preparedStatement.setString(2, destDate);
            preparedStatement.setString(3, depAirport);
            preparedStatement.setString(4, destAirport);
            preparedStatement.setBoolean(5, Boolean.parseBoolean(isInter));
            preparedStatement.setInt(6, Integer.parseInt(numStops));
            preparedStatement.setFloat(7, Float.parseFloat(price));
            preparedStatement.setInt(8, Integer.parseInt(capacity));
            preparedStatement.setInt(9, Integer.parseInt(passengersBooked));
            preparedStatement.setInt(10, Integer.parseInt(flightNum));

            int rowsAffected = preparedStatement.executeUpdate();

            // Check if the update was successful
            if (rowsAffected > 0) {
    %>
    <p>Flight information updated successfully!</p>
    <%out.println("<p><a href=\"successemp.jsp\">Customer Rep Home</a></p>");%>
    
    <% } else { %>
    <p>Failed to update flight information.</p>
    <%out.println("<p><a href=\"successemp.jsp\">Customer Rep Home</a></p>");%>
    <% }
        } catch (SQLException e) {
            out.println("Error: " + e.getMessage());
            out.println("<p><a href=\"successemp.jsp\">Customer Rep Home</a></p>");
        } finally {
            // Close resources in the reverse order of their creation
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                out.println("Error closing resources: " + e.getMessage());
                out.println("<p><a href=\"successemp.jsp\">Customer Rep Home</a></p>");
            }
        }
    %>
</body>
</html>
