<%@page import="es.ulpgc.ratingames.model.User"%>
<%@page import="java.sql.ResultSet"%>
<%@include file="BBDDConnection.jsp"%>
<jsp:include page="header.jsp"/>
<%    String gameId = request.getParameter("gameID");
    String platformName = request.getParameter("platformName");

    User user = (User) session.getAttribute("User");

    ResultSet oldRating = s.executeQuery("SELECT * FROM rating WHERE userId=" + "'" + user.getId() + "'"
            + "AND gameId=" + "'" + gameId + "'");

    if (request.getParameter("ratingDone") != null) {
        try {
            if (oldRating.next()) {
                s.executeUpdate("UPDATE rating SET rating=" + request.getParameter("rating")
                        + ", message=" + "'" + request.getParameter("message") + "'" + "WHERE userId=" + "'" + user.getId() + "'"
                        + "AND gameId=" + "'" + gameId + "'");

            } else {
                s.executeUpdate("INSERT INTO rating (gameId, userId, rating, message, ratingType) VALUES"
                        + "('" + gameId + "', " + "'" + user.getId() + "'" + ", '" + request.getParameter("rating") + "', '"
                        + request.getParameter("message") + "', '0')");
                oldRating.close();
            }

        } catch (SQLException e) {
            out.println("<h1 class=\"bad\">Error al introducir valoración.</hi>");
        }
        /*String redirectURL = "viewGame.jsp";
        request.setAttribute("gameID", gameId);
        request.setAttribute("platformName", platformName);
        response.sendRedirect(redirectURL);*/
    }
%>
<div class="rating">
    <h3>NUEVA VALORACIÓN</h3>
    <%
        ResultSet getGameTitle = s.executeQuery("SELECT title FROM game WHERE id=" + "'" + gameId + "'");

        while (getGameTitle.next()) {
            out.println("<h4>" + getGameTitle.getString("title") + "</h4>");
        }

        if (oldRating.isClosed()) {
            oldRating = s.executeQuery("SELECT * FROM rating WHERE userId=" + "'" + user.getId() + "'"
                    + "AND gameId=" + "'" + gameId + "'");
        }

        if (oldRating.next()) {
            out.println("<form method=\"POST\">"
                    + "<p>Nota (0-10)</p>"
                    + "<input type=\"number\" name=\"rating\" min=\"0\" max=\"10\" value=\"" + oldRating.getString("rating") + "\" required><br>"
                    + "<p>Comentario</p>"
                    + "<textarea rows=\"10\" name=\"message\" cols=\"70\" required>" + oldRating.getString("message") + "</textarea><br>"
                    + "<input type=\"hidden\" name=\"gameID\" value=\"" + gameId + "\">"
                    + "<input type=\"hidden\" name=\"platformName\" value=\"" + platformName + "\">"
                    + "<input type=\"submit\" name=\"ratingDone\" =value=\"Aceptar\">"
                    + "</form>");
        } else {
            out.println("<form method=\"POST\">"
                    + "<p>Nota (0-10)</p>"
                    + "<input type=\"number\" name=\"rating\" min=\"0\" max=\"10\" required><br>"
                    + "<p>Comentario</p>"
                    + "<textarea rows=\"10\" name=\"message\" cols=\"70\" required></textarea><br>"
                    + "<input type=\"hidden\" name=\"gameID\" value=\"" + gameId + "\">"
                    + "<input type=\"hidden\" name=\"platformName\" value=\"" + platformName + "\">"
                    + "<input type=\"submit\" name=\"ratingDone\" =value=\"Aceptar\">"
                    + "</form>");
        }

        out.println("<form action=\"viewGame.jsp\">"
                + "<input type=\"hidden\" value=\"" + gameId + "\" name=\"gameID\"/>"
                + "<input type=\"hidden\" value=\"" + platformName + "\" name=\"platformName\"/>"
                + "<input type=\"submit\" value=\"Volver al juego\">"
                + "</form>");
    %>
</div>
</body>
</html>