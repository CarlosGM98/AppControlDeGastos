<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="es.studium.Practica.ConexionBD" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Generar Informe</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
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
    <div class="container mt-4">
        <h2>Generar Informe de Compras</h2>
        <form action="GenerarInformeServlet" method="post">
            <div class="form-group">
                <label for="mes">Mes:</label>
                <select id="mes" name="mes" class="form-control" required>
                    <%
                        List<String> mesesConCompras = new ArrayList<>();
                        try (Connection conn = ConexionBD.getConnection()) {
                            String query = "SELECT DISTINCT MONTH(fechaCompra) AS mes, YEAR(fechaCompra) AS anio FROM Compras ORDER BY anio DESC, mes DESC";
                            try (PreparedStatement stmt = conn.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {
                                while (rs.next()) {
                                    int mes = rs.getInt("mes");
                                    int anio = rs.getInt("anio");
                                    String mesAnio = obtenerNombreMes(mes) + " de " + anio;
                                    mesesConCompras.add(mesAnio);
                                }
                            } catch (SQLException e) {
                                out.println("<script>console.log('Error al cargar los meses: " + e.getMessage() + "');</script>");
                            }
                        } catch (SQLException e) {
                            out.println("<script>console.log('Error al conectar a la base de datos: " + e.getMessage() + "');</script>");
                        }

                        for (String mesAnio : mesesConCompras) {
                    %>
                    <option value="<%= mesAnio %>"><%= mesAnio %></option>
                    <%
                        }
                    %>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Generar Informe</button>
            <a href="nuevaCompra.jsp" class="btn btn-success">Nueva Compra</a>
            <a href="principal.jsp" class="btn btn-secondary">Volver</a>
        </form>

        <%
            String mesAnioSeleccionado = request.getParameter("mes");
            if (mesAnioSeleccionado != null) {
                String[] partes = mesAnioSeleccionado.split(" de ");
                int mes = obtenerNumeroMes(partes[0]);
                int anio = Integer.parseInt(partes[1]);

                try (Connection conn = ConexionBD.getConnection()) {
                    // Calcular el total gastado en el mes seleccionado
                    String queryTotal = "SELECT SUM(importeCompra) AS totalGastado FROM Compras WHERE MONTH(fechaCompra) = ? AND YEAR(fechaCompra) = ?";
                    try (PreparedStatement stmtTotal = conn.prepareStatement(queryTotal)) {
                        stmtTotal.setInt(1, mes);
                        stmtTotal.setInt(2, anio);
                        ResultSet rsTotal = stmtTotal.executeQuery();
                        double totalGastado = rsTotal.next() ? rsTotal.getDouble("totalGastado") : 0;

                        // Obtener el desglose por tiendas y fechas
                        String queryDesglose = "SELECT c.idCompra, c.fechaCompra, t.nombreTienda, c.importeCompra, c.idTiendaFK " +
                                               "FROM Compras c " +
                                               "JOIN Tiendas t ON c.idTiendaFK = t.idTienda " +
                                               "WHERE MONTH(c.fechaCompra) = ? AND YEAR(c.fechaCompra) = ? " +
                                               "ORDER BY c.fechaCompra DESC";
                        try (PreparedStatement stmtDesglose = conn.prepareStatement(queryDesglose)) {
                            stmtDesglose.setInt(1, mes);
                            stmtDesglose.setInt(2, anio);
                            ResultSet rsDesglose = stmtDesglose.executeQuery();

                            SimpleDateFormat formatoFecha = new SimpleDateFormat("dd/MM/yyyy");
        %>
        <h3>Informe de Compras para <%= mesAnioSeleccionado %></h3>
        <h4>Total Gastado: <%= totalGastado %> €</h4>
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
                        while (rsDesglose.next()) {
                            String fechaFormateada = formatoFecha.format(rsDesglose.getDate("fechaCompra"));
                    %>
                    <tr>
                        <td><%= fechaFormateada %></td>
                        <td><%= rsDesglose.getString("nombreTienda") %></td>
                        <td><%= rsDesglose.getDouble("importeCompra") %> €</td>
                        <td><a href="editarCompra.jsp?id=<%= rsDesglose.getInt("idCompra") %>&fecha=<%= fechaFormateada %>&importe=<%= rsDesglose.getDouble("importeCompra") %>&tienda=<%= rsDesglose.getInt("idTiendaFK") %>" class="btn btn-warning">Editar</a></td>
                        <td><a href="#" onclick="confirmarBorrado(<%= rsDesglose.getInt("idCompra") %>)" class="btn btn-danger">Borrar</a></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
        <%
                        } catch (SQLException e) {
                            out.println("<script>console.log('Error al obtener el desglose: " + e.getMessage() + "');</script>");
                        }
                    } catch (SQLException e) {
                        out.println("<script>console.log('Error al calcular el total gastado: " + e.getMessage() + "');</script>");
                    }
                } catch (SQLException e) {
                    out.println("<script>console.log('Error al conectar a la base de datos: " + e.getMessage() + "');</script>");
                }
            }
        %>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

<%!
    // Método para obtener el nombre del mes
    private String obtenerNombreMes(int mes) {
        switch (mes) {
            case 1: return "Enero";
            case 2: return "Febrero";
            case 3: return "Marzo";
            case 4: return "Abril";
            case 5: return "Mayo";
            case 6: return "Junio";
            case 7: return "Julio";
            case 8: return "Agosto";
            case 9: return "Septiembre";
            case 10: return "Octubre";
            case 11: return "Noviembre";
            case 12: return "Diciembre";
            default: return "";
        }
    }

    // Método para obtener el número del mes
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
%>

