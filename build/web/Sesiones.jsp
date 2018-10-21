<%-- 
    Document   : Estudiante
    Created on : 15/05/2018, 12:54:11 AM
    Author     : Manager
--%>

<%@page import="Java.AccionesEstudiante"%>
<%@page import="TablasSQL.Sesiones"%>
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
    <meta charset="utf-8">
    <script type="text/javascript" src="JavaScript/jQuery.js"></script>
    <title>META | Sesiones de estudio</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="stylesheet" media="screen" href="Estilos/Sesiones.css">
    <link rel="icon" href="img/LOGOI.ico">
    
    <%
            HttpSession sesion = (HttpSession) request.getSession();
            Cuenta e = (Cuenta) sesion.getAttribute("Usuario");
            if(e!=null && e.getNombre()!=null){
                if(e.getTipoCuenta()==1){
                    Estudiante es= new Estudiante();
                    es = AccionesCuenta.ObtenerEstudianteByIdCuenta(e.getIdCuenta());
                    Sesiones hoy= AccionesEstudiante.ObtenerSesionHoy(es.getIdEstudiante());
                    String resp= (String) request.getAttribute("CS");
                    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
                    response.setHeader("Pragma", "no-cache");
                    response.setDateHeader("Expires", 0);
                    if(resp!=null){
    %>
    <script>
        $(document).ready(function(){
            swal({
            position: 'top',
            type: 'success',
            title: '<%=resp %>',
            showConfirmButton: false,
            timer: 1500
          });
        });
    </script>
    <%
        } if(hoy.getNumero()==8){
    %>
    <script>
        $(document).ready(function(){
            swal('Ya haz alcanzado el número máximo de sesiones de estudio').then(function(){
               location.href='Estudiante.jsp'; 
            });
        });
    </script>
    <%
        }
    %>
</head>
<body>
    <audio id="xyz" src="multimedia/Notificacion.mp3" preload="auto" style="display:none;"></audio>
    <div class="l-site">
        <div class="l-nav">
            <nav class="nav">
                <ul>
                    <li><a href="Estudiante.jsp"><img src="img/LOGOSquare.png" id="logo"></a></li>
                    <li class="hi"><w>¡</w>Hola <z><%=e.getNombre() %></z><y>!</y></li>
                    <li>
                        <x style="color:#8ED948;"><%=es.getXp() %>XP</x>
                    </li>
                    <li class="nav-primary"><a id="studyL" href="Sesiones.jsp"><w>Programar Estudio</w></a></li>
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
                        <h1 id='pitaya'>Programar estudio</h1><br>
                        <p id="textsesion"></p>
                        <hr id='pitaya'><br>
                        <p id='pitaya'>Con META puedes prograrmar tus sesiones de estudio, por lo que te brindamos de un timer, con el cual puedes dividir tus sesiones de estudio y tomar descansos de 5 a 12 minutos</p><br>
                        <h2 style="color:#51A5FE;" id='CuentaAtras'></h2>
    <form id="formu">
        <paso id='sun'><w>¿En cuántas partes quieres dividir tu sesión?</w></paso>
        <input type="text" id="sesiones"><br>
        <paso id='san'><x>Duración de cada parte, en minutos :)</x></paso> 
        <input type="text" id="minutos"><br>
        <paso id='ternera'><y>¿Cuánto tiempo durará el descanso?</y></paso>
        <input type="text" id="descansos"><br><br>
        
        <input type="button" id='boton' onclick="Maximo();" onsubmit="updateReloj()" value="Empezar a estudiar">
    </form>
                    </div>
                    </div>        
    </section>
        </div>
    </div>
    <script type='text/javascript' src="JavaScript/SesionesEstudio.js"></script>
    <script>
        function Maximo(){
            var input= document.querySelector("#sesiones"),
            patron = /^\d*$/;
            if(patron.test(input.value)){
                var hoy= <%=hoy.getNumero() %>;
                hoy= parseInt(hoy);
                var total= parseInt(input.value) + hoy;
                if(total>8 && input.hidden===false){
                    swal("El número máximo de sesiones de estudio que puedes tener en un día es 8\n\
                    te sobran "+ (8-hoy)+" sesiones de estudio por hoy" );
                    return false;
                }else{
                    updateReloj();
                    return true;
                }
            }else return false;
        }
    </script>
    <script type="text/javascript" src="JavaScript/SweetAlert.js"></script>
    <script type="text/javascript" src="JavaScript/animation2.js"></script>
</body>
</html>
        <%
                }else response.sendRedirect("Denegar.jsp");
            }else response.sendRedirect("index.jsp");
        %>