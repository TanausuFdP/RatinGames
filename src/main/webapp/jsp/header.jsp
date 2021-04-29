<html>
	<head>
		<meta charset="UTF-8">
		<title>RatinGames</title>
		<link rel="stylesheet" href="../css-files/styles.css">
	</head>
	<body>
		<div class="topBar">
                        <p>Ratin'Games</p>
                        <a href="index.jsp">Inicio</a>
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
                    out.println(
                            "<a href=\"login.jsp\">LogOut</a>");
                                //cerrar sesion


                }else{
                    out.println(
                            "<a href=\"login.jsp\">LogIn</a>");
                }
 
        
    %>
		</div>