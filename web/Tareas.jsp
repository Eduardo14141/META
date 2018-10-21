<%-- 
    Document   : Tareas
    Created on : 15/05/2018, 01:10:39 AM
    Author     : Manager
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="TablasSQL.Comentario"%>
<%@page import="Java.AccionesEstudiante"%>
<%@page import="java.util.ArrayList"%>
<%@page import="TablasSQL.Tarea"%>
<%@page import="java.util.List"%>
<%@page import="Java.AccionesCuenta"%>
<%@page import="TablasSQL.Estudiante"%>
<%@page import="TablasSQL.Cuenta"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script type="text/javascript" src="JavaScript/jQuery.js"></script>
        <%
            HttpSession sesion = (HttpSession) request.getSession();
            Cuenta e = (Cuenta) sesion.getAttribute("Usuario");
            if(e!=null && e.getNombre()!=null){
                if(e.getTipoCuenta()==1){
                    Estudiante es = AccionesCuenta.ObtenerEstudianteByIdCuenta(e.getIdCuenta());
                    List <Tarea> listaTareas = AccionesEstudiante.getTareasDelEstudiante(es.getIdEstudiante());
                    List <Comentario> listaC = AccionesEstudiante.getMisComentarios(es.getIdEstudiante());
                    Date fecha= new Date();
                    SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                    String[] meses = new String[12];
                    meses[0]="Enero";       meses[1]="Febrero"; meses[2]="Marzo";       meses[3]="Abril";
                    meses[4]="Mayo";        meses[5]="Junio";   meses[6]="Julio";       meses[7]="Agosto";
                    meses[8]="Septiembre";  meses[9]="Octubre"; meses[10]="Noviembre";  meses[11]="Diciembre";
                    String b, fechade, Hoy;
                    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
                    response.setHeader("Pragma", "no-cache");
                    response.setDateHeader("Expires", 0);
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>META | Tareas</title>
        <link rel="stylesheet" href="Estilos/Tareas.css">
        <link rel="icon" href="img/LOGOI.ico">
    </head>
    <body>
        <div class="l-site">
            <div class="l-nav">
                <nav class="nav">
                    <ul>
                        <li><a href="Estudiante.jsp"><img src="img/LOGOSquare.png"></a></li>
                        <li class="hi"><w>¡</w>Hola <z><%=e.getNombre() %></z><y>!</y></li>
                        <li><x style="color:#8ED948;"><%=es.getXp() %>XP</x></li>
                        <li class="nav-primary"><a id="studyL" href="Sesiones.jsp">Programar Estudio</a></li>
                        <li class="nav-primary"><w>Tareas</w></li>
                        <li class="nav-primary"><a id="bossL" href="Jefes.jsp">Jefes</a></li>
                        <li class="nav-primary"><a id="tutorL" href="MisVinculos.jsp">Tutor</a></li>
                        <li class="nav-primary"><a id="home" href="Datos.jsp">Ajustes</a></li>
                        <li class="nav-primary"><a id="salir" href="Salir">Cerrar Sesión</a></li>
                    </ul>
                </nav>
            </div>  
            <div class="l-page">
                <div class="menu"><div class="menu-hamburger"></div></div>
                <section class="band band-b">   
                <div class="band-container">
                <div class="band-inner">
                    <h1>Organiza tus tareas</h1>
                    <p>Agrega tareas a tu lista de tareas <x>pendientes</x>, y para cambiarlas a <y>en progreso</y> da click sobre ellas.</p>
                    <form class="AgregarTarea">
                        <br>      
                        <input type="text" id="Tarea" name="Descripcion" placeholder="Nombre de la tarea">
                        <input type="button" name="BtnAgregar" id="AgregarSubmit" value="Agregar">
                    </form>
                    <div class="To_Do" id="To_Do">
                        <h3>Tareas <x>Pendientes</x></h3><hr>
    <%
                        String num;
                        ArrayList <String> TareasMal= new ArrayList();
                        Hoy=""+ fecha.getDate()+"-"+ (fecha.getMonth()+1)+"-"+ (fecha.getYear()+1900);
                        for(Tarea t: listaTareas){
                            if(t.getCategoria()==3){
                                b= t.getFecha();
                                Date fechaInicial=dateFormat.parse(b);
                                Date fechaFinal=dateFormat.parse(Hoy);
                                int dias=(int) ((fechaFinal.getTime()-fechaInicial.getTime())/86400000);
                                num= t.getDescripcion();
                                if(dias>6) TareasMal.add("• "+num);
                                String fec[]= t.getFecha().split("-");
                                int mesTarea= Integer.parseInt(fec[1]);
                                fechade= fec[0]+ " de "+meses[mesTarea-1]+" del "+ fec[2];
                                
                                
    %>
                        <span>
                        <h4><%=fechade %></h4>
                        <textarea class="Pendientes" readonly id="<%=t.getIdTarea() %>"><%=t.getDescripcion() %></textarea>
    <%
                                if(dias>6){
    %>
                        <img src="img/Trash.png" width="35px" height="40px" class="DesecharTarea" id="df3rn<%=t.getIdTarea() %>">
    <%
                                }
    %>
                        </span>
    <%
                            }
                        }
    %>
                    </div>
                    <div class="En_P" id="En_P">
                        <h3>Tareas <y>en progreso</y></h3><hr>
                        <%
                        for(Tarea t: listaTareas){
                            if(t.getCategoria()==2){
                                b= t.getFecha();
                                Date fechaInicial=dateFormat.parse(b);
                                Date fechaFinal=dateFormat.parse(Hoy);
                                int dias=(int) ((fechaFinal.getTime()-fechaInicial.getTime())/86400000);
                                num=t.getDescripcion();
                                if(dias>6) TareasMal.add("• "+num);
                                
                                String fec[]= t.getFecha().split("-");
                                int mesTarea= Integer.parseInt(fec[1]);
                                fechade= fec[0]+ " de "+meses[mesTarea-1]+" del "+ fec[2];
        %>
                        <span>
                        <h4><%=fechade %></h4>
                        <textarea class="Progreso" readonly id="<%=t.getIdTarea() %>"><%=t.getDescripcion() %></textarea><e style="color:#8ED948; font-size: 20px; font-weight: bold"> <%=t.getProgreso() %>%</e>
                        <%
                                if(dias>6){
                        %>
                        <img src="img/Trash.png" id="df3rn<%=t.getIdTarea() %>" class="DesecharTarea">
                        
                        <%
                                }
                        %>
                        </span>
        <%
                            }
                        }
        %>
                    </div><br>
                    <div class="Notas">
        <%
                        if(!TareasMal.isEmpty()){
                            b="llevas una semana sin checar las siguientes tareas:\n";
                            for(int i=0; i<TareasMal.size();i++) b+=TareasMal.get(i)+"\n";
                            b+="¡no las olvides!";
        %>
                        <textarea readonly>Hola, <%=b %></textarea>
        <%
                        }
        %>
                    </div><br>
                    <div class="Done">
                        <input type="Button" id="BtnAg" value="Tareas terminadas">
                        <div id="divHistorial" class="historial" style="display: none; padding:0 10px 0 10px;">
                            <h3 style="color: #ffbc49;">Tareas finalizadas</h3><hr style="border: 2px solid #ffbc49">
                            <div id="contSpan">
        <%
                        for(Tarea t: listaTareas){
                            if(t.getCategoria()==1){
                                Hoy="si";
        %>
                                <span>
                                    <h4><%=t.getFecha() %></h4>
                                    <textarea class="Historial" id="<%=t.getIdTarea() %>" readonly><%=t.getDescripcion() %></textarea>
                                    <img src="img/Trash.png" id="df3rn<%=t.getIdTarea() %>" class="DesecharTarea">
                                </span>
        <%
                            }
                        }if(Hoy.equals("si")){
        %>
                                <br><input type="button" id="BTNDTT" value="Vaciar todo">
        <%
                        }
        %>
                            </div>
                        </div>
                    </div>
                    <div class="Com" style="padding:0 10px 0 10px;">
                        <h3>Comentarios</h3><hr style="border: 2px solid #ffbc49">
        <%
                        for (Comentario com: listaC) {
                            if(com.getActivo()==1){
                                Tarea comentada= AccionesEstudiante.ObtenerTareaActiva(com.getIdTarea());
                                Cuenta tut = AccionesCuenta.ObtenerCuentaByTutor(com.getIdTutor());
        %>
                        <span id="st4g<%=com.getIdComentario() %>">
                            <y><%=comentada.getDescripcion() %></y><br>
                            <textarea class="ComentarioSR" readonly id="7hf4i<%=com.getIdComentario() %>"><%=tut.getNombre() %>: <%=com.getComentario() %></textarea><hr style="border: 2px solid #ffbc49">
                        </span>
        <%
                            }
                        }
        %>
                    </div><br>               
                    <input type="button" id="BtnMc" value="Más comentarios" onclick="MostarHisC()">
                        <div class="ComentariosR">
                            <div class="Com" style="padding:0 10px 0 10px;">
                                <div class="HistorialC" id="HistorialC" style="display: none;">
                                    <h3>Otros comentarios</h3><hr style="border: 2px solid #ffbc49">
        <%
                        for(Comentario com: listaC){
                            if(com.getActivo()==0){
                                Cuenta tut = AccionesCuenta.ObtenerCuentaByTutor(com.getIdTutor());
                                Tarea comentada= AccionesEstudiante.ObtenerTareaActiva(com.getIdTarea());
         %>
                                    <span id="st4g<%=com.getIdComentario() %>">
                                        <y><%=comentada.getDescripcion() %></y><br>
                                        <textarea class="ComentarioR" readonly><%=tut.getNombre() %>: <%=com.getComentario() %></textarea>
                                        <img src="img/Trash.png" width="30px" height="30px" id="lk9o8<%=com.getIdComentario() %>" class="DesecharCom"><hr style="border: 2px solid #ffbc49">
                                    </span>
        <%                   
                            }
                        }
        %>
                                </div>
                                <form id="Vis" method="post" action="DetallesTarea.jsp"></form>
                            </div>
                        </div>
                    </div>
                    </div>
                </section>
            </div>
        </div>                      
        <script type="text/javascript" src="JavaScript/animation2.js"></script>
        <script type="text/javascript" src="JavaScript/AgregarTareas.js"></script>    
        <script src="JavaScript/OnScrollReveal.js"></script>
        <script type="text/javascript" src="JavaScript/SweetAlert.js"></script>
        <script type="text/javascript">
        window.sr = ScrollReveal();
        sr.reveal('.band .To_Do', {duration: 1500});
        sr.reveal('.band .En_P', {duration: 1500});
        sr.reveal('.band h1', {duration: 1500});
        sr.reveal('.band p', {duration: 1500});
        sr.reveal('.band form', {duration: 1500});
        sr.reveal('.band h3', {duration: 1500});
        sr.reveal('.band input[type=text]', {duration: 1500});
        sr.reveal('.band input[type=reset]', {duration: 1500});
        sr.reveal('.band input[type=button]', {duration: 1500});
        sr.reveal('.band h4', {duration: 1500});
        sr.reveal('.En_P textarea', {duration: 1500});
        sr.reveal('.To_Do textarea', {duration: 1500});
        sr.reveal('.band .Notas', {duration: 1500});
        </script>
    </body>
</html>
        <%
                }else response.sendRedirect("Denegar.jsp");
            }else response.sendRedirect("index.jsp");
        %>