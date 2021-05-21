<%@page import="java.sql.ResultSet"%>
<%@page import="es.ulpgc.ratingames.model.User"%>
<jsp:include page="header.jsp"/>
<%@include file="BBDDConnection.jsp"%>

<div class="results">
<%
    User user = (User) session.getAttribute("User");
    String favouriteForumsSql = "SELECT * "
                            + "FROM favouriteforum F "
                            + "WHERE F.userId =" + user.getId();
    ResultSet rs = s.executeQuery(favouriteForumsSql);
    
    String anterior = request.getParameter("anterior");
    String siguiente = request.getParameter("siguiente");

    String sql = "SELECT COUNT(*) "
                        + "FROM favouriteForum F "
                        + "WHERE F.userId = " + user.getId();
    rs = s.executeQuery(sql);
    int regs = 0;
    if (rs.next()) {
        regs = rs.getInt(1);
    }
    if (regs == 0) {
            out.println("<h3>No ha registrado ningún foro como favorito.</h3>"
                + "<h4>Al acceder al foro de un juego, "
                    + "podrá marcarlo como favorito y acceder rápidamente a este.</h4>");
    }
    int maxPages;
    if (regs % 10 == 0) {
        maxPages = regs / 10;
    } else {
        maxPages = (regs / 10) + 1;
    }

    Integer actualPage = (Integer) session.getAttribute("pageFavouriteForum");
    if (actualPage == null) {
        actualPage = 0;
    }
    if (anterior != null) {
        actualPage--;
    }
    if (siguiente != null) {
        actualPage++;
    }
    session.setAttribute("pageFavouriteForum", actualPage);
    
    sql = "SELECT G.id, G.title, P.name  "
        + "FROM game G, favouriteForum F, platform P "
        + "WHERE G.id = F.gameId "
        + "AND G.platformId = P.id "
        + "AND F.userId = " + user.getId();
    rs = s.executeQuery(sql);

    int minReg = 1 + (10 * actualPage);
    rs.next();
    for (int i = 1; i < minReg; i++) {
        rs.next();
    }

    int maxReg = regs;
    if ((10 * actualPage) + 10 < regs) {
        maxReg = (10 * actualPage) + 10;
    }

    out.println("<table class=\"searchGamesTable\">"
            + "<tr>"
            + "<th><h2>Juego</h2></th>"
            + "<th><h2></h2></th>"
            + "</tr>");
    while (minReg <= maxReg) {
        out.println("<tr>"
                + "<td>" + rs.getString("title") + "</td>"
                + "<td>"
                + "<form action=\"forum.jsp\">"
                + "<input type=\"hidden\" value=\"" + rs.getInt("id") + "\" name=\"gameID\"/>"
                + "<input type=\"hidden\" value=\"" + rs.getString("name") + "\" name=\"platformName\"/>"
                + "<input type=\"submit\" value=\"Ver foro\">"
                + "</form>"
                + "</td>");
        if (minReg != maxReg) {
            rs.next();
        }
        minReg++;
    }
    out.println("</table>");
%>
            <div class="pagination">
                <%
                    if (actualPage != 0) {
                        out.println("<form action=\"favouriteForum.jsp\">"
                                + "<input type=\"hidden\" value=\"True\" name=\"anterior\"/>"
                                + "<input type=\"submit\" value=\"Anterior\">"
                                + "</form>");
                    }
                    out.println("<p>Pagina actual: <b>" + (actualPage + 1) + "</b></p>");
                    if (actualPage != maxPages - 1 && maxReg != 0) {
                        out.println("<form action=\"favouriteForum.jsp\">"
                                + "<input type=\"hidden\" value=\"True\" name=\"siguiente\"/>"
                                + "<input type=\"submit\" value=\"Siguiente\">"
                                + "</form>");
                    }
                %>
            </div>
</div>
</body>
</html>