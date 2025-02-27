<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Compra</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h2>Editar Compra</h2>
        <form action="ActualizarCompraServlet" method="post">
            <input type="hidden" id="idCompra" name="idCompra" value="${compra.idCompra}">
            <div class="form-group">
                <label for="fechaCompra">Fecha:</label>
                <input type="date" id="fechaCompra" name="fechaCompra" class="form-control" value="${compra.fechaCompra}" required>
            </div>
            <div class="form-group">
                <label for="importeCompra">Importe:</label>
                <input type="number" step="0.01" id="importeCompra" name="importeCompra" class="form-control" value="${compra.importeCompra}" required>
            </div>
            <div class="form-group">
                <label for="idTiendaFK">Tienda:</label>
                <select id="idTiendaFK" name="idTiendaFK" class="form-control" required>
                    <!-- Opciones de tiendas aquí -->
                    <%
                        // Aquí puedes cargar las tiendas desde la base de datos
                        // Ejemplo:
                        // <option value="1" ${compra.idTiendaFK == 1 ? "selected" : ""}>Tienda 1</option>
                    %>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Aceptar</button>
            <button type="reset" class="btn btn-secondary">Limpiar</button>
        </form>
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
