<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*, java.util.*, java.sql.*"%>
<%@ page import="javax.servlet.http.*, javax.servlet.*"%>

<%
    ApplicationDB db = new ApplicationDB();
    Connection con = null;
    PreparedStatement preparedStatement = null;

    try {
        con = db.getConnection();

        int isInternational = Integer.parseInt(request.getParameter("isInter"));
        int isDomestic = (isInternational == 0) ? 1 : 0;
        int numStops = Integer.parseInt(request.getParameter("stops"));
        int price = Integer.parseInt(request.getParameter("price"));
        String depAirport = request.getParameter("depAirport");
        String destAirport = request.getParameter("destAirport");
        String depDate = request.getParameter("depDate");
        String destDate = request.getParameter("destDate");
        String aircraftId = request.getParameter("aircraft");
        String airlineId = request.getParameter("airlineid");
        int capacity = Integer.parseInt(request.getParameter("capacity")); // Add capacity parameter
        int passengersBooked = 0; // Initialize passengersBooked

        // Using a prepared statement to prevent SQL injection
        String query = "INSERT INTO flight (departuredate, destinationdate, departureairport, destinationairport, " +
                "isinternational, isdomestic, price, stops, aircraftid, airlineid, capacity, passengers_booked) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        preparedStatement = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);

        preparedStatement.setString(1, depDate);
        preparedStatement.setString(2, destDate);
        preparedStatement.setString(3, depAirport);
        preparedStatement.setString(4, destAirport);
        preparedStatement.setInt(5, isInternational);
        preparedStatement.setInt(6, isDomestic);
        preparedStatement.setInt(7, price);
        preparedStatement.setInt(8, numStops);
        preparedStatement.setString(9, aircraftId);
        preparedStatement.setString(10, airlineId);
        preparedStatement.setInt(11, capacity);
        preparedStatement.setInt(12, passengersBooked);

        int affectedRows = preparedStatement.executeUpdate();

        if (affectedRows > 0) {
            // Retrieving the generated flight number
            ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
            if (generatedKeys.next()) {
                int flightNum = generatedKeys.getInt(1);

                // Displaying the flight information
                out.println("Flight Number: " + flightNum + "<br/>");
                out.println("Airline: " + airlineId + "<br/>");
                out.println("Aircraft: " + aircraftId + "<br/>");
                out.println("Departure Date: " + depDate + "<br/>");
                out.println("Destination Date: " + destDate + "<br/>");
                out.println("Departure Airport: " + depAirport + "<br/>");
                out.println("Destination Airport: " + destAirport + "<br/>");
                out.println((isInternational == 1) ? "Scope: international<br/>" : "Scope: domestic<br/>");
                out.println("Price: " + price + "<br/>");
                out.println("Stops: " + numStops + "<br/>");
                out.println("Capacity: " + capacity + "<br/>"); // Displaying capacity
                out.println("<p><a href=\"successemp.jsp\">Customer Rep Home</a></p>");
            }
        } else {
            out.println("Error creating flight.");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        // Closing resources in a finally block
        try {
            if (preparedStatement != null) {
                preparedStatement.close();
            }
            if (con != null) {
                con.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
