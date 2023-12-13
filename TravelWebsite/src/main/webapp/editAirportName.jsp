<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>


<%
ApplicationDB db = new ApplicationDB();

String airportid = request.getParameter("airportid");
String airportname = request.getParameter("airportname");

db.updateAirport(airportid, airportname);%>

The following airport information has been updated:<br/>

<%out.println("Airport ID: " + airportid);%><br/>
<%out.println("Airport Name: " + airportname);%><br/>
<%out.print("<p><a href=\"successemp.jsp\">Customer Rep Home</a></p>");%>