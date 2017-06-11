package servlets;

/**
 * Created by vincent on 11/06/17.
 */
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class Etudiant extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException {

        response.setContentType("text/html");
        response.setCharacterEncoding( "UTF-8" );
        response.addHeader("Access-Control-Allow-Origin", "http://www.example.com");
        this.getServletContext().getRequestDispatcher( "/WEB-INF/etudiant.jsp" ).forward( request, response );
    }
}