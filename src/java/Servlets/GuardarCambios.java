package Servlets;

import Java.AccionesCuenta;
import TablasSQL.Cuenta;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class GuardarCambios extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession sesion = (HttpSession) request.getSession();
        Cuenta q = (Cuenta) sesion.getAttribute("Usuario");
        if(q==null || q.getNombre()==null) response.sendRedirect("index.jsp");
        else{
            String a, b, c, d, e, pass;
            a= request.getParameter("nombre");
            b= request.getParameter("appat");
            c= request.getParameter("apmat");
            d= request.getParameter("email");
            pass=q.getPassword();
            e= request.getParameter("GradoAcademico");
            if((a==null || b==null) || ((c==null|| d==null)|| e==null)) response.sendRedirect("Datos.jsp");
            else if((a.trim().isEmpty() || b.trim().isEmpty()) || ((c.trim().isEmpty()|| d.trim().isEmpty())|| e.trim().isEmpty())){
                response.sendRedirect("Datos.jsp");
            }
            else{
                if(AccionesCuenta.isNumeric(e)){
                    List <Cuenta> lista = AccionesCuenta.getEmails();
                    int Grado = Integer.parseInt(e);
                    if(Grado>6||Grado<1){
                        request.setAttribute("CA", "Para registarte exitosamente, debes dejar los valores de los campos igual");
                        request.getRequestDispatcher("Datos.jsp").forward(request, response);
                    }else{
                        d=cifrarBase64(d);
                        Cuenta p = new Cuenta();
                        p.setNombre(a);
                        p.setAppat(b);
                        p.setApmat(c);
                        p.setEmail(d);
                        p.setTítulo(Grado);
                        p.setIdCuenta(q.getIdCuenta());

                        boolean proteccion = false;
                        for(Cuenta v: lista){
                            if(d.equals(v.getEmail()) && (!d.equals(q.getEmail()))){
                                proteccion=true;
                            }
                        }
                        if(!proteccion){
                            int status= AccionesCuenta.ActualizarDatos(p);
                            if(status>0){
                                System.out.println("Datos actualizados con éxito");
                                sesion.removeAttribute("Usuario");
                                Cuenta UsuarioActivo = AccionesCuenta.IniciarS(d, pass);
                                sesion.setAttribute("Usuario", UsuarioActivo);
                                request.setAttribute("CA", "Cambios guardados con éxito");
                                request.getRequestDispatcher("Datos.jsp").forward(request, response);
                            }else{
                                System.out.println("Error en GuardarCambios.java");
                                request.setAttribute("CA", "Error al guardar los cambios, inténtalo más tarde :(");
                                request.getRequestDispatcher("Datos.jsp").forward(request, response);
                            }
                        }else{
                            request.setAttribute("CA", "El email que registraste ya está registrado, use otro por favor");
                            request.getRequestDispatcher("Datos.jsp").forward(request, response);
                        }
                    }
                }else{
                    request.setAttribute("CA", "Para registarte exitosamente, debes dejar los valores de los campos igual");
                    request.getRequestDispatcher("Datos.jsp").forward(request, response);
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
    public static String cifrarBase64(String a){
        Base64.Encoder encoder = Base64.getEncoder();
        return encoder.encodeToString(a.getBytes(StandardCharsets.UTF_8));
    }
}