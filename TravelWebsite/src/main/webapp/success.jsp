<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%
    if ((session.getAttribute("user") == null)) {
%>
You are not logged in<br/>
<a href="index.jsp">Please Login</a>
<%} else {
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	
	/*String user = (String)session.getAttribute("user");
	String userCID;
	
	String query = "select * from users u where u.username = " + "values(?)";
	
	PreparedStatement prepstmt = con.prepareStatement(query);
	prepstmt.setString(1, user);
	prepstmt.execute();*/
%>
		
Welcome <%=session.getAttribute("user")%> CID: <%=session.getAttribute("userCID") %><br/>
<a href='logout.jsp'>Log out</a><br/>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br/>
View Past Or Upcoming Reservations?
<br>
	<form method="post" action="resUpcomingOrPast.jsp">
		<select name="timing">
			<option>past</option>
			<option>upcoming</option>
		</select><br/>
		Enter your CID to confirm:
		<table>
		<tr>
		<td><input type="text" name="cid"></td>
		</tr>
		</table>
		<input type="submit" value="Submit">
	</form>
<br>

Sort flights by price, take-off time, or landing time?
<br>
	<form method="post" action="sort.jsp">
		<select name="sort" size=1>
			<option value="price">sort by price</option>
			<option value="departuredate">sort by take-off time</option>
			<option value="destinationdate">sort by landing time</option>
		</select>&nbsp;<br> <input type="submit" value="submit">
	</form>
<br>

Filter flights by price:
<br>
	<form method="post" action="filterPrice.jsp">
		<select name="price" size=1>
			<option value="300">$300 and under</option>
			<option value="500">$500 and under</option>
			<option value="501">$above 500</option>
		</select>&nbsp;<br> <input type="submit" value="submit">
	</form>
<br>

Filter flights by number of stops:
<br>
	<form method="post" action="filterStops.jsp">
		<select name="stops" size=1>
			<option value="0">0</option>
			<option value="1">1</option>
			<option value="2">2 and above</option>
		</select>&nbsp;<br> <input type="submit" value="submit">
	</form>
<br>

Filter the flights by airline:
<br>
	<form method="post" action="filterAirlines.jsp">
	<%
			Statement st5 = null;
			ResultSet rs5 = null;
			st5 = con.createStatement();
			rs5 = st5.executeQuery("select * from airlinecompany"); 
		%>
		<select name="airline" size=1>
			<%
		while (rs5.next()) {
		%>
		<option value="<%=rs5.getString(1)%>"><%=rs5.getString(1)%> -
			<%=rs5.getString(2)%></option>
		<%}%>
		</select>&nbsp;<br> <input type="submit" value="submit">
	</form>
<br>

Cancel flight reservations? Enter your ticket number:<br/>
<br>
	<form method="post" action="cancelReservation.jsp">
	<table>
	<tr>
	<td>ticket number</td><td><input type="text" name="ticketnum"></td>
	</tr>
	</table>
	<input type="submit" value="submit">
	</form>
<br>

Your flight is full? Enter the waiting list!
Enter the flight number and your id: 
<br>
	<form method="post" action="enterWaitingList.jsp">
	<table>
	<tr>
	<td>Flight Number</td><td><input type="text" name="flightNum"></td>
	</tr>
	<tr>
	<td>ID</td><td><input type="text" name="cid"></td>
	</tr>
	</table>
	<input type="submit" value="submit">
	</form>
<br>



<!-- Add a section for searching user and predefined questions by keyword -->
<form method="get" action="userSearchesQuestions.jsp" style="margin-top: 10px;">
    <label for="keyword">Search User and Predefined Questions:</label>
    <input type="text" id="keyword" name="keyword">
    <input type="submit" value="Search">
</form>

<br>

<!-- Flight Search Section -->
<h2>Flight Search</h2>
<form method="get" action="searchFlights.jsp">
    <label for="fromAirport">From Airport:</label>
    <input type="text" id="fromAirport" name="fromAirport" required>
    <label for="toAirport">To Airport:</label>
    <input type="text" id="toAirport" name="toAirport" required>
    <label for="departureDate">Departure Date:</label>
    <input type="date" id="departureDate" name="departureDate" required>
    <label for="returnDate">Return Date:</label>
    <input type="date" id="returnDate" name="returnDate">
    <label for="flexibleDates">Flexible Dates:</label>
    <input type="checkbox" id="flexibleDates" name="flexibleDates"> (+/- 3 days)
    <input type="submit" value="Search Flights">
</form>


<%
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome <%=session.getAttribute("user") %></title>
</head>
<body>
</body>
</html>