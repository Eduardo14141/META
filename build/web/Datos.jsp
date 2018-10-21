<%-- 
    Document   : Datos
    Created on : 15/05/2018, 04:45:15 PM
    Author     : Manager
--%>

<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="java.util.Base64"%>
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
                String b="", c="", correo=e.getEmail();
                if(e.getSexo()==1) b= "Masculino";
                if(e.getSexo()==2) b= "Femenino";
                if(e.getTipoCuenta()==1) c="Estudiante.jsp";
                if(e.getTipoCuenta()==2) c="Tutor.jsp";
                response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
                response.setHeader("Pragma", "no-cache");
                response.setDateHeader("Expires", 0);

                Base64.Decoder decoder = Base64.getDecoder();
                byte[] decodedByteArray = decoder.decode(correo);
                correo = new String(decodedByteArray);
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>META | Mis datos</title>
        <link rel="stylesheet" media="screen" href="Estilos/Datos.css">
        <link rel="icon" href="img/LOGOI.ico">
        <script src="JavaScript/jQuery.js"></script>
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <%
            String resp= (String) request.getAttribute("CA");
            if(resp!=null){
        %>
        <script>
            $(document).ready(function(){
                var respuesta= "<%=resp %>";
                if(respuesta==="Cambios guardados con éxito"){
                    swal({
                        position: 'top-end',
                        type: 'success',
                        title: respuesta,
                        showConfirmButton: false,
                        timer: 1500
                    });
                }else{
                    swal({
                        type: 'error',
                        title: 'Oops...',
                        text: respuesta,
                    });
                }
            });
        </script>
        <%
            }
        %>
    </head>
    <body>
        <div class="l-site">
            <div class="l-nav" scroll="no">
                <nav class="nav">
                    <ul>
                        <li><a href="<%=c %>"><img src="img/LOGOSquare.png" id="logo"></a></li>
                        <li class="nav-primary"><a id="home" href="Datos.jsp"><k>Ajustes</k></a></li>
                        <li class="nav-primary"><a id="home" href="Cuenta.jsp">Cambia tu contraseña</a></li>
                        <li class="nav-primary"><a id="salir" href="Salir">Cerrar Sesión</a></li>
                    </ul>
                </nav>
            </div>
            <div class="l-page">
                <div class="menu">
                    <div class="menu-hamburger"></div>
                </div>
                <div class="YescasHazLoTuyo">
                    <div class="Registro">
                        <h2>Mis Datos</h2><br>
                        <form class="Form_R" name="FormB" method="post" id="FormDatos" action="GuardarCambios">

                            <div class="Grupo">
                                <input type="text" name="nombre" id="nombre"
                                       value="<%=e.getNombre() %>">
                                <label for="nombre" class="label active">Nombre:</label>
                            </div>
                            <div class="Grupo">
                                <input type="text" name="appat" id="appat"
                                       value="<%=e.getAppat() %>">
                                <label for="appat" class="label active">Apellido paterno:</label>
                            </div>
                            <div class="Grupo">
                                <input type="text" name="apmat" id="apmat"
                                       value="<%=e.getApmat() %>">
                                <label for="apmat" class="label active">Apellido materno:</label>
                            </div>
                            <div class="Grupo">
                                <input type="text" name="Sexo" id="sexo"
                                       value="<%=b %>" readonly>
                                <label for="sexo" class="label active">Sexo:</label>
                            </div>
                            <div class="Grupo">
                                <input type="text" name="email" id="mail"
                                       value="<%=correo %>">
                                <label for="email" class="label active">Correo:</label>
                            </div>
                            <div class="Grupo radio">
                                <h4>Último grado de estudios:</h4>
                                <input type="radio" name="GradoAcademico" id="R1" value="1">
                                <label for="R1">Primaria</label>
                                <input type="radio" name="GradoAcademico" id="R2" value="2">
                                <label for="R2">Secundaria</label>
                                <input type="radio" name="GradoAcademico" id="R3" value="3">
                                <label for="R3">Media Superior</label>
                                <input type="radio" name="GradoAcademico" id="R4" value="4">
                                <label for="R4">Superior</label>
                                <input type="radio" name="GradoAcademico" id="R5" value="5">
                                <label for="R5">Maestría</label>
                                <input type="radio" name="GradoAcademico" id="R6" value="6">
                                <label for="R6">Doctorado</label>
                            </div>
                            <input type="button" value="Guardar Cambios" onclick="ValidarCambios('<%=e.getPassword() %>')">
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- scripts -->
        <script src="JavaScript/OnScrollReveal.js"></script>
        <script type="text/javascript">
            window.sr = ScrollReveal();
            sr.reveal('.Registro', {
                duration: 1500
            });
            $(document).ready(function(){
               document.querySelector("#R<%=e.getTítulo() %>").checked=true;
            });
        </script>
        <script type="text/javascript" src="JavaScript/animation2.js"></script>
        <script type="text/javascript" src="JavaScript/SweetAlert.js"></script>
        <script src="JavaScript/Cuenta.js"></script>
    </body>
</html>
        <%
            }else{
                response.sendRedirect("index.jsp");
            }
        %>
