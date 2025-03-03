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

@WebServlet("/EliminarCompraServlet")
public class EliminarCompraServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idCompra = Integer.parseInt(request.getParameter("id"));

        try (Connection conn = ConexionBD.getConnection()) {
            String query = "DELETE FROM Compras WHERE idCompra = ?";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setInt(1, idCompra);
                stmt.executeUpdate();
            }
            response.sendRedirect("principal.jsp?mensaje=Compra borrada con éxito"); // Redirige a la página principal con un mensaje de éxito
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
