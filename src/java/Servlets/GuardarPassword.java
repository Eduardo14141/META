package Servlets;

import Java.AccionesCuenta;
import TablasSQL.Cuenta;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class GuardarPassword extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession sesion = (HttpSession) request.getSession();
        Cuenta q = (Cuenta) sesion.getAttribute("Usuario");
        String pass= request.getParameter("pass2");        
        if(pass== null || pass.trim().isEmpty() || q==null || q.getIdCuenta()==0) response.sendRedirect("Cuenta.jsp");
        else{
            String d= q.getEmail();
            pass= cifrarBase64(pass);
            int status= AccionesCuenta.ActualizarPassword(q.getIdCuenta(), pass);
            if(status>0){
                sesion.removeAttribute("Usuario");
                Cuenta UsuarioActivo = AccionesCuenta.IniciarS(d, pass);
                sesion.setAttribute("Usuario", UsuarioActivo);
                request.setAttribute("CA", "Cambios guardados con éxito");
                request.getRequestDispatcher("Cuenta.jsp").forward(request, response);
                response.sendRedirect("Cuenta.jsp");
                System.out.println("Contraseña cambiada con éxito");
            }else{
                System.out.println("Error al cambiar contraseña");
                request.setAttribute("CD", "Error al actualizar los datos, por favor inténtalo más tarde");
                request.getRequestDispatcher("Cuenta.jsp").forward(request, response);
            }
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }
    public static String cifrarBase64(String a){
        Base64.Encoder encoder = Base64.getEncoder();
        return encoder.encodeToString(a.getBytes(StandardCharsets.UTF_8));
    }
}