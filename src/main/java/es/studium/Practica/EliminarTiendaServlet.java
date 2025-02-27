package es.studium.Practica;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EliminarTiendaServlet")
public class EliminarTiendaServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/practicatema4";
    private static final String DB_USER = "usuarioPractica";
    private static final String DB_PASSWORD = "Studium2024;";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idTienda = Integer.parseInt(request.getParameter("id"));

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String query = "DELETE FROM Tiendas WHERE idTienda = ?";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setInt(1, idTienda);
                stmt.executeUpdate();
            }
            response.sendRedirect("tiendas.jsp"); // Redirige a la lista de tiendas
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}

