<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.sql.ResultSet"%>
<jsp:include page="header.jsp"/>
<%@include file="BBDDConnection.jsp"%>
        <%
    String idGame = request.getParameter("gameID");
    Integer rows = 0;
    if (request.getParameter("updateGameForm") != null) {
        String title = request.getParameter("title");
        String studio = request.getParameter("studio");
        String players = request.getParameter("players");
        String newReleaseDate = request.getParameter("releaseDate");
        String minimumAgeString = request.getParameter("minimumAge");
        int minimumAge = minimumAgeString != null ? Integer.parseInt(minimumAgeString) : 0;
        int platformId = Integer.parseInt(request.getParameter("platformId"));
        String language;
        String[] languagesArray = request.getParameterValues("language");
        if (languagesArray == null) {
            language = "Desconocido";
        } else {
            language = Arrays.toString(languagesArray).replace("[", "").replace("]", "");
        }
        String updateGame = String.format("UPDATE game SET title='%s', studio='%s', "
                + "players='%s', releaseDate='%s', language='%s', minimumAge=%d, "
                + "platformId=%d WHERE game.id = '%s'", title, studio, players, newReleaseDate, language,
                minimumAge, platformId, idGame);
        System.out.println(updateGame);
        try {
            s.executeUpdate(updateGame);
        } catch (SQLException ex) {
            out.println("<h2 class=\"bad\">ERROR AL MODIFICAR JUEGO</h2>");
        }
        int gameID = Integer.parseInt(idGame);
        String[] genresArray = request.getParameterValues("genre");
        if (genresArray != null) {
            String insertGenre = String.format("INSERT INTO gamegenre (gameId, genreId) VALUES ");
            for (int i = 0; i < genresArray.length; i++) {
                insertGenre = insertGenre.concat(String.format("(%d,'%s'),", gameID, genresArray[i]));
            }
            try {
                s.executeUpdate(String.format("DELETE FROM gamegenre WHERE gameId='%s'", idGame));
                rows = s.executeUpdate(insertGenre.substring(0, insertGenre.length() - 1));
            } catch (SQLException ex) {
                out.println("<h2 class=\"bad\">ERROR AL MODIFICAR GÉNEROS</h2>");
            }
        }
    }

%>

<%    
    String gameSql = "SELECT G.*,P.name "
            + "FROM game G, platform P "
            + "WHERE G.platformId = P.id "
            + "AND G.id = '" + idGame + "'";
    ResultSet rs = s.executeQuery(gameSql);
    rs.next();
%>
<div class="rating">
    <form class="form" method="POST" action="updateGame.jsp">
        <input type="hidden" name="updateGameForm" value="true">
        <input type="hidden" name="gameID" value="<%=idGame%>">
        <label>Título</label>
        <input type="text" name="title" placeholder="Título" required value="<%=rs.getString("title")%>">
        <label>Estudio</label>
        <input type="text" name="studio" placeholder="Estudio" required value="<%=rs.getString("studio")%>">
        <label>Jugadores</label>
        <input type="text" name="players" placeholder="Jugadores" required value="<%=rs.getString("players")%>">
        <label>Edad mínima</label>
        <input type="text" name="minimumAge" placeholder="Edad mínima" value="<%=rs.getInt("minimumAge")%>">
        <label>Fecha de salida</label>
<%
    Date date = rs.getDate("releaseDate");
    String releaseDate = new SimpleDateFormat("yyyy-MM-dd").format(date);
    out.println("<input type=\"date\" name=\"releaseDate\" required value=\"" + releaseDate +"\">");
%>        
        <label>Idiomas</label>
        <%String languages = rs.getString("language"); %>
        <table>
            <tbody>
                <tr>
                    <td><label>Inglés</label></td>
                    <td><input type="checkbox" name="language" value="EN" 
                               <%if (languages.contains("EN")) {%>checked<%}%>
                               ></td>
                    <td><label>Francés</label></td>
                    <td><input type="checkbox" name="language" value="FR"
                               <%if (languages.contains("FR")) {%>checked<%}%>
                               ></td>
                    <td><label>Alemán</label></td>
                    <td><input type="checkbox" name="language" value="DE"
                               <%if (languages.contains("DE")) {%>checked<%}%>
                               ></td>
                </tr>
                <tr>
                    <td><label>Español</label></td>
                    <td><input type="checkbox" name="language" value="ES"
                               <%if (languages.contains("ES")) {%>checked<%}%>
                               ></td>
                    <td><label>Italiano</label></td>
                    <td><input type="checkbox" name="language" value="IT"
                               <%if (languages.contains("IT")) {%>checked<%}%>
                               ></td>
                    <td><label>Portugés</label></td>
                    <td><input type="checkbox" name="language" value="PT"
                               <%if (languages.contains("PT")) {%>checked<%}%>
                               ></td>
                </tr>
                <tr>
                    <td><label>Ruso</label></td>
                    <td><input type="checkbox" name="language" value="RU"
                               <%if (languages.contains("RU")) {%>checked<%}%>
                               ></td>
                    <td><label>Japonés</label></td>
                    <td><input type="checkbox" name="language" value="JA"
                               <%if (languages.contains("JA")) {%>checked<%}%>
                               ></td>
                    <td><label>Chino</label></td>
                    <td><input type="checkbox" name="language" value="ZH"
                               <%if (languages.contains("ZH")) {%>checked<%}%>
                               ></td>
                </tr>
                <tr>
                    <td><label>Coreano</label></td>
                    <td><input type="checkbox" name="language" value="KO"
                               <%if (languages.contains("KO")) {%>checked<%}%>
                               ></td>
                </tr>
            </tbody>
        </table>
        <%
            String platformName = rs.getString("name");
        %>
        <label>Géneros</label>
        <table>
            <tbody>
                <%
                    String query = "SELECT genre.name "
                            + "FROM genre, gamegenre "
                            + "WHERE genre.id = gamegenre.genreId "
                            + "AND gamegenre.gameId = '" + idGame + "'";
                    rs = s.executeQuery(query);
                    List<String> genres = new ArrayList<String>();
                    while (rs.next()) {
                        genres.add(rs.getString("name"));
                    }
                    String genresSql = "SELECT * FROM genre";
                    rs = s.executeQuery(genresSql);
                    while (rs.next()) {
                        out.println("<tr>");
                        for (int i = 0; i < 3; i++) {
                            out.println("<td><label>" + rs.getString("name") + "</label></td>");
                            if (genres.contains(rs.getString("name"))) {
                                out.println("<td><input type=\"checkbox\" name=\"genre\" value=" + rs.getString("id") + " checked></td>");
                            } else {
                                out.println("<td><input type=\"checkbox\" name=\"genre\" value=" + rs.getString("id") + "></td>");
                            }
                            if (!rs.next()) {
                                break;
                            }
                        }
                        out.println("</tr>");
                    }
                %>
            </tbody>
        </table>

        <label>Plataforma</label>
        <select name="platformId">
            <%
                String platformSql = "SELECT * " + "FROM platform";
                rs = s.executeQuery(platformSql);                
                while (rs.next()) {
                    String platform = rs.getString("name");
                    if (platform.equals(platformName)) {
                        out.println("<option value = " + rs.getString("id") + " selected>" + rs.getString("name") + "</option>");
                    } else {
                        out.println("<option value = " + rs.getString("id") + ">" + rs.getString("name") + "</option>");
                    }
                }
            %>
        </select>
        <input type="submit" value="Modificar">
    </form>
            <%
                if (rows > 0) {
                    out.println("<div class=\"forumBack\">"
                            + "<p>Juego modificado.</p></div>");
                }

                out.println("<form action=\"viewGame.jsp\">"
                        + "<input type=\"hidden\" value=\"" + idGame + "\" name=\"gameID\"/>"
                        + "<input type=\"hidden\" value=\"" + platformName + "\" name=\"platformName\"/>"
                        + "<input type=\"submit\" value=\"Volver al juego\">"
                        + "</form>");
            %>
</div>
</body>
</html>
