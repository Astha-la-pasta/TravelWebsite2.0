<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%
    String firstname = request.getParameter("first_name");
    String lastname = request.getParameter("last_name");
    String userid = request.getParameter("username");
    String pwd = request.getParameter("password");
    int cid = (int)(Math.random() * 1000000000);
        
    //Class.forName("com.mysql.jdbc.Driver");
    //Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/TravelWebsiteSQL","root", "12345678");
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    if (con == null) System.out.println("is null");
    String query = " insert into users (firstname, lastname, username, password, cid)" + " values (?, ?, ?, ?, ?)";

    // create the mysql insert preparedstatement
    PreparedStatement preparedStmt = con.prepareStatement(query);
    preparedStmt.setString(1, firstname);
    preparedStmt.setString(2, lastname);
    preparedStmt.setString(3, userid);
    preparedStmt.setString(4, pwd);
    preparedStmt.setInt(5, cid);

    // execute the Preparedstatement
    preparedStmt.execute();
    
    session.setAttribute("user", userid);
    session.setAttribute("userCID", cid);
    out.println("welcome " + userid);
    out.println("<a href='logout.jsp'>Log out</a>");
    response.sendRedirect("success.jsp");
%>