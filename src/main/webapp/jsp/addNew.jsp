<%@page import="es.ulpgc.ratingames.model.Journalist"%>
<%@page import="es.ulpgc.ratingames.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp"/>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>News</title>

    </head>
    <body>
    <%
        //Journalist user = (Journalist)session.getAttribute("User");
        Journalist user = new Journalist(7,"sdf","dsf","sdf");
        //String newId = request.getParameter("newId");
        
    %>
        <center>
           <div> 
               <h2>Nueva Noticia</h2>
        </div>
        <form  action="../Controller" method="POST" enctype="multipart/form-data">
            <input type="hidden" name="journalistId" value="<%= user.getId() %>">
            <h2>Titulo</h2>
            <input type="text" name="txtnom" required>
            <h2>Imagen</h2>
            <input type="file" name="fileFoto">
            <textarea id="subject" name="subject" placeholder="Escribe tu noticia" style="height:200px" required></textarea>
            <input type="submit" name="accion" value="Guardar">
            <input type="submit" name="accion" value="Regresar">
        </form>
            
            
        </center>
    </body>
</html>
