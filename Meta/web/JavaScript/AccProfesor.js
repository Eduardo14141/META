$(document).ready(function(){
    $('body').on('click', '.MiAlumno', function(){
        swal({
            title: 'Visitar estudiante',
            text: "¿Quiere visitar al alumno "+this.value+"?",
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Visitar'
        }).then((result) => {
            if (result.value) {
                var idEst= $(this).attr("id");
                idEst= idEst.replace("df3rgo", "");
                var input = document.createElement("input");
                var form= document.querySelector("#VerAl");
                input.setAttribute("type","hidden");
                input.setAttribute("value",idEst);
                input.setAttribute("name","idEstudiante");
                form.appendChild(input);
                form.submit();
            }
        });
    });
});
$(document).ready(function(){
    $('body').on('click', '#Coment', function(e){
        var idTarea= $("#Coment").attr("name").replace("eks2t",""),
            Comentario= document.querySelector("#txtarea").value;
        if(Comentario.length<4) swal("Por favor envíe un comentario de al menos 4 caracteres");
        else if(Comentario.length>250) swal("El comentario puede tener hasta 250 caracteres");
        else{
            $.ajax({
                url:"Comentar",
                type:"post",
                data: {idTarea: idTarea, Comentario: Comentario},
                success: function(retorna){
                    if(retorna.includes("enviado"))
                        swal({
                            type: 'success',
                            text: retorna,
                        });
                    else swal(retorna);
                }
            });
        }
    });
});
$(document).ready(function(){
    $('body').on('click', '.Tarea', function(e){
        var idTarea= $(this).attr("id").replace("mj23sd4","");
        var form= document.querySelector("#FormComentar");
        var input = document.querySelector("#Coment");
        form.style.display="block";
        input.name="eks2t"+idTarea;
    });
});