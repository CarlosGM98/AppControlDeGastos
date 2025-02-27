package es.studium.Practica;


import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/GuardarTiendaServlet")
public class GuardarTiendaServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombreTienda = request.getParameter("nombreTienda");

        try (Connection conn = ConexionBD.getConnection()) {
            String query = "INSERT INTO Tiendas (nombreTienda) VALUES (?)";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, nombreTienda);
                stmt.executeUpdate();
            }
            response.sendRedirect("tiendas.jsp"); // Redirige a la lista de tiendas
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}

