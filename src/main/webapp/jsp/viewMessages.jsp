<%@page import="java.sql.ResultSet" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mensajes foro</title>
        <link rel="stylesheet" href="../css-files/searchGames.css">
    </head>
    <body>
        <%@include file="BBDDConnection.jsp" %>
        <div class="results">
            <jsp:include page="header.jsp"/>
            <link rel="stylesheet" href="../css-files/message.css">
            <br> <br>
            <h1>Mensajes:</h1>
            <%        int regsPerPage = 10;
                String discussionID = request.getParameter("discussion");
                String gameID = request.getParameter("gameID");
                String pltName = request.getParameter("platformName");
                String anterior = request.getParameter("anterior");
                String siguiente = request.getParameter("siguiente");

                String sql = "SELECT * "
                        + "FROM message M "
                        + "WHERE M.discussionId = '" + discussionID + "'";

                ResultSet rs = null;
                int regs = 0;
                try {
                    rs = s.executeQuery(sql);
                    rs.last();
                    regs = rs.getRow();
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

                int minReg = 1 + (regsPerPage * actualPage);
                try {
                    if (minReg == 1) {
                        rs.first();
                    } else {
                        rs.absolute(minReg);
                    }
                } catch (SQLException exc) {
                    exc.printStackTrace();
                }

                out.println("<table class=\"center\">"
                        + "<tr>"
                        + "<th><h2>Mensaje</h2></th>"
                        + "<th><h2>Fecha</h2></th>"
                        + "</tr>");

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
                                + "<td>" + rs.getString("date") + "</td>");

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
                <%            if (actualPage != 0) {
                        out.println("<form action=\"viewMessages.jsp\">"
                                + "<input type=\"hidden\" value=\"" + discussionID + "\" name=\"discussion\"/>"
                                + "<input type=\"hidden\" value=\"" + gameID + "\" name=\"gameID\"/>"
                                + "<input type=\"hidden\" value=\"" + pltName + "\" name=\"platformName\"/>"
                                + "<input type=\"hidden\" value=\"True\" name=\"anterior\"/>"
                                + "<input type=\"submit\" value=\"Anterior\">"
                                + "</form>");
                    }
                    out.println("Pagina actual: " + (actualPage + 1));
                    if (actualPage != maxPages - 1) {
                        out.println("<form action=\"viewMessages.jsp\">"
                                + "<input type=\"hidden\" value=\"" + discussionID + "\" name=\"discussion\"/>"
                                + "<input type=\"hidden\" value=\"" + gameID + "\" name=\"gameID\"/>"
                                + "<input type=\"hidden\" value=\"" + pltName + "\" name=\"platformName\"/>"
                                + "<input type=\"hidden\" value=\"True\" name=\"siguiente\"/>"
                                + "<input type=\"submit\" value=\"Siguiente\">"
                                + "</form>");
                    }
                    out.println("<form action=\"sendMessage.jsp\">"
                            + "<input type=\"hidden\" value=\"" + gameID + "\" name=\"gameID\"/>"
                            + "<input type=\"hidden\" value=\"" + pltName + "\" name=\"platformName\"/>"
                            + "<input type=\"submit\" value=\"Publicar mensaje\">"
                            + "</form>");

                    out.println("<form action=\"forum.jsp\">"
                            + "<input type=\"hidden\" value=\"" + gameID + "\" name=\"gameID\"/>"
                            + "<input type=\"hidden\" value=\"" + pltName + "\" name=\"platformName\"/>"
                            + "<input type=\"submit\" value=\"Volver al foro\">"
                            + "</form>");
                %>
            </div>
        </div>
    </body>
</html>
