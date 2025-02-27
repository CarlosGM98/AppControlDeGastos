<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="es.studium.Practica.ConexionBD" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Tienda</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2>Editar Tienda</h2>
        <%
            try {
                // Usar la clase ConexionBD para obtener la conexión
                Connection conn = ConexionBD.getConnection();
                int idTienda = Integer.parseInt(request.getParameter("id"));
                String query = "SELECT * FROM Tiendas WHERE idTienda = ?";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setInt(1, idTienda);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    String nombreTienda = rs.getString("nombreTienda");
        %>
        <form action="ActualizarTiendaServlet" method="post">
            <input type="hidden" id="idTienda" name="idTienda" value="<%= idTienda %>">
            <div class="form-group">
                <label for="nombreTienda">Nombre de la Tienda:</label>
                <input type="text" id="nombreTienda" name="nombreTienda" class="form-control" value="<%= nombreTienda %>" required>
            </div>
            <button type="submit" class="btn btn-primary">Aceptar</button>
            <a href="tiendas.jsp" class="btn btn-secondary">Volver</a>
        </form>
        <%
                } else {
                    out.println("<script>alert('Tienda no encontrada.'); history.back();</script>");
                }
                rs.close();
                stmt.close();
                conn.close();
            } catch (Exception e) {
                out.println("<script>alert('Error al cargar los datos de la tienda: " + e.getMessage() + "');</script>");
                e.printStackTrace(); // Imprime el stack trace en la consola del servidor
            }
        %>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

