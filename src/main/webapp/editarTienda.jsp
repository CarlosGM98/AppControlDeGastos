<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Tienda</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h2>Editar Tienda</h2>
        <form action="ActualizarTiendaServlet" method="post">
            <input type="hidden" id="idTienda" name="idTienda" value="${tienda.idTienda}">
            <div class="form-group">
                <label for="nombreTienda">Nombre de la Tienda:</label>
                <input type="text" id="nombreTienda" name="nombreTienda" class="form-control" value="${tienda.nombreTienda}" required>
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
