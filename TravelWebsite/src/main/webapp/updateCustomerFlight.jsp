<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.sql.*" %>
<%@ page import="com.cs336.pkg.*" %>

<%
    // Retrieve form parameters
    String cid = request.getParameter("cid");
    String selectedFlightNum = request.getParameter("flightNum");

    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();

    // Fetch existing flight details for the selected customer
    Statement stFlights = con.createStatement();
    ResultSet rsFlights = stFlights.executeQuery("SELECT * FROM ticket WHERE cid = " + cid);

    // Populate the Flight dropdown based on the customer's existing flights
    while (rsFlights.next()) {
%>
        <option value="<%=rsFlights.getString("flightNum")%>" 
            <%= selectedFlightNum.equals(rsFlights.getString("flightNum")) ? "selected" : "" %>>
            <%=rsFlights.getString("flightNum")%> - <%=rsFlights.getString("departuredate")%> 
            to <%=rsFlights.getString("destinationdate")%>
        </option>
<%
    }
%>

<form action="processUpdateFlight.jsp" method="POST">
    <!-- Display existing flight details for the selected flight -->
    <!-- You can add input fields to allow users to update specific flight information -->

    <p>
        <input type="submit" value="Update Flight Information" />
    </p>
</form>
