$(document).ready(function(){
    $("#loginform").change(function(){
        var Formlen = document.querySelector('#loginform');
        for(var i=0;i<Formlen.elements.length;i++){
            var FormC = Formlen.elements[i];
            if(FormC.type==="text" || FormC.type==="password"){
                if(FormC.value.length>0) FormC.parentElement.children[1].className="active";
                else FormC.parentElement.children[1].className="label";
            }
        }
    });
    $("#FormRegistro").change(function(){
        var Formlen = document.querySelector('#FormRegistro');
        for(var i=0;i<Formlen.elements.length;i++){
            var FormC = Formlen.elements[i];
            if(FormC.type==="text" || FormC.type==="password"){
                if(FormC.value.length>0) FormC.parentElement.children[1].className="active";
                else FormC.parentElement.children[1].className="label";
            }
        }
    });
});
//FormC.parentElement.children[0].className="Iactive";
//Los deja azules si están completos
//FormC.parentElement.children[1].className= FormC.parentElement.children[1].className.replace(" error","");