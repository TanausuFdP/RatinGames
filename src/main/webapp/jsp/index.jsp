<%@page import="java.sql.ResultSet"%>
<jsp:include page="header.jsp"/>
<%@include file="BBDDConnection.jsp"%>
<%    String title = "Lorem ipsum dolor sit amet consectetur.";
    String text = "Adipiscing elit auctor, ultrices vivamus consequat vulputate purus.";
    String news_image = "../css-files/images/news_sample.jpg";
    String game_image = "../css-files/images/game_sample.png";
%>

<div class="topNews">
    <h3>TOP NOTICIAS</h3>
    <div class="firstTopNew">
        <%
            out.println("<img src=\"" + news_image + "\">");
            out.println("<p><b>" + title + "</b></p>");
        %>
    </div>
    <%
        out.println("<table>");
        for (int i = 0; i < 4; i++) {
            out.println("<tr>");
            out.println("<td><img src=\"" + news_image + "\">");
            out.println("<p><b>" + title + "</b></p></td>");
            out.println("<td><img src=\"" + news_image + "\">");
            out.println("<p><b>" + title + "</b></p></td>");
            out.println("</tr>");
        }
        out.println("</table>");
    %>
</div>

<div class="topGames">
    <h3>TOP JUEGOS</h3>
    <%
        String sql = "SELECT * FROM game";

        ResultSet rs = null;
        out.println("<table>");
        try {

            rs = s.executeQuery(sql);
            int i = 0;
            while (rs.next()) {
                if (i >= 5) {
                    break;
                }
                out.println("<tr>");
                out.println("<td><img src=\"" + game_image + "\"></td>");
                out.println("<td><p><b>" + rs.getString("title") + "</b></p>");
                out.println("<p>" + rs.getString("studio") + "</p></td>");
                out.println("</tr>");

                i++;
            }
            for (int j = i; j < 5; j++) {
                out.println("<tr>");
                out.println("<td><img src=\"" + game_image + "\"></td>");
                out.println("<td><p><b>" + title + "</b></p>");
                out.println("<p>" + text + "</p></td>");
                out.println("</tr>");
            }
        } catch (SQLException exc) {
            for (int i = 0; i < 5; i++) {
                out.println("<tr>");
                out.println("<td><img src=\"" + game_image + "\"></td>");
                out.println("<td><p><b>" + title + "</b></p>");
                out.println("<p>" + text + "</p></td>");
                out.println("</tr>");
            }
        }
        out.println("</table>");
    %>
</div>

<div class="topForum">
    <h3>�LTIMAS DISCUSIONES DEL FORO</h3>
    <%
        sql = "SELECT * FROM discussion";
        out.println("<ul>");
        try {
            rs = s.executeQuery(sql);
            int i = 0;
            while (rs.next()) {
                if (i >= 5) {
                    break;
                }
                out.println("<li><p><b>" + rs.getString("subject") + "</b></p></li>");
                i++;
            }
            for (int j = i; j < 5; j++) {
                out.println("<li><p><b>" + title + "</b></p></li>");
            }
        } catch (SQLException exc) {
            for (int i = 0; i < 5; i++) {
                out.println("<li><p><b>" + title + "</b></p></li>");
            }
        }
        out.println("</ul>");
    %>
</div>

<jsp:include page="footer.jsp"/>
