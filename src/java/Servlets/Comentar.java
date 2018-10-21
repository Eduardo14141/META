package Servlets;

import Java.AccionesCuenta;
import Java.AccionesTutor;
import TablasSQL.Comentario;
import TablasSQL.Cuenta;
import TablasSQL.Tutor;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
public class Comentar extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession sesion = (HttpSession) request.getSession();
        Cuenta e = (Cuenta) sesion.getAttribute("Usuario");
        if(e!=null && e.getNombre()!=null){
            if(e.getTipoCuenta()==2){
                Tutor tut = AccionesCuenta.ObtenerTutorByIdCuenta(e.getIdCuenta());
                String idT= request.getParameter("idTarea"),
                comentario= request.getParameter("Comentario");
                if(idT==null || comentario==null) response.sendRedirect("MisEstudiantes.jsp");
                else if(idT.trim().isEmpty() || comentario.trim().isEmpty() || !AccionesCuenta.isNumeric(idT)) response.sendRedirect("MisEstudiantes.jsp");
                else{ 
                    int idTarea= Integer.parseInt(idT);
                    if(comentario.length()>250 || idT.isEmpty() || comentario.length()<12) response.sendRedirect("index.jsp");
                    List <Comentario> listita= AccionesTutor.getComentariosTareaByIdTarea(idTarea, tut.getIdTutor());
                    boolean comento=false;
                    PrintWriter out = response.getWriter();
                    if(!listita.isEmpty()) comento=true;
                    if(!comento){
                        Comentario d= new Comentario();
                        d.setComentario(comentario);
                        d.setIdTarea(idTarea);
                        d.setIdTutor(tut.getIdTutor());
                        int status = AccionesTutor.Comentar(d);
                        if(status>0) out.print("Comentario enviado con éxito");
                        else out.print("Ha ocurrido un error al mandar el comentario, por favor inténtelo de nuevo");
                    }else out.print("Ya ha comentado esta tarea, sólo se puede hacer una vez :(");
                }
            }else response.sendRedirect("Denegar.jsp");
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