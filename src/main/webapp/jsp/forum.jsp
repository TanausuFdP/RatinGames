<%@page import="java.sql.ResultSet" %>
<jsp:include page="header.jsp"/>
<%@include file="BBDDConnection.jsp"%>
<div class="results">
            <h1>Discusiones del foro:</h1>
            <%        
                String gameID = request.getParameter("gameID");
                String pltName = request.getParameter("platformName");
                String anterior = request.getParameter("anterior");
                String siguiente = request.getParameter("siguiente");
                session.setAttribute("pageMessages", null);

                String sql = "SELECT COUNT(*) "
                        + "FROM discussion D "
                        + "WHERE D.gameId = '" + gameID + "'";

                ResultSet rs = s.executeQuery(sql);

                int regs = 0;
                if(rs.next()){
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
                            + "<input type=\"hidden\" value=\"" + pltName + "\" name=\"platformName\"/>"
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
                                + "<input type=\"hidden\" value=\"" + pltName + "\" name=\"platformName\"/>"
                                + "<input type=\"hidden\" value=\"True\" name=\"anterior\"/>"
                                + "<input type=\"submit\" value=\"Anterior\">"
                                + "</form>");
                    }
                    out.println("<p>Pagina actual: <b>" + (actualPage + 1) + "</b></p>");
                    if (actualPage != maxPages - 1) {
                        out.println("<form action=\"forum.jsp\">"
                                + "<input type=\"hidden\" value=\"" + gameID + "\" name=\"gameID\"/>"
                                + "<input type=\"hidden\" value=\"" + pltName + "\" name=\"platformName\"/>"
                                + "<input type=\"hidden\" value=\"True\" name=\"siguiente\"/>"
                                + "<input type=\"submit\" value=\"Siguiente\">"
                                + "</form>");
                    }
                    out.println("</div>"
                            + "<div class=\"forumBack\">");
                    out.println("<form action=\"viewGame.jsp\">"
                            + "<input type=\"hidden\" value=\"" + gameID + "\" name=\"gameID\"/>"
                            + "<input type=\"hidden\" value=\"" + pltName + "\" name=\"platformName\"/>"
                            + "<input type=\"submit\" value=\"Volver al juego\">"
                            + "</form>");
                    out.println("</div>");
                %>
            </div>
        </div>
    </body>
</html>
