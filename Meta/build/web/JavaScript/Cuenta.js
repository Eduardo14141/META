$(document).ready(function(){
    if($("#FormDatos").length!==0){
        $("#FormDatos").change(function(){
            var Formlen = document.querySelector('#FormDatos');
            for(var i=0;i<Formlen.elements.length;i++){
                var FormC = Formlen.elements[i];
                if((FormC.type==="text" || FormC.type==="password")||FormC.type==="radio"){
                    if(FormC.value.length>0) FormC.parentElement.children[1].className="label active";
                    if(FormC.value.length<1) FormC.parentElement.children[1].className="label";
                }
            }
        });
    }else if($("#FormCuenta").length!==0){
        $("#FormCuenta").change(function(){
            var Formlen = document.querySelector('#FormCuenta'), FormC;
            for(var i=0;i<Formlen.elements.length;i++){
                FormC = Formlen.elements[i];
                if((FormC.type==="text" || FormC.type==="password")){
                    if(FormC.value.length>0) FormC.parentElement.children[1].className="label active";
                    if(FormC.value.length<1) FormC.parentElement.children[1].className="label";
                }
            }
        });
    }
});
function ValidarCambios(q){
    var formulario=document.querySelector("#FormDatos");
    var elementos = formulario.elements;
    var patron = /^([A-Za-zÑñáéíóúÁÉÍÓÚ ]+)$/;
    var nom =document.querySelector("#nombre"), 
    appat=document.querySelector("#appat"),
    apmat=document.querySelector("#apmat");
    //Validando textbox completos
    for (var i = 0; i < elementos.length; i++) {
        if ((elementos[i].type === "text" || elementos[i].type === "password")&&(i!=2 || i!=3)) {
            if (elementos[i].value.length == 0) {
		swal('Por favor llene el campo');
		elementos[i].className = elementos[i].className + " error";
                elementos[i].focus();
		return false;
            }else if(elementos[i].value.length>25 &&(i==1||i==2||i==0)){
                //Validando campos nombre, appat, apmat y contraseña;
                swal("No ingreses más de 25 carácteres en este campo");
                elementos[i].className = elementos[i].className + " error";
                elementos[i].focus();
                return false;
            }
            else {
                elementos[i].className = elementos[i].className.replace(" error", "");
            }
        }
    }
    //validando nombre
    if(!patron.test(nom.value)){
        swal("Ingresa un nombre válido");
        nom.className = nom.className + " error";
        nom.focus();
        return false;
    }
    if(!patron.test(appat.value)){
        swal("Ingresa un apellido válido");
        appat.className = appat.className + " error";
        appat.focus();
        return false;
    }
    if(!patron.test(apmat.value) && apmat.value.length>0){
        swal("Ingresa un apellido válido");
        apmat.className = apmat.className + " error";
        apmat.focus();
        return false;
    }
    //Validando correo
    var emailRegex = /^[-\w.%+]{1,64}@(?:[A-Z0-9-]{1,63}\.){1,125}[A-Z]{2,63}$/i;
    var correo= document.querySelector("#mail");
    var alv=correo.value;
    if(!emailRegex.test(alv)){
        swal("introduce un correo válido");
        correo.className= correo.className+" error";
        correo.focus();
        return false;
    }else if(correo.value.length>45){
        swal("Por favor no ingreses más de 45 caracteres en este campo");
        correo.className= correo.className+" error";
        correo.focus();
        return false;
    }
    else correo.className= correo.className.replace(" error", "");
    //Validando Radios
    var opciones= document.getElementsByName("GradoAcademico");
    var resultado=false;
    for (var i = 0; i < elementos.length; i++) {
        if(elementos[i].type === "radio" && elementos[i].name === "GradoAcademico"){
            for (var o = 0; o < opciones.length; o++) {
                if (opciones[o].checked) {
                    resultado=true;
                    break;
		}
            }
            if (!resultado) {
                swal('Por favor seleccione una opción');
		elementos[i].className = elementos[i].className + " error";
		return false;
            } else elementos[i].parentNode.className = elementos[i].parentNode.className.replace(" error", "");
        }
    }//Prompt
    swal({
        title: 'Confirmar cambios',
        input: 'password',
        inputAttributes: {
            autocapitalize: 'off'
        },
        showCancelButton: true,
        confirmButtonText: 'Modificar',
        showLoaderOnConfirm: true,
        allowOutsideClick: () => !swal.isLoading()
      }).then((result) => {
        var m= atob(q);
        if(result.value!== m){
            swal("La contraseña ingresada no coincide");
            return false;
        }else formulario.submit();
    });
}
function ValidarPassword(q){
    var formulario=document.querySelector("#FormCuenta");
    var elementos = formulario.elements;
    //Validando textbox completos
    for (var i = 0; i < elementos.length; i++) {
        if (elementos[i].type === "password") {
            if (elementos[i].value.length == 0) {
		swal('Por favor llene el campo');
		elementos[i].className = elementos[i].className + " error";
                elementos[i].focus();
		return false;
            }else if(elementos[i].value.length>25){
                swal("Por favor no ingreses más de 25 caracteres en este campo");
                elementos[i].className = elementos[i].className + " error";
                elementos[i].focus();
		return false;
            }else if(elementos[i].value.length<6){
                swal("Te recomendamos una contraseña de al menos 6 caracteres");
                elementos[i].className = elementos[i].className + " error";
                elementos[i].focus();
		return false;
            }
            else {
                elementos[i].className = elementos[i].className.replace(" error", "");
            }
        }
    }
    //Validando contraseñas
    var p1= document.querySelector("#pass1"), 
        p2= document.querySelector("#pass2");
    if(p1.value!==p2.value){
        swal("Las contraseñas ingresadas no coinciden");
        p1.focus();
        p2.className= p2.className+" error";
        return false;
    }else{
        p2.className= p2.className.replace(" error","");
    }
    swal({
        title: 'Confirmar cambios',
        input: 'password',
        inputAttributes: {
            autocapitalize: 'off'
        },
        showCancelButton: true,
        confirmButtonText: 'Modificar',
        showLoaderOnConfirm: true,
        allowOutsideClick: () => !swal.isLoading()
      }).then((result) => {
        var m= atob(q);
        if(result.value!== m){
            swal("La contraseña ingresada no coincide");
            return false;
        }else formulario.submit();
    });
}
function ValidarVinculos(){
    var contenido= document.querySelector("#Vin").value,
        patron=/^[A-Za-zÑñáéíóúÁÉÍÓÚ\d]{8}$/i;
    if(!patron.test(contenido)) swal("Código no válido");
    else{
        $.ajax({
            url:"Vincular",
            type:"post",
            data: {codigoP: contenido},
            success: function(retorna){
                if(!retorna.includes("{")) swal(retorna);
                else{
                    var span= document.createElement("span"),
                        input1= document.createElement("input"),
                        input2= document.createElement("input"),
                        br= document.createElement("br"),
                        objeto= JSON.parse(retorna);
                
                    span.setAttribute("id", "xcm3r7"+objeto.idTutor);
                    input1.setAttribute("type", "text");
                    input1.setAttribute("value", objeto.Nombre);
                    input1.setAttribute("readonly", true);
                    input2.setAttribute("type", "text");
                    input2.setAttribute("class", "codel");
                    input2.setAttribute("readonly", true);
                    input2.setAttribute("value",contenido);
                    $("#MisVinculos").append(span);
                    $(span).append(input1);
                    $(span).append(input2);
                    $(span).append(br);
                    swal("Vinculado con éxito :3");
                }
            }
        });
    }
}
function ValidarVinculo(){
    var contenido= document.querySelector("#Ban").value,
        patron=/^[A-Za-zÑñáéíóúÁÉÍÓÚ\d]{8}$/i;
    if(!patron.test(contenido)) swal("Código no válido");
    else{
        $.ajax({
            url:"Desvincular",
            type:"post",
            data: {ByeTutor: contenido},
            success: function(retorna){
                if(isNaN(retorna)) swal(retorna);
                else{
                    $("#xcm3r7"+retorna).remove();
                    swal("Vinculo desactivado correctamente");
                }
            }
        });
    }
}
$(document).ready(function(){
    $("#bye").click(function(){ValidarVinculo();});
    $("#btnVinc").click(function(){ValidarVinculos();});
});
$(document).ajaxComplete(function() {
    $("#bye").click(function(){ValidarVinculo();});
});
function Asignar(){
    var btn= document.querySelector("#Send");
    var ema = document.querySelector("#selectbox");
    var email = ema.options[ema.selectedIndex].value;
    btn.setAttribute("onclick", "EnviarEvidencia('"+email+"')");
}
function EnviarEvidencia(e){
    var email= atob(e);
    var form= document.querySelector("#Enviar");
    form.action="mailto:"+email;
    form.submit();   
}