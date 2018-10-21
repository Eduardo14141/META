<%-- 
    Document   : Cuenta
    Created on : 20/05/2018, 08:56:21 PM
    Author     : Manager
--%>

<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="java.util.Base64"%>
<%@page import="TablasSQL.Cuenta"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
            HttpSession sesion = (HttpSession) request.getSession();
            Cuenta e = (Cuenta) sesion.getAttribute("Usuario");
            if(e!=null && e.getNombre()!=null){
                    String c="";
                    if(e.getTipoCuenta()==1) c="Estudiante.jsp";
                    if(e.getTipoCuenta()==2) c="Tutor.jsp";
                    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
                    response.setHeader("Pragma", "no-cache");
                    response.setDateHeader("Expires", 0);
                    //StringTokenizer stTexto = new StringTokenizer(func.usu.get(i).getContraseña());                    
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>META | Mis datos</title>
        <link rel="stylesheet" media="screen" href="Estilos/Datos.css">
        <link rel="icon" href="img/LOGOI.ico">
        <script src="JavaScript/jQuery.js"></script>
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <%
            String resp= (String) request.getAttribute("CA");
            String resp2= (String) request.getAttribute("CD");
            if(resp!=null){
        %>
        <script>
            $(document).ready(function(){          
                swal({
                    position: 'center',
                    type: 'success',
                    title: "<%=resp %>",
                    showConfirmButton: false,
                    timer: 1500
                });
            });
        </script>
        <%
            }else if(resp2!=null){
        %>
        <script>
            $(document).ready(function(){
                swal({
                    type: 'error',
                    title: 'Oops...',
                    text: "<%=resp2 %>",
                });
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
                        <li class="hi"><w>¡</w>Hola <z><%=e.getNombre() %></z><y>!</y></li>
                        <li class="nav-primary"><a id="home" href="Datos.jsp">Ajustes</a></li>
                        <li class="nav-primary"><a id="home" href="Cuenta.jsp"><k>Cambia tu contraseña</k></a></li>
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
                    <form class="Form_R" name="FormB" method="post" id="FormCuenta" action="GuardarPassword">
                        <div class="Grupo">
                            <input type="password" name="pass" id="pass1" onclick="ChecarP()" onkeypress="ChecarP()">
                            <label for="pass" class="label">Nueva contraseña:</label>
                        </div>
                        <div class="Grupo">
                            <input type="password" name="pass2" id="pass2" onclick="ChecarP()" onkeypress="ChecarP()">
                            <label for="pass2" class="label">Confirma tu contraseña:</label>
                        </div>
                        <input type="button" value="Guardar Cambios" onclick="ValidarPassword('<%=e.getPassword() %>')">
                    </form>
                </div>
                </div>
            </div>
        </div>
        <!-- scripts -->
        <script type="text/javascript" src="JavaScript/jQuery.js"></script>
        <script src="JavaScript/OnScrollReveal.js"></script>
        <script type="text/javascript">
            window.sr = ScrollReveal();
            sr.reveal('.Registro', {
                duration: 1500
            });
        </script>
        <script type="text/javascript" src="JavaScript/SweetAlert.js"></script>
        <script type="text/javascript" src="JavaScript/animation2.js"></script>
        <script src="JavaScript/Cuenta.js"></script>
    </body>
</html>
        <%
            }else response.sendRedirect("index.jsp");
        %>