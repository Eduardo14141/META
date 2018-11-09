package Servlets;

import Java.AccionesCuenta;
import TablasSQL.Cuenta;
import java.io.IOException;
import java.io.PrintWriter;
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
        Cuenta e = (Cuenta) sesion.getAttribute("Usuario");
        
        String pass= request.getParameter("pass");
        String new_pass= request.getParameter("new_pass");
        System.out.println(pass);
        System.out.println(new_pass);
        PrintWriter out = response.getWriter();
        
        if(e == null || e.getIdCuenta() == 0) out.print("{\"error\":true, \"description\": \"La sesión ha caducado\"}");
        else if(pass == null || pass.trim().isEmpty()) out.print("{\"error\":true, \"description\": \"Se perdieron los datos\"}");
        else if(new_pass == null || new_pass.trim().isEmpty()) out.print("{\"error\":true, \"description\": \"Se perdieron los datos\"}");
        else{
            if(!e.getPassword().equals(pass))
                out.print("{\"error\": true, \"description\": \"la contraseña no coincide\"}");
            String email= e.getEmail();
            pass= cifrarBase64(new_pass);
            int status= AccionesCuenta.ActualizarPassword(e.getIdCuenta(), new_pass);
            if(status>0){
                sesion.removeAttribute("Usuario");
                Cuenta UsuarioActivo = AccionesCuenta.IniciarS(email, pass);
                sesion.setAttribute("Usuario", UsuarioActivo);
                out.print("{\"error\": false, \"description\":\"Cambios guardados con éxito\"}");
            }else{
                System.out.println("Error al cambiar contraseña: Servlets: GuardarPassword.java");
                out.print("{\"error\":true, \"description\": \"Error al actualizar su contraseña\"}");
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