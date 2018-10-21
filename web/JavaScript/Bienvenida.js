var document;
var enviando=0;
function Validar(){
    var formulario=document.querySelector("#FormRegistro");
    var elementos = formulario.elements;
    var patron = /^([A-Za-zÑñáéíóúÁÉÍÓÚ ]+)$/;
    //Validando textbox completos
    for (var i = 0; i < elementos.length; i++) {
        if ((elementos[i].type === "text" || elementos[i].type === "password")&&i!=2) {
            if (elementos[i].value.length == 0) {
		swal('Por favor llene el campo');
		elementos[i].className = elementos[i].className + " error";
                elementos[i].focus();
		return false;
            }else if(elementos[i].value.length>25 &&(i==1||i==2||i==0||i==11)){
                //Validando campos nombre, appat, apmat y contraseña;
                swal("No ingreses más de 25 carácteres en este campo");
                elementos[i].className = elementos[i].className + " error";
                elementos[i].focus();
                return false;
            }else if((!patron.test([elementos[i].value])) &&(i==1||i==2||i==0)){
                swal("Por favor sólo ingrese letras en este campo");
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
    var p1= document.querySelector("#pass"), 
        p2= document.querySelector("#pass2");
    if(p1.value!==p2.value){
        swal("Las contraseñas ingresadas no coinciden");
        p1.focus();
        p2.className= p2.className+" error";
        return false;
    }else if(p1.value.length<6){
        swal("Ingrese una contraseña de mínimo 6 caracteres");
    }
    else{
        p2.className= p2.className.replace(" error","");
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
    }
    //Validando Radios
    var opciones = document.getElementsByName('Sexo'),
    resultado = false;

    for (var i = 0; i < elementos.length; i++) {
        if(elementos[i].type === "radio" && elementos[i].name == "Sexo"){
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
            } else {
                elementos[i].parentNode.className = elementos[i].parentNode.className.replace(" error", "");
            }
        }
    }
    opciones= document.getElementsByName("GradoAcademico");
    resultado=false;
    for (var i = 0; i < elementos.length; i++) {
        if(elementos[i].type === "radio" && elementos[i].name == "GradoAcademico"){
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
            } else {
                elementos[i].parentNode.className = elementos[i].parentNode.className.replace(" error", "");
            }
        }
    }
    opciones= document.getElementsByName("Tipo");
    resultado=false;
    for (var i = 0; i < elementos.length; i++) {
        if(elementos[i].type === "radio" && elementos[i].name == "Tipo"){
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
            } else {
                elementos[i].parentNode.className = elementos[i].parentNode.className.replace(" error", "");
            }
        }
    }
    var correo= document.querySelector("#mail");
    if(correo.value.length>45){
        swal("No introduzca un correo tan largo, el máximo es de 45 caracteres");
        correo.className += " error";
        correo.focus();
        return false;
    }
    else{
        correo.className= correo.className.replace(" error", "");
    }
    if(enviando===0) formulario.submit();
    else swal("Ya se ha registrado");
    enviando++;
}
