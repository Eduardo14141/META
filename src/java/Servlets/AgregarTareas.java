package Servlets;

import Java.AccionesCuenta;
import Java.AccionesEstudiante;
import TablasSQL.Cuenta;
import TablasSQL.Estudiante;
import TablasSQL.Tarea;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AgregarTareas extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        HttpSession sesion = (HttpSession) request.getSession();
        Cuenta q = (Cuenta) sesion.getAttribute("Usuario");
        if(q==null || q.getNombre()==null || q.getTipoCuenta()!=1) response.sendRedirect("index.jsp");
        else{
            String a = request.getParameter("Descripcion");
            if(a==null || a.trim().isEmpty() || a.length()<10) response.sendRedirect("Estudiante.jsp");
            else{
                Estudiante est = AccionesCuenta.ObtenerEstudianteByIdCuenta(q.getIdCuenta());
                Tarea e = new Tarea();
                e.setIdAlumno(est.getIdEstudiante());
                e.setDescripcion(a);

                int status= AccionesEstudiante.SubirTareas(e);
                if(status>0){
                    System.out.println("Tarea registrada con éxito");
                    PrintWriter out = response.getWriter();
                    out.print(AccionesEstudiante.UltimaTareaAgregadaByEstudiante(est.getIdEstudiante()));
                }else System.out.println("Error en AgregarTareas.java");
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