<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.sql.*, com.cs336.pkg.ApplicationDB"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Update Flight</title>
</head>
<body>

<%
    String customerId = request.getParameter("customerId");
    String ticketNum = request.getParameter("ticketNum");

    if (customerId != null && ticketNum != null) {
        ApplicationDB db = new ApplicationDB();
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = db.getConnection();

            // Retrieve parameters from the form
            String departureAirport = request.getParameter("departureAirport");
            String destinationAirport = request.getParameter("destinationAirport");
            String departureDate = request.getParameter("departureDate");
            String destinationDate = request.getParameter("destinationDate");
            String isFlexible = request.getParameter("isFlexible");
            String bookingCost = request.getParameter("bookingCost");
            String cancelFee = request.getParameter("cancelFee");
            String seatNum = request.getParameter("seatNum");
            String fare = request.getParameter("fare");
            String dateBought = request.getParameter("dateBought");
            String isOneway = request.getParameter("isOneway");
            String waitlist = request.getParameter("waitlist");
            String isRoundtrip = request.getParameter("isRoundtrip");
            String classType = request.getParameter("classType");

            // Update ticket information
            String updateQuery = "UPDATE ticket SET isflexible=?, bookingcost=?, cancelfee=?, seatnum=?, fare=?, datebought=?, " +
                    "is_oneway=?, waitlist=?, is_roundtrip=?, classtype=? WHERE cid=? AND ticketNum=?";
            pstmt = con.prepareStatement(updateQuery);
            pstmt.setBoolean(1, "on".equals(isFlexible));
            pstmt.setInt(2, Integer.parseInt(bookingCost));
            pstmt.setInt(3, Integer.parseInt(cancelFee));
            pstmt.setInt(4, Integer.parseInt(seatNum));
            pstmt.setFloat(5, Float.parseFloat(fare));
            pstmt.setString(6, dateBought);
            pstmt.setBoolean(7, "on".equals(isOneway));
            pstmt.setBoolean(8, "on".equals(waitlist));
            pstmt.setBoolean(9, "on".equals(isRoundtrip));
            pstmt.setString(10, classType);
            pstmt.setInt(11, Integer.parseInt(customerId));
            pstmt.setInt(12, Integer.parseInt(ticketNum));

            int rowsUpdated = pstmt.executeUpdate();

            if (rowsUpdated > 0) {
                out.println("<p>Ticket information updated successfully.</p>");
                out.println("<p><a href=\"successemp.jsp\">Customer Rep Home</a></p>");
            } else {
                out.println("<p>Error updating ticket information.</p>");
                out.println("<p><a href=\"successemp.jsp\">Customer Rep Home</a></p>");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeConnection(con);
        }
    } else {
        out.println("<p>Error: Customer ID or Ticket Number not provided.</p>");
        out.println("<p><a href=\"successemp.jsp\">Customer Rep Home</a></p>");
    }
%>

</body>
</html>
