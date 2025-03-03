<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="es.studium.Practica.ConexionBD" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Tiendas</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script>
        function confirmarBorrado(idTienda) {
            if (confirm("¿Estás seguro de que deseas borrar esta tienda?")) {
                window.location.href = "EliminarTiendaServlet?id=" + idTienda;
            }
        }
    </script>
</head>
<body>
    <div class="container mt-4">
        <h2>Gestión de Tiendas</h2>
        <a href="nuevaTienda.jsp" class="btn btn-primary mb-3">Nueva Tienda</a>
        <a href="principal.jsp" class="btn btn-secondary mb-3">Volver</a>

        <!-- Mensaje de éxito o error -->
        <%
            String mensaje = request.getParameter("mensaje");
            if (mensaje != null) {
        %>
        <div class="alert alert-warning" role="alert">
            <%= mensaje %>
        </div>
        <%
            }
        %>

        <!-- Tabla de Tiendas -->
        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            // Usar la clase ConexionBD para obtener la conexión
                            Connection conn = ConexionBD.getConnection();
                            Statement stmt = conn.createStatement();
                            String query = "SELECT * FROM Tiendas";
                            ResultSet rs = stmt.executeQuery(query);

                            while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getInt("idTienda") %></td>
                        <td><%= rs.getString("nombreTienda") %></td>
                        <td>
                            <a href="editarTienda.jsp?id=<%= rs.getInt("idTienda") %>" class="btn btn-warning">Editar</a>
                            <a href="#" onclick="confirmarBorrado(<%= rs.getInt("idTienda") %>)" class="btn btn-danger">Borrar</a>
                        </td>
                    </tr>
                    <%
                            }
                            rs.close();
                            stmt.close();
                            conn.close();
                        } catch (Exception e) {
                            out.println("<script>alert('Error al cargar las tiendas: " + e.getMessage() + "');</script>");
                            e.printStackTrace(); // Imprime el stack trace en la consola del servidor
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
