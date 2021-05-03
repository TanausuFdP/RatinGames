<%@page import="es.ulpgc.ratingames.model.User"%>
<%@page import="java.sql.ResultSet"%>
<%@include file="BBDDConnection.jsp"%>
<jsp:include page="header.jsp"/>

<%
    String gameId = request.getParameter("gameId");
    User user = (User) session.getAttribute("user");
    
    ResultSet oldRating = s.executeQuery("SELECT * FROM rating WHERE userId=" + user.getId()
        + "AND gameId=" + gameId);
    
    if(request.getParameter("ratingDone") != null){
        ResultSet saveRating;
        
        if(oldRating.next()){
            saveRating = s.executeQuery("UPDATE 'rating' SET 'rating'=" + request.getParameter("rating")
                    + ", 'message'=" + request.getParameter("message") + "WHERE userId=" + user.getId() 
                    + "AND gameId=" + gameId);
        } else {
            saveRating = s.executeQuery("INSERT INTO 'rating' ('gameId', 'userId', 'rating', 'message', 'ratingType') VALUES"
                    + "(" + gameId + ", " + user.getId() + ", " + request.getParameter("rating") + ", "
                    + request.getParameter("message") + ", 0)");
        }
        
        request.setAttribute("gameId", gameId);
        String redirectURL = "viewGame.jsp";
        response.sendRedirect(redirectURL);
    }
%>
<div class="rating">
    <h3>NUEVA VALORACIÓN</h3>
<%
    ResultSet getGameTitle = s.executeQuery("SELECT title FROM game WHERE id=" + gameId);
    
    while(getGameTitle.next()){
        out.println("<h4>" + getGameTitle.getString(0) + "</h4>");
    }
    
    if(oldRating.next()){
        out.println("<form>" +
        "<p>Nota (0-10)</p>" +
        "<input type=\"number\" name=\"rating\" min=\"0\" max=\"10\" value=\"" + oldRating.getString(0) + "\"><br>" +
        "<p>Comentario</p>" +
        "<textarea rows=\"10\" name=\"message\" cols=\"70\">" + oldRating.getString(1) + "</textarea><br>" +
        "<input type=\"hidden\" name=\"gameId\" value=\"" + gameId + "\">" + 
        "<input type=\"submit\" name=\"ratingDone\" =value=\"Aceptar\">" +
        "</form>");
    } else {
%>
    <form>
        <p>Nota (0-10)</p>
        <input type="number" name="rating" min="0" max="10"><br>
        <p>Comentario</p>
        <textarea rows="10" name="message" cols="70"></textarea><br>
<%
    out.println("<input type=\"hidden\" name=\"gameId\" value=\"" + gameId + "\">");
%>
        <input type="submit" name="ratingDone" value="Aceptar">
    </form>
<%
    }
%>
</div>
</body>
</html>