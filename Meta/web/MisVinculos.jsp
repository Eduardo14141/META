<%-- 
    Document   : MisVinculos
    Created on : 15/05/2018, 04:50:33 PM
    Author     : Manager
--%>

<%@page import="TablasSQL.Tutor"%>
<%@page import="Java.AccionesEstudiante"%>
<%@page import="TablasSQL.Vinculo"%>
<%@page import="java.util.List"%>
<%@page import="Java.AccionesCuenta"%>
<%@page import="TablasSQL.Estudiante"%>
<%@page import="TablasSQL.Cuenta"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
            HttpSession sesion = (HttpSession) request.getSession();
            Cuenta e = (Cuenta) sesion.getAttribute("Usuario");
            if(e!=null && e.getNombre()!=null){
                if(e.getTipoCuenta()==1){
                    Estudiante es= AccionesCuenta.ObtenerEstudianteByIdCuenta(e.getIdCuenta());
                    List <Vinculo> listVinculos= AccionesEstudiante.getAllVinculosByIdEstudiante(es.getIdEstudiante());
                    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
                    response.setHeader("Pragma", "no-cache");
                    response.setDateHeader("Expires", 0);
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>META | Mis Tutores</title>
        <script type="text/javascript" src="JavaScript/jQuery.js"></script>
        <link rel="stylesheet" href="Estilos/Vinculos.css">
        <link rel="icon" href="img/LOGOI.ico">
        <%
            String resp= (String) request.getAttribute("CE");
            if(resp!=null){
        %>
        <script>
            $(document).ready(function(){
                swal("<%=resp %>");
            });
        </script>
        <%
            }
        %>
    </head>
    <body>
        <div class="l-site">
        <div class="l-nav">
            <nav class="nav">
                <ul>
                    <li><a href="Estudiante.jsp"><img src="img/LOGOSquare.png"></a></li>
                    <li class="hi">
                        <w>¡</w>Hola<z> <%=e.getNombre() %></z><y>!</y>
                    </li>
                    <li>
                        <x style="color:#8ED948;"><%=es.getXp() %>XP</x>
                    </li>
                    <li class="nav-primary"><a id="studyL" href="Sesiones.jsp">Programar Estudio</a></li>
                    <li class="nav-primary"><a id="homewL" href="Tareas.jsp">Tareas</a></li>
                    <li class="nav-primary"><a id="bossL" href="Jefes.jsp">Jefes</a></li>
                    <li class="nav-primary"><a id="tutorL" href="Vincular.jsp"><x>Tutor</x></a></li>
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
                        <h1>Vinculate con un tutor:</h1><hr>
                        <p>Ingresa el <y>Link Code</y> de tu tutor para empezar a compartir tu progreso.</p>
                        <form action="Vincular" id="Vincular" method="post">
                            <h3>Vincular cuenta</h3>
                            <input type="text" id="Vin" name="codigoP" placeholder="Link Code">
                            <input type="button" value="Vincular" id="btnVinc">
                        </form>
                        <form action="Desvincular" id="Desvincular" method="post">
                            <h3>Desvincular cuenta</h3>
                            <input type="text" id="Ban" name="ByeTutor" placeholder="Link Code">
                            <input type="button" id="bye" value="Desvincular">
                        </form>
                    </div>
                </div>
            </section>
            <section class="band band-c">
                <div class="band-container">
                    <div class="band-inner" id="MisVinculos">
                        <h1>Mis Vínculos</h1><hr>
                        <table>
                            <tr>
                                <td width="300px">Tutor:</td>
                                <td width="200px">Link Code:</td>
                            </tr>
                        </table>
        <%
                        for (Vinculo vin: listVinculos) {
                            if(vin.getActivo()!=0){
                                Cuenta prof= AccionesCuenta.ObtenerCuentaByTutor(vin.getIdTutor());
                                Tutor tut = AccionesCuenta.ObtenerTutorByIdCuenta(prof.getIdCuenta());
        %>
                    <span id="xcm3r7<%=tut.getIdTutor() %>">
                        <input type="text" value="<%=prof.getNombre() %>" readonly>
                        <input type="text" class="codel" value="<%=tut.getCódigo() %>" readonly><br>
                    </span>
        <%
                            }
                        }
        %>
                    </div>
                </div>
            </section>
        </div>
        </div>
        <script src="JavaScript/Cuenta.js"></script>
        <script type="text/javascript" src="JavaScript/animation2.js"></script>
        <script src="JavaScript/OnScrollReveal.js"></script>
        <script type="text/javascript">
            window.sr = ScrollReveal();

            sr.reveal('#Evidence', {
                duration: 1500
            });
            sr.reveal('.band input[type=button]', {
                duration: 1500
            });
            sr.reveal('.band input[type=text]', {
                duration: 1500
            });
            sr.reveal('.band-c input[type=text]', {
                duration: 1500
            });
            sr.reveal('.band h1', {
                duration: 1500
            });
            sr.reveal('.band h3', {
                duration: 1500
            });
            sr.reveal('.band hr', {
                duration: 1500
            });
            sr.reveal('.band p', {
                duration: 1500
            });
            sr.reveal('.band table', {
                duration: 1500
            });
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
