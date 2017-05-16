var seleccionado = 0;
/*modificacion jhe*/
function abrir_ventana($id){  
    $('#ventana_detalles').fadeIn(800); 
    peticion_ajax('?opcion=productos&a=ver_mas&id='+$id,'','ventana_detalles');
}
function cerrar_detalles(){
    $('#ventana_detalles').fadeOut(800); 
}
function seleccion_producto(elemento){
   // $(".producto").click(function(mievento){
   // mievento.preventDefault();
    //alert("Has hecho clicnComo he hecho preventDefault, no te llevaré al href");
    //}); 
  
    var valor = $('#seleccion_'+elemento.id).val();
   
    if(seleccionado !== 0 ){
        $('#seleccion_'+seleccionado).val('0');
        $('#overlay_'+seleccionado).removeClass('producto_seleccionado');
    }
    if(seleccionado === elemento.id){
        seleccionado = 0;
        return;
    }
    if(valor === '0'){
       valor = '1'; 
       $('#overlay_'+elemento.id).addClass('producto_seleccionado');
    }else{
        valor = '0';
        $('#overlay_'+elemento.id).removeClass('producto_seleccionado');
    }
    $('#seleccion_'+elemento.id).val(valor);
    seleccionado = elemento.id;
}
 
function validar_herramienta(herramienta){
    if(herramienta > 1 && seleccionado === 0){
        alert('seleccione algo');
        return;
    }
    if(herramienta == 2){
      window.location = '?opcion=productos&a=formulario_edicion&id='+seleccionado.substring(9);
    }
    if(herramienta == 1){
        window.location = '?opcion=productos&a=formulario_edicion';
    }
    if(herramienta == 3){
      window.location = '?opcion=productos&a=eliminar_producto&id='+seleccionado.substring(9);
    }
} 

/* cambio de imagen herramientas*/
function cambiar_imagen(id, seccion, over){
    if(over === 1){
        $("#"+id).attr("src",'vista/img/producto/'+seccion+'/over/'+id+'.png');
    }else{
        $("#"+id).attr("src",'vista/img/producto/'+seccion+'/'+id+'.png');
    }
}
