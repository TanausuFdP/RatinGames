<%@page import="java.sql.ResultSet"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="es.ulpgc.ratingames.model.User"%>
<jsp:include page="header.jsp"/>
<%@include file="BBDDConnection.jsp"%>
<div class="rating">
    <%  
    User user = (User) session.getAttribute("User");
    String gameID = request.getParameter("gameID");
    String pltName = request.getParameter("platformName");
    %>
    <form class="form" method="POST" action="addDiscussion.jsp">
        <input type="hidden" name="addDiscussionForm" value="true">
        <input type="hidden" name="gameID" value="<%=gameID%>">
        <input type="hidden" name="platformName" value="<%=pltName%>">
        <label>Tema</label>
        <input type="text" name="subject" placeholder="Tema" required>
        <label>Mensaje</label>
        <input type="text" name="body" placeholder="Mensaje" required>
        <input type="submit" value="Añadir">
    </form>
<%  
    if (request.getParameter("addDiscussionForm") != null) {
        String subject = request.getParameter("subject");
        String body = request.getParameter("body");
        
        String insertDiscussion = String.format("INSERT INTO discussion (gameId, userId, subject)"
                + " VALUES (%d,%d,'%s')", Integer.parseInt(gameID), user.getId(), subject);
        try {
            s.executeUpdate(insertDiscussion);
        } catch (SQLException ex) {
            out.println("<h2 class=\"bad\">ERROR AL INSERTAR DISCUSIÓN</h2>");
        }
        
        String sql = "SELECT D.id "
                + "FROM discussion D "
                + "WHERE D.gameId = '" + gameID + "' "
                + "AND D.subject = '" + subject + "'";
        
        try {
            ResultSet rs = s.executeQuery(sql);
            if(!rs.wasNull())
                rs.next();
            
            try {
                Integer res = s.executeUpdate("INSERT INTO message (discussionId, userId, body, date)"
                                + " VALUES ('" + rs.getInt("id") + "', '" + user.getId() + "', '" + body + "', '" + LocalDateTime.now() + "')");
                if(res > 0)
                    out.println("<div class=\"forumBack\">"
                            + "<p>Discusión publicada.</p>" 
                            + "</div>");
            } catch (SQLException ex) {
                out.println("<h2 class=\"bad\">ERROR AL INSERTAR MENSAJE</h2>");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    out.println("<form action=\"forum.jsp\">"
            + "<input type=\"hidden\" value=\"" + gameID + "\" name=\"gameID\"/>"
            + "<input type=\"hidden\" value=\"" + pltName + "\" name=\"platformName\"/>"
            + "<input type=\"submit\" value=\"Volver al foro\">"
            + "</form>");
%>