package es.studium.Practica;


import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EliminarTiendaServlet")
public class EliminarTiendaServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idTienda = Integer.parseInt(request.getParameter("id"));

        try (Connection conn = ConexionBD.getConnection()) {
            // Verificar si la tienda tiene compras asociadas
            String queryCheck = "SELECT COUNT(*) AS totalCompras FROM Compras WHERE idTiendaFK = ?";
            try (PreparedStatement stmtCheck = conn.prepareStatement(queryCheck)) {
                stmtCheck.setInt(1, idTienda);
                ResultSet rsCheck = stmtCheck.executeQuery();
                if (rsCheck.next() && rsCheck.getInt("totalCompras") > 0) {
                    // La tienda tiene compras asociadas
                    response.sendRedirect("tiendas.jsp?mensaje=No se puede eliminar la tienda porque tiene compras asociadas.");
                    return;
                }
            }

            // Si no tiene compras asociadas, eliminar la tienda
            String queryDelete = "DELETE FROM Tiendas WHERE idTienda = ?";
            try (PreparedStatement stmtDelete = conn.prepareStatement(queryDelete)) {
                stmtDelete.setInt(1, idTienda);
                stmtDelete.executeUpdate();
            }
            response.sendRedirect("tiendas.jsp?mensaje=Tienda borrada exitosamente"); // Redirige a la lista de tiendas con un mensaje de éxito
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}

