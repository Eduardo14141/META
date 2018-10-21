<%-- 
    Document   : index.jsp
    Created on : 14/05/2018, 11:38:29 PM
    Author     : Manager
--%>

<%@page import="TablasSQL.Cuenta"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>¡Bienvenido!</title>
    <link rel="stylesheet" href="Estilos/style1.css">
    <script src="JavaScript/jQuery.js"></script>
    <link rel="icon" href="img/LOGOI.ico">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
</head>
<body>
    <%
        HttpSession sesion = (HttpSession) request.getSession();
            Cuenta e = (Cuenta) sesion.getAttribute("Usuario");
            if(e!=null && sesion!=null){
                if(e.getNombre()!=null && sesion.getAttribute("Usuario")!=null){
                    if(e.getTipoCuenta()==1) response.sendRedirect("Estudiante.jsp");
                    else if(e.getTipoCuenta()==2) response.sendRedirect("Tutor.jsp");
                    else response.sendRedirect("Ayuda.jsp");
                }
            }
        String MsgError= (String) request.getAttribute("LogE");
        String MsgSuccess= (String) request.getAttribute("LogS");
        if(MsgError!=null){
    %>
    <script>
        $(document).ready(function(){
            swal({
                position: 'top',
                type: 'error',
                title: '<%=MsgError %>',
                showConfirmButton: false,
                timer: 1500
            });
        });
    </script>
    <%
        MsgError=null;
        }
        if(MsgSuccess!=null){
    %>
    <script>
        $(document).ready(function(){
            swal({
                position: 'top',
                type: 'success',
                title: '<%=MsgSuccess %>',
                showConfirmButton: false,
                timer: 1500
            });
        });
    </script>
    <%
        MsgSuccess=null;
        }
    %>
    <div id="Logo"> 
        <table cellspacing="15">
           <th height="25px" align="left">
               <p>¿Qué es META?</p>
            </th>
            <tr>
                <td width="350px" align="left" style="text-align: justify;">
                    META es una plataforma para el estudiante que desea mejorar, nosotros te ayudamos a crear horarios de estudio,
                    a administrar todas tus tareas y proyectos de una manera sencilla, utilizando diversas técnicas de estudio
                    comprobadas.
                </td>    
            </tr>
        </table>
    </div>
    <div class="project">
        <div class="project__card">
            <a href="" class="project__image"><img src="img/LOGO.png"></a>
            <div class="project__detail">
                <h2 class="project__title">¡Bienvenido!</h2>
                <small class="project__category">Empieza a estudiar ;)</small>
            </div>
        </div>
    </div>
    <div id="box">
        <div id="main"></div>
        <div id="login">
            <h1>Iniciar Sesión</h1>
            <form method="POST" id="loginform" action="HashMap" class="Form_S yotoy">
                <div class="Grupo">
                    <input type="text" name="correo" id="coo" required>
                    <label for="coo" class="label">Correo electrónico:</label>
                </div>
                <div class="Grupo">
                    <input type="password" name="password" id="pss" required>                    
                    <label for="pss" class="label">Contraseña</label>
                </div>
                <button class="button" name="button" type="submit">Iniciar Sesión</button>
            </form>	
        </div>
        <div id="signup">
            <center><h1>Crear cuenta</h1></center>
            <form method="POST" class="Form_R" name="FormB" action="GuardarUsuario" id="FormRegistro" onsubmit="return checkSub()">
                <div class="Grupo">
                    <input type="text" name="nombre" id="nombre">
                    <label for="nombre" class="label">Nombre</label>
                </div><div class="Grupo">
                    <input type="text" name="appat" id="appat">
                    <label for="appat" class="label">Apellido paterno</label>
                </div><div class="Grupo">
                    <input type="text" name="apmat" id="apmat">
                    <label for="appat" class="label">Apellido materno</label>
                </div><div class="Grupo radio">
                   <h4>Sexo:</h4>
                   <center>
                    <input type="radio" name="Sexo" id="R16" value="1">
                    <label for="R16">Hombre</label>
                    <input type="radio" name="Sexo" id="R7" value="2">
                    <label for="R7">Mujer</label>
                    </center>
                </div><div class="Grupo">
                <input type="text" name="email" id="mail">
                <label for="mail" class="label">Correo electrónico</label>
                </div><div class="Grupo radio">
                    <h4>Grado de estudios:</h4>
                    <center>
                    <input type="radio" name="GradoAcademico" id="R1" value="1">
                    <label for="R1">Primaria</label>   
                    <input type="radio" name="GradoAcademico" id="R2" value="2">
                    <label for="R2">Secundaria</label>
                    <input type="radio" name="GradoAcademico" id="R3" value="3">
                    <label for="R3">Media Superior</label>
                    <input type="radio" name="GradoAcademico" id="R4" value="4">
                    <label for="R4">Superior</label><br>
                    <input type="radio" name="GradoAcademico" id="R5" value="5">
                    <label for="R5">Maestría</label>
                    <input type="radio" name="GradoAcademico" id="R6" value="6">
                    <label for="R6">Doctorado</label>
                    </center>
                </div><div class="Grupo">
                <input type="password" name="pass" id="pass">
                <label for="pass" class="label">Contraseña</label>
                </div><div class="Grupo">
                <input type="password" name="pass2" id="pass2">
                <label for="pass2" class="label">Confirma tu contraseña</label>
                </div><div class="Grupo radio" align="center">
                    <input type="radio" name="Tipo" id="R8" value="2">
                    <label for="R8">Tutor</label>
                    <input type="radio" name="Tipo" id="R9" value="1">
                    <label for="R9">Estudiante</label>
                </div>
                <center><input type="button" class="button" onclick="Validar()" value="Registrarme"></center>
            </form>
	</div>
	<div id="login_msg">¿Ya tienes cuenta?</div>
	<div id="signup_msg">¿No tienes cuenta?</div>
	<button id="login_btn">Iniciar Sesión</button>
	<button id="signup_btn">Registrarme</button>
    </div>
    <!-- particles.js container -->
    <div id="particles-js"></div>
    <!-- scripts -->
    <script type="text/javascript" src="JavaScript/jquery.hover3d.js"></script>
    <script type="text/javascript" src="JavaScript/animation1.js"></script>
    <script src="JavaScript/particles.js"></script>
    <script src="JavaScript/app.js"></script>
    <script src="JavaScript/Bienvenida.js"></script>
    <script src="JavaScript/animationinputs.js"></script>
    <script type="text/javascript" src="JavaScript/SweetAlert.js"></script>
</body>
</html>