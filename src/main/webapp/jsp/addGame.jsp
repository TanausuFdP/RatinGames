<%@page import="java.sql.ResultSet"%>
<jsp:include page="header.jsp"/>
<%@include file="BBDDConnection.jsp"%>

<div>
    <form class="form" method="POST" name="addGameForm" action="addGame.jsp">
        <label>Título</label>
        <input type="text" name="title" placeholder="Título" required>
        <label>Estudio</label>
        <input type="text" name="studio" placeholder="Estudio" required>
        <label>Jugadores</label>
        <input type="text" name="players" placeholder="Jugadores" required>
        <label>Fecha de salida</label>
        <input type="date" name="releaseDate">
        <label>Edad mínima</label>
        <input type="number" name="minimumAge" placeholder="Edad mínima">
        <label>Idiomas</label>
        <!--<div style="display: inline-block">-->
            <div style="inline">
                <label>Inglés</label>
                <input type="checkbox" name="language" value="EN">
            </div>
            <div style="inline">
                <label>Francés</label>
                <input type="checkbox" name="language" value="FR">
            </div>
            <div style="inline">
                <label>Alemán</label>
                <input type="checkbox" name="language" value="DE">
            </div>
            <div style="inline">
                <label>Español</label>
                <input type="checkbox" name="language" value="ES">
            </div>
            <div style="inline">
                <label>Italiano</label>
                <input type="checkbox" name="language" value="IT">
            </div>
            <div style="inline">
                <label>Portugés</label>
                <input type="checkbox" name="language" value="PT">
            </div>
            <div style="inline">
                <label>Ruso</label>
                <input type="checkbox" name="language" value="RU">
            </div>
            <div style="inline">
                <label>Japonés</label>
                <input type="checkbox" name="language" value="JA">
            </div>
            <div style="inline">
                <label>Chino</label>
                <input type="checkbox" name="language" value="ZH">
            </div>
            <div style="inline">
                <label>Coreano</label>
                <input type="checkbox" name="language" value="KO">
            </div>
        <!--</div>-->
        <label>Plataforma</label>
        <select name="platformId" required>
            <%            String sql = "SELECT * "
                        + "FROM platform";
                //ResultSet rs = s.executeQuery(sql);
                out.println("<option selected>" + "Seleccione plataforma" + "</option>");
                /*while (rs.next()) {*/
                out.println("<option value = " + /*rs.getString("id")*/ 1 + ">" + /*rs.getString("name")*/ "PC" + "</option>");

                //}
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
            languages = languagesArray.toString();
        }
        String sqlSentence = String.format("INSERT INTO games (title, studio, players, releaseDate, language, minimumAge, plataformId)"
                + " VALUES (%s,%s,%s,%s,%s,%d,%d)", title, studio, players, releaseDate, languages, minimumAge, platformId);
        s.executeUpdate(sqlSentence);
    }

%>

<jsp:include page="footer.jsp"/>