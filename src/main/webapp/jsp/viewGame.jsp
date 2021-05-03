<%@page import="java.sql.ResultSet" %>
<%@page import="es.ulpgc.ratingames.model.Player" %>
<%@page import="es.ulpgc.ratingames.model.User" %>
<%@include file="BBDDConnection.jsp" %>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<link rel="stylesheet" href="../css-files/searchGames.css">
<div class="results">
    <%@include file="header.jsp" %>
    <link rel="stylesheet" href="../css-files/message.css">

    <%
        out.println("<br> <br>");
    %>
    <h1>Videojuego seleccionado:</h1>
    <%
        String idGame = request.getParameter("gameID");
        String pltName = request.getParameter("platformName");

        User user = (User) session.getAttribute("User");
        if (user instanceof Player) {
            out.println(""
                    + "<form action=\"sendMessage.jsp\">"
                    + "<input type=\"hidden\" value=\"" + idGame + "\" name=\"game\"/>"
                    + "<input type=\"submit\" value=\"Publicar mensaje\">"
                    + "</form>");
        }
        String sql = "SELECT * "
                + "FROM game G "
                + "WHERE G.id = '" + idGame + "'";

        ResultSet rs = null;
        try {
            rs = s.executeQuery(sql);
            if (rs.next()) {
                String gameID = rs.getString("id");
                session.setAttribute("SelectedgameID", gameID);
                out.println("<table class=\"center\">"
                        + "<tr>"
                        + "<th><h2>Titulo</h2></th>"
                        + "<th><h2>Studio</h2></th>"
                        + "<th><h2>Jugadores</h2></th>"
                        + "<th><h2>Fecha de salida</h2></th>"
                        + "<th><h2>Idioma</h2></th>"
                        + "<th><h2>Restriccion de edad</h2></th>"
                        + "<th><h2>Plataforma</h2></th>"
                        + "</tr>");

                out.println("<tr>"
                        + "<td>" + rs.getString("title") + "</td>"
                        + "<td>" + rs.getString("studio") + "</td>"
                        + "<td>" + rs.getString("players") + "</td>"
                        + "<td>" + rs.getString("releaseDate") + "</td>"
                        + "<td>" + rs.getString("language") + "</td>"
                        + "<td>" + rs.getString("minimumAge") + "</td>"
                        + "<td>" + pltName + "</td>");
                out.println("</tr></table>");
            }
        } catch (SQLException exception) {
            exception.printStackTrace();
        }


        sql = "SELECT  name "
                + "FROM  genre "
                + "where id IN( "
                + "select  genreId "
                + "from gamegenre "
                + "where gameId = " + idGame + ")";
        try {
            rs = s.executeQuery(sql);
        } catch (SQLException exception) {
            exception.printStackTrace();
        }

        out.println("<table class=\"center\">"
                + "<tr>"
                + "<th><h2>Generos</h2></th>"
                + "</tr>");
        try {
            while (rs.next()) {
                out.println("<tr>"
                        + "<td>" + rs.getString("name") + "</td>"
                        + "</tr>");
            }
        } catch (SQLException exception) {
            exception.printStackTrace();
        }
        out.println("</table>");
        try {
            s.close();
            conexion.close();
        } catch (SQLException exception) {
            exception.printStackTrace();
        }
    %>
</div>
<div>
    <%
        if (user instanceof Player) {

            out.println("<form action=\"sendMessage.jsp\">"
                    + "<input type=\"hidden\" value=\"" + idGame + "\" name=\"game\"/>"
                    + "<input type=\"submit\" value=\"Publicar mensaje\">"
                    + "</form>");
        }
        out.println("<br>");

        out.println("<form action=\"forum.jsp\">"
                + "<input type=\"hidden\" value=\"" + idGame + "\" name=\"game\"/>"
                + "<input type=\"submit\" value=\"Ver foro\">"
                + "</form>");
    %>
</div>
</body>
</html>
