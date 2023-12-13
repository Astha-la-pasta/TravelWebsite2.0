<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*,java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Confirm delete airport</title>
</head>
<body>
    <%
        try {
            // Get the database connection
            ApplicationDB db = new ApplicationDB();    
            Connection con = db.getConnection();

            // Validate and sanitize input
            String airportidval = request.getParameter("airportid");
            if (airportidval == null || airportidval.isEmpty()) {
                throw new IllegalArgumentException("Airport ID is required.");
            }

            // Check for associated flights with departure airport
            String departureFlightCheckQuery = "SELECT COUNT(*) FROM flight WHERE departureairport=?";
            try (PreparedStatement departureFlightCheckStmt = con.prepareStatement(departureFlightCheckQuery)) {
                departureFlightCheckStmt.setString(1, airportidval);

                try (ResultSet departureFlightCheckResult = departureFlightCheckStmt.executeQuery()) {
                    if (departureFlightCheckResult.next() && departureFlightCheckResult.getInt(1) > 0) {
                        // Delete associated tickets for departure flights
                        String deleteDepartureTicketsQuery = "DELETE FROM ticket WHERE flightNum IN (SELECT flightNum FROM flight WHERE departureairport=?)";
                        try (PreparedStatement deleteDepartureTicketsStmt = con.prepareStatement(deleteDepartureTicketsQuery)) {
                            deleteDepartureTicketsStmt.setString(1, airportidval);
                            deleteDepartureTicketsStmt.executeUpdate();
                        }

                        // Delete associated departure flights
                        String deleteDepartureFlightsQuery = "DELETE FROM flight WHERE departureairport=?";
                        try (PreparedStatement deleteDepartureFlightsStmt = con.prepareStatement(deleteDepartureFlightsQuery)) {
                            deleteDepartureFlightsStmt.setString(1, airportidval);
                            deleteDepartureFlightsStmt.executeUpdate();
                        }
                    }
                }
            }

            // Check for associated flights with destination airport
            String destinationFlightCheckQuery = "SELECT COUNT(*) FROM flight WHERE destinationairport=?";
            try (PreparedStatement destinationFlightCheckStmt = con.prepareStatement(destinationFlightCheckQuery)) {
                destinationFlightCheckStmt.setString(1, airportidval);

                try (ResultSet destinationFlightCheckResult = destinationFlightCheckStmt.executeQuery()) {
                    if (destinationFlightCheckResult.next() && destinationFlightCheckResult.getInt(1) > 0) {
                        // Delete associated tickets for destination flights
                        String deleteDestinationTicketsQuery = "DELETE FROM ticket WHERE flightNum IN (SELECT flightNum FROM flight WHERE destinationairport=?)";
                        try (PreparedStatement deleteDestinationTicketsStmt = con.prepareStatement(deleteDestinationTicketsQuery)) {
                            deleteDestinationTicketsStmt.setString(1, airportidval);
                            deleteDestinationTicketsStmt.executeUpdate();
                        }

                        // Delete associated destination flights
                        String deleteDestinationFlightsQuery = "DELETE FROM flight WHERE destinationairport=?";
                        try (PreparedStatement deleteDestinationFlightsStmt = con.prepareStatement(deleteDestinationFlightsQuery)) {
                            deleteDestinationFlightsStmt.setString(1, airportidval);
                            deleteDestinationFlightsStmt.executeUpdate();
                        }
                    }
                }
            }

            // Delete the airport
            String deleteAirportQuery = "DELETE FROM airport WHERE airportid=?";
            try (PreparedStatement deleteAirportStmt = con.prepareStatement(deleteAirportQuery)) {
                deleteAirportStmt.setString(1, airportidval);

                // Run the query against the database.
                int rowsAffected = deleteAirportStmt.executeUpdate();

                if (rowsAffected > 0) {
                    out.print("The airport has been deleted.");
                    out.print("<p><a href=\"successemp.jsp\">Customer Rep Home</a></p>");
                } else {
                    out.print("Airport not found or already deleted.");
                    out.print("<p><a href=\"successemp.jsp\">Customer Rep Home</a></p>");
                }
            }

            // Close the connection.
            con.close();
        } catch (Exception e) {
            // Log the exception
            e.printStackTrace();
            out.print("Error in delete: " + e.getMessage());
            out.print("<p><a href=\"successemp.jsp\">Customer Rep Home</a></p>");
        }
    %>
</body>
</html>
