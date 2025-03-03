package es.studium.Practica;


import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener la sesión del usuario
        HttpSession session = request.getSession(false);

        if (session != null) {
            // Invalidar la sesión
            session.invalidate();
        }

        // Redirigir a la página de login
        response.sendRedirect("login.jsp");
    }
}

