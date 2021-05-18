<%@page import="es.ulpgc.ratingames.model.Admin"%>
<%@page import="es.ulpgc.ratingames.model.User"%>
<html>
    <head>
        <meta charset="UTF-8">
        <title>RatinGames</title>
        <link rel="stylesheet" href="../css-files/styles.css">
    </head>
    <body>
        <div class="topBar">
            <p><a href="index.jsp" class="topBarLogo">Ratin'Games</a></p>
            <a class="topBarLink">JUEGOS</a>
            <a href="news.jsp" class="topBarLink">NOTICIAS</a>
            <%
                if (session.getAttribute("User") != null) {
                    User user = (User) session.getAttribute("User");
                    out.println("<a href=\"favouriteForum.jsp\" class=\"topBarLink\">FORO</a>");
                    if (user instanceof Admin) {
                        out.println("<a href=\"addGame.jsp\" class=\"topBarLink\">A�ADIR JUEGO</a>");
                    }
                } else {
                    out.println("<a href=\"login.jsp\" class=\"topBarLink\">FORO</a>");
                }
            %>
            <a href="contact.jsp" class="topBarLink">CONTACTO</a>
            <a href="login.jsp"><img src="../css-files/images/login.png"></a>
            <form action="SearchGames.jsp" class="topBarForm" method="get">
                <input type=text placeholder="Buscar juegos" name="search_games">
            </form>
           <img src="../css-files/images/search.png" class="topBarSearch">
        </div>
