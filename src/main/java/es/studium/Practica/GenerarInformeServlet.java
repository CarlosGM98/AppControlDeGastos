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
import javax.servlet.http.HttpSession;

@WebServlet("/GenerarInformeServlet")
public class GenerarInformeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession();
    	String mesAnio = request.getParameter("mes");
        String[] partes = mesAnio.split(" de ");
        int mes = obtenerNumeroMes(partes[0]);
        int anio = Integer.parseInt(partes[1]);
        int idUsuarioFK = Integer.parseInt(session.getAttribute("idUsuario").toString());
        
        try (Connection conn = ConexionBD.getConnection()) {
            // Calcular el total gastado en el mes seleccionado
            String queryTotal = "SELECT SUM(importeCompra) AS totalGastado FROM Compras WHERE MONTH(fechaCompra) = ? AND YEAR(fechaCompra) = ? AND idUsuarioFK = ? ";
            try (PreparedStatement stmtTotal = conn.prepareStatement(queryTotal)) {
                stmtTotal.setInt(1, mes);
                stmtTotal.setInt(2, anio);
                stmtTotal.setInt(3, idUsuarioFK);
                ResultSet rsTotal = stmtTotal.executeQuery();
                double totalGastado = rsTotal.next() ? rsTotal.getDouble("totalGastado") : 0;

                // Guardar los resultados en el request
                request.setAttribute("totalGastado", totalGastado);
                request.setAttribute("mesAnio", mesAnio);

                // Redirigir a la página de informes con los datos
                request.getRequestDispatcher("informes.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private int obtenerNumeroMes(String nombreMes) {
        switch (nombreMes) {
            case "Enero": return 1;
            case "Febrero": return 2;
            case "Marzo": return 3;
            case "Abril": return 4;
            case "Mayo": return 5;
            case "Junio": return 6;
            case "Julio": return 7;
            case "Agosto": return 8;
            case "Septiembre": return 9;
            case "Octubre": return 10;
            case "Noviembre": return 11;
            case "Diciembre": return 12;
            default: return 0;
        }
    }
}


