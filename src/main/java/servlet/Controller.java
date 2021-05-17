package servlet;


import es.ulpgc.ratingames.model.New;
import es.ulpgc.ratingames.model.NewDAO;
import java.io.IOException;
import java.io.InputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;


@WebServlet(name = "Controller", urlPatterns = {"/Controller"})
@MultipartConfig
public class Controller extends HttpServlet {
    NewDAO dao = new NewDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
        int id = Integer.parseInt(request.getParameter("id"));
        dao.listarIMG(id, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        switch(accion){

            case "Guardar":
                String titulo = request.getParameter("txtNom");
                Integer idJournalist = Integer.parseInt(request.getParameter("journalistId"));
                String body = request.getParameter("subject");
                Part part = request.getPart("fileFoto");
                InputStream is = part.getInputStream();
                New n = new New(0, titulo, body, idJournalist, is);
                dao.agregar(n);
                response.sendRedirect("jsp/addNew.jsp");

                break;
                
            case "Eliminar":
                Integer newId = Integer.parseInt(request.getParameter("newId"));
                dao.eliminar(newId);
                response.sendRedirect("jsp/index.jsp");

                break;
            default:
                break;
        }
        
    }
}
