<%@ page import ="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%
    String firstname = request.getParameter("first_name");
    String lastname = request.getParameter("last_name");
    String userid = request.getParameter("username");
    String pwd = request.getParameter("password");
    int ssn = Integer.parseInt(request.getParameter("ssn"));
    int eid = (int)(Math.random() * 1000000000);
        
    //Class.forName("com.mysql.jdbc.Driver");
    //Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/TravelWebsiteSQL","root", "12345678");
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    String query = " insert into employee (eid, firstname, lastname, ssn, emp_username, emp_password)" + " values (?, ?, ?, ?, ?, ?)";

    // create the mysql insert preparedstatement
    PreparedStatement preparedStmt = con.prepareStatement(query);
    preparedStmt.setInt(1, eid);
    preparedStmt.setString(2, firstname);
    preparedStmt.setString(3, lastname);
    preparedStmt.setInt(4, ssn);
    preparedStmt.setString(5, userid);
    preparedStmt.setString(6, pwd);

    // execute the Preparedstatement
    preparedStmt.executeUpdate();
    
    session.setAttribute("user", userid);
    out.println("welcome " + userid);
    out.println("<a href='logout.jsp'>Log out</a>");
    response.sendRedirect("successemp.jsp");
%>