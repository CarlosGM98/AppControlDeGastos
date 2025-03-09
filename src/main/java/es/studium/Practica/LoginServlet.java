package es.studium.Practica;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/practicatema4";
    private static final String DB_USER = "usuarioPractica";
    private static final String DB_PASSWORD = "Studium2024;";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String usuario = request.getParameter("usuario");
        String clave = request.getParameter("clave");

        try {
            Usuario user = validarUsuario(usuario, clave);
            if (user != null) {
                // Redirigir a la página principal si las credenciales son correctas
            	int idUser = user.getIdUsuario();
            	HttpSession session = request.getSession();
            	session.setAttribute("idUsuario", idUser+""); //Permite usar el ID autenticado en el restod e la app
//            	String nextPage = "/principal.jsp";
//            	ServletContext servletContext = getServletContext(); 
//            	  RequestDispatcher requestDispatcher = 
//            	servletContext.getRequestDispatcher(nextPage); 
//            	  requestDispatcher.forward(request,  response); 
                response.sendRedirect("principal.jsp");
            } else {
                // Mostrar error si las credenciales son incorrectas
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<script>alert('Usuario o clave incorrectos'); history.back();</script>");
            }
        } catch (Exception e) {
            // Manejo de errores del servidor
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('Error en el servidor: " + e.getMessage() + "'); history.back();</script>");
            e.printStackTrace();
        }
    }

    private Usuario validarUsuario(String usuario, String clave) throws ClassNotFoundException, SQLException {
        String query = "SELECT idUsuario, nombreUsuario, claveUsuario FROM Usuarios WHERE nombreUsuario = ?";

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, usuario);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) { // Si encuentra el usuario
                String usuarioBD = rs.getString("nombreUsuario");
                String claveEncriptadaBD = rs.getString("claveUsuario");
                String claveIngresadaEncriptada = encriptarSHA256(clave); // Encriptamos la clave ingresada

                // Comparamos usuario y contraseña
                if (usuario.equals(usuarioBD) && claveIngresadaEncriptada.equals(claveEncriptadaBD)) {
                    return new Usuario(rs.getInt("idUsuario"), usuarioBD, claveEncriptadaBD);
                }
            }
        }
        return null; // Usuario no encontrado o credenciales incorrectas
    }

    private String encriptarSHA256(String clave) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = digest.digest(clave.getBytes());
            StringBuilder hexString = new StringBuilder();
            for (byte b : hashBytes) {
                hexString.append(String.format("%02x", b));
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error: Algoritmo SHA-256 no disponible", e);
        }
    }
}
