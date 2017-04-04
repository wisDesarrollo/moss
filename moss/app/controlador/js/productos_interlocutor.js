function validar_formulario() {  
    var contador = 0;
    $("input:checked").each(function() {
        contador = contador + 1;
    });

    if(contador == 0){
        mostrar_alerta('html',"Debe seleccionar por lo menos un producto");
    }else{
        enviar_formulario('formulario_productos');  
    }
    
}