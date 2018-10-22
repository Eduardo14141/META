<%-- 
    Document   : Jefes
    Created on : 17/05/2018, 11:25:52 PM
    Author     : Manager
--%>

<%@page import="TablasSQL.Misiones"%>
<%@page import="TablasSQL.Jefes"%>
<%@page import="Java.AccionesEstudiante"%>
<%@page import="java.util.List"%>
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
            if(e!=null){
                if(e.getNombre()!=null){
                    if(e.getTipoCuenta()==1){
                        int idCuenta= e.getIdCuenta();
                        Estudiante es= new Estudiante();
                        es = AccionesCuenta.ObtenerEstudianteByIdCuenta(idCuenta);
                        int idEstudiante= es.getIdEstudiante();
                        List <Jefes> listJefes= AccionesEstudiante.getAllJefes(idEstudiante);
                        String[] imagenesJefe = new String[8];
                        imagenesJefe[0]="img/Bosses/Boss1.png";
                        imagenesJefe[1]="img/Bosses/Boss2.png";
                        imagenesJefe[2]="img/Bosses/Boss4.png";
                        imagenesJefe[3]="img/Bosses/boss8.png";
                        imagenesJefe[4]="img/Bosses/Boss6.png";
                        imagenesJefe[5]="img/Bosses/descarga.png";
                        imagenesJefe[6]="img/Bosses/Boss7.png";
                        imagenesJefe[7]="img/Bosses/Boss5.png";
                    
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>META | Jefes</title>
        <link rel="stylesheet" href="Estilos/Jefes.css">
        <link rel="icon" href="img/LOGOI.ico">
    </head>
    <body>
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
            <div class="l-page">
                <div class="menu">
                <div class="menu-hamburger"></div>
                </div>
                    <section class="band band-c">
                <div class="band-container">
                    <div class="band-inner">
                    <h1>Crea jefes ;)</h1><hr>   
                        <form id="FormAJ" method="post">
                <input type="text" id="Jefe" name="Jefe" placeholder="Nombre del Jefe">
                <input type="date" id="Fin" name="Fin" placeholder="Fecha límite:">
                </form><br>
                        <p>Elige la imagen de tu jefe:</p>
            <div class="gallery">
                <a href="#">
    <figure>
      <img src="img/Bosses/Boss1.png" alt="Jefe 1">
        <figcaption><button onclick="AgImg(1)">Seleccionar</button></figcaption>
    </figure>
  </a>
                <a href="#">
    <figure>
      <img src="img/Bosses/Boss2.png" alt="Jefe 2">
        <figcaption><button onclick="AgImg(2)">Seleccionar</button></figcaption>
    </figure>
  </a>
                <a href="#">
    <figure>
      <img src="img/Bosses/Boss4.png" alt="Jefe 3">
        <figcaption><button onclick="AgImg(3)">Seleccionar</button></figcaption>
    </figure>
  </a>
                <a href="#">
    <figure>
      <img src="img/Bosses/boss8.png" alt="Jefe 4">
        <figcaption><button onclick="AgImg(4)">Seleccionar</button></figcaption>
    </figure>
  </a>
                <a href="#">
    <figure>
      <img src="img/Bosses/Boss6.png" alt="Jefe 5">
        <figcaption><button onclick="AgImg(5)">Seleccionar</button></figcaption>
    </figure>
  </a>
                <a href="#">
    <figure>
      <img src="img/Bosses/descarga.png" alt="Jefe 6">
        <figcaption><button onclick="AgImg(6)">Seleccionar</button></figcaption>
    </figure>
  </a>
                <a href="#">
    <figure>
      <img src="img/Bosses/Boss7.png" alt="Jefe 6">
        <figcaption><button onclick="AgImg(7)">Seleccionar</button></figcaption>
    </figure>
  </a>
                <a href="#">
    <figure>
      <img src="img/Bosses/Boss5.png" alt="Jefe 6">
        <figcaption><button onclick="AgImg(8)">Seleccionar</button></figcaption>
    </figure>
  </a>
            </div>
                      <input type="button" onclick="AgJefe(<%=es.getXp() %>)" value="Crear Jefe">  
            
                    </div>
                </div>
            </section>
            <%
                int idJefe=0, num=0, idima, misionescumplidas;
                for(Jefes JefeMost: listJefes){
                    misionescumplidas=0;
                    if(JefeMost.getActivo()==1 || JefeMost.getActivo()==0){
                    idJefe= JefeMost.getIdJefe();
                    idima= JefeMost.getImgJefe()-1;
                    if(idima>7 || idima<0) idima=1;
                    Jefes mostrar = AccionesEstudiante.ObtenerJefeActivo(idJefe);
                    List <Misiones> listaM= AccionesEstudiante.getMisionesJefe(idJefe);
                    num=0;
                
            %>
            <section class="bandband-a">
                <div class="band-container">
                    <div class="band-inner">
                        <h1><y>Mis jefes:</y></h1><hr>
                        <p><f>Para empezar a derrotar a tus jefes da click sobre ellos.</f></p><br><br>
                    <h1><f><%=mostrar.getJefe() %></f></h1>
                        <p><%=mostrar.getFin() %></p>
                        <table class="bossB">
        <%
                    if(listaM.size()==0){
                        if(JefeMost.getImgJefe()==0)JefeMost.setImgJefe(1);
        %>
                            <tr>                                
                                <td rowspan="3"><img src="<%=imagenesJefe[idima] %>" onclick="VisitarJefe(<%=idJefe %>)" class="VJ"></td>
                            </tr>
        <%
                    }else{
                    for(Misiones obtM: listaM){
                        
                        num++;
                        if(num==1){
        %>
                            <tr>                                
                                <td rowspan="<%=listaM.size() %>"><img src="<%=imagenesJefe[idima] %>" class="VJ" onclick="VisitarJefe(<%=idJefe %>)"></td>
                                <td> &nbsp;<%=obtM.getMision() %> &nbsp;</td>
        <%
                        if(obtM.getActivo()==0 && JefeMost.getActivo()==1){
                            misionescumplidas++;
        %>
        <td style="float: left;"><img src="img/Paloma.png" width="16px" height="16px"></td>
        <%
                        }
        %>
                            </tr>
        <%
                        }else{
        %>
                            <tr>
                                <td> &nbsp;<%=obtM.getMision() %> &nbsp;</td>
        <%
                        if(obtM.getActivo()==0 && JefeMost.getActivo()==1){
                            misionescumplidas++;
        %>
        <td style="float: left;"><img src="img/Paloma.png" width="16px" height="16px"></td>
        <%
                        }
        %>
                            </tr>
        <%
                        }
                    }
                    }
                    double porcentaje= listaM.size();
                    if(listaM.size()>0){
                        porcentaje=Math.floor(((misionescumplidas/porcentaje)*100));
                    }else{
                        porcentaje=0.0;
                    }
        %>
                            <tr>
                                <td align="right"><x style="color:#8ED948; font-size: 24px;"><%=porcentaje %>%</x></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </section>
            <%
                    }
                    }
            %>
            </div>
            </div>
            <form id="FormVis" method="post"></form>
        <script type="text/javascript" src="JavaScript/SweetAlert.js"></script>
        <script type="text/javascript" src="JavaScript/jQuery.js"></script>
        <script src="JavaScript/Jefes.js"></script>
        <script type="text/javascript" src="JavaScript/animation2.js"></script>
        <script src="JavaScript/OnScrollReveal.js"></script>
    <script type="text/javascript">
        window.sr = ScrollReveal();

        sr.reveal('.gallery', {
            duration: 1500
        });
        sr.reveal('.band-c h1', {
            duration: 1500
        });
        sr.reveal('.band-c input', {
            duration: 1500
        });
        sr.reveal('.bossB', {
            duration: 1500
        });
        sr.reveal('.band h1', {
            duration: 1500
        });
        sr.reveal('.band p', {
            duration: 1500
        });
        sr.reveal('.band hr', {
            duration: 1500
        });

    </script>
    </body>
</html>
        <%
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
