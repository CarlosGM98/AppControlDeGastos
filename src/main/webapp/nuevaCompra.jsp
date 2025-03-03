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
    <title>Nueva Compra</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script>
        function mostrarExito() {
            alert("La compra se ha creado con éxito.");
            window.location.href = "principal.jsp"; // Redirige a la página principal
        }

        function limpiarFormulario() {
            document.getElementById("fechaCompra").value = "";
            document.getElementById("importeCompra").value = "";
            document.getElementById("idTiendaFK").selectedIndex = 0;
        }
    </script>
</head>
<body>
    <div class="container mt-4">
        <h2>Nueva Compra</h2>
        <form action="GuardarCompraServlet" method="post" onsubmit="mostrarExito()">
            <div class="form-group">
                <label for="fechaCompra">Fecha:</label>
                <input type="date" id="fechaCompra" name="fechaCompra" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="importeCompra">Importe:</label>
                <input type="number" step="0.01" id="importeCompra" name="importeCompra" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="idTiendaFK">Tienda:</label>
                <select id="idTiendaFK" name="idTiendaFK" class="form-control" required>
                    <option value="" disabled selected>Selecciona una tienda</option>
                    <%
                        try {
                            // Usar la clase ConexionBD para obtener la conexión
                            Connection conn = ConexionBD.getConnection();
                            String query = "SELECT idTienda, nombreTienda FROM Tiendas";
                            PreparedStatement stmt = conn.prepareStatement(query);
                            ResultSet rs = stmt.executeQuery();

                            while (rs.next()) {
                    %>
                    <option value="<%= rs.getInt("idTienda") %>"><%= rs.getString("nombreTienda") %></option>
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
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Aceptar</button>
            <button type="reset" class="btn btn-secondary" onclick="limpiarFormulario()">Limpiar</button>
            <a href="principal.jsp" class="btn btn-secondary">Volver</a>
        </form>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
