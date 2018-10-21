<%-- 
    Document   : Estudiante
    Created on : 15/05/2018, 12:54:11 AM
    Author     : Manager
--%>

<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="Java.AccionesCuenta"%>
<%@page import="TablasSQL.Estudiante"%>
<%@page import="TablasSQL.Cuenta"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <%
            HttpSession sesion = (HttpSession) request.getSession();
            Cuenta e = (Cuenta) sesion.getAttribute("Usuario");
            if(e!=null && e.getNombre()!=null && sesion!=null){
                if(e.getTipoCuenta()==1){
                    Estudiante es = AccionesCuenta.ObtenerEstudianteByIdCuenta(e.getIdCuenta());
                    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
                    response.setHeader("Pragma", "no-cache");
                    response.setDateHeader("Expires", 0);
        %>
    <meta charset="utf-8">
    <title>META | Metodología Ágil</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="stylesheet" media="screen" href="Estilos/style2.css">
    <link rel="icon" href="img/LOGOI.ico">
</head>

<body>
    <div class="l-site">
        <div class="l-nav">
            <nav class="nav">
                <ul>
                    <li><a href="Estudiante.jsp"><img src="img/LOGOSquare.png" id="logo"></a></li>
                    <li class="hi"><w>¡</w>Hola <z><%=e.getNombre() %></z><y>!</y></li>
                    <li>
                        <x style="color:#8ED948;"><%=es.getXp() %>XP</x>
                    </li>
                    <li class="nav-primary"><a id="studyL" href="Sesiones.jsp">Programar Estudio</a></li>
                    <li class="nav-primary"><a id="homewL" href="Tareas.jsp">Tareas</a></li>
                    <li class="nav-primary"><a id="bossL" href="Jefes.jsp">Jefes</a></li>
                    <li class="nav-primary"><a id="tutorL" href="MisVinculos.jsp">Tutor</a></li>
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
                        <h1>¡Crea tus propias sesiones de estudio!</h1>
                        <hr id="SStudyB">
                        <p>Con META crea sesiones de estudio personalizadas, en las que tú eliges cuánto tiempo durará la sesión, la cantidad de descansos que quieres y el número de sesiones que quieres estudiar
                            <f>(Recibe 25XP por cada sesión realizada)</f>.</p>
                        <br>
                        <p>
                            ¿Qué esperas?, ¡comienza a estudiar ya!
                        </p>
                        <br>
                        <button id="SStudy" onclick="location.href='Sesiones.jsp'">¡A estudiar!</button>
                    </div>
                </div>
            </section>
            <section class="band band-b">
                <div class="band-container">
                    <div class="band-inner">
                        <h1>Organiza tus tareas, y comienza el cambio</h1>
                        <hr>
                        <p><b>META</b> te ofrece la posibilidad de no sólo organizar tus tareas académicas, sino que, también tus actividades personales, recreativas y/o pendientes, de forma dinámica. Clasifica tus tareas como: <b><z>Pendientes</z></b>, <b><y>En Progreso</y></b> y <b><x>Finalizadas</x></b> (Recibe 25XP por cada tarea finalizada).</p>
                        <br>
                        <button id="OTares" onclick="location.href='Tareas.jsp'">Organizar tareas</button>
                    </div>
                </div>
            </section>
            <section class="band band-c">
                <div class="band-container">
                    <div class="band-inner">
                        <h1>Vence jefes, y completa tus metas ;)</h1>
                        <hr>
                        <p>Comienza a proponerte grandes metas y con la ayuda de <b>META</b> crea jefes. Derrótalos para completar tus metas. </p><br>
                        <p>
                            Asignales un nombre y todas las actividades que debes cumplir para lograr tu meta. Conseguirás 150XP por cada jefe que logres derrotar, y así conviertete en <b><x>el mejor alumno META</x></b>.</p><br>
                        <button id="DBosses" onclick="location.href='Jefes.jsp'">¡A destrozar jefes!</button>
                    </div>
                </div>
            </section>
            <section class="band band-d">
                <div class="band-container">
                    <div class="band-inner">
                        <h1>Vincula tu cuenta con un tutor</h1>
                        <hr>
                        <p>Al vincular tu cuenta con un tutor, puedes empezar a darle seguimiento a tus tareas mediante un tercero que no necesariamente debe ser un profesor. Un tutor puede ser desde un amigo que te ayude a estudiar hasta tus padres para que esten al tanto de tu progreso.</p><br>
                        <button id="VTutor" onclick="location.href='MisVinculos.jsp';">Vincular cuenta</button>
                    </div>
                </div>
            </section>
        </div>
    </div>
    <!-- scripts -->
    <script type="text/javascript" src="JavaScript/jQuery.js"></script>
    <script src="JavaScript/OnScrollReveal.js"></script>
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
