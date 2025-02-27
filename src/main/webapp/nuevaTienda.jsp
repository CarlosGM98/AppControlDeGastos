<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nueva Tienda</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script>
        function mostrarExito() {
            alert("La tienda se ha creado con éxito.");
            window.location.href = "tiendas.jsp"; // Redirige a la lista de tiendas
        }
    </script>
</head>
<body>
    <div class="container mt-4">
        <h2>Nueva Tienda</h2>
        <form action="GuardarTiendaServlet" method="post" onsubmit="mostrarExito()">
            <div class="form-group">
                <label for="nombreTienda">Nombre de la Tienda:</label>
                <input type="text" id="nombreTienda" name="nombreTienda" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary">Aceptar</button>
            <a href="tiendas.jsp" class="btn btn-secondary">Volver</a>
        </form>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
