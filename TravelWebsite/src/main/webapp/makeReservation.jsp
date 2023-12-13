<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.sql.*, java.io.*, java.util.*"%>
<%@ page import="com.cs336.pkg.ApplicationDB" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>

<%
    // Retrieve form parameters
    String cid = request.getParameter("cid");
    String flightNum = request.getParameter("flightNum");

    try {
        // Get the database connection
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        // Check if the customer and flight exist
        String checkCustomerQuery = "SELECT * FROM users WHERE cid = ?";
        PreparedStatement checkCustomerStmt = con.prepareStatement(checkCustomerQuery);
        checkCustomerStmt.setString(1, cid);

        ResultSet customerResult = checkCustomerStmt.executeQuery();

        String checkFlightQuery = "SELECT * FROM flight WHERE flightNum = ?";
        PreparedStatement checkFlightStmt = con.prepareStatement(checkFlightQuery);
        checkFlightStmt.setString(1, flightNum);

        ResultSet flightResult = checkFlightStmt.executeQuery();

        // Check if the customer and flight exist
        if (customerResult.next() && flightResult.next()) {
            // Check if the customer is already booked on the flight
            String checkReservationQuery = "SELECT * FROM ticket WHERE cid = ? AND flightNum = ?";
            PreparedStatement checkReservationStmt = con.prepareStatement(checkReservationQuery);
            checkReservationStmt.setString(1, cid);
            checkReservationStmt.setString(2, flightNum);

            ResultSet existingReservationResult = checkReservationStmt.executeQuery();

            if (existingReservationResult.next()) {
                // Customer is already booked on the flight
                out.println("<h3>Customer is already booked on this flight. Reservation not allowed.</h3>");
                out.print("<p><a href=\"successemp.jsp\">Back to Employee Page</a></p>");

            } else {
                // Perform the reservation logic
                String reservationQuery = "INSERT INTO ticket (cid, flightNum, datebought, fare) VALUES (?, ?, ?, ?)";
                PreparedStatement reservationStmt = con.prepareStatement(reservationQuery);
                reservationStmt.setString(1, cid);
                reservationStmt.setString(2, flightNum);
                reservationStmt.setDate(3, new java.sql.Date(System.currentTimeMillis())); // Set the current date as the datebought
                reservationStmt.setDouble(4, flightResult.getDouble("price")); // Set the fare based on flight price

                // Execute the reservation query
                int rowsAffected = reservationStmt.executeUpdate();

                // Check if the reservation was successful
                if (rowsAffected > 0) {
                    out.println("<h3>Reservation successful!</h3>");
                    out.print("<p><a href=\"successemp.jsp\">Back to Employee Page</a></p>");

                } else {
                    out.println("<h3>Reservation failed. Please try again.</h3>");
                    out.print("<p><a href=\"successemp.jsp\">Back to Employee Page</a></p>");

                }
            }
        } else {
            out.println("<h3>Invalid customer or flight. Please check the details and try again.</h3>");
            out.print("<p><a href=\"successemp.jsp\">Back to Employee Page</a></p>");
        }

        // Close the connection
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
