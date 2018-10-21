package Servlets;

import Java.AccionesCuenta;
import Java.AccionesEstudiante;
import TablasSQL.Cuenta;
import TablasSQL.Estudiante;
import TablasSQL.Tutor;
import TablasSQL.Vinculo;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Desvincular extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        HttpSession sesion = (HttpSession) request.getSession();
        Cuenta q = (Cuenta) sesion.getAttribute("Usuario");
        PrintWriter out = response.getWriter();
        String a= request.getParameter("ByeTutor");
        if(q==null || q.getNombre()==null || a==null || a.trim().isEmpty()) response.sendRedirect("index.jsp");
        else{
            Tutor b= AccionesEstudiante.ObtenerTutorByCodigo(a);
            Estudiante c= AccionesCuenta.ObtenerEstudianteByIdCuenta(q.getIdCuenta());            
            List<Vinculo> lista= AccionesEstudiante.getAllVinculosByIdEstudiante(c.getIdEstudiante());
            boolean existe=false;
            for(Vinculo d: lista){
                if((d.getIdTutor()==b.getIdTutor())&& d.getActivo()==1){
                    int status= AccionesEstudiante.DesactivarVinculo(d.getIdVinculo());
                    if(status>0) out.print(b.getIdTutor());
                    else out.print("Ha ocurrido un error inesperado, por favor inténtelo de nuevo");
                    existe=true;
                    break;
                }
            }if(!existe) out.print("El vínculo no existe en tu lista");
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