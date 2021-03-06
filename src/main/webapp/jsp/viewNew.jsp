<%@page import="es.ulpgc.ratingames.model.Admin"%>
<%@page import="java.sql.SQLException"%>
<%@page import="es.ulpgc.ratingames.model.User"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="es.ulpgc.ratingames.model.Journalist"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="BBDDConnection.jsp" %>
<jsp:include page="header.jsp"/>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Noticia</title>
    </head>
    <body>
    <%
        User user = (User)session.getAttribute("User");
        String newId = request.getParameter("newId");
        ResultSet rs;
        try {
            rs = s.executeQuery("SELECT N.*, J.id, J.userId, U.username, U.id "
                            + "FROM new N, journalist J, user U "
                            + "WHERE N.id = '" + newId + "' "
                            + "AND J.id = N.journalistId "
                            + "AND J.userId = U.id");
            if(rs.next()){
                out.println("<div class=\"rating\" align=\"center\">");
                out.println("<h1>"+ rs.getString("title")  +"</h1>");
                out.println("<h2>"+ rs.getDate("date") +"</h2>");
                out.println("<img src=\"../Controller?id="+ newId +"\" width=\"500\" height=\"400\">");
                out.println("<p>"+ rs.getString("body")  +"</p>");
                out.println("<h3> Periodista: "+ rs.getString("U.username").toUpperCase() +"</h3>");
                if(user != null){
                    if(user instanceof Admin || ( rs.getInt("U.id") == user.getId() )) {
                        out.println("<form action=\"../Controller\" method=\"POST\" >");
                        out.println("<input type=\"hidden\" name=\"newId\" value=\""+ newId +"\">");
                        out.println("<input type=\"submit\" name=\"accion\" value=\"Eliminar\">");
                        out.println("</form>");
                    }
                }
            }
        } catch (SQLException exc) {exc.printStackTrace();}
        out.println("<form action=\"news.jsp\" method=\"POST\">");
        out.println("<input type=\"submit\" name=\"accion\" value=\"Atr??s\">");
        out.println("</form>");
        out.println("</div>");
    %>
    </body>
</html>
