function AgJefe(num){
    //var reg= /^(?:(?:(?:0?[1-9]|1\d|2[0-8])[/](?:0?[1-9]|1[0-2])|(?:29|30)[/](?:0?[13-9]|1[0-2])|31[/](?:0?[13578]|1[02]))[/](?:0{2,3}[1-9]|0{1,2}[1-9]\d|0?[1-9]\d{2}|[1-9]\d{3})|29[/]0?2[/](?:\d{1,2}(?:0[48]|[2468][048]|[13579][26])|(?:0?[48]|[13579][26]|[2468][048])00))$/;
    $(document).ready(function(){
        var Jefe= document.querySelector("#Jefe").value,
            fin= document.querySelector("#Fin"),
            img= document.querySelector("#imgJefeS");
        if(Jefe.length>25){
            swal("El nombre del jefe a derrotar, puede tener una longitud máxima de 25 caracteres");
            return false;
        }else if(Jefe.length<3){
            swal("El nombre del jefe a derrotar, debe tener al menos 3 caracteres");
            return false;
        }else if(fin.value.length>10){
            swal("Ingresa tu fecha en el formato dd/mm/aaaa");
            return false;
        }else if($(img).length == 0) {
            swal("Seleccione la imagen del jefe que quiera derrotar");
            return false;
        }else if(fin.value==null){
            swal("Por favor inserta cuando estimas acabar con el jefe");
            return false;
        }else if(!validaFecha(fin.value)){
            swal("Ingresa una fecha adecuada, los jefes pueden durar hasta el siguiente año");
            return false;
        }else if(!ValidarFechaMayor(fin.value)){
            swal("esa fecha ya pasó");
            return false;
        }else if((img.value-1)>verificarXP(num)){
            var xpnece= obtenerxpNecesario(img.value);
            swal("Jefe Bloqueado, necesitas "+xpnece+" xp");
            return false;
        }else{
            console.log("llegué")
            $.ajax({
                url:"CrearJefe",
                type:"post",
                data: {jefe: Jefe, fin: fin.value , img_jefe: img.value },
                success: function(){
                    alert("creado");
                }
            });
        }
    });
}
function VisitarJefe(m){
    $(document).ready(function(){
        $('body').on('click', '.VJ', function(e){
            var input = document.createElement("input"),
            form= document.querySelector("#FormVis");
            input.setAttribute("type","hidden");
            input.setAttribute("value",m);
            input.setAttribute("name","idJefe");
            form.appendChild(input);

            form.action="Misiones.jsp";
            form.submit();
        });
    });
}
function ValidarMision(m){
    $(document).ready(function(){
        var form = document.querySelector("#AgMision"),
            as= document.getElementsByName("Mision"),
            bs=document.getElementsByName("Aprox"),
            input= document.createElement("input"),
            mision= document.querySelector("#Mision"),
            aprox= document.querySelector("#Aprox");
        if($(as).length == 0 || $(form).length==0 || $(bs).length==0) {
            swal("No cambies los nombres :(");
            location.href="Denegar.jsp";
            return false;
        }else{
            if(mision.value.length>90){
                swal("La misión a cumplir puede tener hasta 90 caracteres");
                mision.focus();
                return false;
            }else if(mision.value.length<10){
                swal("La misión a cumplir debe tener por lo menos 10 caracteres");
                mision.focus();
                return false;
            }else if(aprox.value==null){
                swal("Por favor inserta cuando estimas acabar la misión");
                return false;
            }else if(aprox.value.length<8||aprox.value.length>10){
                swal("Por favor inserta cuando estimas acabar la misión");
                return false;
            }else if(!validaFecha(aprox.value)){
                swal("Ingresa una fecha adecuada, los jefes pueden durar hasta el siguiente año");
                return false;
            }else if(!ValidarFechaMayor(aprox.value)){
                swal("esa fecha ya pasó");
                return false;
            }else{
                input.setAttribute("type", "hidden");
                input.setAttribute("name", "idJefe");
                input.setAttribute("value", m);
                form.appendChild(input);
                form.action="AgregarMision";
                form.submit();
            }
        }
    });
}
function FinalizarMision(m){
    $(document).ready(function(){
        $('body').on('click', '.IrMision', function(e){
            var conf= confirm("¿Quiere finalizar esta misión?");
            if(conf){
                var input = document.createElement("input"),
                    form= document.querySelector("#ActMis");

                input.setAttribute("type","hidden");
                input.setAttribute("value",m);
                input.setAttribute("name","idMision");
                form.appendChild(input);

                form.action="DesactivarMision";
                form.submit();
            }else{
                return false;
            }
        });
    });
}
function AgImg(m){    
    swal({
        title: '¿Desea escoger este jefe?',
        text: "Se establecerá como el jefe a vencer",
        type: 'question',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: '¡Sí!'
    }).then((result) => {
        if (result.value) {
            var input = document.createElement("input"),
                form= document.querySelector("#FormAJ"),
                input3=document.querySelector("#imgJefeS");

            if($(input3).length == 0) {
                input.setAttribute("type","hidden");
                input.setAttribute("value",m);
                input.setAttribute("name","ImgJefe");
                input.setAttribute("id","imgJefeS");
                form.appendChild(input);
            }else{
                form.removeChild(form.lastChild);
                input.setAttribute("type","hidden");
                input.setAttribute("value",m);
                input.setAttribute("name","ImgJefe");
                input.setAttribute("id","imgJefeS");
                form.appendChild(input);
            }
        }
    });
}
function VencerJefe(m){
    var form = document.querySelector("#ActMis"),
    input= document.createElement("input");
    input.setAttribute("type","hidden");
    input.setAttribute("name","idJefe");
    input.setAttribute("value", m);
    form.appendChild(input);
    form.action="VencerJefe";
    form.submit();
}
function validaFecha(fecha){
        var hoy = new Date(); //fecha actual
        var fec= fecha.split("-");
        fecha= fec[2]+"-"+fec[1]+"-"+fec[0];
	var dtCh= "-";
	var minYear=hoy.getFullYear();
	var maxYear=hoy.getFullYear()+1;
	function isInteger(s){
		var i;
		for (i = 0; i < s.length; i++){
			var c = s.charAt(i);
			if (((c < "0") || (c > "9"))) return false;
		}
		return true;
	}
	function stripCharsInBag(s, bag){
		var i;
		var returnString = "";
		for (i = 0; i < s.length; i++){
			var c = s.charAt(i);
			if (bag.indexOf(c) == -1) returnString += c;
		}
		return returnString;
	}
	function daysInFebruary (year){
		return (((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 );
	}
	function DaysArray(n) {
		for (var i = 1; i <= n; i++) {
			this[i] = 31;
			if (i==4 || i==6 || i==9 || i==11) {this[i] = 30;}
			if (i==2) {this[i] = 29;}
		}
		return this
	}
	function isDate(dtStr){
		var daysInMonth = DaysArray(12);
		var pos1=dtStr.indexOf(dtCh);
		var pos2=dtStr.indexOf(dtCh,pos1+1);
		var strDay=dtStr.substring(0,pos1);
		var strMonth=dtStr.substring(pos1+1,pos2);
		var strYear=dtStr.substring(pos2+1),
		strYr=strYear;
		if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1)
		if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1)
		for (var i = 1; i <= 3; i++) {
			if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
		}
		var month=parseInt(strMonth),
		day=parseInt(strDay),
		year=parseInt(strYr);
		if (pos1==-1 || pos2==-1){
			return false;
		}
		if (strMonth.length<1 || month<1 || month>12){
			return false;
		}
		if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]){
			return false;
		}
		if (strYear.length != 4 || year==0 || year<minYear || year>maxYear){
			return false;
		}
		if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false){
			return false;
		}
		return true
	}
	if(isDate(fecha)){
		return true;
	}else{
		return false;
	}
}

function ValidarFechaMayor(fecha){
    
    var hoy = new Date(); //fecha actual
    var fechaFormulario = new Date(fecha); //fecha ingresada

    hoy.setHours(0,0,0,0);  // Seteamos a las 00:00 horas
    fechaFormulario.setHours(0,0,0,0);  // Seteamos a las 00:00 horas

    if (hoy <= fechaFormulario) return true;
    else if (hoy === fechaFormulario) return true;
    else return false;
}
function verificarXP(num){
    var num2=0;
    if(num<50){
        num2= 0;
    }else if(num>=50 && num<150){
        num2=1;
    }else if(num>=250 && num <750){
        num2=2;
    }else if(num>=750 && num<1550){
        num2=3;
    }else if(num>=1550 && num<2850){
        num2=4;
    }else if(num>=2850 && num<4050){
        num2=5;
    }else if(num>=4050 && num<15000){
        num2=6;
    }else if(num>=15000){
        num2=7;
    }
    return num2;
}
function obtenerxpNecesario(num){
    var num2=0;
    if(num==1) num2=0;
    else if(num==2) num2=50;
    else if(num==3) num2=250;
    else if(num==4) num2=750;
    else if(num==5) num2=1550;
    else if(num==6) num2=2850;
    else if(num==7) num2=4050;
    else if(num==8) num2=15000;
    return num2;
}