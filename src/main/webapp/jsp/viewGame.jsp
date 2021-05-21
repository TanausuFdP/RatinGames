<%@page import="es.ulpgc.ratingames.model.Admin"%>
<%@page import="es.ulpgc.ratingames.model.ForumUser"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.DecimalFormatSymbols"%>
<%@page import="java.sql.ResultSet" %>
<%@page import="es.ulpgc.ratingames.model.Player" %>
<%@page import="es.ulpgc.ratingames.model.User" %>
<jsp:include page="header.jsp"/>
<%@include file="BBDDConnection.jsp"%>

<div class="gameView">

<%      String idGame = request.getParameter("gameID");
        session.setAttribute("pageForum", null);
        User user = (User) session.getAttribute("User");
        String sql = "SELECT G.* , P.name "
                + "FROM game G , platform P "
                + "WHERE G.id = '" + idGame + "'"
                + "AND P.id = G.platformId";
        ResultSet rs = null;
        try {
            rs = s.executeQuery(sql);
            if (rs.next()) {
                String gameID = rs.getString("id");
                session.setAttribute("SelectedgameID", gameID);
                out.println("<h1>" + rs.getString("title") + "</h1>"
                        + "<ul>"
                        + "<li><b>Estudio: </b>" + rs.getString("studio") + "</li>"
                        + "<li><b>Plataforma: </b>" + rs.getString("name") + "</li>"
                        + "<li><b>Fecha de salida: </b>" + rs.getString("releaseDate") + "</li>"
                        + "<hr>"
                        + "<li><b>Idioma: </b>" + rs.getString("language") + "</li>"
                        + "<li><b>Edad mínima: </b>" + rs.getString("minimumAge") + "</li>"
                        + "<li><b>Jugadores: </b>" + rs.getString("players") + "</li>"
                        + "<hr>");
            }
        } catch (SQLException exc) {
            exc.printStackTrace();
        }
        sql = "SELECT  name "
                + "FROM  genre "
                + "where id IN( "
                + "select  genreId "
                + "from gamegenre "
                + "where gameId = " + idGame + ")";
        try {
            rs = s.executeQuery(sql);
        } catch (SQLException exc) {
            exc.printStackTrace();
        }
        try {
            if (rs.next()) {
                String genres = rs.getString("name") + ", ";
                while (rs.next()) {
                    genres += rs.getString("name") + ", ";
                }
                out.println("<li><b>Género: </b>" + genres.substring(0, genres.lastIndexOf(",")) + "</li>");
            } else {
                out.println("<li><b>Género: </b>" + "Desconocido" + "<li>");
            }
        } catch (SQLException exc) {
            exc.printStackTrace();
        }
        sql = "SELECT  rating "
                + "FROM rating "
                + "WHERE ratingType = 0 "
                + "AND gameId = '" + idGame + "'";

        rs = s.executeQuery(sql);
        DecimalFormatSymbols separadoresPersonalizados = new DecimalFormatSymbols();
        separadoresPersonalizados.setDecimalSeparator('.');
        DecimalFormat format = new DecimalFormat("#.##");

        float media = 0;
        int n = 0;
        if (rs.next()) {
            n++;
            media += Float.parseFloat(rs.getString("rating"));
            while (rs.next()) {
                n++;
                media += Float.parseFloat(rs.getString("rating"));
            }
            media = media / n;
            out.println("<li><b>Valoración: </b>" + format.format(media) + "</li>");
        }else{
            out.println("<li><b>Valoración: </b>" + "-" + "</li>");
        }

        sql = "SELECT  rating "
                + "FROM rating "
                + "WHERE ratingType = 1 "
                + "AND gameId = '" + idGame + "'";

        rs = s.executeQuery(sql);
        separadoresPersonalizados = new DecimalFormatSymbols();
        separadoresPersonalizados.setDecimalSeparator('.');
        format = new DecimalFormat("#.##");

        media = 0;
        n = 0;
        if(rs.next()){
            n++;
            media += Float.parseFloat(rs.getString("rating"));
            while (rs.next()) {
                n++;
                media += Float.parseFloat(rs.getString("rating"));
            }
            media = media / n;
            out.println("<li><b>Nota media de prensa: </b>" + format.format(media) + "</li>"
                    + "</ul>");
        }else{
            out.println("<li><b>Nota media de prensa: </b>" + "-" + "</li>"
                    + "</ul>");
        }
    %>
</div>
<div class="gameButtons">
    <%
        if (user instanceof ForumUser) {
            out.println("<form action=\"sendMessage.jsp\">"
                    + "<input type=\"hidden\" value=\"" + idGame + "\" name=\"gameID\"/>"
                    + "<input type=\"submit\" value=\"Publicar mensaje\">"
                    + "</form>");
        }
        if (user instanceof Player) {
            out.println("<form action=\"rating.jsp\">"
                    + "<input type=\"hidden\" value=\"" + idGame + "\" name=\"gameID\"/>"
                    + "<input type=\"submit\" value=\"Valorar\">"
                    + "</form>");
        }
        if (user instanceof Admin) {
                        out.println("<form action=\"updateGame.jsp\">"
                    + "<input type=\"hidden\" value=\"" + idGame + "\" name=\"gameID\"/>"
                    + "<input type=\"submit\" value=\"Modificar juego\">"
                    + "</form>");

        }
        out.println("<form action=\"forum.jsp\">"
                + "<input type=\"hidden\" value=\"" + idGame + "\" name=\"gameID\"/>"
                + "<input type=\"submit\" value=\"Ver foro\">"
                + "</form>");
    %>
</div>
</body>
</html>
