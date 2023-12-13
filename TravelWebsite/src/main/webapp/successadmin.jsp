<%@ page import ="java.sql.*" %>
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
%>
<% 
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
%>
Welcome <%=session.getAttribute("user")%><br/>
<a href='logout.jsp'>Log out</a><br/>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br/>
<a href='ticketsSold.jsp'>View List of Most Active Flights</a><br/>
<a href='customerWithMostRevenue.jsp'>View Customer Who Generated Most Revenue</a><br/>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br/>
Add Customer:
<br>
<form action="updateRegister.jsp" method="POST">
    First Name: <input type="text" name="first_name"/> <br/>
    Last Name: <input type="text" name="last_name"/> <br/>
    Username: <input type="text" name="username"/> <br/>
    Password:<input type="password" name="password"/> <br/>
    <input type="submit" value="Submit"/>
</form>
<br>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br/>
Add Customer Rep:
<br>
<form action="updateEmpRegister.jsp" method="POST">
    First Name: <input type="text" name="first_name"/> <br/>
    Last Name: <input type="text" name="last_name"/> <br/>
    SSN: <input type="text" name="ssn"/> <br/>
    Username: <input type="text" name="username"/> <br/>
    Password:<input type="password" name="password"/> <br/>
    <input type="submit" value="Submit"/>
</form>
<br>
Delete Customer:
<br>
<form action="deleteCustomer.jsp" method="POST">
    Choose Customer
    <%
        Statement st7 = null;
        ResultSet rs7 = null;
        st7 = con.createStatement();
        rs7 = st7.executeQuery("SELECT * FROM users"); 
    %>
    <select name="customerId">
        <%
            while(rs7.next()){ %>
            <option value="<%=rs7.getString(5)%>"><%=rs7.getString(1)%> <%=rs7.getString(2)%> <%=rs7.getString(5)%></option>
            <%}%>  
    </select><br/>
    <input type="submit" value="Delete Customer">
</form>
<br>

Manage Customer Representatives:
<br>
	<form method="post" action="customerreps.jsp">
		Choose Customer Rep
		<%
			Statement st = null;
			ResultSet rs = null;
			st = con.createStatement();
			rs = st.executeQuery("select * from employee"); 
		%>
		<select name="lastname">
			<%
				while(rs.next()){ %>
        		<option value="<%=rs.getString(3)%>"><%=rs.getString(1)%> - <%=rs.getString(2)%> <%=rs.getString(3)%></option>
                        <%}%>       
		</select><br/>
		Update Customer Rep Personal Info:<br/>
		<table>
		<tr>    
		<td>Change First Name</td><td><input type="text" name="firstname"></td>
		</tr>
		</table>
		<input type="submit" value="Update Customer Rep">
	</form>

<br>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br/>
View Sales Report By Month:
<br>
	<form method="post" action="salesByMonth.jsp">
		Choose Month
		<select name="month">
			<option>1</option>
			<option>2</option>
			<option>3</option>
			<option>4</option>
			<option>5</option>
			<option>6</option>
			<option>7</option>
			<option>8</option>
			<option>9</option>
			<option>10</option>
			<option>11</option>
			<option>12</option>
		</select><br/>
		<input type="submit" value="Choose month">
	</form>
<br>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br/>
View Reservations By Customer:
<br>
	<form method="post" action="showResByName.jsp">
	<%
			Statement st1 = null;
			ResultSet rs1 = null;
			st1 = con.createStatement();
			rs1 = st1.executeQuery("select * from users"); 
		%>
		<select name="entity">
			<%
				while(rs1.next()){ %>
        		<option value="<%=rs1.getString(5)%>"><%=rs1.getString(1)%> <%=rs1.getString(2)%> <%=rs1.getString(5)%></option>
                        <%}%>   
		</select><br/>
		<input type="submit" value="Submit">
	</form>
<br>

View Reservations By Flight Number:
<br>
	<form method="post" action="showResByFlight.jsp">
		<%
			Statement st2 = null;
			ResultSet rs2 = null;
			st2 = con.createStatement();
			rs2 = st2.executeQuery("select * from flight"); 
		%>
		<select name="entity">
			<%
				while(rs2.next()){ %>
        		<option value="<%=rs2.getString(1)%>"><%=rs2.getString(1)%></option>
                        <%}%>     
		</select><br/>
		<input type="submit" value="Submit">
	</form>
<br>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br/>
View Revenue Generated By Flight:
<br>
	<form method="post" action="showRevByFlight.jsp">
	<%
			Statement st3 = null;
			ResultSet rs3 = null;
			st3 = con.createStatement();
			rs3 = st3.executeQuery("select * from flight"); 
		%>
		<select name="entity">
			<%
				while(rs3.next()){ %>
        		<option value="<%=rs3.getString(1)%>"><%=rs3.getString(1)%></option>
                        <%}%>     
		</select><br/>
		<input type="submit" value="Choose flight">
	</form>
<br>

View Revenue Generated By Customer:
<br>
	<form method="post" action="showRevByName.jsp">
	<%
			Statement st4 = null;
			ResultSet rs4 = null;
			st4 = con.createStatement();
			rs4 = st4.executeQuery("select * from users"); 
		%>
		<select name="entity">
			<%
				while(rs4.next()){ %>
        		<option value="<%=rs4.getString(5)%>"><%=rs4.getString(1)%> <%=rs4.getString(2)%> <%=rs4.getString(5)%></option>
                        <%}%>  
		</select><br/>
		<input type="submit" value="Choose name">
	</form>
<br>

View Revenue Generated By Airline:
<br>
	<form method="post" action="showRevByAirline.jsp">
		<%
			Statement st5 = null;
			ResultSet rs5 = null;
			st5 = con.createStatement();
			rs5 = st5.executeQuery("select * from airlinecompany"); 
		%>
		<select name="entity">
		<%
		while (rs5.next()) {
		%>
		<option value="<%=rs5.getString(1)%>"><%=rs5.getString(1)%> -
			<%=rs5.getString(2)%></option>
		<%}%>
	</select><br/>
		<input type="submit" value="Choose airline">
	</form>
<br>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br/>
View Flights by Airport:
<br>
	<form method="post" action="allFlights.jsp">
	<%
			Statement st6 = null;
			ResultSet rs6 = null;
			st6 = con.createStatement();
			rs6 = st6.executeQuery("select * from airport"); 
		%>
		Choose Airport
		<select name="airport">
			<%
				while(rs6.next()){ %>
        		<option value="<%=rs6.getString(1)%>"><%=rs6.getString(1)%> - <%=rs6.getString(2)%></option>
                        <%}%>
		</select><br/>
		<input type="submit" value="Choose airport">
	</form>
<br>

Delete Flight:
<form action="deleteFlight.jsp" method="POST">
    Choose Flight
    <%
        Statement st8 = null;
        ResultSet rs8 = null;
        st8 = con.createStatement();
        rs8 = st8.executeQuery("SELECT * FROM flight"); 
    %>
    <select name="flightNum">
        <%
            while(rs8.next()){ %>
            <option value="<%=rs8.getString(1)%>"><%=rs8.getString(1)%> - <%=rs8.getString(2)%></option>
            <%}%>  
    </select><br/>
    <input type="submit" value="Delete Flight">
</form>
<br>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br/>
<%
    }
%>