<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.sql.*,java.util.List,java.util.ArrayList,com.cs336.pkg.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Edit Customer Flight</title>
</head>
<body>

<%
    String customerId = request.getParameter("customerId");

    if (customerId != null) {
        ApplicationDB db = new ApplicationDB();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            con = db.getConnection();

            // Retrieve customer information
            String customerQuery = "SELECT firstname, lastname FROM users WHERE cid=?";
            pstmt = con.prepareStatement(customerQuery);
            pstmt.setInt(1, Integer.parseInt(customerId));
            rs = pstmt.executeQuery();

            String firstName = "";
            String lastName = "";

            if (rs.next()) {
                firstName = rs.getString("firstname");
                lastName = rs.getString("lastname");
            }

            // Retrieve all flights for the customer
            String query = "SELECT t.ticketNum, t.flightNum, f.departureairport, f.destinationairport, f.departuredate, f.destinationdate, t.isflexible, t.bookingcost, t.cancelfee, t.seatnum, t.fare, t.datebought, t.is_oneway, t.waitlist, t.is_roundtrip, t.classtype FROM ticket t JOIN flight f ON t.flightNum = f.flightNum WHERE t.cid=?";
            pstmt = con.prepareStatement(query);
            pstmt.setInt(1, Integer.parseInt(customerId));
            rs = pstmt.executeQuery();

            out.println("<h1>Edit Customer Flights for Customer ID: " + customerId + "</h1>");
            out.println("<h2>Name: " + firstName + " " + lastName + "</h2>");

            while (rs.next()) {
                int ticketNum = rs.getInt("ticketNum");
                int flightNum = rs.getInt("flightNum");
                String departureAirport = rs.getString("departureairport");
                String destinationAirport = rs.getString("destinationairport");
                Date departureDate = rs.getDate("departuredate");
                Date destinationDate = rs.getDate("destinationdate");
                boolean isFlexible = rs.getBoolean("isflexible");
                int bookingCost = rs.getInt("bookingcost");
                int cancelFee = rs.getInt("cancelfee");
                int seatNum = rs.getInt("seatnum");
                float fare = rs.getFloat("fare");
                Date dateBought = rs.getDate("datebought");
                boolean isOneway = rs.getBoolean("is_oneway");
                boolean waitlist = rs.getBoolean("waitlist");
                boolean isRoundtrip = rs.getBoolean("is_roundtrip");
                String classType = rs.getString("classtype");

                // Display flight information in editable form
                out.println("<form action='processUpdateFlight.jsp' method='POST'>");
                out.println("<p>Ticket Number: " + ticketNum + "</p>");
                out.println("<p>Flight Number: " + flightNum + "</p>");
                out.println("<p>Departure Airport: <input type='text' name='departureAirport' value='" + departureAirport + "'></p>");
                out.println("<p>Destination Airport: <input type='text' name='destinationAirport' value='" + destinationAirport + "'></p>");
                out.println("<p>Departure Date: <input type='date' name='departureDate' value='" + departureDate + "'></p>");
                out.println("<p>Destination Date: <input type='date' name='destinationDate' value='" + destinationDate + "'></p>");
                out.println("<p>Is Flexible: <input type='checkbox' name='isFlexible' " + (isFlexible ? "checked" : "") + "></p>");
                out.println("<p>Booking Cost: <input type='text' name='bookingCost' value='" + bookingCost + "'></p>");
                out.println("<p>Cancel Fee: <input type='text' name='cancelFee' value='" + cancelFee + "'></p>");
                out.println("<p>Seat Number: <input type='text' name='seatNum' value='" + seatNum + "'></p>");
                out.println("<p>Fare: <input type='text' name='fare' value='" + fare + "'></p>");
                out.println("<p>Date Bought: <input type='date' name='dateBought' value='" + dateBought + "'></p>");
                out.println("<p>Is Oneway: <input type='checkbox' name='isOneway' " + (isOneway ? "checked" : "") + "></p>");
                out.println("<p>Waitlist: <input type='checkbox' name='waitlist' " + (waitlist ? "checked" : "") + "></p>");
                out.println("<p>Is Roundtrip: <input type='checkbox' name='isRoundtrip' " + (isRoundtrip ? "checked" : "") + "></p>");
                out.println("<p>Class Type: <input type='text' name='classType' value='" + classType + "'></p>");
                out.println("<input type='hidden' name='customerId' value='" + customerId + "'>");
                out.println("<input type='hidden' name='ticketNum' value='" + ticketNum + "'>");
                out.println("<input type='submit' value='Update Flight'>");
                out.println("</form>");
                out.println("<hr>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeConnection(con);
        }
    } else {
        out.println("<p>Error: Customer ID not provided.</p>");
    }
%>

</body>
</html>
