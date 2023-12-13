<%@ page import="java.sql.*"%>
<%@ page import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
    String userid = request.getParameter("username");
    String pwd = request.getParameter("password");

    try {
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        // Use PreparedStatement to prevent SQL injection
        String query = "SELECT cid FROM users WHERE username=? AND password=?";
        try (PreparedStatement preparedStatement = con.prepareStatement(query)) {
            preparedStatement.setString(1, userid);
            preparedStatement.setString(2, pwd);

            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                String cid = rs.getString("cid");
                session.setAttribute("user", userid);
                session.setAttribute("userCID", cid);
                response.sendRedirect("success.jsp");
            } else {
                response.sendRedirect("invalidLogin.jsp");
            }
        }
    } catch (SQLException e) {
        out.println("SQL Error: " + e.getMessage());
    } catch (Exception e) {
        out.println("An error occurred: " + e.getMessage());
    }
%>
