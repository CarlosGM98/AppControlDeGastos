<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pantalla Principal</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h2>Gestión Doméstica</h2>
        <h3>ENERO 2023</h3>
        <p>TOTAL ACTUAL: $180.45 €</p>
        <table class="table">
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
                <tr>
                    <td>22/01/2023</td>
                    <td>Mercamona</td>
                    <td>10.50 €</td>
                    <td><a href="editarCompra.jsp?id=1">Editar</a></td>
                    <td><a href="borrarCompra.jsp?id=1">Borrar</a></td>
                </tr>
                <!-- Más filas aquí -->
            </tbody>
        </table>
        <a href="nuevaCompra.jsp" class="btn btn-primary">Nueva Compra</a>
        <a href="tiendas.jsp" class="btn btn-secondary">Tiendas</a>
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
