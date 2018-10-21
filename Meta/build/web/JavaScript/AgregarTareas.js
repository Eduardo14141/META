$(document).ready(function(){
   $("#AgregarSubmit").click(function(){
        var tareades = document.getElementsByName("Descripcion"),
        tareaInput = document.querySelector("#Tarea"),
        tarea = tareaInput.value.length, 
        To= document.querySelector("#To_Do"), 
        Pro= document.querySelector("#En_P");
        var numero= To.getElementsByTagName('textarea').length+ Pro.getElementsByTagName('textarea').length;
        if(tarea<10){
            swal({
                type: 'warning',
                title: 'Oops...',
                text: 'por favor ingrese una descripción de al menos 10 caracteres',
            });
            tareaInput.focus();
            return false;
        }else if(tarea>128){
            swal({
                type: 'warning',
                title: 'Oops...',
                text: 'Por favor no imgrese más de 128 caracteres',
            });
            tareaInput.focus();
            return false;
        }else if(numero>15){
            swal({
                type: 'warning',
                title: 'Oops...',
                text: 'Has alcanzado el número máximo de tareas',
            });
            return false;
        }else if($(tareades).length === 0) {
            swal({
                type: 'warning',
                title: 'Oops...',
                text: 'Para subir tu tarea exitosamente respeta los nombres del documento',
            });
            location.href="Tareas.jsp";
            return false;
        }else{
//            var data={Descripcion:tareaInput.value};
//            $.post("AgregarTareas", data, function(res, est, jqXHR){
//                $("#To_Do").remove...
//            });
            $.ajax({
                url:"AgregarTareas",
                type:"post",
                data: {Descripcion: tareaInput.value},
                success: function(retorna){
                    var txtarea= document.createElement("textarea");
                    var fe= document.createElement("h4");
                    fe.textContent= fecha();
                    txtarea.textContent=tareaInput.value;
                    txtarea.className="Pendientes";
                    txtarea.id=retorna;
                    txtarea.setAttribute("readonly", true);
                    To.append(fe);
                    To.append(txtarea);
                    tareaInput.value="";
                }
            });
        }
   });
});
function fecha(){
    var meses = new Array ("Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre");
    var f=new Date();
    return (f.getDate() + " de " + meses[f.getMonth()] + " de " + f.getFullYear());
}
$(document).ready(function(){
    var idTarea,
    msg1="¿Desea marcar esta tarea como tarea en progreso?, al hacerlo irás a la sección de tareas :3";
    $(".Pendientes").click(function(){
        idTarea= $(this).attr("id");
        swal({
            title: 'Visitar tarea',
            text: msg1,
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Visitar'
        }).then((result) => {
            if(result.value){
                var form= $("#Vis"),
                input= document.createElement("input");
                input.setAttribute("type", "hidden");
                input.setAttribute("value", idTarea);
                input.setAttribute("name", "idTarea");
                form.append(input);
                form.submit();                
            }
        });
    });
    $(".Progreso").click(function(){
        idTarea= $(this).attr("id");
        var form= $("#Vis"),
        input= document.createElement("input");
        input.setAttribute("type", "hidden");
        input.setAttribute("value", idTarea);
        input.setAttribute("name", "idTarea");
        form.append(input);
        form.submit();
    });
});
function CalificarSesion(m){
    var progreso= document.getElementsByName("Progreso"),
        contenido = document.querySelector("#Progreso").value,
        patron = /^\d*$/;    
    if(contenido.length<1) swal("Ingresa tu progreso para finalizar la sesión");
    else if($(progreso).length === 0) swal("No cambies los nombres :(").then(function(){location.href="Sesiones.jsp";});
    else if(isNaN(contenido)) swal("Por favor no ingreses letras");
    else if(contenido<0) swal("El rango de calificación es entre 0 y 100");
    else if(!patron.test(contenido)) swal("Por favor no ingreses puntos");
    else if(contenido>100) swal("El rango de calificación es entre 0 y 100");
    else{
        $.ajax({
            url:"ActualizarTareas",
            type:"post",
            data: {idTarea: m, Progreso: contenido},
            success: function(respuesta){
                if(respuesta==="1"){
                    var otro = document.querySelector("#AProgress");
                    otro.value=contenido;
                    if(contenido==="100") location.href="Tareas.jsp";
                    contenido="";
                }else swal(respuesta);
            }
        });
    }
}
function MostrarHistorial(){
    var div = document.querySelector("#divHistorial"),
    boton = document.querySelector("#BtnAg");
    if(div.style.display==='none'){
        div.style.display="block";
        div.style.display="align-self:flex-end;";
        boton.value="Ocultar historial";
    }else{
        div.style.display="none";
        boton.value="Ver tareas terminadas";
    }
}

function DesecharTarea(idTarea){
    swal({
        title: 'Desechar tarea',
        type: 'warning',
        text: "No será capaz de revertir esta acción",
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Eliminar'
    }).then((result) => {
        if(result.value){
            $.ajax({
                url:"EliminarTarea",
                type:"post",
                data: {idTarea: idTarea},
                success: function(respuesta){
                    if(respuesta==="sin"){
                        var txta=$("#df3rn"+idTarea).parent();
                        $(txta).remove();
                    }else{
                        var txta=$("#df3rn"+idTarea).parent();
                        $(txta).remove();
                        var a=respuesta.split(",");
                        a.forEach(ABC);
                        function ABC(item, index){
                            var Comment= $("#st4g"+item);
                            $(Comment).remove();
                        }
                    }
                }
            });
        }
    });
}
$(document).ajaxComplete(function() {
    $(".Pendientes").click(function(){
        var idTarea= $(this).attr("id"),
        msg1="¿Desea marcar esta tarea como tarea en progreso?, al hacerlo irás a la sección de tareas :3";
        swal({
            title: 'Visitar tarea',
            text: msg1,
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Visitar'
        }).then((result) => {
            if(result.value){
                var form= $("#Vis"),
                input= document.createElement("input");
                input.setAttribute("type", "hidden");
                input.setAttribute("value", idTarea);
                input.setAttribute("name", "idTarea");
                form.append(input);
                form.submit();                
            }
        });
    });
    $(".DesecharTarea").click(function (){var idTarea= $(this).attr("id").replace("df3rn","");DesecharTarea(idTarea);});
});
$(document).ready(function(){
    $(".DesecharTarea").click(function (){var idTarea= $(this).attr("id").replace("df3rn","");DesecharTarea(idTarea);});
    $("#BTNDTT").click(function (){ DesecharTodasLasTareas(); });
    $("#BtnAg").click(function (){ MostrarHistorial();});
    $("#Finish").click(function (){var idTarea= $(this).attr("name"); CalificarSesion(idTarea);});
    
});
function DesecharTodasLasTareas(){
    $.ajax({
        url:"VaciarTareas",
        type:"post",
        data: {},
        success: function(respuesta){
            if(respuesta ==="1") $("#contSpan").remove();
            else swal({
                type: 'error',
                title: 'Oops...',
                text: 'ha ocurrido un error inténtelo de nuevo',
            });
        }
    });
}
$(document).ready(function(){
    $('body').on('click', '.ComentarioSR', function(){
        swal({
            title: 'Resolver',
            text: '¿Marcar este comentario como resuelto?',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '¡Ya lo!'
        }).then((result) => {
            if(result.value){
                var idComentario= $(this).attr("id").replace("7hf4i","");
                $.ajax({
                    url:"DesactivarComentario",
                    type:"post",
                    data: {idComentario: idComentario},
                    success: function(respuesta){
                        if(respuesta ==="1"){
                            swal({
                                type: 'Success',
                                text: 'Marcado como resuelto',
                                showConfirmButton: false,
                                timer: 1500
                            });
                            $("#st4g"+idComentario).remove();
                            var txt= document.createElement("textarea"),
                                y= document.createElement("y"),
                                img= document.createElement("img"),
                                span= document.createElement("span");
                            span.setAttribute("id", "st4g"+idComentario);
                            $("#HistorialC").append(span);
                            y.textContent= document.querySelector("#st4g"+idComentario).elements[0].textContent;
                            txt.setAttribute("id", "lk9o8"+idComentario);
                            img.setAttribute("id", "lk9o8"+idComentario);
                            img.setAttribute("src", "img/Trash.png");
                            img.setAttribute("width", "30px");
                            img.setAttribute("height", "30px");
                            img.setAttribute("class", "DesecharCom");
                            $(span).append(y);
                            $(span).append(img);
                        }
                        else swal({
                            type: 'error',
                            title: 'Oops...',
                            text: 'No se ha podido desactivar, inténtelo de nuevo :(',
                        });
                    }
                });
            }
        });
    });
});