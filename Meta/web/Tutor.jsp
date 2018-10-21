<%-- 
    Document   : Tutor
    Created on : 20/05/2018, 07:50:27 PM
    Author     : Manager
--%>

<%@page import="Java.AccionesCuenta"%>
<%@page import="TablasSQL.Tutor"%>
<%@page import="TablasSQL.Cuenta"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
            HttpSession sesion = (HttpSession) request.getSession();
            Cuenta e = (Cuenta) sesion.getAttribute("Usuario");
            if(e!=null && e.getNombre()!=null){
                if(e.getTipoCuenta()==2){
                    Tutor tut= AccionesCuenta.ObtenerTutorByIdCuenta(e.getIdCuenta());
                    String[] titulo = new String[6];
                    titulo[0]="Primaria";       titulo[1]="Secundaria";
                    titulo[2]="Media superior"; titulo[3]="Superior";
                    titulo[4]="Mastría";        titulo[5]="Doctorado";
                    String a= titulo[e.getTítulo()-1];
                    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
                    response.setHeader("Pragma", "no-cache");
                    response.setDateHeader("Expires", 0);
        %>
    <meta charset="utf-8">
    <title>META | Metodología Ágil</title>
    <link rel="icon" href="img/LOGOI.ico">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="stylesheet" media="screen" href="Estilos/style2.css">
    <link rel="icon" href="img/LOGOI.ico">
</head>

<body>
    <div class="l-site">
        <div class="l-nav" scroll="no">
            <nav class="nav">
                <ul>
                    <li><a href="Tutor.jsp"><img src="img/LOGOSquare.png"></a></li>
                    <li class="hi"><w>¡</w>Hola <z><%=e.getNombre() %></z><y>!</y></li>
                    <li><y>Link Code</y></li>
                    <li><x style="color:#8ED948; font-size: 26px;"><%=tut.getCódigo() %></x></li>
                    <li><x style="color:#8ED948;"><%=a %></x></li>
                    <li class="nav-primary"><a id="studyL" href="MisEstudiantes.jsp">Mis estudiantes</a></li>
                    <li class="nav-primary"><a id="tutorL" href="Examen2.jsp">Crear examen</a></li>
                    <li class="nav-primary"><a id="home" href="Datos.jsp">Ajustes</a></li>
                    <li class="nav-primary"><a id="salir" href="Salir">Cerrar Sesión</a></li>
                </ul>
            </nav>
        </div>
        <div class="l-page">
            <div class="menu"><div class="menu-hamburger"></div></div>
            <section class="bandband-a">
                <div class="band-container">
                    <div class="band-inner">
                        <h1>Supervisa el progreso de tus estudiantes :)</h1>
                        <hr id="SStudyB">
                        <p>Con META, una gran cantidad de estudiantes pueden vincularse con tu cuenta a través de tu <y>"Link Code"</y>. Con esto puedes supervisar el avance de estos respecto a sus tareas además de poder mandar comentarios para recordar fechas de entrega, avisos, etc.</p><br>
                        <p>¡Comienza a vincularte ya!</p><br>
                        <button id="SStudy" onclick="location.href='MisEstudiantes.jsp'">¡Mis estudiantes!</button>
                    </div>
                </div>
            </section>
            <section class="band band-d">
                <div class="band-container">
                    <div class="band-inner">
                        <h1>¡Crea examenes y mandalos por email de forma automática!</h1><hr>
                        <p>META te ofrece la posibilidad de crear examenes de manera rápida y sencilla. Además de que te brinda la facilidad de mandar este por email a los alumnos que creas necesario</p><br>
                        <p>Comienza a hacer tus examenes con META</p><br>
                        <button id="VTutor" onclick="location.href='Examen.jsp';">Crear examen</button>
                    </div>
                </div>
            </section>
        </div>
    </div>
    <!-- scripts -->
    <script src="JavaScript/OnScrollReveal.js"></script>
    <script type="text/javascript" src="JavaScript/jQuery.js"></script>
    <script type="text/javascript">
        window.sr = ScrollReveal();

        sr.reveal('.nav', {
            duration: 1500
        });
        sr.reveal('.bandband-a h1', {
            duration: 1500
        });
        sr.reveal('.bandband-a p', {
            duration: 1500
        });
        sr.reveal('#SStudyB', {
            duration: 1500
        });
        sr.reveal('#SStudy', {
            duration: 1500
        });
        sr.reveal('.band h1', {
            duration: 1500
        });
        sr.reveal('.band hr', {
            duration: 1500
        });
        sr.reveal('.band p', {
            duration: 1500
        });
        sr.reveal('#OTares', {
            duration: 1500
        });
        sr.reveal('#DBosses', {
            duration: 1500
        });
        sr.reveal('#VTutor', {
            duration: 1500
        });

    </script>
    <script type="text/javascript" src="JavaScript/animation2.js"></script>
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