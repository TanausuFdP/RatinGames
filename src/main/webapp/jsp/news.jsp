<%@page import="es.ulpgc.ratingames.model.User"%>
<%@page import="es.ulpgc.ratingames.model.Journalist"%>
<%@page import="java.sql.ResultSet"%>
<jsp:include page="header.jsp"/>
<%@include file="BBDDConnection.jsp"%>

<div class="searchNews">
    <h2>Buscar noticias</h2>
    <form>
        <input type="text" placeholder="Buscar noticias..." name="searchNews">
        <input type="submit" value="Buscar">
    </form>
</div>

<% 
    User user = (User) session.getAttribute("User");
    if(user instanceof Journalist){
        out.println("<div class=\"rating\">"
                + "<form action=\"addNew.jsp\" method=\"post\">"
                + "<input type=\"submit\" value=\"Publicar Noticia\">"
                + "</form>"
                + "</div>"); 
    }
    if(request.getParameter("searchNews") != null){
%>
<div class="results">
<table class="searchGamesTable">
    <tr>
        <th><h2>Título</h2></th>
        <th><h2>Periodista</h2></th>
        <th><h2>Fecha</h2></th>
        <th></th>
    </tr>
    <%  
        String anterior = request.getParameter("anterior");
        String siguiente = request.getParameter("siguiente");
        String search = request.getParameter("searchNews").toLowerCase();
        String count = "SELECT COUNT(*) "
                        + "FROM `new` "
                        + "WHERE title LIKE '%" + search + "%'";

        ResultSet rs = s.executeQuery(count);

        int regs = 0;
        if(rs.next()){
            regs = rs.getInt(1);
        }

        int maxPages;
        if (regs % 10 == 0) {
            maxPages = regs / 10;
        } else {
            maxPages = (regs / 10) + 1;
        }

        Integer actualPage = (Integer) session.getAttribute("pageNews");
        if (actualPage == null) {
            actualPage = 0;
        }
        if (anterior != null) {
            actualPage--;
        }
        if (siguiente != null) {
            actualPage++;
        }
        session.setAttribute("pageNews", actualPage);
        
        String sql = "SELECT N.id, N.title, N.`date`, U.username FROM `new` N, `user` U "
                + "WHERE N.title LIKE '%" + search + "%' AND "
                + "U.id=(SELECT userId FROM journalist WHERE id=N.journalistId) "
                + "ORDER BY N.`date` DESC;";

        rs = null;
        Statement aux = null;
        try {
            rs = s.executeQuery(sql);
            aux = conexion.createStatement();
        } catch (SQLException exc) {
            exc.printStackTrace();
        }
        
        try {
            int minReg = 1 + (10 * actualPage);
            rs.next();
            for (int i = 1; i < minReg; i++) {
                rs.next();
            }

            int maxReg = regs;
            if ((10 * actualPage) + 10 < regs) {
                maxReg = (10 * actualPage) + 10;
            }
            while (minReg <= maxReg) {
                out.println("<tr>"
                        + "<td>" + rs.getString("title") + "</td>"
                        + "<td>" + rs.getString("username") + "</td>"
                        + "<td>" + rs.getString("date") + "</td>"
                        + "<td><form action=\"viewNew.jsp\">"
                        + "<input type=\"hidden\" value=\"" + rs.getInt("id") + "\" name=\"newId\"/>"
                        + "<input type=\"submit\" value=\"Ver noticia\">"
                        + "</form></td>"
                        + "</tr>");
                if (minReg != maxReg) {
                    rs.next();
                }
                minReg++;
            }
            s.close();
            conexion.close();
        } catch (SQLException exc) {
            exc.printStackTrace();
        }

    
    %>
</table>
</div>

<div class="pagination">
                <%
                    if (actualPage != 0) {
                        out.println("<form>"
                                + "<input type=\"hidden\" value=\"" + search + "\" name=\"searchNews\"/>"
                                + "<input type=\"hidden\" value=\"True\" name=\"anterior\"/>"
                                + "<input type=\"submit\" value=\"Anterior\">"
                                + "</form>");
                    }
                    out.println("<p>Pagina actual: <b>" + (actualPage + 1) + "</b></p>");
                    if (actualPage != maxPages - 1) {
                        out.println("<form>"
                                + "<input type=\"hidden\" value=\"" + search + "\" name=\"searchNews\"/>"
                                + "<input type=\"hidden\" value=\"True\" name=\"siguiente\"/>"
                                + "<input type=\"submit\" value=\"Siguiente\">"
                                + "</form>");
                    }
                }
                %>
</div>
</body>
</html>
