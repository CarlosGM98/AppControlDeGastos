<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Informes</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h2>Informes</h2>
        <form action="GenerarInformeServlet" method="post">
            <div class="form-group">
                <label for="mes">Selecciona el Mes:</label>
                <select id="mes" name="mes" class="form-control" required>
                    <!-- Opciones de meses aquí -->
                    <option value="2023-01">Enero 2023</option>
                    <option value="2023-02">Febrero 2023</option>
                    <!-- Añade más opciones según sea necesario -->
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Generar Informe</button>
        </form>
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
