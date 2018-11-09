package Servlets;

import Java.AccionesCuenta;
import Java.AccionesEstudiante;
import TablasSQL.Cuenta;
import TablasSQL.Estudiante;
import TablasSQL.Misiones;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AgregarMision extends HttpServlet {

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
            String mision= request.getParameter("Mision"),
                aprox= request.getParameter("Aprox"),
                idJ= request.getParameter("idJefe");
            if(aprox==null || mision==null || idJ==null) response.sendRedirect("Estudiante.jsp");
            else if(aprox.trim().isEmpty() || mision.trim().isEmpty()|| idJ.trim().isEmpty()) response.sendRedirect("Estudiante.jsp");
            else{
                int idJefe = Integer.parseInt(idJ);
                String fec[]= aprox.split("-");
                aprox=fec[2]+"-"+fec[1]+"-"+fec[0];
                Misiones e= new Misiones();
                e.setIdJefe(idJefe);
                e.setMision(mision);
                e.setAprox(aprox);
                int status = AccionesEstudiante.AñadirMision(e);
                if(status>0){
                    List <Misiones> listaM = AccionesEstudiante.getMisionesJefe(idJefe);
                    if(listaM.size()==3){
                        int st= AccionesEstudiante.ActivarJefe(idJefe);
                        if(st>0){
                            System.out.println("Jefe activado con éxito");
                        }else{
                            System.out.println("Error grave al activa jefe");
                        }
                    }
                    System.out.println("Misión añadida con éxito");
                    request.setAttribute("idJefe", idJefe);
                    request.getRequestDispatcher("Misiones.jsp").forward(request, response);
                }else{
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
