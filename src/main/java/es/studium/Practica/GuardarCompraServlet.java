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

@WebServlet("/GuardarCompraServlet")
public class GuardarCompraServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/practicatema4";
    private static final String DB_USER = "usuarioPractica";
    private static final String DB_PASSWORD = "Studium2024;";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fechaCompra = request.getParameter("fechaCompra");
        double importeCompra = Double.parseDouble(request.getParameter("importeCompra"));
        int idTiendaFK = Integer.parseInt(request.getParameter("idTiendaFK"));
        int idUsuarioFK = 1; // Aquí debes obtener el ID del usuario logueado

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String query = "INSERT INTO Compras (fechaCompra, importeCompra, idUsuarioFK, idTiendaFK) VALUES (?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setDate(1, java.sql.Date.valueOf(fechaCompra));
                stmt.setDouble(2, importeCompra);
                stmt.setInt(3, idUsuarioFK);
                stmt.setInt(4, idTiendaFK);
                stmt.executeUpdate();
            }
            response.sendRedirect("principal.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}

