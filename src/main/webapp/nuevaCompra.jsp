<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nueva Compra</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h2>Nueva Compra</h2>
        <form action="GuardarCompraServlet" method="post">
            <div class="form-group">
                <label for="fecha">Fecha:</label>
                <input type="date" id="fecha" name="fecha" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="tienda">Tienda:</label>
                <select id="tienda" name="tienda" class="form-control" required>
                    <!-- Opciones de tiendas aquí -->
                </select>
            </div>
            <div class="form-group">
                <label for="importe">Importe:</label>
                <input type="number" step="0.01" id="importe" name="importe" class="form-control" required>
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
