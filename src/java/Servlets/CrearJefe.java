package Servlets;

import Java.AccionesCuenta;
import Java.AccionesEstudiante;
import TablasSQL.Cuenta;
import TablasSQL.Estudiante;
import TablasSQL.Jefes;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CrearJefe extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession sesion = (HttpSession) request.getSession();
        Cuenta q = (Cuenta) sesion.getAttribute("Usuario");
        
        if(q==null || q.getNombre()==null || q.getTipoCuenta()!=1) response.sendRedirect("index.jsp");
        else{
            String Nombre = request.getParameter("jefe");
            String Fecha = request.getParameter("fin");
            String im = request.getParameter("img_jefe");
            
            if(Nombre==null || Fecha==null || im==null) response.sendRedirect("Estudiante.jsp");
            else if(Nombre.trim().isEmpty() || Fecha.trim().isEmpty() || im.trim().isEmpty()) response.sendRedirect("Estudiante.jsp");
            else{
                Estudiante es = AccionesCuenta.ObtenerEstudianteByIdCuenta(q.getIdCuenta());
                Jefes je= new Jefes();                
                String fec[]= Fecha.split("-");
                Fecha= fec[2]+"-"+fec[1]+"-"+fec[0];
                je.setJefe(Nombre);
                je.setIdAlumno(es.getIdEstudiante());
                je.setFin(Fecha);
                je.setImgJefe(Integer.parseInt(im));
                int status= AccionesEstudiante.AñadirJefe(je);
                if(status>0){
                    System.out.println("Jefe generado");
                    response.sendRedirect("Jefes.jsp");
                }else{
                    System.out.println("Error al crear jefe");
                    response.sendRedirect("Estudiante.jsp");
                }
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
