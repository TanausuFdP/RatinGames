<%@page import="es.ulpgc.ratingames.model.Journalist"%>
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
                int id = rs.getInt("Id");
                String nombre =rs.getString("username");
                String pass =rs.getString("password");
                String email =rs.getString("email");
                User user = null;
                rs = s.executeQuery("SELECT * FROM journalist where userId=" + "'" +
                    id + "'");
                if(rs.next()){
                    user = new Journalist(id,nombre,pass,email);
                    System.out.println("PERIODISTA");
                }else {
                    rs = s.executeQuery("SELECT * FROM admin where userId=" + "'" +
                    id + "'");
                    if(rs.next()){
                        user = new Admin(id,nombre,pass,email);
                    }else{
                        user = new Player(id,nombre,pass,email);
                    }
                }
                session.setAttribute("User", user);
                session.setAttribute("UserID", id);
                response.sendRedirect("index.jsp");
            } else {
                out.println("<h1 class=\"bad\">ERROR DE AUTENTIFICACION.</hi>");
            }
        } catch (SQLException exc) {
            exc.printStackTrace();
        }
    }
    if (username != null && password != null && correo != null) {
        String insertUser = String.format("INSERT INTO user (username, password, email)"
                + " VALUES ('%s','%s','%s')", username, password, correo);

        try {
            s.executeUpdate(insertUser);
        } catch (SQLException ex) {
            out.println("<h2 class=\"bad\">ERROR AL AÑADIR USUARIO</h2>");
        }    
        String sql = "SELECT id "
                + "FROM user "
                + "WHERE username = '" + username + "' "
                + "AND email = '" + correo + "'";
        try{
            ResultSet rs = s.executeQuery(sql);
            if(rs.next()){
                System.out.println("DENTRO");
                try{
                    Integer rs2 = s.executeUpdate("INSERT INTO player (userId)"
                             + " VALUES ('" + rs.getInt("id") + "')");
                    if(rs2 > 0)
                        out.println("<h1 class=\"good\">Usuario registrado con éxito.</h1>");

                }catch (SQLException ex) {
                    out.println("<h2 class=\"bad\">ERROR EN LA TABLA PLAYER</h2>");
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
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