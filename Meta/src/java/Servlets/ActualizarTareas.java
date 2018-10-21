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

public class ActualizarTareas extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession sesion = (HttpSession) request.getSession();
        Cuenta q = (Cuenta) sesion.getAttribute("Usuario");
        
        if(q==null || q.getNombre()==null) response.sendRedirect("index.jsp");
        else if(q.getTipoCuenta()!=1) response.sendRedirect("Denegar.jsp");
        else{
            String a= request.getParameter("idTarea"),
                   c = request.getParameter("Progreso");
            if(a==null || c==null || a.trim().isEmpty() || c.trim().isEmpty()) response.sendRedirect("Tareas.jsp");
            else if(!AccionesCuenta.isNumeric(a) || !AccionesCuenta.isNumeric(c)) response.sendRedirect("Tareas.jsp");
            else{
                int idT=Integer.parseInt(a),
                    progreso= Integer.parseInt(c);     
                PrintWriter out = response.getWriter();
                Tarea tarea= AccionesEstudiante.ObtenerTareaActiva(idT);
                Estudiante est= AccionesCuenta.ObtenerEstudianteByIdCuenta(q.getIdCuenta());
                if(tarea.getIdAlumno() == est.getIdEstudiante()){
                    Tarea e= new Tarea();
                    e.setIdTarea(idT);
                    e.setProgreso(progreso);
                    int status= AccionesEstudiante.ActualizarTareas(e);
                    if(status>0){
                        if(progreso==100) status= AccionesEstudiante.ActualizarXP((est.getXp()+25), est.getIdEstudiante());
                        if(status>0) out.print(1);
                    }else System.out.println("Error en ActualizarTareas.java");
                }else{
                    out.print("Esta tarea no es tuya");
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