<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.util.Map.Entry"%>
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

<h2>Make a Flight Reservation</h2>
<form action="makeReservation.jsp" method="POST">
    <p>Select Customer:</p>
    <select name="cid">
        <%
            Statement stCustomers = con.createStatement();
            ResultSet rsCustomers = stCustomers.executeQuery("SELECT * FROM users");

            while (rsCustomers.next()) {
        %>
                <option value="<%=rsCustomers.getString("cid")%>"><%=rsCustomers.getString("firstname")%> <%=rsCustomers.getString("lastname")%></option>
        <%
            }
        %>
    </select>

    <p>Select Flight:</p>
    <select name="flightNum">
        <%
            Statement stFlights = con.createStatement();
            ResultSet rsFlights = stFlights.executeQuery("SELECT * FROM flight");

            while (rsFlights.next()) {
        %>
                <option value="<%=rsFlights.getString("flightNum")%>"><%=rsFlights.getString("flightNum")%> - <%=rsFlights.getString("departureairport")%> to <%=rsFlights.getString("destinationairport")%></option>
        <%
            }
        %>
    </select>

    <!-- Add other reservation input fields as needed -->

    <p>
        <input type="submit" value="Make Reservation" />
    </p>
</form>

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
	<h2>Edit Airport Information</h2>
    <form action="editAirportName.jsp" method="POST">
        <p>Select Airport:</p>
        <select name="airportid">
            <%
                ApplicationDB appdb = new ApplicationDB();
                Map<String, String> airports = appdb.getAirports();

                for (Entry<String, String> entry : airports.entrySet()) {
            %>
                <option value="<%= entry.getKey() %>"><%= entry.getKey() %> - <%= entry.getValue() %></option>
            <%
                }
            %>
        </select>

        <p>Rename Airport:<input name="airportname"></input></p>

        <p>
            <input type="submit" value="Submit"/>
        </p>
    </form>
	<br>
	
	<form action="confirmDeleteAirport.jsp">
		<p>Select Airport to Delete:</p>
        <select name="airportid">
            <%
                //Map<String, String> airports = db.getAirports();

                for (Entry<String, String> entry : airports.entrySet()) {
            %>
                <option value="<%= entry.getKey() %>"><%= entry.getKey() %> - <%= entry.getValue() %></option>
            <%
                }
            %>
        </select>

        <p>
            <input type="submit" value="Submit"/>
        </p>
	</form>
	
	<h2>Add Airport to the Database</h2>
<form action="addAirport.jsp" method="POST">
    <p>Enter Airport Code:</p>
    <input type="text" name="airportCode" required/><br/>

    <p>Enter Airport Name:</p>
    <input type="text" name="airportName" required/><br/>

    <p>
        <input type="submit" value="Add Airport"/>
    </p>
</form>
	
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br/>

<h2>Add Aircraft to the Database</h2>
<form action="addAircraft.jsp" method="POST">
    <p>Enter Aircraft ID:</p>
    <input type="text" name="aircraftid" required/><br/>

    <p>Select Airline:</p>
    <select name="airlineid">
        <%
            Statement stAirlines = con.createStatement();
            ResultSet rsAirlines = stAirlines.executeQuery("SELECT * FROM airlinecompany");

            while (rsAirlines.next()) {
        %>
                <option value="<%=rsAirlines.getString(1)%>"><%=rsAirlines.getString(1)%> - <%=rsAirlines.getString(2)%></option>
        <%
            }
        %>
    </select><br/>

    <p>
        <input type="submit" value="Add Aircraft"/>
    </p>
</form>


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br/>

    <h2>Create a Flight</h2>
<form action="createFlights.jsp" method="POST">
    <!-- ... other flight input fields ... -->

    <p>Select Airline:</p>
    <select name="airlineid">
        <%
            Statement stAirlines1 = con.createStatement();
            ResultSet rsAirlines1 = stAirlines.executeQuery("SELECT * FROM airlinecompany");

            while (rsAirlines1.next()) {
        %>
                <option value="<%=rsAirlines1.getString(1)%>"><%=rsAirlines1.getString(1)%> - <%=rsAirlines1.getString(2)%></option>
        <%
            }
        %>
    </select>

    <p>
        <input type="submit" value="Submit" />
    </p>
</form>

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



Welcome <%=session.getAttribute("user")%><br/>
<a href='logout.jsp'>Log out</a>

<%
    }
%>
