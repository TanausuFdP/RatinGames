<%@page import="es.ulpgc.ratingames.model.Admin"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.sql.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="es.ulpgc.ratingames.model.Player"%>
<%@page import="es.ulpgc.ratingames.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Nuevo Mensaje</title>
        <link rel="stylesheet" href="../css-files/message.css">

    </head>
    <body>
        <%@include file="header.jsp"%>
        <%@include file="BBDDConnection.jsp"%>

        <%
        String gameID = (String)session.getAttribute("SelectedgameID");
        %>

        <h3>Escribir en el foro</h3>
        <div class="container">
            <form action="sendMessage.jsp">   
                <input type="hidden" name="valor" value="0"/>
                <select onchange="this.form.valor.value = this.value;">
                <%
                String sql = "SELECT * "
                        + "FROM discussion "
                        + "where gameId = "+ gameID;
                String idDiscusion = request.getParameter("valor");
                ResultSet rs = s.executeQuery (sql);
                out.println("<option selected>"+ "Selecciona discusión"  +"</option>");
                while(rs.next()){
                    out.println("<option value = "+rs.getString("id")+">"+ rs.getString("subject")  +"</option>");
                }
                %>
                </select>       
                <textarea id="subject" name="subject" placeholder="Descríbenos el problema" style="height:200px" required></textarea>                
                <input type="submit" value="Submit">
            </form>
                <%
                out.println("<br>");
                sql = "SELECT  P.name "
                    + "from  platform P, game G "
                    + "where G.id = '"+ gameID +"'"
                    + "and P.id = G.platformId";
                rs= s.executeQuery(sql); rs.next();
                out.println("<form action=\"viewGame.jsp\">"
                + "<input type=\"hidden\" value=\"" + gameID + "\" name=\"gameID\"/>"                    
                + "<input type=\"hidden\" value=\"" + rs.getString("name") + "\" name=\"platformName\"/>"
                + "<input type=\"submit\" value=\"Volver al juego\">"
                + "</form>");
                %>
        </div>
        <%      
        // guardamos mensaje en la BBDD
        User user = (User)session.getAttribute("User");
        Integer userId = (Integer)session.getAttribute("UserID");
        if(user instanceof Player){
            String subjt = request.getParameter("subject");
            if(subjt != null){

                try{
                    Integer res = s.executeUpdate("INSERT INTO message (discussionId, userId, body,date)"
                        + " VALUES ('" +idDiscusion + "', '" + userId + "', '" + subjt +"', '" + LocalDateTime.now() + "')");
                    if(res > 0){
                        out.println("Mensaje publicado.");
                        out.println("<form action=\"viewMessages.jsp\">"
                            + "<input type=\"hidden\" value=\"" + idDiscusion + "\" name=\"discussion\"/>"
                            + "<input type=\"submit\" value=\"Ver mensajes\">"
                            + "</form>");
                    }

                }catch(SQLException e){
                    out.println("<h2 class=\"bad\">ERROR AL PUBLICAR MENSAJE</h2>");
                }        
            }
        }else if(user instanceof Admin){
            // si es admin...
        }
        
        s.close();
        conexion.close();
        %>
    </body>
</html>