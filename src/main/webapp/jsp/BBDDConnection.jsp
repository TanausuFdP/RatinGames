<%-- 
    Document   : BBDDConnection
    Created on : 26-abr-2021, 12:24:08
    Author     : gabriel_hijo
--%>

<%@page import="java.sql.Statement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>--!>
        <% 
            
            Class.forName("com.mysql.jdbc.Driver");
            Connection conexion = null;
            Statement s = null;
            try{
                conexion = DriverManager.getConnection ("jdbc:mysql://localhost:3306/ratingames","root", "admin");
                s = conexion.createStatement();
                
            }catch(SQLException ex){
                out.println("<div class=\"bad\">Intentelo mas tarde.</div>");
                
            }

        %>

    <!--</body>
</html>--!>
