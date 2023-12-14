<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.cs336.pkg.ApplicationDB"%>

<%
    // Check if the user is logged in
    if (session.getAttribute("user") == null) {
        response.sendRedirect("index.jsp");
    } else {
        // Get form parameters
        String flightNumStr = request.getParameter("flightNum");
        String isFlexibleStr = request.getParameter("isFlexible");
        String classType = request.getParameter("classtype");

        // Validate and process the form data
        if (flightNumStr != null && classType != null) {
            try {
                int flightNum = Integer.parseInt(flightNumStr);
                boolean isFlexible = isFlexibleStr != null;

                ApplicationDB db = new ApplicationDB();
                Connection con = db.getConnection();

                // Check if the selected flight exists
                String flightCheckQuery = "SELECT * FROM flight WHERE flightNum = ?";
                PreparedStatement flightCheckStmt = con.prepareStatement(flightCheckQuery);
                flightCheckStmt.setInt(1, flightNum);

                ResultSet flightCheckResult = flightCheckStmt.executeQuery();

                if (flightCheckResult.next()) {
                    // The flight exists, proceed with booking

                    // TODO: Implement logic to insert the booking into the database
                    // Placeholder SQL query, update accordingly based on your schema
                    String insertBookingQuery = "INSERT INTO ticket (cid, flightNum, isflexible, bookingcost, seatnum, fare, datebought, is_oneway, waitlist, is_roundtrip, classtype) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    PreparedStatement insertBookingStmt = con.prepareStatement(insertBookingQuery);

                    // Set appropriate values based on your database schema
                    String userCIDStr = (String) session.getAttribute("userCID");
                    int userCID = Integer.parseInt(userCIDStr);

                    insertBookingStmt.setInt(1, userCID);
                    insertBookingStmt.setInt(2, flightNum);
                    insertBookingStmt.setBoolean(3, isFlexible);
                    insertBookingStmt.setInt(4, 25); // bookingcost
                    insertBookingStmt.setInt(5, 0);  // seatnum (provide a valid seat number)
                    insertBookingStmt.setFloat(6, 0.0f); // fare (provide a valid fare)
                    insertBookingStmt.setDate(7, new java.sql.Date(new java.util.Date().getTime()));
                    insertBookingStmt.setBoolean(8, true);  // is_oneway (provide a valid value)
                    insertBookingStmt.setBoolean(9, false); // waitlist (provide a valid value)
                    insertBookingStmt.setBoolean(10, true); // is_roundtrip (provide a valid value)
                    insertBookingStmt.setString(11, classType);

                    // Execute the query
                    insertBookingStmt.executeUpdate();

                    // TODO: Redirect the user to a confirmation page
                    response.sendRedirect("bookingConfirmation.jsp");
                } else {
                    // The selected flight does not exist
                    response.sendRedirect("success.jsp");
                }

            } catch (SQLException | NumberFormatException e) {
                e.printStackTrace();
                // Handle database errors or invalid input
                response.sendRedirect("success.jsp");
            }
        } else {
            // Handle invalid form data
            response.sendRedirect("success.jsp");
        }
    }
%>
