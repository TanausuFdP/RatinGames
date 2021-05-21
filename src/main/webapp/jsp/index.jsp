<%@page import="es.ulpgc.ratingames.model.NewDAO"%>
<%@page import="java.sql.ResultSet"%>
<jsp:include page="header.jsp"/>
<%@include file="BBDDConnection.jsp"%>
<%    
    String title = "Lorem ipsum dolor sit amet consectetur.";
    String text = "Adipiscing elit auctor, ultrices vivamus consequat vulputate purus.";
    String news_image = "../css-files/images/news_sample.jpg";
    String game_image = "../css-files/images/game_sample.png";
    ResultSet rs = null;
%>
<div class="topNews">
    <h3>�LTIMAS NOTICIAS</h3>
    <div class="firstTopNew">
        <%
            String sql = "SELECT * FROM new ORDER BY date DESC";
            rs = s.executeQuery(sql);
            if(rs.next()){
                out.println("<td><a href=\"viewNew.jsp?newId="+ rs.getInt("id") +"\"><img src=\"../Controller?id="+ rs.getInt("id") +"\" width=\"45%\"></a>");
                out.println("<h3>" + rs.getString("title") + "</h3></td><br>");
            }else{
                out.println("<td><img src=\""+ news_image +"\" width=\"45%\">");
                out.println("<h3>" + title + "</h3></td><br>");
            }
        %>
    </div>
    <%
        out.println("<table>");
        int i = 0;
        try {
            while (rs.next() && i < 8) {
                i++;
                if(i%2!=0){
                    out.println("<tr>");
                }
                out.println("<td><a href=\"viewNew.jsp?newId="+ rs.getInt("id") +"\"><img src=\"../Controller?id="+ rs.getInt("id") +"\" width=\"45%\">");
                out.println("<h3>" + rs.getString("title") + "</h3></td>");
                if(i%2==0){
                    out.println("</tr>");
                }
            }
        } catch (SQLException exc) {}
        for (int j = i; j < 8;) {
            j++;
            if(j%2!=0){
                out.println("<tr>");
            }
            out.println("<td><img src=\"" + news_image + "\">");
            out.println("<p><b>" + title + "</b></p></td>");
            if(j%2==0){
                out.println("</tr>");
            }
        }
        out.println("</table>");
    %>
</div>
<div class="topGames">
    <h3>JUEGOS M�S RECIENTES</h3>
    <%
        sql = "SELECT * FROM game ORDER BY releaseDate DESC";
        rs = null;
        out.println("<table>");
        try {

            rs = s.executeQuery(sql);
            i = 0;
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
            for (i = 0; i < 5; i++) {
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
        sql = "SELECT * FROM discussion ORDER BY id DESC";
        out.println("<ul>");
        try {
            rs = s.executeQuery(sql);
            i = 0;
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
            for (i = 0; i < 5; i++) {
                out.println("<li><p><b>" + title + "</b></p></li>");
            }
        }
        out.println("</ul>");
    %>
</div>
    
<jsp:include page="footer.jsp"/>
