<jsp:include page="header.jsp"/>
<%
	String title = "Lorem ipsum dolor sit amet consectetur.";
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
	
	out.println("<table>");
	for (int i = 0; i < 5; i++) {
            out.println("<tr>");
            out.println("<td><img src=\"" + game_image + "\"></td>");
            out.println("<td><p><b>" + title + "</b></p>");
            out.println("<p>" + text + "</p></td>");
            out.println("</tr>");
	}
	out.println("</table>");
%>
		</div>

		<div class="topForum">
			<h3>?LTIMOS MENSAJES DEL FORO</h3>
<%
	out.println("<ul>");
	for (int i = 0; i < 5; i++) {
		out.println("<li><p><b>" + title + "</b></p></li>");
	}
	out.println("</ul>");
%>
		</div>

<jsp:include page="footer.jsp"/>
