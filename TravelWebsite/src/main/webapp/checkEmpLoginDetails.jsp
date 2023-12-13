<%@ page import ="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%
    String userid = request.getParameter("username");   
    String pwd = request.getParameter("password");
    //Class.forName("com.mysql.jdbc.Driver");
    ApplicationDB db = new ApplicationDB();
    //Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/TravelWebsiteSQL","root", "12345678");
    Connection con = db.getConnection();
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from employee where emp_username='" + userid + "' and emp_password='" + pwd + "'");
    if (rs.next()) {
        session.setAttribute("user", userid); // the username will be stored in the session
        out.println("welcome " + userid);
        out.println("<a href='logout.jsp'>Log out</a>");
        response.sendRedirect("successemp.jsp");
    } else {
        out.println("Invalid password <a href='index.jsp'>try again</a>");
    }
%>