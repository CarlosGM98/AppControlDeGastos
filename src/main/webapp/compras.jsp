<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Compras</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h2>Compras</h2>
        <a href="nuevaCompra.jsp" class="btn btn-primary mb-3">Nueva Compra</a>
        <table class="table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Fecha</th>
                    <th>Importe</th>
                    <th>Tienda</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // Aquí puedes cargar las compras desde la base de datos
                    // Ejemplo:
                    // <tr>
                    //     <td>1</td>
                    //     <td>2023-01-01</td>
                    //     <td>10.50</td>
                    //     <td>Tienda 1</td>
                    //     <td>
                    //         <a href="editarCompra.jsp?id=1" class="btn btn-warning">Editar</a>
                    //         <a href="EliminarCompraServlet?id=1" class="btn btn-danger">Eliminar</a>
                    //     </td>
                    // </tr>
                %>
            </tbody>
        </table>
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
