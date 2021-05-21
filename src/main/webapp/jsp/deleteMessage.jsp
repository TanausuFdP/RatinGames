<%@page import="java.sql.ResultSet"%>
<jsp:include page="header.jsp"/>
<%@include file="BBDDConnection.jsp"%>
<div class="rating">
    <%  
    String gameID = request.getParameter("gameID");
    String messageID = request.getParameter("messageID");
    String discussionID = request.getParameter("discussion");
    if (request.getParameter("deleteMessageForm") != null) {
        String sql = "DELETE FROM message "
                        + "WHERE id = " + messageID;
        try {
            s.executeUpdate(sql);
            
            out.println("<div class=\"forumBack\">"
                    + "<p>Mensaje eliminado.</p>" 
                    + "</div>");
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }else {
        %>
        <form class="form" method="DELETE" action="deleteMessage.jsp">
            <input type="hidden" name="deleteMessageForm" value="true">
            <input type="hidden" name="gameID" value="<%=gameID%>">
            <input type="hidden" name="discussion" value="<%=discussionID%>">
            <input type="hidden" name="messageID" value="<%=messageID%>">
            <label>¿Seguro que desea borrar el mensaje?</label>
            <input type="submit" value="Borrar">
        </form>
        <%
        String sql = "SELECT M.body "
                        + "FROM message M "
                        + "WHERE M.discussionId = '" + discussionID + "' "
                        + "AND M.id = '" + messageID + "'";
        try {
            ResultSet rs = s.executeQuery(sql);
            if(rs.next()){
                out.println("<p>Mensaje:</p>"
                    +  "<p>" + rs.getString("body") + "</p>");
            }  
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    out.println("<form action=\"viewMessages.jsp\">"
            + "<input type=\"hidden\" value=\"" + gameID + "\" name=\"gameID\"/>"
            + "<input type=\"hidden\" value=\"" + discussionID + "\" name=\"discussion\"/>"
            + "<input type=\"submit\" value=\"Volver a la discusión\">"
            + "</form>");
%>
</div>