<%@page import="es.ulpgc.ratingames.model.User"%>
<%@page import="java.sql.ResultSet"%>
<%@include file="BBDDConnection.jsp"%>
<jsp:include page="header.jsp"/>
<%
    String gameId = request.getParameter("gameID");
    String platformName = request.getParameter("platformName");

    User user = (User) session.getAttribute("User");
    
    ResultSet oldRating = s.executeQuery("SELECT * FROM rating WHERE 'userId'=" + "'"+ user.getId()+ "'"
        + "AND 'gameId'=" + "'" + gameId + "'");
    
    if(request.getParameter("ratingDone") != null){
        Integer saveRating;
        
        try{
            
            if(oldRating.next()){
                saveRating = s.executeUpdate("UPDATE 'rating' SET 'rating'=" + request.getParameter("rating")
                        + ", 'message'=" + "'" +request.getParameter("message") + "'" + "WHERE 'userId'=" + "'"+ user.getId()+ "'" 
                        + "AND 'gameId'=" + "'"+ gameId + "'");

            } else {
                saveRating = s.executeUpdate("INSERT INTO rating (gameId, userId, rating, message, ratingType) VALUES"
                        + "('" + gameId + "', " + "'"+ user.getId()+ "'" + ", '" + request.getParameter("rating") + "', '"
                        + request.getParameter("message") + "', '0')");
            }

        }catch(SQLException e){
            out.println("<h1 class=\"bad\">Error al introducir valoración.</hi>");  
            String redirectURL = "viewGame.jsp";
            request.setAttribute("gameID", gameId);
            request.setAttribute("platformName", platformName);
            //response.sendRedirect(redirectURL);
        }
    }
%>
<div class="rating">
    <link rel="stylesheet" href="../css-files/login.css">
    <h3>NUEVA VALORACIÓN</h3>
<%
    ResultSet getGameTitle = s.executeQuery("SELECT title FROM game WHERE 'id'=" +"'"+ gameId+"'");
    
    while(getGameTitle.next()){
        out.println("<h4>" + getGameTitle.getString(0) + "</h4>");
    }
    
    ResultSet oldRating1 = s.executeQuery("SELECT * FROM rating WHERE 'userId'=" + "'"+ user.getId()+ "'"
        + "AND 'gameId'=" + "'" + gameId + "'");
    
    if(oldRating1.next()){
        out.println("<form>" +
        "<p>Nota (0-10)</p>" +
        "<input type=\"number\" name=\"rating\" min=\"0\" max=\"10\" value=\"" + oldRating.getString(0) + "\"><br>" +
        "<p>Comentario</p>" +
        "<textarea rows=\"10\" name=\"message\" cols=\"70\">" + oldRating.getString(1) + "</textarea><br>" +
        "<input type=\"hidden\" name=\"gameID\" value=\"" + gameId + "\">" + 
        "<input type=\"hidden\" name=\"platformName\" value=\"" + platformName + "\">" + 
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
    out.println("<input type=\"hidden\" name=\"gameID\" value=\"" + gameId + "\">");
    out.println("<input type=\"hidden\" name=\"platformName\" value=\"" + platformName + "\">");
%>
        <input type="submit" name="ratingDone" value="Aceptar">
    </form>
<%
    }
%>
</div>
</body>
</html>