<%@page import="es.ulpgc.ratingames.model.Admin"%>
<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.Statement" %>
<%@page import="es.ulpgc.ratingames.model.Player" %>
<%@page import="es.ulpgc.ratingames.model.User" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>login</title>
    <link rel="stylesheet" href="../css-files/login.css">
    <script src="../js-files/loginAnimation.js"></script>
</head>
<body>


<div class="imgcontainer">
    <img src="../css-files/images/logo_white_large.png" alt="Avatar" class="avatar">
</div>
<div class="container" id="container">
    <div class="form-container sign-up-container">
        <form autocomplete="off" action="login.jsp" method="post">
            <h1>Crea tu cuenta</h1>
            <input type="text" placeholder="Usuario" name="uname" required>
            <input type="email" placeholder="Email" name="correo" required>
            <input type="password" placeholder="Contraseña" name="psw" required>
            <button>Registrarse</button>
        </form>
    </div>
    <div class="form-container sign-in-container">
        <form autocomplete="off" action="login.jsp" method="post">
            <input type="text" placeholder="Usuario" name="uname" required/>
            <input type="password" placeholder="Contraseña" name="psw" required/>
            <button>Iniciar sesión</button>
        </form>
    </div>
    <div class="overlay-container">
        <div class="overlay">
            <div class="overlay-panel overlay-left">
                <h1>¡Bienvenido de nuevo!</h1>
                <button class="ghost" id="signIn">Iniciar sesión</button>
            </div>
            <div class="overlay-panel overlay-right">
                <h1>¿Nuevo ingreso?</h1>

                <button class="ghost" id="signUp">Registrarse</button>
            </div>
        </div>
    </div>
</div>

<%@include file="BBDDConnection.jsp" %>

<%
    if (session.getAttribute("User") != null) {
        session.setAttribute("User", null);
        session.setAttribute("UserID", null);
        response.sendRedirect("index.jsp");
    }

    String username = request.getParameter("uname");
    String password = request.getParameter("psw");
    String correo = request.getParameter("correo");

    if ((username != null && password != null) && correo == null) {
        ResultSet rs = null;
        try {
            rs = s.executeQuery("SELECT*FROM user where username=" + "'" +
                    username + "' and password=" + "'" + password + "'");
        } catch (SQLException exc) {
            exc.printStackTrace();
        }

        try {
            if (rs.next()) {
                User user = null;
                if(rs.getString("username").equals("admin")){
                    user = new Admin(rs.getInt("Id"), rs.getString("username"), rs.getString("password"), rs.getString("email"));
                }else{
                    
                    user = new Player(rs.getInt("Id"), rs.getString("username"), rs.getString("password"), rs.getString("email"));
                }
                session.setAttribute("User", user);
                session.setAttribute("UserID", rs.getInt("Id"));
                response.sendRedirect("index.jsp");
            } else {
                out.println("<h1 class=\"bad\">ERROR DE AUTENTIFICACION.</hi>");
            }
        } catch (SQLException exc) {
            exc.printStackTrace();
        }
    }

    if (username != null && password != null && correo != null) {
        try {
            Integer rs = s.executeUpdate("INSERT INTO user (username, password, email)"
                    + " VALUES ('" + username + "', '" + password + "', '" + correo + "')");
            if (rs > 0) out.println("<h1 class=\"good\">Usuario registrado con éxito.</h1>");

        } catch (SQLException e) {
            out.println("<h1 class=\"bad\">ERROR AL REGISTRAR USUARIO.</h1>");
        }
    }
    try {
        s.close();
        conexion.close();
    } catch (SQLException exc) {
        exc.printStackTrace();
    }
%>


</body>
</html>