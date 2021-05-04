<%@page import="java.util.Arrays"%>
<%@page import="java.sql.ResultSet"%>
<jsp:include page="header.jsp"/>
<%@include file="BBDDConnection.jsp"%>

<div class="rating">
    <form class="form" method="POST" action="addGame.jsp">
        <input type="hidden" name="addGameForm" value="true">
        <label>Título</label>
        <input type="text" name="title" placeholder="Título" required>
        <label>Estudio</label>
        <input type="text" name="studio" placeholder="Estudio" required>
        <label>Jugadores</label>
        <input type="text" name="players" placeholder="Jugadores" required>
        <label>Edad mínima</label>
        <input type="number" name="minimumAge" placeholder="Edad mínima">
        <label>Fecha de salida</label>
        <input type="date" name="releaseDate">
        <label>Idiomas</label>
        <table>
            <tbody>
                <tr>
                    <td><label>Inglés</label></td>
                    <td><input type="checkbox" name="language" value="EN"></td>
                    <td><label>Francés</label></td>
                    <td><input type="checkbox" name="language" value="FR"></td>
                    <td><label>Alemán</label></td>
                    <td><input type="checkbox" name="language" value="DE"></td>
                </tr>
                <tr>
                    <td><label>Español</label></td>
                    <td><input type="checkbox" name="language" value="ES"></td>
                    <td><label>Italiano</label></td>
                    <td><input type="checkbox" name="language" value="IT"></td>
                    <td><label>Portugés</label></td>
                    <td><input type="checkbox" name="language" value="PT"></td>
                </tr>
                <tr>
                    <td><label>Ruso</label></td>
                    <td><input type="checkbox" name="language" value="RU"></td>
                    <td><label>Japonés</label></td>
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
        <label>Plataforma</label>
        <select name="platformId">
            <%  
                String sql = "SELECT * " + "FROM platform";
                ResultSet rs = s.executeQuery(sql);
                while (rs.next()) {
                    out.println("<option value = " + rs.getString("id") + ">" + rs.getString("name") + "</option>");
                }
            %>
        </select>
        <input type="submit" value="Añadir">
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
        String sqlSentence = String.format("INSERT INTO game (title, studio, players, releaseDate, language, minimumAge, platformId)"
                + " VALUES ('%s','%s','%s','%s','%s',%d,%d)", title, studio, players, releaseDate, languages, minimumAge, platformId);
        try{
            s.executeUpdate(sqlSentence);
        } catch(SQLException ex){
            out.println("<h2 class=\"bad\">ERROR AL PUBLICAR MENSAJE</h2>");
        }
    }

%>