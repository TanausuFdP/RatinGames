<%@page import="java.sql.ResultSet" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@include file="BBDDConnection.jsp" %>
<%@include file="header.jsp" %>

<!DOCTYPE html>
<link rel="stylesheet" href="../css-files/searchGames.css">
<div class="results">
    <%        
        User user = (User) session.getAttribute("User");
        String search = request.getParameter("search_games").toLowerCase();
        String sql = "SELECT * FROM game WHERE game.title LIKE '%" + search + "%'";

        ResultSet rs = null;
        Statement aux = null;
        try {
            rs = s.executeQuery(sql);
            aux = conexion.createStatement();
        } catch (SQLException exc) {
            exc.printStackTrace();
        }
    %>

    <h1>RESULTADOS</h1>

    <%
        out.println("<table>"
                + "<tr>"
                + "<th><h2>Titulo</h2></th>"
                + "<th><h2>Studio</h2></th>"
                + "<th><h2>Plataforma</h2></th>"
                + "<th></th>"
                + "</tr>");
        try {
            while (rs.next()) {
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
                        + "<input type=\"hidden\" value=\"" + rs1.getString("name") + "\" name=\"platformName\"/>"
                        + "<button>Ver juego</button>"
                        + "</form></td>"
                        + "</tr>");
            }
            out.println("</table>");
            s.close();
            conexion.close();
        } catch (SQLException exc) {
            exc.printStackTrace();
        }
    %>
</div>



