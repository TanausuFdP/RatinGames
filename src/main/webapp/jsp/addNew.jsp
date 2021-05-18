<%@page import="java.sql.ResultSet"%>
<%@page import="es.ulpgc.ratingames.model.Journalist"%>
<%@page import="es.ulpgc.ratingames.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp"/>
<%@include file="BBDDConnection.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add New</title>
    </head>
    <body>
    <%
        User user = (User) session.getAttribute("User");
        ResultSet rs = s.executeQuery("SELECT id FROM journalist where userId='" + user.getId() +"'"); 
        rs.next();
        int journalistId = rs.getInt("id");
    %>
        <div class="rating">
            <form class="form" action="../Controller" method="POST" enctype="multipart/form-data">
                <input type="hidden" name="journalistId" value="<%= journalistId %>">
                <label>Titulo</label>
                <input type="text" name="txtNom" required>
                <label>Imagen</label>
                <input type="file" name="fileFoto" required>
                <textarea id="subject" name="subject" placeholder="Escribe tu noticia" style="height:200px" required></textarea>
                <input type="submit" name="accion" value="Guardar">
            </form>
            <form class="form" action="index.jsp" method="POST">
                <input type="submit" name="accion" value="Regresar">
            </form>       
        </div>
    </body>
</html>
