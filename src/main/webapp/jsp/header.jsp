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
            <a class="topBarLink">NOTICIAS</a>
            <a class="topBarLink">FORO</a>
            <a class="topBarLink">PLATAFORMAS</a>
            <a href="login.jsp"><img src="../css-files/images/login.png"></a>
            <form action="resultOfSearchGames.jsp" class="topBarForm" method="get">
                <input type=text placeholder="Buscar juegos" name="search_games">
            </form>
           <img src="../css-files/images/search.png" class="topBarSearch">

            <%
                if (session.getAttribute("User") != null) {
                    User user = (User) session.getAttribute("User");
                    if (user instanceof Admin) {
                        out.println("<a href=\"addGame.jsp\">AÑADIR JUEGO</a>");
                    }
                }
            %>
        </div>
