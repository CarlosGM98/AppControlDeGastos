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

@WebServlet("/ActualizarCompraServlet")
public class ActualizarCompraServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idCompra = Integer.parseInt(request.getParameter("idCompra"));
        String fechaCompra = request.getParameter("fechaCompra");
        double importeCompra = Double.parseDouble(request.getParameter("importeCompra"));
        int idTiendaFK = Integer.parseInt(request.getParameter("idTiendaFK"));

        try (Connection conn = ConexionBD.getConnection()) {
            String query = "UPDATE Compras SET fechaCompra = ?, importeCompra = ?, idTiendaFK = ? WHERE idCompra = ?";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setDate(1, java.sql.Date.valueOf(fechaCompra));
                stmt.setDouble(2, importeCompra);
                stmt.setInt(3, idTiendaFK);
                stmt.setInt(4, idCompra);
                stmt.executeUpdate();
            }
            response.sendRedirect("principal.jsp?mensaje=Compra actualizada con éxito"); // Redirige a la página principal con un mensaje de éxito
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}

