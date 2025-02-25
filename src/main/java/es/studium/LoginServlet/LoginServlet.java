package es.studium.LoginServlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/practicatema4";
    private static final String DB_USER = "usuarioPractica";
    private static final String DB_PASSWORD = "Studium2024;";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String usuario = request.getParameter("usuario");
        String clave = request.getParameter("clave");

        try {
            Usuario user = validarUsuario(usuario, clave);
            if (user != null) {
                // Redirigir a la pantalla principal
                response.sendRedirect("principal.jsp");
            } else {
                // Mostrar error
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<script>mostrarError('Usuario o clave incorrectos'); history.back();</script>");
            }
        } catch (Exception e) {
            // Manejo de excepciones
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<script>mostrarError('Error en el servidor: " + e.getMessage() + "'); history.back();</script>");
            e.printStackTrace(); // Imprime el stack trace en la consola del servidor
        }
    }

    private Usuario validarUsuario(String usuario, String clave) throws ClassNotFoundException, SQLException {
        String query = "SELECT * FROM Usuarios WHERE nombreUsuario = ? AND claveUsuario = ?";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, usuario);
            stmt.setString(2, clave);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Usuario(rs.getInt("idUsuario"), rs.getString("nombreUsuario"), rs.getString("claveUsuario"));
            }
        }
        return null;
    }
}

