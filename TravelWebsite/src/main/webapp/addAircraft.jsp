<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.sql.*,java.util.*"%>
<%@ page import="com.cs336.pkg.ApplicationDB"%>

<%
    // Retrieve form data
    String aircraftID = request.getParameter("aircraftid");
    String airlineID = request.getParameter("airlineid");

    // Validate form data (you may add more validation as needed)
    if (aircraftID == null || aircraftID.isEmpty() || airlineID == null || airlineID.isEmpty()) {
        // Handle invalid input (you may redirect to an error page)
        out.println("Invalid input. Please fill in all fields.");
    } else {
        Connection con = null;
        PreparedStatement insertAircraft = null;
        ResultSet rs = null;

        try {
            // Get a database connection
            ApplicationDB db = new ApplicationDB();
            con = db.getConnection();

            // Check if the aircraft ID already exists
            PreparedStatement checkAircraftID = con.prepareStatement("SELECT * FROM aircraft WHERE aircraftid = ?");
            checkAircraftID.setString(1, aircraftID);
            rs = checkAircraftID.executeQuery();

            if (rs.next()) {
                // Aircraft ID already exists, handle accordingly (you may redirect to an error page)
                out.println("Aircraft ID already exists. Please choose a different ID.");
                out.println("<p><a href=\"successemp.jsp\">Customer Rep Home</a></p>");
            } else {
                // Insert the new aircraft into the database
                insertAircraft = con.prepareStatement("INSERT INTO aircraft (aircraftid, airlineid) VALUES (?, ?)");
                insertAircraft.setString(1, aircraftID);
                insertAircraft.setString(2, airlineID);
                int rowsAffected = insertAircraft.executeUpdate();

                if (rowsAffected > 0) {
                    // Aircraft added successfully
                    out.println("Aircraft added successfully!");
                    out.println("<p><a href=\"successemp.jsp\">Customer Rep Home</a></p>");
                } else {
                    // Handle insertion failure (you may redirect to an error page)
                    out.println("Failed to add aircraft. Please try again.");
                    out.println("<p><a href=\"successemp.jsp\">Customer Rep Home</a></p>");
                }
            }
        } catch (SQLException e) {
            // Handle database connection error (you may redirect to an error page)
            e.printStackTrace();
            out.println("Database connection error. Please try again.");
        } finally {
            // Close resources in the finally block
            try {
                if (rs != null) {
                    rs.close();
                }
                if (insertAircraft != null) {
                    insertAircraft.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
