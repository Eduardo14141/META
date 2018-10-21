package Servlets;

import Java.AccionesCuenta;
import TablasSQL.Cuenta;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

public class HashMap extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        String correo= request.getParameter("correo"), pass= request.getParameter("password");
        if(correo==null || pass==null || correo.trim().isEmpty() || pass.trim().isEmpty()) response.sendRedirect("index.jsp");
        else{
            pass= cifrarBase64(pass);
            correo= cifrarBase64(correo);
            Cuenta e = AccionesCuenta.IniciarS(correo, pass);

            if(e!=null && e.getNombre()!=null){
                HttpSession sesion= request.getSession();
                sesion.setAttribute("Usuario", e);
                sesion.setMaxInactiveInterval(60*6*25);//2.5 horas
                switch (e.getTipoCuenta()) {
                    case 1:
                        response.sendRedirect("Estudiante.jsp");
                        break;
                    case 2:
                        response.sendRedirect("Tutor.jsp");
                        break;
                    default:
                        response.sendRedirect("Salir");
                        break;
                }
            }else{
                request.setAttribute("LogE", "Usuario y/o contraseña incorrectos");
                request.getRequestDispatcher("index.jsp").forward(request, response);
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
    }@Override
    public String getServletInfo() {
        return "Short description";
    }
    public static String cifrarBase64(String a){
        Base64.Encoder encoder = Base64.getEncoder();
        String b = encoder.encodeToString(a.getBytes(StandardCharsets.UTF_8) );        
        return b;
    }
}