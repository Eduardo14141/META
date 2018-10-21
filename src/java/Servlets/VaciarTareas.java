package Servlets;

import Java.AccionesCuenta;
import Java.AccionesEstudiante;
import TablasSQL.Cuenta;
import TablasSQL.Estudiante;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class VaciarTareas extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession sesion = (HttpSession) request.getSession();
        Cuenta q = (Cuenta) sesion.getAttribute("Usuario");
        if(q==null || q.getNombre()==null) response.sendRedirect("index.jsp");
        else if(q.getTipoCuenta()!=1) response.sendRedirect("Denegar.jsp");
        else{
            PrintWriter out = response.getWriter();
            Estudiante est= AccionesCuenta.ObtenerEstudianteByIdCuenta(q.getIdCuenta());
            int vacio = AccionesEstudiante.VaciarTareas(est.getIdEstudiante());
            if(vacio>0) out.print(1);
            else{
                System.out.println("Error al vaciar las tareas");
                out.print(0);
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
}
