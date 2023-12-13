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

Welcome <%=session.getAttribute("user")%><br/>
<a href='logout.jsp'>Log out</a>

<%
    }
%>