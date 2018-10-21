<%-- 
    Document   : MisEstudiantes
    Created on : 20/05/2018, 09:07:08 PM
    Author     : Manager
--%>

<%@page import="TablasSQL.Estudiante"%>
<%@page import="Java.AccionesTutor"%>
<%@page import="TablasSQL.Vinculo"%>
<%@page import="java.util.List"%>
<%@page import="Java.AccionesCuenta"%>
<%@page import="TablasSQL.Tutor"%>
<%@page import="TablasSQL.Cuenta"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>META | Mis estudiantes</title>
        <link rel="icon" href="img/LOGOI.ico">
        <link rel="stylesheet" href="Estilos/MisEstudiantes.css">
        <%
            HttpSession sesion = (HttpSession) request.getSession();
            Cuenta e = (Cuenta) sesion.getAttribute("Usuario");
            if(e!=null && e.getNombre()!=null){
                if(e.getTipoCuenta()==2){
                    Tutor tut = AccionesCuenta.ObtenerTutorByIdCuenta(e.getIdCuenta());
                    List <Vinculo> listVinculos= AccionesTutor.getAllVinculosById(tut.getIdTutor());
                    String nombreAlumno="";
                    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
                    response.setHeader("Pragma", "no-cache");
                    response.setDateHeader("Expires", 0);
                    String[] titulo = new String[6];
                    titulo[0]="Primaria";       titulo[1]="Secundaria";
                    titulo[2]="Media superior"; titulo[3]="Superior";
                    titulo[4]="Mastría";        titulo[5]="Doctorado";
                    String a= titulo[e.getTítulo()-1];
        %>
    </head>
    <body>
        <div class="l-site">
            <div class="l-nav">
    <nav class="nav">
        <ul>
            <li><a href="Tutor.jsp"><img src="img/LOGOSquare.png"></a></li>
            <li class="hi"><w>¡</w>Hola <z><%=e.getNombre() %></z><y>!</y></li>
            <li><y>Link Code</y></li>
            <li><x style="color:#8ED948; font-size: 26px;"><%=tut.getCódigo() %></x></li>
            <li><x style="color:#8ED948;"><%=a %></x></li>
            <li class="nav-primary"><a id="studyL" href="MisEstudiantes.jsp"><z>Mis estudiantes</z></a></li>
            <li class="nav-primary"><a id="tutorL" href="Examen2.jsp">Crear examen</a></li>
            <li class="nav-primary"><a id="home" href="Datos.jsp">Ajustes</a></li>
            <li class="nav-primary"><a id="salir" href="Salir">Cerrar Sesión</a></li>
        </ul>
                </nav>
            </div>
            <div class="l-page">
                <div class="menu">
      <div class="menu-hamburger"></div>
    </div>
                <section class="bandband-a">
                    <div class="band-container">
                <div class="band-inner">
                    <h1><f>Mis Vínculos</f></h1><hr>
                    <p>
                    Comienza a <f>darle seguimiento a las tareas</f> de tus estudiantes dando click sobre sus nombres.</p>
                    <form method="post" action="DetallesEstudiante.jsp" id="VerAl">
        <%
                        for (Vinculo vin: listVinculos) {
                            if(vin.getActivo()!=0){
                                Cuenta cu= AccionesCuenta.ObtenerCuentaByEstudiante(vin.getIdAlumno());
                                Estudiante est = AccionesCuenta.ObtenerEstudianteByIdCuenta(cu.getIdCuenta());
                                nombreAlumno= cu.getNombre()+" "+cu.getAppat() +"   "+ est.getXp()+"XP";
        %>
                    <input type="text" class="MiAlumno" value="<%=nombreAlumno %>" id="df3rgo<%=vin.getIdAlumno() %>" readonly><br>
        <%
                            }
                        }
        %>
                    </form>
                </div>
            </div>
            </section>
            </div><form id="VerAl" method="post" action="DetallesEstudiante.jsp"></form>
                    </div>
        <script type="text/javascript" src="JavaScript/jQuery.js"></script>
        <script src="JavaScript/AccProfesor.js"></script>
        <script type="text/javascript" src="JavaScript/animation2.js"></script>
        <script src="JavaScript/OnScrollReveal.js"></script>
        <script type="text/javascript">
        window.sr = ScrollReveal();

        sr.reveal('.bandband-a input[type=text]', {duration: 1500});
        sr.reveal('.bandband-a h1', {duration: 1500});
        sr.reveal('.bandband-a p', {duration: 1500});
        sr.reveal('.bandband-a hr', {duration: 1500});                
        </script>
        <script type="text/javascript" src="JavaScript/SweetAlert.js"></script>
    </body>
</html>
        <%
                }else{
                    response.sendRedirect("Denegar.jsp");
                }
            }else{
                response.sendRedirect("index.jsp");
            }
        %>