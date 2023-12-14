<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.sql.*, java.io.*, java.util.*"%>
<%@ page import="com.cs336.pkg.ApplicationDB" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%
ApplicationDB db = new ApplicationDB();

int flightNum = Integer.parseInt(request.getParameter("flightNum"));
String departureDate = request.getParameter("depDate");
String destinationDate = request.getParameter("destDate");
String departureAirport = request.getParameter("depAirport");
String destinationAirport = request.getParameter("destAirport");
// Parse isInter as boolean instead of integer
boolean isInternational = Boolean.parseBoolean(request.getParameter("isInter"));
int numStops = Integer.parseInt(request.getParameter("numStops"));
int isDomestic = (isInternational) ? 1 : 0;

// Add more fields according to your flight table
float price = Float.parseFloat(request.getParameter("price"));
int capacity = Integer.parseInt(request.getParameter("capacity"));
int passengersBooked = Integer.parseInt(request.getParameter("passengersBooked"));

Connection connection = db.getConnection();
PreparedStatement preparedStatement = null;

try {
    // Assuming 'flights' is your flight table name
    String updateQuery = "UPDATE flights SET departuredate=?, destinationdate=?, departureairport=?, destinationairport=?, isinternational=?, isdomestic=?, numstops=?, price=?, capacity=?, passengers_booked=? WHERE flightnum=?";
    preparedStatement = connection.prepareStatement(updateQuery);

    preparedStatement.setString(1, departureDate);
    preparedStatement.setString(2, destinationDate);
    preparedStatement.setString(3, departureAirport);
    preparedStatement.setString(4, destinationAirport);
    preparedStatement.setBoolean(5, isInternational);
    preparedStatement.setInt(6, isDomestic);
    preparedStatement.setInt(7, numStops);
    preparedStatement.setFloat(8, price);
    preparedStatement.setInt(9, capacity);
    preparedStatement.setInt(10, passengersBooked);
    preparedStatement.setInt(11, flightNum);

    int rowsUpdated = preparedStatement.executeUpdate();

    if (rowsUpdated > 0) {
        out.println("Flight information has been updated successfully!");
    } else {
        out.println("Failed to update flight information. Please check your inputs.");
    }
} catch (SQLException e) {
    out.println("Error: " + e.getMessage());
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
    }
}
%>
