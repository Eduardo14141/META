<%-- 
    Document   : DetallesTarea
    Created on : 16/05/2018, 07:48:01 PM
    Author     : Alumno
--%>

<%@page import="Java.AccionesEstudiante"%>
<%@page import="TablasSQL.Tarea"%>
<%@page import="Java.AccionesCuenta"%>
<%@page import="TablasSQL.Estudiante"%>
<%@page import="TablasSQL.Cuenta"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>META | Progreso</title>
        <link rel="stylesheet" href="Estilos/AreaDeTrabajo.css">
        <link rel="icon" href="img/LOGOI.ico">
        <script type="text/javascript" src="JavaScript/jQuery.js"></script>
        <script src="JavaScript/jquery.knob.js"></script>
  <script>
    $(document).ready(function() {
      //$(".dial").knob();
      $('.circle').knob({
        'min':0,
        'max':100,
        'width':250,
        'height':250,
        'displayInput':true,
        'fgColor':"#3b5998",
        'release':function(v) {$("p").text(v);},
        'readOnly':true
      });
    });
  </script>
        <%
            HttpSession sesion = (HttpSession) request.getSession();
            Cuenta e = (Cuenta) sesion.getAttribute("Usuario");
            if(e!=null && e.getNombre()!=null){
                    if(e.getTipoCuenta()==1){
                        Estudiante es= AccionesCuenta.ObtenerEstudianteByIdCuenta(e.getIdCuenta());
                        String a= request.getParameter("idTarea");
                        if(a==null || a.trim().isEmpty()) response.sendRedirect("Tareas.jsp");
                        else if(!AccionesCuenta.isNumeric(a)) response.sendRedirect("Denegar.jsp");
                        else{
                        int idTarea=Integer.parseInt(a);
                        Tarea tarea= AccionesEstudiante.ObtenerTareaActiva(idTarea);                        
                        if(tarea.getIdAlumno()!= es.getIdEstudiante()) response.sendRedirect("Denegar.jsp");
                        else{
                            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
                            response.setHeader("Pragma", "no-cache");
                            response.setDateHeader("Expires", 0);
        %>
    </head>
    <body>
        <div class="l-site">
            <div class="l-nav">
                <nav class="nav">
                    <ul>
                        <li><a href="Estudiante.jsp"><img src="img/LOGOSquare.png"></a></li>
                        <li class="hi"><w>¡</w>Hola <z><%=e.getNombre() %></z><y>!</y></li>
                        <li>
                            <x style="color:#8ED948;"><%=es.getXp() %>XP</x>
                        </li>
                        <li class="nav-primary"><a id="studyL" href="Estudiante.jsp">Programar Estudio</a></li>
                        <li class="nav-primary"><a id="homewL" href="Tareas.jsp">Tareas</a></li>
                        <li class="nav-primary"><a id="bossL" href="Jefes.jsp">Jefes</a></li>
                        <li class="nav-primary"><a id="tutorL" href="Vincular.jsp">Tutor</a></li>
                        <li class="nav-primary"><a id="home" href="Datos.jsp">Ajustes</a></li>
                        <li class="nav-primary"><a id="salir" href="Salir">Cerrar Sesión</a></li>
                    </ul>
                </nav>
            </div>
            <div class="l-page">
                <div class="menu">
                    <div class="menu-hamburger"></div>
                </div>
                <section class="band band-b">
                    <div class="band-container">
                        <div class="band-inner">
                            <h1>
                                <%=tarea.getDescripcion() %>
                            </h1>
                            <hr>
                            <form>
                                <p>Modifica tu progreso: &nbsp;<input type="text" id="Progreso" placeholder="0-100" name="Progreso"></p><br>
                                <center><input type="text" class="circle" id="AProgress" value="<%=tarea.getProgreso() %>" style="color: #ffb230;">
                                <br><br>
                                <input type="button" id="Finish" value="Guardar Progreso" name="<%=idTarea %>"></center>
                            </form>
                        </div>
                    </div>
                </section>
            </div>
        </div>
        <script type="text/javascript" src="JavaScript/animation2.js"></script>
        <script src="JavaScript/AgregarTareas.js"></script>
        <script src="JavaScript/OnScrollReveal.js"></script>
        <script type="text/javascript" src="JavaScript/SweetAlert.js"></script>
        <script type="text/javascript">
            window.sr = ScrollReveal();

            sr.reveal('.band h1', {
                duration: 1500
            });
            sr.reveal('.band hr', {
                duration: 1500
            });
            sr.reveal('.band p', {
                duration: 1500
            });
            sr.reveal('#Finish', {
                duration: 1500
            });
            sr.reveal('.band input[type=text]', {
                duration: 1500
            });
        </script>
    </body>
        <%
                        }
                    }
                }else{
                    response.sendRedirect("index.jsp");
                }
            }else{
                response.sendRedirect("index.jsp");
            }
        %>
</html>