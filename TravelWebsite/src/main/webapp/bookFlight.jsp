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
                    String insertBookingQuery = "INSERT INTO ticket (cid, flightNum, isflexible, classtype, datebought) VALUES (?, ?, ?, ?, ?)";
                    PreparedStatement insertBookingStmt = con.prepareStatement(insertBookingQuery);

                    // Set appropriate values based on your database schema
                    String userCIDStr = (String) session.getAttribute("userCID");
                    int userCID = Integer.parseInt(userCIDStr);

                    insertBookingStmt.setInt(1, userCID);
                    insertBookingStmt.setInt(2, flightNum);
                    insertBookingStmt.setBoolean(3, isFlexible);
                    insertBookingStmt.setString(4, classType);
                    insertBookingStmt.setDate(5, new java.sql.Date(new java.util.Date().getTime()));

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
