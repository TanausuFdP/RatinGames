<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Contacto</title>
        <link rel="stylesheet" href="../css-files/contact.css">
    </head>
    <body>
        <%@include file="header.jsp"%>
        <h3>Formulario de contacto</h3>
        <div class="container">
            <form action="contact.jsp" method="POST" >
                <label for="fname">Nombre</label>
                <input type="text" id="fname" name="firstname" required>
                <label for="lname">Apellidos</label>
                <input type="text" id="lname" name="lastname" required>
                <label for="email">Correo electrónico</label>
                <input type="email" id="email" name="email"  required>
                <label for="problem">Tipo de problema</label>
                <select id="problem" name="problem" required>
                    <option value="1">Fallo al ver noticias</option>
                    <option value="2">Fallo al publicar mensaje</option>
                    <option value="3">Fallo al ver juego</option>
                    <option value="4">Fallo al eliminar noticia</option>
                    <option value="5">No puedo iniciar sesión</option>
                    <option value="6">Me olvidé de la contraseña</option>
                </select>
                <label for="subject">Descripción</label>
                <textarea id="subject" name="subject" placeholder="Descríbenos el problema" style="height:200px"></textarea>
                <input type="hidden" name="isCorrect" value="1">
                <input type="submit" name="accion" value="Contacto">
            </form>
        </div>  
    <%
        String aux = request.getParameter("isCorrect");
        if(aux != null){
            if (!aux.equals("1")) {
                out.println("<h2 class=\"bad\">ERROR AL ENVIAR FORMULARIO</h2>");
            }else{
                out.println("<h2 class=\"good\">EXITO AL ENVIAR FORMULARIO</h2>");
            }
        }
    %>
    </body>
</html>
