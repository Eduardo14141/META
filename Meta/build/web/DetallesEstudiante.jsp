<%-- 
    Document   : RevisionP
    Created on : 13/05/2018, 03:09:07 PM
    Author     : Manager
--%>

<%@page import="TablasSQL.Vinculo"%>
<%@page import="TablasSQL.Tarea"%>
<%@page import="Java.AccionesEstudiante"%>
<%@page import="TablasSQL.Estudiante"%>
<%@page import="Java.AccionesCuenta"%>
<%@page import="TablasSQL.Tutor"%>
<%@page import="TablasSQL.Cuenta"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>

<%@page import="java.util.List"%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%
            HttpSession sesion = (HttpSession) request.getSession();
            Cuenta e = (Cuenta) sesion.getAttribute("Usuario");
            if(e!=null || e.getNombre()!=null){
                if(e.getTipoCuenta()==2){
                    Tutor tut= AccionesCuenta.ObtenerTutorByIdCuenta(e.getIdCuenta());
                    String idEst= request.getParameter("idEstudiante");
                    if(idEst==null||idEst.trim().isEmpty()) response.sendRedirect("MisEstudiantes.jsp");
                    else if(!AccionesCuenta.isNumeric(idEst)) response.sendRedirect("MisEstudiantes.jsp");
                    else{
                        int idEstudiante= Integer.parseInt(idEst);
                        boolean existe=false;
                        List<Vinculo> list = AccionesEstudiante.getAllVinculosByIdEstudiante(idEstudiante);
                        for(Vinculo milista: list){
                            if((tut.getIdTutor()==milista.getIdTutor())&& milista.getActivo()==1) existe=true;
                        }
                        if(existe){
                        List <Tarea> listaT= AccionesEstudiante.getTareasDelEstudiante(idEstudiante);
                        Date fecha= new Date();
                        SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                        String b, Hoy;
                        String[] meses = new String[13];
                    meses[0]="Enero";       meses[1]="Febrero"; meses[2]="Marzo";       meses[3]="Abril";
                    meses[4]="Mayo";        meses[5]="Junio";   meses[6]="Julio";       meses[7]="Agosto";
                    meses[8]="Septiembre";  meses[9]="Octubre"; meses[10]="Noviembre";  meses[11]="Diciembre";
                            String[] titulo = new String[6];
                    titulo[0]="Primaria";   titulo[1]="Secundaria"; titulo[2]="Media superior";
                    titulo[3]="Superior";   titulo[4]="Mastría";    titulo[5]="Doctorado";
                        String a= titulo[e.getTítulo()-1];
                        Cuenta miAlumno = AccionesCuenta.ObtenerCuentaByEstudiante(idEstudiante);
                        meses[12]= miAlumno.getNombre()+miAlumno.getAppat();
                        if(miAlumno.getApmat()!=null) meses[12]+= miAlumno.getApmat();
                        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
                        response.setHeader("Pragma", "no-cache");
                        response.setDateHeader("Expires", 0);
        %>
        <title>META | Tareas de Estudiante</title>
        <link rel="stylesheet" href="Estilos/Tareas.css">
        <link rel="icon" href="img/LOGOI.ico">
    </head>
    <body>
        <div class="l-site">
            <div class="l-nav">
    <nav class="nav">
      <ul>
          <li><a href="Tutor.jsp"><img src="img/LOGOSquare.png"></a></li>
          <li class="hi"><w>¡</w>Hola <z><%=e.getNombre() %></z><y>!</y></li>
      <li><y>Link Code</y></li>
      <li><x style="color:#8ED948; font-size: 26px;"><%=tut.getCódigo() %></x></li>
        <x style="color:#8ED948;"><%=a %></x>
        <li class="nav-primary"><a id="studyL" href="MisEstudiantes.jsp">Mis estudiantes</a></li>
          <li class="nav-primary"><a id="tutorL" href="Examen.jsp">Crear examen</a></li>
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
                    <h1>¡Supervisa las tareas de tus estudiantes y enviales comentarios!</h1>
                    <p>Observa cuales son las tareas actuales de tus estudiantes, así como su progreso y si estan en <x>pendientes</x> o <y>en progreso</y>. Y mandales un comentario dando click sobre la tarea que desees.</p><br>
                    <h3><n>Tareas de</n> <z><%=meses[12] %></z></h3>
                <div class="To_Do">
                    <h3>Tareas <x>Pendientes</x></h3><hr>
        <%
                        String num;
                        ArrayList <String> TareasMal= new ArrayList();
                        for(Tarea t: listaT){
                            if(t.getCategoria()==3){
                                b= t.getFecha();
                                Hoy=""+ fecha.getDate()+"-"+ (fecha.getMonth()+1)+"-"+ (fecha.getYear()+1900);
                                Date fechaInicial=dateFormat.parse(b);
                                Date fechaFinal=dateFormat.parse(Hoy);
                                int dias=(int) ((fechaFinal.getTime()-fechaInicial.getTime())/86400000);
                                num=t.getDescripcion();
                                if(dias>6) TareasMal.add("• "+num);

                                String fec[]= t.getFecha().split("-");
                                int mesTarea= Integer.parseInt(fec[1]);
                                String fechade= fec[0]+ " de "+meses[mesTarea]+" del "+ fec[2];
                                
        %>
                        <h4><%=fechade %></h4>
                        <textarea class="Pendientes Tarea" id="mj23sd4<%=t.getIdTarea() %>" readonly><%=t.getDescripcion() %></textarea>
        <%
                            }
                        }
        %>
                    </div>
                    <div class="En_P">
                        <h3>Tareas <y>en progreso</y></h3><hr>
                        <%
                            for(Tarea t: listaT){
                                if(t.getCategoria()==2){
                                    b= t.getFecha();
                                    Hoy=""+ fecha.getDate()+"-"+ (fecha.getMonth()+1)+"-"+ (fecha.getYear()+1900);
                                    Date fechaInicial=dateFormat.parse(b);
                                    Date fechaFinal=dateFormat.parse(Hoy);
                                    int dias=(int) ((fechaFinal.getTime()-fechaInicial.getTime())/86400000);
                                    num=t.getDescripcion();
                                    num = num.substring(0, 9);
                                    if(t.getDescripcion().length()>10) num+="...";
                                    if(dias>6){
                                        TareasMal.add("• "+num);
                                    }

                                    String fec[]= t.getFecha().split("-");
                                    int mesTarea= Integer.parseInt(fec[1]);
                                    String fechade= fec[0]+ " de "+meses[mesTarea]+" del "+ fec[2];
        %>
                        <h4><%=fechade %></h4>
                        <textarea class="Progreso Tarea" id="mj23sd4<%=t.getIdTarea() %>" readonly><%=t.getDescripcion() %></textarea>
        <%
                                }
                            }
        %>
                    </div>
                    <div class="Notas">
        <%
                            if(!TareasMal.isEmpty()){
                                b="el estudiante lleva una semana sin progreso alguno en las siguientes tareas:\n";
                                for(int i=0; i<TareasMal.size();i++) b+=TareasMal.get(i)+"\n";
        %>
                        <textarea readonly>Hola, <%=b %></textarea>
        <%
                            }
        %>
                    </div>
                
                <form action="Comentar" id="FormComentar" method="post" style="display:none;">
                    <div class="Ultimo">
                        <h3>Mandar comentario</h3><hr>
                        <textarea id="txtarea" name="Comentario"></textarea>
                        <input type="button" id="Coment" value="Enviar">
                    </div>
                </form>
            </div>
                            </div>
                            </section>
            </div>                
            </div>
        <script type="text/javascript" src="JavaScript/jQuery.js"></script>
        <script src="JavaScript/AccProfesor.js"></script>
        <script type="text/javascript" src="JavaScript/animation2.js"></script>
        <script src="JavaScript/OnScrollReveal.js"></script>
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
        sr.reveal('.band textarea', {duration: 1500});
        sr.reveal('.band .Notas', {duration: 1500});
        </script>
        <script type="text/javascript" src="JavaScript/SweetAlert.js"></script>
    </body>
</html>
<%
                        }else response.sendRedirect("Denegar.jsp");
                    }
                }else{
                    response.sendRedirect("Denegar.jsp");
                }
            }else{
                response.sendRedirect("index.jsp");
            }
        %>
