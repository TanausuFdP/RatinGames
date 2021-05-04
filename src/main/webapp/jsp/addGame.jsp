<%@page import="java.util.Arrays"%>
<%@page import="java.sql.ResultSet"%>
<jsp:include page="header.jsp"/>
<%@include file="BBDDConnection.jsp"%>

<div class="rating">
    <form class="form" method="POST" action="addGame.jsp">
        <input type="hidden" name="addGameForm" value="true">
        <label>T�tulo</label>
        <input type="text" name="title" placeholder="T�tulo" required>
        <label>Estudio</label>
        <input type="text" name="studio" placeholder="Estudio" required>
        <label>Jugadores</label>
        <input type="text" name="players" placeholder="Jugadores" required>
        <label>Edad m�nima</label>
        <input type="number" name="minimumAge" placeholder="Edad m�nima">
        <label>Fecha de salida</label>
        <input type="date" name="releaseDate" required>
        <label>Idiomas</label>
        <table>
            <tbody>
                <tr>
                    <td><label>Ingl�s</label></td>
                    <td><input type="checkbox" name="language" value="EN"></td>
                    <td><label>Franc�s</label></td>
                    <td><input type="checkbox" name="language" value="FR"></td>
                    <td><label>Alem�n</label></td>
                    <td><input type="checkbox" name="language" value="DE"></td>
                </tr>
                <tr>
                    <td><label>Espa�ol</label></td>
                    <td><input type="checkbox" name="language" value="ES"></td>
                    <td><label>Italiano</label></td>
                    <td><input type="checkbox" name="language" value="IT"></td>
                    <td><label>Portug�s</label></td>
                    <td><input type="checkbox" name="language" value="PT"></td>
                </tr>
                <tr>
                    <td><label>Ruso</label></td>
                    <td><input type="checkbox" name="language" value="RU"></td>
                    <td><label>Japon�s</label></td>
                    <td><input type="checkbox" name="language" value="JA"></td>
                    <td><label>Chino</label></td>
                    <td><input type="checkbox" name="language" value="ZH"></td>
                </tr>
                <tr>
                    <td><label>Coreano</label></td>
                    <td><input type="checkbox" name="language" value="KO"></td>
                </tr>
            </tbody>
        </table>

        <label>G�neros</label>
        <table>
            <tbody>
                <%            
                    String genresSql = "SELECT * FROM genre";
                    ResultSet rs = s.executeQuery(genresSql);
                    while (rs.next()) {
                        out.println("<tr>");
                        for (int i = 0; i < 3; i++) {
                            out.println("<td><label>" + rs.getString("name") + "</label></td>");
                            out.println("<td><input type=\"checkbox\" name=\"genre\" value=" + rs.getString("id") + "></td>");
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
                String sql = "SELECT * " + "FROM platform";
                rs = s.executeQuery(sql);
                while (rs.next()) {
                    out.println("<option value = " + rs.getString("id") + ">" + rs.getString("name") + "</option>");
                }
            %>
        </select>
        <input type="submit" value="A�adir">
    </form>
</div>

<%    if (request.getParameter("addGameForm") != null) {
        String title = request.getParameter("title");
        String studio = request.getParameter("studio");
        String players = request.getParameter("players");
        String releaseDate = request.getParameter("releaseDate");
        String minimumAgeString = request.getParameter("minimumAge");
        int minimumAge = minimumAgeString != null ? Integer.parseInt(minimumAgeString) : 0;
        int platformId = Integer.parseInt(request.getParameter("platformId"));
        String languages;
        String[] languagesArray = request.getParameterValues("language");
        if (languagesArray == null) {
            languages = "Desconocido";
        } else {
            languages = Arrays.toString(languagesArray).replace("[", "").replace("]", "");
        }
        String insertGame = String.format("INSERT INTO game (title, studio, players, releaseDate, language, minimumAge, platformId)"
                + " VALUES ('%s','%s','%s','%s','%s',%d,%d)", title, studio, players, releaseDate, languages, minimumAge, platformId);
        try {
            s.executeUpdate(insertGame);
        } catch (SQLException ex) {
            out.println("<h2 class=\"bad\">ERROR AL INSERTAR JUEGO</h2>");
        }
        String[] genresArray = request.getParameterValues("genre");
        ResultSet gameId = s.executeQuery("SELECT id FROM game WHERE title=\""+title+"\" AND platformId="+platformId);
        gameId.next();
        int gameID = gameId.getInt("id");
        if (genresArray != null){
            String insertGenre = String.format("INSERT INTO gamegenre (gameId, genreId) VALUES ");
            for(int i = 0; i < genresArray.length; i++){
                insertGenre = insertGenre.concat(String.format("(%d,'%s'),",gameID, genresArray[i]));
            }
            System.out.println(insertGenre);
            s.executeUpdate(insertGenre.substring(0,insertGenre.length()-1));
        }
    }

%>