<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		List<String> list = new ArrayList<String>();

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			int flightNum = Integer.parseInt(request.getParameter("revForFlight"));
			String str=null;
			
			str = "SELECT t.flightNum, f.airlineid, f.departureairport, f.destinationairport, DATE_FORMAT(t.datebought, '%Y-%m') AS booking_mth, " +
				      "SUM(CASE WHEN t.isflexible = 0 THEN (t.bookingcost + t.fare) ELSE (t.bookingcost + t.cancelfee) END) AS revenue " +
				      "FROM ticket t " +
				      "JOIN flight f ON t.flightNum = f.flightNum " +
				      "WHERE f.flightNum = " + flightNum + " " +
				      "GROUP BY t.flightNum, f.airlineid, f.departureairport, f.destinationairport, booking_mth";

			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);

			//Make an HTML table to show the results in:
			out.print("<table>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			out.print("Flight Num");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Airline ID");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Departure Airport");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Destination Airport");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Month");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Revenue");
			out.print("</td>");
			out.print("</tr>");

			//parse out the results
			//parse out the results
			while (result.next()) {
			    //make a row
			    out.print("<tr>");
			    //make a column
			    out.print("<td>");
			    out.print(result.getString("flightNum"));
			    out.print("</td>");
			    out.print("<td>");
			    out.print(result.getString("airlineid"));
			    out.print("</td>");
			    out.print("<td>");
			    //Print out current departure airport
			    out.print(result.getString("departureairport"));
			    out.print("</td>");
			    out.print("<td>");
			    //Print out current destination airport
			    out.print(result.getString("destinationairport"));
			    out.print("</td>");
			    out.print("<td>");
			    //Print out current month
			    out.print(result.getString("booking_mth"));
			    out.print("</td>");
			    out.print("<td>");
			    //Print out current revenue
			    out.print(result.getString("revenue"));
			    out.print("</td>");
			    out.print("</tr>");
			}

			out.print("</table>");

			//close the connection.
			con.close();

		} catch (Exception e) {
			out.print("failed to load data.");
			out.print("<br>");
			out.print(e);
		}
	%>

</body>
</html>