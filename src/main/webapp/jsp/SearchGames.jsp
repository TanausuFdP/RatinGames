<%@page import="java.sql.ResultSet" %>
<%@include file="header.jsp" %>
<%@include file="BBDDConnection.jsp" %>

<div class="results">
    <%        
        String search = request.getParameter("search_games").toLowerCase();
        String newSearch = request.getParameter("newSearch");
        ResultSet rs;
        String anterior = request.getParameter("anterior");
        String siguiente = request.getParameter("siguiente");
        String sql = "SELECT COUNT(*) "
                + "FROM game "
                + "WHERE game.title LIKE '%" + search + "%'";

        rs = s.executeQuery(sql);

        int regs = 0;
        if (rs.next()) {
            regs = rs.getInt(1);
        }
        int maxPages;
        if (regs % 10 == 0) {
            maxPages = regs / 10;
        } else {
            maxPages = (regs / 10) + 1;
        }
        Integer actualPage = (Integer) session.getAttribute("pageSearchGames");
        if (actualPage == null || newSearch != null) {
            actualPage = 0;
        }
        else if (anterior != null) {
            actualPage--;
        }
        else if (siguiente != null) {
            actualPage++;
        }
        session.setAttribute("pageSearchGames", actualPage);
        
        sql = "SELECT * FROM game WHERE game.title LIKE '%" + search + "%'";
        Statement aux = null;
        try {
            rs = s.executeQuery(sql);
            aux = conexion.createStatement();
        } catch (SQLException exc) {
            exc.printStackTrace();
        }
        int minReg = 1 + (10 * actualPage);
        rs.next();
            for (int i = 1; i < minReg; i++) {
                rs.next();
            }
        int maxReg = regs;
        if ((10 * actualPage) + 10 < regs) {
            maxReg = (10 * actualPage) + 10;
        }
    %>
    <h1>RESULTADOS</h1>
    <%
        out.println("<table class=\"searchGamesTable\">"
                + "<tr>"
                + "<th><h2>Título</h2></th>"
                + "<th><h2>Estudio</h2></th>"
                + "<th><h2>Plataforma</h2></th>"
                + "<th></th>"
                + "</tr>");
        try {
            while (minReg <= maxReg) {
                out.println("<tr>"
                        + "<td>" + rs.getString("title") + "</td>"
                        + "<td>" + rs.getString("studio") + "</td>");
                String platId = (String) rs.getString("platformId");
                sql = "SELECT  name "
                        + "from  platform "
                        + "where id = '" + platId + "'";
                ResultSet rs1 = aux.executeQuery(sql);
                rs1.next();
                out.println("<td>" + rs1.getString("name") + "</td>");

                out.println(""
                        + "<td><form action=\"viewGame.jsp\">"
                        + "<input type=\"hidden\" value=\"" + rs.getInt("id") + "\" name=\"gameID\"/>"
                        + "<input type=\"submit\" value=\"Ver juego\">"
                        + "</form></td>"
                        + "</tr>");
                if (minReg != maxReg) {
                    rs.next();
                }
                minReg++;
            }
            out.println("</table>");
            s.close();
            conexion.close();
        } catch (SQLException exc) {
            exc.printStackTrace();
        }
    %>
    <div class="pagination">
        <%
            if (actualPage != 0) {
                out.println("<form action=\"SearchGames.jsp\">"
                        + "<input type=\"hidden\" value=\"" + search + "\" name=\"search_games\"/>"
                        + "<input type=\"hidden\" value=\"True\" name=\"anterior\"/>"
                        + "<input type=\"submit\" value=\"Anterior\">"
                        + "</form>");
            }
            out.println("<p>Pagina actual: <b>" + (actualPage + 1) + "</b></p>");
            if (actualPage != maxPages - 1 && maxReg != 0) {
                out.println("<form action=\"SearchGames.jsp\">"
                        + "<input type=\"hidden\" value=\"" + search + "\" name=\"search_games\"/>"
                        + "<input type=\"hidden\" value=\"True\" name=\"siguiente\"/>"
                        + "<input type=\"submit\" value=\"Siguiente\">"
                        + "</form>");
            }
            out.println("</div>");
        %>
    </div>
</div>



