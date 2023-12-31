<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Make Flight Reservations</title>
</head>
<body>
<h1> Make Flight Reservations</h1>
<%
List<String> tripTypes = Arrays.asList("One Way", "Round Trip");
ApplicationDB appdb = new com.cs336.pkg.ApplicationDB(); 
Map<String, String> airports = appdb.getAirports();
for (Map.Entry mapElement : airports.entrySet()) {
	//out.println(mapElement.getKey());
}
%>
<form action="getFlights.jsp" method="POST">
	<p>Select Trip:</p>
<select name="typeOfTrip">
<% 
	
  for (String item: tripTypes) {
%>
  <option value="<%=item%>"><%=item%></option>
<% } %>
</select>

<p>Select Origin:</p>
<select name="origin">
 <% 
	
 for (Map.Entry mapElement : airports.entrySet()) {
%>
  <option value="<%=mapElement.getKey()%>"><%=mapElement.getKey()%> - <%=mapElement.getValue()%></option>
<% } %>
</select>
<p>Select Destination:</p>

<select name="dest">
 <% 
	
 for (Map.Entry mapElement : airports.entrySet()) {
%>
  <option value="<%=mapElement.getKey()%>"><%=mapElement.getKey()%> - <%=mapElement.getValue()%></option>
<% } %>
</select>

<p>Departure Date: <input name="startDate"></input> </p>
<p> Only Select Return Date for Round Trip Tickets:</p>
<p>Return Date:<input name="destDate"></input> </p>

<p>If "Flexible Dates" is chosen, flights within three days of your selected departure date will be displayed.</p>
<select name="flexible">
<option value="flexible">Flexible Dates</option>
<option value="not flexible">No Flexible Dates</option>
</select>

<p>
<input type="submit" value="Get Flights"/>
</p>

</form>
  


</body>
</html>