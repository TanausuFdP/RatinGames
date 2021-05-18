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
        //String newId = request.getParameter("newId");
        String newId = "2";
        ResultSet rs;
        try {
            rs = s.executeQuery("select * from new where id = " + newId);
            if(rs.next()){
                out.println("<h1>"+ rs.getString("title")  +"</h1>");
                out.println("<h2>"+ rs.getDate("date") +"</h2>");
                out.println("<img src=\"../Controller?id="+ newId +"\" width=\"500\" height=\"400\">");
                out.println("<p>"+ rs.getString("body")  +"</p>");
                Integer journalId = rs.getInt("journalistId");
                ResultSet rs2 = s.executeQuery("select id from journalist where userId = '" + 8 + "'");rs2.next();
                if( user instanceof Admin || ( rs2.getInt("id") == journalId )) {
                    out.println("<form action=\"../Controller\" method=\"POST\" >");
                    out.println("<input type=\"hidden\" name=\"newId\" value=\""+ newId +"\">");
                    out.println("<input type=\"submit\" name=\"accion\" value=\"Eliminar\">");
                    out.println("</form>");
                }
            }
        } catch (SQLException exc) {exc.printStackTrace();}
        out.println("<form action=\"index.jsp\" method=\"POST\">");
        out.println("<input type=\"submit\" name=\"accion\" value=\"Atrás\">");
        out.println("</form>");
    %>
    </body>
</html>
