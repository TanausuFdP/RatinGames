<%-- 
    Document   : forum
    Created on : 28-abr-2021, 21:39:31
    Author     : gabriel_hijo
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Foro</title>
        <link rel="stylesheet" href="../css-files/searchGames.css">
    </head>
    <body>
        <%@include file="BBDDConnection.jsp"%>
        <div class="results">
            <jsp:include page="header.jsp"/>
            <link rel="stylesheet" href="../css-files/message.css">
            <br> <br>
            <h1>Discusiones del foro:</h1>
            <%
                String gameID = request.getParameter("game");
                String anterior = request.getParameter("anterior");
                String siguiente = request.getParameter("siguiente");
                session.setAttribute("pageMessages", null);
                
                String sql = "SELECT * "
                + "FROM discussion D "
                + "WHERE D.gameId = '"+ gameID +"'";

                ResultSet rs = s.executeQuery (sql);
                
                rs.last();
                int regs = rs.getRow();
                
                int maxPages;
                if(regs%10 == 0){
                    maxPages = regs/10;
                }else{
                    maxPages = (regs/10)+1;
                }
                
                Integer actualPage = (Integer) session.getAttribute("pageForum");
                if(actualPage == null){
                    actualPage = 0;
                }
                if(anterior != null){
                    actualPage--;
                }
                if(siguiente != null){
                    actualPage++;
                }
                session.setAttribute("pageForum", actualPage);
                
                int minReg = 1 +(10*actualPage);
                if(minReg == 1){
                  rs.first();
                }else{
                    rs.absolute(minReg);
                }
                
                int maxReg = regs;
                if((10*actualPage)+10 < regs){
                    maxReg = (10*actualPage)+10;
                }
                
                out.println("<table class=\"center\">"
                        + "<tr>"
                        + "<th><h2>Título discusión</h2></th>"
                        + "<th><h2>Enlace discusión</h2></th>"
                        + "</tr>"); 
                
                while(minReg <= maxReg){
                    String discussionID = rs.getString("id");
                    session.setAttribute("discussionID", discussionID);

                    out.println("<tr>"
                            + "<td>" + rs.getString("subject") + "</td>"
                            + "<td>" 
                            + "<form action=\"viewMessages.jsp\">"
                            + "<input type=\"hidden\" value=\"" + rs.getString("id") + "\" name=\"discussion\"/>"
                            + "<input type=\"submit\" value=\"Ver mensajes\">"
                            + "</form>"
                            + "</td>");
                    if(minReg != maxReg)
                        rs.next();
                    minReg++;
                }
                out.println("</table>");
                %>
                <div>
                    <%
                        if(actualPage !=0){
                            out.println("<form action=\"forum.jsp\">"
                                + "<input type=\"hidden\" value=\"" + gameID + "\" name=\"game\"/>"
                                + "<input type=\"hidden\" value=\"True\" name=\"anterior\"/>"
                                + "<input type=\"submit\" value=\"Anterior\">"
                                + "</form>");
                        }
                        out.println("Pagina actual: " + (actualPage+1));
                        if(actualPage != maxPages-1){
                            out.println("<form action=\"forum.jsp\">"
                                + "<input type=\"hidden\" value=\"" + gameID + "\" name=\"game\"/>"
                                + "<input type=\"hidden\" value=\"True\" name=\"siguiente\"/>"
                                + "<input type=\"submit\" value=\"Siguiente\">"
                                + "</form>");
                        }
                    %>
                </div>
                <%
                sql = "SELECT  P.name "
                        + "from  platform P, game G "
                        + "where G.id = '"+ gameID +"'"
                        + "and P.id = G.platformId";
                rs= s.executeQuery(sql); rs.next();
                
                out.println("<form action=\"viewGame.jsp\">"
                    + "<input type=\"hidden\" value=\"" + gameID + "\" name=\"gameID\"/>"                    
                    + "<input type=\"hidden\" value=\"" + rs.getString("name") + "\" name=\"platformName\"/>"
                    + "<input type=\"submit\" value=\"Volver al juego\">"
                    + "</form>");
            %>
        </div>
    </body>
</html>
