package Servlets;

import Java.AccionesCuenta;
import Java.AccionesEstudiante;
import TablasSQL.Cuenta;
import TablasSQL.Estudiante;
import TablasSQL.Sesiones;
import java.io.IOException;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CompletarSesion extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession sesion = (HttpSession) request.getSession();
        Cuenta q = (Cuenta) sesion.getAttribute("Usuario");
        
        if(q==null || q.getNombre()==null){
            response.sendRedirect("index.jsp");
        }else if(q.getTipoCuenta()!=1){
            response.sendRedirect("Denegar.jsp");
        }else{
            Estudiante es= AccionesCuenta.ObtenerEstudianteByIdCuenta(q.getIdCuenta());
            Sesiones hoy= AccionesEstudiante.ObtenerSesionHoy(es.getIdEstudiante());                           
            String a=request.getParameter("NoSesiones"),
                   b=request.getParameter("Duracion");
            if(a==null||b==null||a.trim().isEmpty()||b.trim().isEmpty()) response.sendRedirect("SesionesEstudio.jsp");
            else if(!AccionesCuenta.isNumeric(a) || !AccionesCuenta.isNumeric(b)) response.sendRedirect("Sesiones.jsp");
            else{
                int Numero= Integer.parseInt(a),
                    Duracion= Integer.parseInt(b), 
                    xp= 10 * Numero;
                if(Duracion>0&&Duracion<30) xp+=10*Numero;
                else if(Duracion>=30&&Duracion<45) xp+=20*Numero;
                else if(Duracion>=45 && Duracion<=60) xp+=50*Numero;
                if(hoy.getNumero()==0 || hoy.getIdSesion()==0){
                    Sesiones ses = new Sesiones();
                    ses.setIdAlumno(es.getIdEstudiante());
                    ses.setNumero(Numero);
                    int status= AccionesEstudiante.CrearSesionEstudio(ses);
                    if(status>0){
                        status= AccionesEstudiante.ActualizarXP((xp+es.getXp()), es.getIdEstudiante());
                        if(status>0){
                            request.setAttribute("CS", "Gracias por estudiar con nosotros, te sobran "+(8-Numero)+" sesiones por hoy");
                            request.getRequestDispatcher("Sesiones.jsp").forward(request, response);
                        }
                    }else{
                        request.setAttribute("CS", "Hubo un error actualizando los datos");
                        request.getRequestDispatcher("Sesiones.jsp").forward(request, response);
                    }
                }else if(hoy.getNumero()>0 && hoy.getNumero()<8){
                    Sesiones ses = new Sesiones();
                    ses.setNumero((hoy.getNumero()+Numero));
                    ses.setIdSesion(hoy.getIdSesion());
                    int status= AccionesEstudiante.ActualizarSesiones(ses);
                    if(status>0){
                        status= AccionesEstudiante.ActualizarXP((xp+es.getXp()), es.getIdEstudiante());
                        if(status>0){
                            request.setAttribute("CS", "Gracias por estudiar con nosotros, te sobran "+(8-Numero)+" sesiones por hoy");
                            request.getRequestDispatcher("Sesiones.jsp").forward(request, response);
                        }
                    }else{
                        request.setAttribute("CS", "Hubo un error actualizando los datos");
                        request.getRequestDispatcher("Sesiones.jsp").forward(request, response);
                    }
                }else{
                    request.setAttribute("CS", "Hoy ya estudiaste el número máximo de sesiones");
                    request.getRequestDispatcher("Sesiones.jsp").forward(request, response);
                }
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("Denegar.jsp");
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