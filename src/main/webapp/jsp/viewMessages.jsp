<%-- 
    Document   : viewMessages
    Created on : 29-abr-2021, 18:26:53
    Author     : gabriel_hijo
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mensajes foro</title>
        <link rel="stylesheet" href="../css-files/searchGames.css">
    </head>
    <body>
        <%@include file="BBDDConnection.jsp"%>
        <div class="results">
            <jsp:include page="header.jsp"/>
            <link rel="stylesheet" href="../css-files/message.css">
            <br> <br>
            <h1>Mensajes:</h1>
            <%
                String discussionID = request.getParameter("discussion");
                String anterior = request.getParameter("anterior");
                String siguiente = request.getParameter("siguiente");
                
                String sql = "SELECT * "
                + "FROM message M "
                + "WHERE M.discussionId = '"+ discussionID +"'";

                ResultSet rs = s.executeQuery(sql);
                
                rs.last();
                int regs = rs.getRow();
                
                int maxPages;
                if(regs%10 == 0){
                    maxPages = regs/10;
                }else{
                    maxPages = (regs/10)+1;
                }
                
                Integer actualPage = (Integer) session.getAttribute("pageMessages");
                if(actualPage == null){
                    actualPage = 0;
                }
                if(anterior != null){
                    actualPage--;
                }
                if(siguiente != null){
                    actualPage++;
                }
                session.setAttribute("pageMessages", actualPage);
                
                int minReg = 1 +(10*actualPage);
                if(minReg == 1){
                  rs.first();
                }else{
                    rs.absolute(minReg);
                }
                
                out.println("<table class=\"center\">"
                            + "<tr>"
                            + "<th><h2>Mensaje</h2></th>"
                            + "<th><h2>Fecha</h2></th>"
                            + "</tr>"); 
                
                int maxReg = regs;
                if((10*actualPage)+10 < regs){
                    maxReg = (10*actualPage)+10;
                }
                
                while(minReg <= maxReg){
                    String messageID = rs.getString("id");
                    session.setAttribute("messageID", messageID);

                    out.println("<tr>"
                            + "<td>" + rs.getString("body") + "</td>"
                            + "<td>" + rs.getString("date") + "</td>");
                    if(minReg != maxReg)
                        rs.next();
                    minReg++;
                }
                out.println("</table>");
                
                %>
                <div>
                    <%
                        if(actualPage !=0){
                            out.println("<form action=\"viewMessages.jsp\">"
                                + "<input type=\"hidden\" value=\"" + discussionID + "\" name=\"discussion\"/>"
                                + "<input type=\"hidden\" value=\"True\" name=\"anterior\"/>"
                                + "<input type=\"submit\" value=\"Anterior\">"
                                + "</form>");
                        }
                        out.println("Pagina actual: " + (actualPage+1));
                        if(actualPage != maxPages-1){
                            out.println("<form action=\"viewMessages.jsp\">"
                                + "<input type=\"hidden\" value=\"" + discussionID + "\" name=\"discussion\"/>"
                                + "<input type=\"hidden\" value=\"True\" name=\"siguiente\"/>"
                                + "<input type=\"submit\" value=\"Siguiente\">"
                                + "</form>");
                        }
                    %>
                </div>
                <%
                sql = "SELECT  gameId "
                        + "from  discussion D "
                        + "where D.id = '"+ discussionID +"'";
                rs= s.executeQuery(sql); rs.next();
                
                out.println("<form action=\"forum.jsp\">"
                    + "<input type=\"hidden\" value=\"" + rs.getInt("gameId") + "\" name=\"game\"/>"
                    + "<input type=\"submit\" value=\"Volver al foro\">"
                    + "</form>");
            %>
        </div>
    </body>
</html>
