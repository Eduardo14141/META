<%-- 
    Document   : Misiones
    Created on : 19/05/2018, 07:42:44 PM
    Author     : Manager
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="TablasSQL.Misiones"%>
<%@page import="java.util.List"%>
<%@page import="TablasSQL.Jefes"%>
<%@page import="Java.AccionesEstudiante"%>
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
            if(e!=null){
                if(e.getNombre()!=null){
                    if(e.getTipoCuenta()==1){
                        int idCuenta= e.getIdCuenta();
                        Estudiante es= AccionesCuenta.ObtenerEstudianteByIdCuenta(idCuenta);
                        String a= request.getParameter("idJefe");
                        if(a==null || a.trim().isEmpty()) response.sendRedirect("Jefes.jsp");
                        else{
                        int idJefee=Integer.parseInt(a);
                        Jefes jefe= AccionesEstudiante.ObtenerJefeActivo(idJefee);
                        
                        if(jefe.getJefe()==null) response.sendRedirect("Jefes.jsp");
                        else if(jefe.getIdAlumno()!= es.getIdEstudiante()) response.sendRedirect("Denegar.jsp");
                        else{
                            List <Misiones> listaM= AccionesEstudiante.getMisionesJefe(idJefee);
                        String[] imagenesJefe = new String[8];
                        imagenesJefe[0]="img/Bosses/Boss1.png";
                        imagenesJefe[1]="img/Bosses/Boss2.png";
                        imagenesJefe[2]="img/Bosses/Boss4.png";
                        imagenesJefe[3]="img/Bosses/boss8.png";
                        imagenesJefe[4]="img/Bosses/Boss6.png";
                        imagenesJefe[5]="img/Bosses/descarga.png";
                        imagenesJefe[6]="img/Bosses/Boss7.png";
                        imagenesJefe[7]="img/Bosses/Boss5.png";
                        
                        String[] meses = new String[12];
                        meses[0]="Enero";
                        meses[1]="Febrero";
                        meses[2]="Marzo";
                        meses[3]="Abril";
                        meses[4]="Mayo";
                        meses[5]="Junio";
                        meses[6]="Julio";
                        meses[7]="Agosto";
                        meses[8]="Septiembre";
                        meses[9]="Octubre";
                        meses[10]="Noviembre";
                        meses[11]="Diciembre";
                        Date fecha= new Date();
                        SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                        String Hoy=""+ fecha.getDate()+"-"+ (fecha.getMonth()+1)+"-"+ (fecha.getYear()+1900);
                        Date fechaFinal=dateFormat.parse(Hoy);
                        
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>META | Misiones</title>
        <link rel="icon" href="img/LOGOI.ico">
        <link rel="stylesheet" href="Estilos/Misiones.css">
    </head>
    <body>
        <!--
            Importante:
            Hay una palomita en las misiones cumplidas, dar estilo de favor :D
        -->
        <div class="l-site">
        <div class="l-nav" scroll="no">
            <nav class="nav">
                <ul>
                    <li><a href="Estudiante.jsp"><img src="img/LOGOSquare.png" id="logo"></a></li>
                    <li class="hi"><w>¡</w>Hola <z><%=e.getNombre() %></z><y>!</y></li>
                    <li>
                        <x style="color:#8ED948;"><%=es.getXp() %>XP</x>
                    </li>
                    <li class="nav-primary"><a id="studyL" href="Sesiones.jsp">Programar Estudio</a></li>
                    <li class="nav-primary"><a id="homewL" href="Tareas.jsp">Tareas</a></li>
                    <li class="nav-primary"><a id="bossL" href="Jefes.jsp"><y>Jefes</y></a></li>
                    <li class="nav-primary"><a id="tutorL" href="MisVinculos.jsp">Tutor</a></li>
                    <li class="nav-primary"><a id="home" href="Datos.jsp">Ajustes</a></li>
                    <li class="nav-primary"><a id="salir" href="Salir">Cerrar Sesión</a></li>
                </ul>
            </nav>
        </div>
                    <%
                    int idima= jefe.getImgJefe()-1;
                    if(idima>7 || idima<0 ) idima=1;
                    %>
            <div class="l-page">
                <div class="menu">
                <div class="menu-hamburger"></div>
                </div>
                 <section class="bandband-a">
                <div class="band-container">
                    <div class="band-inner">
                        <h1><%=jefe.getJefe() %></h1>
                        <p><%=jefe.getFin() %></p>
                        <div class="contenedor" style="display: flex;">
                            <img src="<%=imagenesJefe[idima] %>" class="VJ" style="margin-right: 50px;">
                            <span>
        <%
                for(Misiones obtM: listaM){
                    Date fechaAprox = dateFormat.parse(obtM.getAprox());
                    int dias=(int) ((fechaAprox.getTime()-fechaFinal.getTime())/86400000);
                    System.out.println(obtM.getAprox()+" vs "+Hoy+" = "+dias);
                    String fec[]= obtM.getAprox().split("-");
                    int mesTarea= Integer.parseInt(fec[1]);
                    String fechade= fec[0]+ " de "+meses[mesTarea-1]+" del "+ fec[2];
                        if(obtM.getActivo()==0 && jefe.getActivo()==1){
        %>
        <textarea readonly>&nbsp;<%=obtM.getMision() %> &nbsp;</textarea>
        <img src="img/Paloma.png" width="16px" height="16px">
        <%
                        }else if(obtM.getActivo()==1 && jefe.getActivo()==1){
                            if(dias<1){
        %>
        <p style="color:#D32F2F; ">Fecha aproximada: <%=fechade %> <br> ¡Esfuérzate más!</p>
        <%
                            }else{
        %>
        <p>Fecha aproximada: <%=fechade %> </p>
        <% 
                            }
        %>
                            <textarea readonly class="IrMision" onclick="FinalizarMision(<%=obtM.getIdMision() %>)">&nbsp;<%=obtM.getMision() %> &nbsp;</textarea>
        <%
                        }else{
%>
                            <textarea readonly >&nbsp;<%=obtM.getMision() %> &nbsp;</textarea>
<%
                        }
                    }
                                
        %>                        
                                
                            </span>
                        </div>
        <br><br>
                        <div  class="misiones">
                            <form method="post" action="AgregarMision" id="AgMision" name="AgMision">
                                <input type="text" placeholder="Nombre de la misión" name="Mision" id="Mision">
                                <input type="date" placeholder="Fecha límite:" name="Aprox" id="Aprox"> &nbsp; &nbsp;
                                <input type="button" value="Agregar Misión" onclick="ValidarMision(<%=jefe.getIdJefe() %>)">
                            </form>
                        </div><br><br>
                        <p style="color: cornflowerblue; font-size: 24px;">Más información acerca de los jefes:</p><br><br>
                        <p style="color: #6f1cbc;">Los jefes no son cosa fácil, para completar una misión da click sobre el nombre de la misma.</p><br>
                        <p style="color: slateblue;">Los jefes son fuertes, debes atacarlos con 3 misiones por lo menos para debilitarlos.</p><br>
                        <p style="color: lightskyblue;">Los jefes se alimentan de las tareas olvidadas, ¡cumple todas para que no se fortalezca!</p><br>
                        <p style="color: sandybrown;">Los jefes se despiertan a partir de la tercera misión, mientras no podrás debilitarlo</p><br>
                        <input type="button" id="VencerB" onclick="VencerJefe(<%=jefe.getIdJefe() %>)" value="Derrotar Jefe">
                    </div>
                </div>
            </section>
        <form method="post" id="ActMis"></form><!--No borrar-->
            </div>
        </div>
    </body>
    <script src="JavaScript/Jefes.js"></script>
    <script type="text/javascript" src="JavaScript/SweetAlert.js"></script>
    <script type="text/javascript" src="JavaScript/jQuery.js"></script>
        <%
            String resp= (String) request.getAttribute("CA");
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
</html>
        <%
                        }
                        }
                    }else{
                        response.sendRedirect("Denegar.jsp");
                    }
                }else{
                    response.sendRedirect("index.jsp");
                }
            }else{
                response.sendRedirect("index.jsp");
            }
        %>
