<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="es.studium.Practica.ConexionBD" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión Doméstica</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .container {
            margin-top: 20px;
        }
        .table-responsive {
            margin-top: 20px;
        }
    </style>
    <script>
        function confirmarBorrado(idCompra) {
            if (confirm("¿Estás seguro de que deseas borrar esta compra?")) {
                window.location.href = "EliminarCompraServlet?id=" + idCompra;
            }
        }
    </script>
    <script>
        // Mostrar mensaje de éxito o error
        <%
            String mensaje = request.getParameter("mensaje");
            if (mensaje != null) {
        %>
        <script>
            alert('<%= mensaje %>');
        </script>
        <%
            }
        %>
    </script>
</head>
<body>
    <div class="container">
        <h2>Gestión Doméstica</h2>
        <%
            // Obtener el mes actual
            Calendar cal = Calendar.getInstance();
            int mesActual = cal.get(Calendar.MONTH) + 1; // Los meses en Calendar son 0-11
            int añoActual = cal.get(Calendar.YEAR);
            SimpleDateFormat monthFormat = new SimpleDateFormat("MMMM");
            String nombreMesActual = monthFormat.format(cal.getTime());
        %>
        <h3>Compras del Mes Actual (<%= nombreMesActual %> <%= añoActual %>)</h3>

        <!-- Tabla de Compras -->
        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Fecha</th>
                        <th>Tienda</th>
                        <th>Importe</th>
                        <th>Editar</th>
                        <th>Borrar</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            // Usar la clase ConexionBD para obtener la conexión
                            Connection conn = ConexionBD.getConnection();
                            String query = "SELECT c.fechaCompra, t.nombreTienda, c.importeCompra, c.idCompra, c.idTiendaFK " +
                                           "FROM Compras c " +
                                           "JOIN Tiendas t ON c.idTiendaFK = t.idTienda " +
                                           "WHERE MONTH(c.fechaCompra) = ? AND YEAR(c.fechaCompra) = ? AND idUsuarioFK = ? " +
                                           "ORDER BY c.fechaCompra DESC";
                            int idUsuario = Integer.parseInt(session.getAttribute("idUsuario").toString()); 
                            PreparedStatement stmt = conn.prepareStatement(query);
                            stmt.setInt(1, mesActual);
                            stmt.setInt(2, añoActual);
                            stmt.setInt(3, idUsuario);
                            ResultSet rs = stmt.executeQuery();

                            SimpleDateFormat formatoFecha = new SimpleDateFormat("dd/MM/yyyy");
                            SimpleDateFormat formatoFechaEdicion = new SimpleDateFormat("yyyy-MM-dd");

                            while (rs.next()) {
                                String fechaFormateada = formatoFecha.format(rs.getDate("fechaCompra"));
                                String fechaEdicion = formatoFechaEdicion.format(rs.getDate("fechaCompra"));
                    %>
                    <tr>
                        <td><%= fechaFormateada %></td>
                        <td><%= rs.getString("nombreTienda") %></td>
                        <td><%= rs.getDouble("importeCompra") %> €</td>
                        <td><a href="editarCompra.jsp?id=<%= rs.getInt("idCompra") %>&fecha=<%= fechaEdicion %>&importe=<%= rs.getDouble("importeCompra") %>&tienda=<%= rs.getInt("idTiendaFK") %>" class="btn btn-warning">Editar</a></td>
                        <td><a href="#" onclick="confirmarBorrado(<%= rs.getInt("idCompra") %>)" class="btn btn-danger">Borrar</a></td>
                    </tr>
                    <%
                            }
                            rs.close();
                            stmt.close();
                            conn.close();
                        } catch (Exception e) {
                            out.println("<script>alert('Error al cargar las compras: " + e.getMessage() + "');</script>");
                            e.printStackTrace(); // Imprime el stack trace en la consola del servidor
                        }
                    %>
                </tbody>
            </table>
        </div>

        <!-- Botones de Acción -->
        <div class="mt-3">
            <a href="nuevaCompra.jsp" class="btn btn-primary">Nueva Compra</a>
            <a href="tiendas.jsp" class="btn btn-secondary">Gestionar Tiendas</a>
            <a href="informes.jsp" class="btn btn-info">Generar Informe</a>
            <a href="LogoutServlet" class="btn btn-danger">Logout</a>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
