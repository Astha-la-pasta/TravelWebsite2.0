<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sort Flights</title>
</head>
<body>
	<%
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			String entity = request.getParameter("sort");
			String str = "SELECT flightNum, departuredate, destinationdate, price FROM  flight order by " + entity;
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			//Make an HTML table to show the results in:
			out.print("<table>");
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			out.print("flight number");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("departure date");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("destination date");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("price");
			out.print("</td>");
			out.print("</tr>");

			//parse out the results
			while (result.next()) {
			     
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				
				out.print(result.getString("flightNum"));
				out.print("</td>");
				out.print("<td>");
				
				out.print(result.getString("departuredate"));
				out.print("</td>");
				out.print("<td>");
				
				out.print(result.getString("destinationdate"));
				out.print("</td>");
				out.print("<td>");
				
				out.print(result.getString("price"));
				out.print("</td>");
				out.print("</tr>");
			}
			out.print("</table>");

			//close the connection.
			con.close();

		} catch (Exception e) {
		}
	%>

</body>
</html>