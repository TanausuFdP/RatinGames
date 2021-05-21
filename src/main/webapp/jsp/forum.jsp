<%@page import="es.ulpgc.ratingames.model.User"%>
<%@page import="es.ulpgc.ratingames.model.Player"%>
<%@page import="java.sql.ResultSet" %>
<jsp:include page="header.jsp"/>
<%@include file="BBDDConnection.jsp"%>
<div class="results">
            <h1>Discusiones del foro:</h1>
            <%
                String gameID = request.getParameter("gameID");
                User user = (User) session.getAttribute("User");
                ResultSet rs;
                if (user != null) {
                    String favourite = request.getParameter("favourite");
                    if ("true".equals(favourite)) {
                        String insertFavouriteForumSql = String.format("INSERT INTO favouriteforum (gameId, userId) VALUES (%d, %d)",
                                Integer.parseInt(gameID),user.getId());
                        s.executeUpdate(insertFavouriteForumSql);
                    } else if ("false".equals(favourite)) {
                        String deleteFavouriteForumSql = String.format("DELETE FROM favouriteforum WHERE gameId = %d AND userId = %d",
                                Integer.parseInt(gameID),user.getId());
                        s.executeUpdate(deleteFavouriteForumSql);
                    }
                    String isFavouriteForumSql = "SELECT * "
                            + "FROM favouriteforum F "
                            + "WHERE F.userId =" + user.getId() + " AND F.gameId = " + gameID;
                    rs = s.executeQuery(isFavouriteForumSql);
                    if (!rs.next()) {
                        out.println("<div class=\"forumBack\">"
                                + "<form action=\"forum.jsp\">"
                                + "<input type=\"hidden\" value=\"true\" name=\"favourite\"/>"
                                + "<input type=\"hidden\" value=\"" + gameID + "\" name=\"gameID\"/>"
                                + "<input type=\"submit\" value=\"Añadir favorito\">"
                                + "</form></div>");
                    } else {
                        out.println("<div class=\"forumBack\">"
                                + "<form action=\"forum.jsp\">"
                                + "<input type=\"hidden\" value=\"false\" name=\"favourite\"/>"
                                + "<input type=\"hidden\" value=\"" + gameID + "\" name=\"gameID\"/>"
                                + "<input type=\"submit\" value=\"Quitar favorito\">"
                                + "</form></div>");
                    }
                }
                String anterior = request.getParameter("anterior");
                String siguiente = request.getParameter("siguiente");
                session.setAttribute("pageMessages", null);
                String sql = "SELECT COUNT(*) "
                        + "FROM discussion D "
                        + "WHERE D.gameId = '" + gameID + "'";

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
                Integer actualPage = (Integer) session.getAttribute("pageForum");
                if (actualPage == null) {
                    actualPage = 0;
                }
                if (anterior != null) {
                    actualPage--;
                }
                if (siguiente != null) {
                    actualPage++;
                }
                session.setAttribute("pageForum", actualPage);
                sql = "SELECT * "
                        + "FROM discussion D "
                        + "WHERE D.gameId = '" + gameID + "'";

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
                        + "<th><h2>Título discusión</h2></th>"
                        + "<th><h2>Enlace discusión</h2></th>"
                        + "</tr>");
                while (minReg <= maxReg) {
                    String discussionID = rs.getString("id");
                    session.setAttribute("discussionID", discussionID);
                    out.println("<tr>"
                            + "<td>" + rs.getString("subject") + "</td>"
                            + "<td>"
                            + "<form action=\"viewMessages.jsp\">"
                            + "<input type=\"hidden\" value=\"" + rs.getString("id") + "\" name=\"discussion\"/>"
                            + "<input type=\"hidden\" value=\"" + gameID + "\" name=\"gameID\"/>"
                            + "<input type=\"submit\" value=\"Ver mensajes\">"
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
                        out.println("<form action=\"forum.jsp\">"
                                + "<input type=\"hidden\" value=\"" + gameID + "\" name=\"gameID\"/>"
                                + "<input type=\"hidden\" value=\"True\" name=\"anterior\"/>"
                                + "<input type=\"submit\" value=\"Anterior\">"
                                + "</form>");
                    }
                    out.println("<p>Pagina actual: <b>" + (actualPage + 1) + "</b></p>");
                    if (actualPage != maxPages - 1 && maxReg != 0) {
                        out.println("<form action=\"forum.jsp\">"
                                + "<input type=\"hidden\" value=\"" + gameID + "\" name=\"gameID\"/>"
                                + "<input type=\"hidden\" value=\"True\" name=\"siguiente\"/>"
                                + "<input type=\"submit\" value=\"Siguiente\">"
                                + "</form>");
                    }
                    out.println("</div>"
                            + "<div class=\"forumBack\">");
                    if(user instanceof Player){
                        out.println("<form action=\"addDiscussion.jsp\">"
                                + "<input type=\"hidden\" value=\"" + gameID + "\" name=\"gameID\"/>"
                                + "<input type=\"submit\" value=\"Añadir discusión\">"
                                + "</form>");
                    }
                    out.println("<form action=\"viewGame.jsp\">"
                            + "<input type=\"hidden\" value=\"" + gameID + "\" name=\"gameID\"/>"
                            + "<input type=\"submit\" value=\"Volver al juego\">"
                            + "</form>");
                    out.println("</div>");
                %>
            </div>
        </div>
    </body>
</html>
