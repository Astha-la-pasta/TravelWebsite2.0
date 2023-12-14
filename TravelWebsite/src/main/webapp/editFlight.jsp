<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.sql.*, java.io.*, java.util.*, com.cs336.pkg.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Edit Flight</title>
</head>
<body>
    <h1>Edit Flight Information</h1>

    <%
        ApplicationDB appdb = new ApplicationDB();
        Map<String, String> airports = appdb.getAirports();

        // Retrieve the flight number from the request parameters
        String flightNum = request.getParameter("flightNum");

        // Fetch the existing flight details from the database
        Connection connection = appdb.getConnection();
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;

        try {
            String selectQuery = "SELECT * FROM flight WHERE flightNum=?";
            preparedStatement = connection.prepareStatement(selectQuery);
            preparedStatement.setString(1, flightNum);
            rs = preparedStatement.executeQuery();

            if (rs.next()) {
                // Retrieve existing flight details
                String departureDate = rs.getString("departuredate");
                String destinationDate = rs.getString("destinationdate");
                String departureAirport = rs.getString("departureairport");
                String destinationAirport = rs.getString("destinationairport");
                boolean isInternational = rs.getBoolean("isinternational");
                int numStops = rs.getInt("stops");
                float price = rs.getFloat("price");
                int capacity = rs.getInt("capacity");
                int passengersBooked = rs.getInt("passengers_booked");
                // Add more fields according to your flight table
    %>

    <form action="updateFlight.jsp" method="POST">
        <!-- Include the flight number in a hidden input field to send it to the next page -->
        <input type="hidden" name="flightNum" value="<%=flightNum%>" />
        
        <p>Flight Number: <%=flightNum%></p>
        
        <p>Enter new Departure Date: <input name="depDate" type="date" required value="<%=departureDate%>" /> </p>
        <p>Enter new Destination Date: <input name="destDate" type="date" required value="<%=destinationDate%>" /></p>

        <p>Select Departure Airport:</p>
        <select name="depAirport">
            <%
                for (Map.Entry mapElement : airports.entrySet()) {
            %>
            <option value="<%=mapElement.getKey()%>" <%= departureAirport.equals(mapElement.getKey()) ? "selected" : "" %>><%=mapElement.getKey()%> - <%=mapElement.getValue()%></option>
            <%
                }
            %>
        </select>

        <p>Select Destination Airport:</p>
        <select name="destAirport">
            <%
                for (Map.Entry mapElement : airports.entrySet()) {
            %>
            <option value="<%=mapElement.getKey()%>" <%= destinationAirport.equals(mapElement.getKey()) ? "selected" : "" %>><%=mapElement.getKey()%> - <%=mapElement.getValue()%></option>
            <%
                }
            %>
        </select>

        <p>Is International Flight?
            <select name="isInter">
                <option value="true" <%= isInternational ? "selected" : "" %>>Yes</option>
                <option value="false" <%= !isInternational ? "selected" : "" %>>No</option>
            </select>
        </p>

        <p>Number of Stops: <input name="numStops" type="number" required value="<%=numStops%>" /></p>
        <p>Price: <input name="price" type="number" step="0.01" required value="<%=price%>" /></p>
        <p>Capacity: <input name="capacity" type="number" required value="<%=capacity%>" /></p>
        <p>Passengers Booked: <input name="passengersBooked" type="number" required value="<%=passengersBooked%>" /></p>
        <!-- Add other flight input fields as needed -->

        <p>
            <input type="submit" value="Submit" />
        </p>
    </form>

    <%
            } else {
                out.println("Flight not found.");
            }
        } catch (SQLException e) {
            out.println("Error: " + e.getMessage());
        } finally {
            // Close resources in the reverse order of their creation
            try {
                if (rs != null) {
                    rs.close();
                }
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
</body>
</html>
