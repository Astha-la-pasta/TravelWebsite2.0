<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.sql.*, com.cs336.pkg.ApplicationDB"%>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<%
    // Retrieve form parameters
    String airportCode = request.getParameter("airportCode");
    String airportName = request.getParameter("airportName");

    try {
        // Get the database connection
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        // Check if the airport code already exists
        String checkAirportQuery = "SELECT * FROM airport WHERE airportid = ?";
        PreparedStatement checkAirportStmt = con.prepareStatement(checkAirportQuery);
        checkAirportStmt.setString(1, airportCode);

        ResultSet existingAirportResult = checkAirportStmt.executeQuery();

        if (existingAirportResult.next()) {
            out.println("<h3>Airport with code " + airportCode + " already exists.</h3>");
            out.print("<p><a href=\"successemp.jsp\">Back to Employee Page</a></p>");

        } else {
            // Add the airport to the database
            String addAirportQuery = "INSERT INTO airport (airportid, airportname) VALUES (?, ?)";
            PreparedStatement addAirportStmt = con.prepareStatement(addAirportQuery);
            addAirportStmt.setString(1, airportCode);
            addAirportStmt.setString(2, airportName);

            // Execute the query
            int rowsAffected = addAirportStmt.executeUpdate();

            // Check if the addition was successful
            if (rowsAffected > 0) {
                out.println("<h3>Airport added successfully!</h3>");
                out.print("<p><a href=\"successemp.jsp\">Back to Employee Page</a></p>");

            } else {
                out.println("<h3>Failed to add airport. Please try again.</h3>");
                out.print("<p><a href=\"successemp.jsp\">Back to Employee Page</a></p>");

            }
        }

        // Close the connection
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
