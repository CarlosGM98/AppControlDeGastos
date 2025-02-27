package es.studium.Practica;

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

@WebServlet("/GenerarInformeServlet")
public class GenerarInformeServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/practicatema4";
    private static final String DB_USER = "usuarioPractica";
    private static final String DB_PASSWORD = "Studium2024;";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String mes = request.getParameter("mes");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String query = "SELECT * FROM Compras WHERE fechaCompra LIKE ?";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, mes + "%");
                ResultSet rs = stmt.executeQuery();

                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<html><body>");
                out.println("<h2>Informe de Compras para el Mes de " + mes + "</h2>");
                out.println("<table border='1'>");
                out.println("<tr><th>ID</th><th>Fecha</th><th>Importe</th><th>Tienda</th></tr>");

                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getInt("idCompra") + "</td>");
                    out.println("<td>" + rs.getDate("fechaCompra") + "</td>");
                    out.println("<td>" + rs.getDouble("importeCompra") + "</td>");
                    out.println("<td>" + rs.getInt("idTiendaFK") + "</td>");
                    out.println("</tr>");
                }

                out.println("</table>");
                out.println("</body></html>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}

