package Servlets;
import Java.AccionesCuenta;
import TablasSQL.Cuenta;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

public class GuardarUsuario extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        List <Cuenta> lista = AccionesCuenta.getEmails();
        
        String nombre, appat, apmat, correo, password, sexoa, tituloa, tCuentaa;
        int sexo, titulo, TCuenta;
        nombre=request.getParameter("nombre"); appat=request.getParameter("appat");
        apmat=request.getParameter("apmat"); correo=request.getParameter("email");
        password=request.getParameter("pass"); sexoa=request.getParameter("Sexo");
        tituloa=request.getParameter("GradoAcademico"); tCuentaa=request.getParameter("Tipo");
        String msg="Para registarte exitosamente, debes dejar los valores de los campos igual";
        //Verificando Valores
        if(nombre==null || nombre.length()>25 || nombre.length()<2 || nombre.trim().isEmpty()) {
            request.setAttribute("LogE", "El nombre no es válido");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }else if(appat==null || appat.length()>25 || appat.length()<2 || appat.trim().isEmpty()){
            request.setAttribute("LogE", "El appelido no es válido");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }else if((apmat!=null && apmat.length()>25) || (apmat!=null && apmat.trim().isEmpty())){
            request.setAttribute("LogE", "El appelido no es válido");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }else if(correo==null || correo.length()>45 || correo.trim().isEmpty()) {
            request.setAttribute("LogE", "El correo enviado no es válido");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }else if(password==null || password.length()>25 || password.length()<6 || password.trim().isEmpty()) {
            request.setAttribute("LogE", "Datos de la contraseña rechazados");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }else if(sexoa==null) response.sendRedirect("index.jsp");
        else if(tituloa==null) response.sendRedirect("index.jsp");
        else if(tCuentaa==null) response.sendRedirect("index.jsp");
        else{
            if(AccionesCuenta.isNumeric(sexoa) && AccionesCuenta.isNumeric(tituloa) && AccionesCuenta.isNumeric(tCuentaa)){
                sexo=Integer.parseInt(sexoa); titulo=Integer.parseInt(tituloa); TCuenta=Integer.parseInt(tCuentaa);
                if((sexo>2||sexo<1) || (TCuenta>2||TCuenta<1) || (titulo>6||titulo<1)){
                    request.setAttribute("LogE", msg);
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                }else{
                    boolean proteccion = false;
                    correo = cifrarBase64(correo);
                    for(Cuenta d: lista){
                        if(correo.equals(d.getEmail())) proteccion=true;
                    }
                    if(!proteccion){
                        password=cifrarBase64(password);
                        Cuenta e= new Cuenta();
                        e.setNombre(nombre);
                        e.setAppat(appat);
                        e.setApmat(apmat);
                        e.setSexo(sexo);
                        e.setEmail(correo);
                        e.setPassword(password);
                        e.setTítulo(titulo);
                        e.setTipoCuenta(TCuenta);
                        String msg2="Hubo un error al registrar la cuenta, por favor inténtelo de nuevo";
                        try{ 
                            int status= AccionesCuenta.Guardar(e);
                            if(status>0){
                                System.out.println("Cuenta registrada con éxito");
                                nombre=null;
                                request.setAttribute("LogS", "Cuenta registrada con éxito");
                                request.getRequestDispatcher("index.jsp").forward(request, response);
                            }else{
                                request.setAttribute("LogE", msg2);
                                request.getRequestDispatcher("index.jsp").forward(request, response);
                            }
                        }catch(IOException | ServletException ol){
                            request.setAttribute("LogE", msg2);
                            request.getRequestDispatcher("index.jsp").forward(request, response);
                            System.out.println(ol.getMessage());
                            System.out.println(Arrays.toString(ol.getStackTrace()));
                        }
                    }else{
                        request.setAttribute("LogE", "Ya existe una cuenta registrada con ese correo electrónico");
                        request.getRequestDispatcher("index.jsp").forward(request, response);
                    }
                }
            }else{
                request.setAttribute("LogE", msg);
                request.getRequestDispatcher("index.jsp").forward(request, response);
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
    public static String CifradoCesar(String texto){
        String minus, resultado="";
        minus ="abcdefghijklmnñopqrstuvwxyzABCDEFGHIJKLMNÑOPQRSTUVWXYZÁÉÍÓÚÜáéíóúü";//longitud 66 caracteres
        for(int i=0; i<texto.length();i++){
            for(int h=0; h<minus.length();h++){
                if(texto.charAt(i)==minus.charAt(h)){
                    if(h+11>=minus.length()){
                        resultado+= minus.charAt(h +11 - minus.length());
                    }else{
                        resultado+= minus.charAt(h+11);
                    }
                    break;
                }
            }
        }
        return resultado;
    }
    public static String cifrarBase64(String a){
        Base64.Encoder encoder = Base64.getEncoder();
        return encoder.encodeToString(a.getBytes(StandardCharsets.UTF_8));
    }
}