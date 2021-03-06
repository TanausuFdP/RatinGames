<%@page import="es.ulpgc.ratingames.model.Admin"%>
<%@page import="es.ulpgc.ratingames.model.Player"%>
<%@page import="es.ulpgc.ratingames.model.ForumUser"%>
<%@page import="java.sql.ResultSet" %>
<%@page import="es.ulpgc.ratingames.model.User"%>
<jsp:include page="header.jsp"/>
<%@include file="BBDDConnection.jsp"%>
        <div class="results">
            <h1>Mensajes:</h1>
            <%        
                int regsPerPage = 10;
                String discussionID = request.getParameter("discussion");
                User user = (User) session.getAttribute("User");
                String gameID = request.getParameter("gameID");
                String anterior = request.getParameter("anterior");
                String siguiente = request.getParameter("siguiente");
                String sql = "SELECT COUNT(*) "
                        + "FROM message M "
                        + "WHERE M.discussionId = '" + discussionID + "'";
                ResultSet rs = null;
                int regs = 0;
                try {
                    rs = s.executeQuery(sql);
                    if(rs.next()){
                        regs = rs.getInt(1);
                    }
                } catch (SQLException exc) {
                    exc.printStackTrace();
                }
                int maxPages;
                if (regs % regsPerPage == 0) {
                    maxPages = regs / regsPerPage;
                } else {
                    maxPages = (regs / regsPerPage) + 1;
                }
                Integer actualPage = (Integer) session.getAttribute("pageMessages");
                if (actualPage == null) {
                    actualPage = 0;
                }
                if (anterior != null) {
                    actualPage--;
                }
                if (siguiente != null) {
                    actualPage++;
                }
                session.setAttribute("pageMessages", actualPage);
                sql = "SELECT M.id, M.body, M.date, M.userId, U.username "
                        + "FROM message M, user U "
                        + "WHERE M.discussionId = '" + discussionID + "' "
                        + "AND M.userId = U.id";
                
                rs = s.executeQuery(sql);
                int minReg = 1 + (regsPerPage * actualPage);
                try {
                    rs.next();
                    for (int i = 1; i < minReg; i++) {
                        rs.next();
                    }
                } catch (SQLException exc) {
                    exc.printStackTrace();
                }
                out.println("<table class=\"searchGamesTable\">"
                    + "<tr>"
                    + "<th><h2>Mensaje</h2></th>"
                    + "<th><h2>Fecha</h2></th>"
                    + "<th><h2>Usuario</h2></th>");
                if(user instanceof Player)
                    out.println("<th></th>");
                if(user instanceof ForumUser)
                    out.println("<th></th>");
                out.println("</tr>");

                int maxReg = regs;
                if ((regsPerPage * actualPage) + regsPerPage < regs) {
                    maxReg = (regsPerPage * actualPage) + regsPerPage;
                }
                try {
                    while (minReg <= maxReg) {
                        String messageID = rs.getString("id");
                        session.setAttribute("messageID", messageID);
                        
                        out.println("<tr>"
                            + "<td>" + rs.getString("body") + "</td>"
                            + "<td>" + rs.getString("date") + "</td>"
                            + "<td>" + rs.getString("username") + "</td>");
                        
                        if(user instanceof Player){
                            out.println("<td>"
                                    + "<form action=\"responseMessage.jsp\">"
                                    + "<input type=\"hidden\" value=\"" + messageID + "\" name=\"messageID\"/>"
                                    + "<input type=\"hidden\" value=\"" + discussionID + "\" name=\"discussion\"/>"
                                    + "<input type=\"hidden\" value=\"" + gameID + "\" name=\"gameID\"/>"
                                    + "<input type=\"submit\" value=\"Responder\">"
                                    + "</form>"
                                + "</td>");
                            if(rs.getInt("userId") == user.getId()){
                                out.println("<td>"
                                        + "<form action=\"deleteMessage.jsp\">"
                                        + "<input type=\"hidden\" value=\"" + messageID + "\" name=\"messageID\"/>"
                                        + "<input type=\"hidden\" value=\"" + discussionID + "\" name=\"discussion\"/>"
                                        + "<input type=\"hidden\" value=\"" + gameID + "\" name=\"gameID\"/>"
                                        + "<input type=\"submit\" value=\"Borrar\">"
                                        + "</form>"
                                    + "</td>");
                            }else{
                                 out.println("<td>-</td>");
                            }
                        }
                        if(user instanceof Admin){
                            out.println("<td>"
                                    + "<form action=\"deleteMessage.jsp\">"
                                    + "<input type=\"hidden\" value=\"" + messageID + "\" name=\"messageID\"/>"
                                    + "<input type=\"hidden\" value=\"" + discussionID + "\" name=\"discussion\"/>"
                                    + "<input type=\"hidden\" value=\"" + gameID + "\" name=\"gameID\"/>"
                                    + "<input type=\"submit\" value=\"Borrar\">"
                                    + "</form>"
                                + "</td>");
                        }
                        out.println("</tr>");
                        if (minReg != maxReg) {
                            rs.next();
                        }
                        minReg++;
                    }
                } catch (SQLException exc) {
                    exc.printStackTrace();
                }
                out.println("</table>");
            %>
            <div class="pagination">
                <%            
                    if (actualPage != 0) {
                        out.println("<form action=\"viewMessages.jsp\">"
                                + "<input type=\"hidden\" value=\"" + discussionID + "\" name=\"discussion\"/>"
                                + "<input type=\"hidden\" value=\"" + gameID + "\" name=\"gameID\"/>"
                                + "<input type=\"hidden\" value=\"True\" name=\"anterior\"/>"
                                + "<input type=\"submit\" value=\"Anterior\">"
                                + "</form>");
                    }
                    out.println("<p>Pagina actual: <b>" + (actualPage + 1) + "</b></p>");
                    if (actualPage != maxPages - 1 && maxReg != 0) {
                        out.println("<form action=\"viewMessages.jsp\">"
                                + "<input type=\"hidden\" value=\"" + discussionID + "\" name=\"discussion\"/>"
                                + "<input type=\"hidden\" value=\"" + gameID + "\" name=\"gameID\"/>"
                                + "<input type=\"hidden\" value=\"True\" name=\"siguiente\"/>"
                                + "<input type=\"submit\" value=\"Siguiente\">"
                                + "</form>");
                    }
                    out.println("</div>"
                            + "<div class=\"forumBack\">");
                    
                    if (user instanceof ForumUser) {
                        out.println("<form action=\"sendMessage.jsp\">"
                                + "<input type=\"hidden\" value=\"" + gameID + "\" name=\"gameID\"/>"
                                + "<input type=\"submit\" value=\"Publicar mensaje\">"
                                + "</form>");
                    }

                    out.println("<form action=\"forum.jsp\">"
                            + "<input type=\"hidden\" value=\"" + gameID + "\" name=\"gameID\"/>"
                            + "<input type=\"submit\" value=\"Volver al foro\">"
                            + "</form>");
                %>
            </div>
        </div>
    </body>
</html>
