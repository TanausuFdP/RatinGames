<%@page import="es.ulpgc.ratingames.model.Admin" %>
<%@page import="java.time.LocalDateTime" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="es.ulpgc.ratingames.model.Player" %>
<%@page import="es.ulpgc.ratingames.model.User" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Nuevo Mensaje</title>
        <link rel="stylesheet" href="../css-files/message.css">
    </head>
    <body>
        <%@include file="header.jsp" %>
        <%@include file="BBDDConnection.jsp" %>

        <%    String gameID = request.getParameter("gameID");
            String pltName = request.getParameter("platformName");
        %>


        <h3>Escribir en el foro</h3>
        <div class="container">
            <form action="sendMessage.jsp">
                <input type="hidden" name="valor" value="1"/>
                <%
                   out.println("<input type=\"hidden\" value=\"" + gameID + "\" name=\"gameID\"/>");
                   out.println("<input type=\"hidden\" value=\"" + pltName + "\" name=\"platformName\"/>");
                %>
                <select onchange="this.form.valor.value = this.value;">
                    <%
                        String sql = "SELECT * "
                                + "FROM discussion "
                                + "where gameId = " + gameID;
                        String idDiscusion = request.getParameter("valor");
                        ResultSet rs = null;
                        try {
                            rs = s.executeQuery(sql);
                            while (rs.next()) {
                                out.println("<option value = " + rs.getString("id") + ">" + rs.getString("subject") + "</option>");
                            }
                        } catch (SQLException exc) {
                            exc.printStackTrace();
                        }
                    %>
                </select>
                <textarea id="subject" name="subject" placeholder="Descríbenos el problema" style="height:200px"
                          required></textarea>
                <input type="submit" value="Submit">
            </form>
            <%
                out.println("<form action=\"viewGame.jsp\">"
                        + "<input type=\"hidden\" value=\"" + gameID + "\" name=\"gameID\"/>"
                        + "<input type=\"hidden\" value=\"" + pltName + "\" name=\"platformName\"/>"
                        + "<input type=\"submit\" value=\"Volver al juego\">"
                        + "</form>");
            %>
        </div>
        <%
            User user = (User) session.getAttribute("User");
            Integer userId = (Integer) session.getAttribute("UserID");
            if (user instanceof Player) {
                String subjt = request.getParameter("subject");
                if (subjt != null) {

                    try {
                        Integer res = s.executeUpdate("INSERT INTO message (discussionId, userId, body,date)"
                                + " VALUES ('" + idDiscusion + "', '" + userId + "', '" + subjt + "', '" + LocalDateTime.now() + "')");
                        if (res > 0) {
                            out.println("Mensaje publicado.");
                            out.println("<form action=\"viewMessages.jsp\">"
                                    + "<input type=\"hidden\" value=\"" + idDiscusion + "\" name=\"discussion\"/>"
                                    + "<input type=\"hidden\" value=\"" + gameID + "\" name=\"gameID\"/>"
                                    + "<input type=\"hidden\" value=\"" + pltName + "\" name=\"platformName\"/>"
                                    + "<input type=\"submit\" value=\"Ver mensajes\">"
                                    + "</form>");
                        }

                    } catch (SQLException e) {
                        out.println("<h2 class=\"bad\">ERROR AL PUBLICAR MENSAJE</h2>");
                    }
                }
            } else if (user instanceof Admin) {
                // si es admin...
            }

            try {
                s.close();
                conexion.close();
            } catch (SQLException exc) {
                exc.printStackTrace();
            }
        %>
    </body>
</html>