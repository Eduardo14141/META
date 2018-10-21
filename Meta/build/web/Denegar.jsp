<%-- 
    Document   : Denegar
    Created on : 18/05/2018, 01:57:46 PM
    Author     : Manager
--%>

<%@page import="TablasSQL.Cuenta"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
            HttpSession sesion = (HttpSession) request.getSession();
            Cuenta e = (Cuenta) sesion.getAttribute("Usuario");
            if(e!=null && e.getNombre()!=null && sesion!=null){
                String link="index.jsp";
                if(e.getTipoCuenta()==1) link="Estudiante.jsp";
                else if(e.getTipoCuenta()==2) link="Tutor.jsp";
                response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
                response.setHeader("Pragma", "no-cache");
                response.setDateHeader("Expires", 0);
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Meta | Upss</title>
        <link rel="stylesheet" media="screen" href="Estilos/Datos.css">
        <link rel="icon" href="img/LOGOI.ico">
    </head>
    <body>
        <div class="l-site">
            <div class="l-nav" scroll="no">
                <nav class="nav">
                    <ul>
                        <li><a href="<%=link %>"><img src="img/LOGOSquare.png" id="logo"></a></li>
                        <li><a href="<%=link %>">Inicio</a></li>
                        <li class="nav-primary"><a id="salir" href="Salir">Cerrar Sesión</a></li>
                    </ul>
                </nav>
            </div>
            <div class="l-page">
                <div class="menu">
                    <div class="menu-hamburger"></div>
                </div>
                <div class="YescasHazLoTuyo"><!--Falta mejorar el CSS, sólo no cambies los nombres,
                    puedes eliminar los onclicks y onkeypressed, si los borras, la función checar()
                    no tendrá sentido deberás borrarla igual-->
                    <div class="Registro">
                    <h2>Lo sentimos, no puedes acceder a esta página, ya que es de acceso restringido</h2><br>
                </div>
                </div>
            </div>
        </div>
        <script type="text/javascript" src="JavaScript/SweetAlert.js"></script>
    </body>
    <%          
            }else response.sendRedirect("index.jsp");
        %>
</html>