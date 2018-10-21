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

public class Vincular extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession sesion = (HttpSession) request.getSession();
        Cuenta q = (Cuenta) sesion.getAttribute("Usuario");
        String a=request.getParameter("codigoP");
        if(q==null || q.getNombre()==null || a==null|| a.trim().isEmpty()) response.sendRedirect("index.jsp");
        else{
            Tutor tut= AccionesEstudiante.ObtenerTutorByCodigo(a);
            Estudiante c= AccionesCuenta.ObtenerEstudianteByIdCuenta(q.getIdCuenta());
            boolean existe=false, existecodigo=false;
            int idAlumno=c.getIdEstudiante();
            List<Vinculo> lista= AccionesEstudiante.getAllVinculosByIdEstudiante(idAlumno);
            List<Tutor> listaC= AccionesCuenta.getAllCodigos();
            for(Tutor exist : listaC){
                if(a.equals(exist.getCódigo())){
                    existecodigo=true;
                    break;
                }
            }
            if(existecodigo){
                int num_vin=0;
                num_vin = lista.stream().filter((actdes) -> (actdes.getActivo()==1)).map((_item) -> 1).reduce(num_vin, Integer::sum);
                if(num_vin>5){
                    request.setAttribute("CE", "Límite de cuentas vinculadas alcanzado");
                    request.getRequestDispatcher("MisVinculos.jsp").forward(request, response);
                }else{
                    for(Vinculo d: lista){
                        if(d.getIdTutor() == tut.getIdTutor()){
                            if(d.getActivo()==1) out.println("El vínculo ya existe entre ustedes");
                            else{
                                int status= AccionesEstudiante.ActivarVinculo(d.getIdVinculo());
                                if(status>0){
                                    Cuenta miTutor= AccionesCuenta.ObtenerCuentaByTutor(tut.getIdTutor());
                                    System.out.println("Vínculo reestablecido con éxito");
                                    a="{\"Nombre\": \""+miTutor.getNombre()+" "+miTutor.getAppat()+"\", \"idTutor\":\""+tut.getIdTutor()+"\"}";
                                    out.print(a);
                                }else{
                                    System.out.println("Error al vincular");
                                    out.print("Ha ocurrido un error, inténtelo de nuevo");
                                }
                            }
                            existe=true;
                            break;
                        }
                    }
                    if(!existe){
                        Vinculo e = new Vinculo();
                        e.setIdTutor(tut.getIdTutor());
                        e.setIdAlumno(idAlumno);
                        int status = AccionesEstudiante.VincularCuenta(e);
                        if(status>0) out.print("Vinculado con éxito");
                        else{
                            System.out.println("Error en Vincular.java");
                            out.print("Ha ocurrido un error, inténtelo de nuevo");
                        }
                    }
                }
            }else out.print("No existe dicho código");            
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