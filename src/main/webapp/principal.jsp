<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
</head>
<body>
    <div class="container">
        <h2>Gestión Doméstica</h2>
        <h3>Compras del Mes Actual</h3>

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
                        // Aquí puedes cargar las compras del mes actual desde la base de datos
                        // Ejemplo:
                        // <tr>
                        //     <td>22/01/2023</td>
                        //     <td>Mercamona</td>
                        //     <td>10.50 €</td>
                        //     <td><a href="editarCompra.jsp?id=1" class="btn btn-warning">Editar</a></td>
                        //     <td><a href="EliminarCompraServlet?id=1" class="btn btn-danger">Borrar</a></td>
                        // </tr>
                    %>
                </tbody>
            </table>
        </div>

        <!-- Botones de Acción -->
        <div class="mt-3">
            <a href="nuevaCompra.jsp" class="btn btn-primary">Nueva Compra</a>
            <a href="tiendas.jsp" class="btn btn-secondary">Gestionar Tiendas</a>
            <a href="informes.jsp" class="btn btn-info">Generar Informe</a>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

