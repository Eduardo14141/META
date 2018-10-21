$(document).ready(function(){
    $('body').on('click', 'a', function(e){
        e.preventDefault();
        var link = $(this).attr("href");
        swal({
            title: 'Salir de la sesión',
            text: "Si sales de la sesión, no se guardará tu progreso",
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Visitar'
        }).then((result) => {
            if(result.value){
                location.href=link;
            }
        });
    });
});

//Sesiones de estudio por tiempo 

/* Determinamos el tiempo total en segundos */
var activo = true;
var activoPlus = true;
var activoUltra = true;
var totalTiempo = 0;
var sesi = 0;
var sesiCurso = 1;
var descanso = 0;
var habil = false,
submits=0;
/* Determinamos la url donde redireccionar */
var url="Estudiante.jsp";

function updateReloj(){
    var a1= document.querySelector("#sesiones"),
    b1= document.querySelector("#minutos"),
    c1= document.querySelector("#descansos"),
    patron = /^\d*$/,
    btn= document.querySelector("#boton"),
    d1=document.querySelector("#textsesion");
    if(a1.value==null || b1.value==null || c1.value==null || a1.value.length<1 || b1.value.length<1|| c1.value.length<1){
        swal({
            type: 'error',
            title: 'Oops...',
            text: 'Asegúrese de completar todos los campos',
        });
        return false;
    }else if(isNaN(a1.value)){
        swal({
            type: 'error',
            title: 'Oops...',
            text: 'Ingrese los datos usando dígitos',
        }).then(function() {
            swal.close();
            a1.focus();
        });
        return false;
    }else if(isNaN(b1.value)){
        swal({
            type: 'error',
            title: 'Oops...',
            text: 'Ingrese los datos usando dígitos',
        }).then(function() {
            swal.close();
            b1.focus();
        });
        return false;
    }else if(isNaN(c1.value)){
        swal({
            type: 'error',
            title: 'Oops...',
            text: 'Ingrese los datos usando dígitos',
        }).then(function() {
            c1.focus();
        });
        return false;
    }else if(!patron.test(a1.value)){
        swal("El numero de sesiones de estudio sólo pueden contarse en unidades, tampoco ingrese puntos en este campo ;)").then(function() {
            a1.focus();
        });
        return false;
    }else if(a1.value.length>1 || a1.value>8){
        swal("Te recomendamos tomar un máximo de 8 sesiones de estudio, administra bien tus tiempos\n\
        y planea con cautela tu estudio").then(function() {
            a1.focus();
        });
        return false;
    }else if(b1.value<15){
        swal("Para tener un estudio adecuado se recomienda dedicar 25 minutos, sin embargo,\n\
        te pedimos 15 minutos como mínimo, para mejorar tu estudio").then(function() {
            b1.focus();
        });
        return false;
    }else if(b1.value>60){
        swal("Te aconsejamos tomar un descanso cada hora, usa un máximo de 60 minutos seguidos, se inteligente a la hora de estudiar, no te agobies ;)").then(function() {
            swal.close();
        });
        return false;
    }else if(b1.value.length>5){
        swal("No es necesario que seas tan específico").then(function(){
            b1.focus();
        });
        
        return false;
    }else if(c1.value>12 || c1.value<5){
        swal("Te aconsejamos que los descansos entre cada sesión sean entre 5 y 12 minutos para siempre\n\
        tener el estudio de la mejor calidad posible").then(function() {
            c1.focus();
        });
        return false;
    }else if(c1.value.length>5){
        swal("No es necesario que seas tan específico").then(function() {
            c1.focus();
        });
        return false;
    }else{
        document.getElementById('pitaya').hidden=true;
        a1.hidden=true;
        b1.hidden=true;
        document.getElementById('sun').hidden=true;
        document.getElementById('san').hidden=true;
        document.getElementById('ternera').hidden=true;
        c1.hidden=true;

        if(activoUltra){
            var relax = document.getElementById('descansos').value*60;
            document.getElementById('pitaya').value="Descansando";

        }
        if(activoPlus){
            var tempo = document.getElementById('minutos').value*60;
            sesi=document.getElementById('sesiones').value;
            document.getElementById('pitaya').value="Estudiando";

        }
        if(activo){
            if(activoPlus){
                totalTiempo=tempo;
                activoPlus=false;
                activoUltra=false;
                habil=false;
            }else if(activoUltra){
                totalTiempo=relax;
                activoUltra=false;
                habil=true;
            }
            document.getElementById('boton').disabled=true;
            document.getElementById('boton').value="En curso";
            activo=false;
        }
        var mostrarTiempo= ConvertirTiempo(totalTiempo);
        document.getElementById('CuentaAtras').innerHTML = "Tiempo restante: "+mostrarTiempo;

        if(sesiCurso>sesi){
            if(habil==0){
                habil++;
                var noses= Math.ceil(a1.value);
                var duracion= Math.ceil(b1.value);
                $.ajax({
                    url:"CompletarSesion",
                    type:"post",
                    data: {NoSesiones: noses, Duracion: duracion},
                    success: function(){
                        swal({
                            position: 'top-end',
                            type: 'success',
                            title: 'Sesión de estudio completada, bien hecho',
                            showConfirmButton: false,
                            timer: 2000
                        }).then(function(){
                            location.href="Estudiante.jsp";
                        });
                    }
                });
            }else{
                habil=0;
            }
            //window.location=url;//creo que ya no la vamos a usar
        }

        if(totalTiempo==0&&!habil)
        {
            d1.textContent="Sesion "+sesiCurso+" de "+sesi+" completada";

            sesiCurso++;
            document.getElementById('boton').disabled=false;
            document.getElementById('boton').value="Empezar descanso";

            activo=true;
            activoUltra=true;
            //Reproducir();
            swal({
                position: 'top-end',
                type: 'success',
                title: 'Haz completado esta sesión de estudio',
                showConfirmButton: false,
                timer: 2500
            });
            document.querySelector('#xyz').play();
            btn.click();

        }else if(totalTiempo==0&&habil){
            document.getElementById('boton').disabled=false;
            document.getElementById('boton').value="Empezar estudio";

            activo=true;
            activoPlus=true;
        }
        else{
            /* Restamos un segundo al tiempo restante */
            totalTiempo-=1;
            //document.getElementById('minutos').value-=1;
            /* Ejecutamos nuevamente la función al pasar 1000 milisegundos (1 segundo) */
            setTimeout("updateReloj()",1000);
        }


    }
    window.onsubmit=updateReloj;
    }
    function ConvertirTiempo(time){
        var minutes = Math.floor( time / 60 );
        var seconds = time % 60;

        //Anteponiendo un 0 a los minutos si son menos de 10
        minutes = minutes < 10 ? '0' + minutes : minutes;

        //Anteponiendo un 0 a los segundos si son menos de 10
        seconds = seconds < 10 ? '0' + seconds : seconds;

        var result = minutes + " min : " + seconds+" s";  // 161:30
        return result;
    }
    /*function Reproducir(){
        document.all.sound.src = "multimedia\\Notificacion.mp3";
    }
    function Parar(){
        document.all.sound.src = ""
    }*/
