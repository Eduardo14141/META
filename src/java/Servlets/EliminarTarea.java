package Servlets;


import Java.AccionesCuenta;
import Java.AccionesEstudiante;
import TablasSQL.Comentario;
import TablasSQL.Cuenta;
import TablasSQL.Estudiante;
import TablasSQL.Tarea;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class EliminarTarea extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession sesion = (HttpSession) request.getSession();
        Cuenta e = (Cuenta) sesion.getAttribute("Usuario");
        if(e!=null && e.getNombre()!=null){
            if(e.getTipoCuenta()==1){        
                String a= request.getParameter("idTarea");
                if(a==null || a.trim().isEmpty()) response.sendRedirect("Tareas.jsp");
                else if(!AccionesCuenta.isNumeric(a)) response.sendRedirect("Tareas.jsp");
                else{
                    int idTarea= Integer.parseInt(a);
                    PrintWriter out = response.getWriter();
                    Tarea tar= AccionesEstudiante.ObtenerTareaActiva(idTarea);
                    Estudiante es = AccionesCuenta.ObtenerEstudianteByIdCuenta(e.getIdCuenta());
                    if(tar.getIdAlumno()==0) response.sendRedirect("Estudiante.jsp");
                    else if(tar.getIdAlumno()!=es.getIdEstudiante()){
                        response.sendRedirect("Denegar.jsp");
                    }else{
                        List <Comentario> siHay= AccionesEstudiante.getComentariosTarea(idTarea);
                        if(!siHay.isEmpty()){
                            int estado= AccionesEstudiante.EliminarComentario(idTarea);
                            if(estado>0){
                                System.out.println("Comentario eliminado");
                                int status= AccionesEstudiante.EliminarTarea(idTarea);
                                if(status>0) System.out.println("Tarea desactivada con éxito");
                                else System.out.println("No se pudo desactivar la tarea");
                                a="";
                                a = siHay.stream().map((micom) -> micom.getIdComentario()+",").reduce(a, String::concat);
                                System.out.println(a);
                                out.print(a);
                            }
                        }else{
                            int status= AccionesEstudiante.EliminarTarea(idTarea);
                            if(status>0) System.out.println("Tarea desactivada con éxito");
                            else System.out.println("No se pudo desactivar la tarea");
                            out.print("sin");
                        }
                    }
                }
            }else{
                response.sendRedirect("Denegar.jsp");
            }
        }else{
            response.sendRedirect("index.jsp");
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