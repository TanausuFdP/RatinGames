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
    String messageID = request.getParameter("messageID");
    String discussionID = request.getParameter("discussion");
    %>
    <form class="form" method="POST" action="responseMessage.jsp">
        <input type="hidden" name="addResponseForm" value="true">
        <input type="hidden" name="gameID" value="<%=gameID%>">
        <input type="hidden" name="platformName" value="<%=pltName%>">
        <input type="hidden" name="discussion" value="<%=discussionID%>">
        <input type="hidden" name="messageID" value="<%=messageID%>">
        <label>Mensaje de respuesta</label>
        <input type="text" name="responseBody" placeholder="Respuesta" required>
        <input type="submit" value="Añadir">
    </form>
<%  
    if (request.getParameter("addResponseForm") != null) {
        String responseBody = request.getParameter("responseBody");
        String sql = "SELECT M.id, M.body, U.username "
                        + "FROM message M, user U "
                        + "WHERE M.discussionId = '" + discussionID + "' "
                        + "AND M.id = '" + messageID + "' "
                        + "AND M.userId = U.id";
        try {
            ResultSet rs = s.executeQuery(sql);
            if(rs.next()){
                try {
                    String messageBody = rs.getString("body");
                    int responseIndex = messageBody.indexOf("Respuesta:");
                    if(responseIndex != -1){
                        messageBody = messageBody.substring(responseIndex+10);
                    }
                    String message = "Mensaje de: " + rs.getString("username") 
                            + "\n-\n" + messageBody;
                    message += "\nRespuesta:\n" + responseBody;
                    Integer res = s.executeUpdate("INSERT INTO message (discussionId, userId, body, date)"
                                    + " VALUES ('" + discussionID + "', '" + user.getId() + "', '" + message + "', '" + LocalDateTime.now() + "')");
                    if(res > 0)
                        out.println("<div class=\"forumBack\">"
                                + "<p>mensaje publicado.</p>" 
                                + "</div>");
                } catch (SQLException ex) {
                    out.println("<h2 class=\"bad\">ERROR AL INSERTAR MENSAJE</h2>");
                }
            }  
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    out.println("<form action=\"viewMessages.jsp\">"
            + "<input type=\"hidden\" value=\"" + gameID + "\" name=\"gameID\"/>"
            + "<input type=\"hidden\" value=\"" + pltName + "\" name=\"platformName\"/>"
            + "<input type=\"hidden\" value=\"" + discussionID + "\" name=\"discussion\"/>"
            + "<input type=\"submit\" value=\"Volver a la discusión\">"
            + "</form>");
%>
</div>