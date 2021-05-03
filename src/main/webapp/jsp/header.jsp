<html>
<head>
    <meta charset="UTF-8">
    <title>RatinGames</title>
    <link rel="stylesheet" href="../css-files/styles.css">
		<link rel="stylesheet" href="../css-files/addGame.css">
</head>
<body>
<div class="topBar">
    <p>Ratin'Games</p>
    <a href="index.jsp">INICIO</a>
    <a>JUEGOS</a>
    <a>NOTICIAS</a>
    <a>FORO</a>
    <a>PLATAFORMAS</a>
    <img src="../css-files/images/login.png">
    <form action="resultOfSearchGames.jsp" class="topBarForm" method="get">
        <input type=text placeholder="Buscar juegos" name="search_games">
    </form>
    <img src="../css-files/images/search.png" class="topBarSearch">

    <%
        if (session.getAttribute("User") != null) {
            out.println("<a href=\"login.jsp\">LOGOUT</a>");
        } else {
            out.println("<a href=\"login.jsp\">LOGIN</a>");
        }
    %>
  </div>
