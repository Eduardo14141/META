package Servlets;

import Java.AccionesCuenta;
import Java.AccionesEstudiante;
import TablasSQL.Comentario;
import TablasSQL.Cuenta;
import TablasSQL.Estudiante;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DesactivarComentario extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession sesion = (HttpSession) request.getSession();
        Cuenta q = (Cuenta) sesion.getAttribute("Usuario");
        String idC= request.getParameter("idComentario");
        if(q==null || q.getNombre()==null || q.getTipoCuenta()!=1) response.sendRedirect("index.jsp");
        else if(idC==null || idC.trim().isEmpty() || !AccionesCuenta.isNumeric(idC)) response.sendRedirect("Estudiante.jsp");
        else{
            PrintWriter out= response.getWriter();
            int idComentario= Integer.parseInt(idC);
            Estudiante est= AccionesCuenta.ObtenerEstudianteByIdCuenta(q.getIdCuenta());
            List <Comentario> Es= AccionesEstudiante.getMisComentarios(est.getIdEstudiante());
            for(Comentario micom: Es){
                if(micom.getIdComentario()== idComentario){
                    idC="Existe";
                    break;
                }
            }
            if(idC.equals("Existe")){
                int status= AccionesEstudiante.DesactivarComentario(idComentario);
                if(status>0) out.print("1");
                else System.out.println("Hubo un error en DesactivarComentarios.java");
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