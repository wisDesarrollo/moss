var id_anterior = 0;
var monto_activo = 0;

function inicializar(iniciar) {	
	$("#valor" ).change(function() {
  		formatear_numero('valor');	
	});
	
	$("#boton_enviar_formulario_venta").click(function() {
		if(validar_formulario()){
			var proveedor = $("#nombre_proveedor").val(); 
			var valor = $('#valor').val();
		 	enviar_formulario('formulario_venta');
                        cambiar_producto(1, 1);
 	  	}
	});
}

function cambiar_producto(id,categoria){
	if(categoria == 2){
	}
        var idd = $('#producto_seleccionado').val();
        $('#producto_'+idd).removeClass('elemento_activo');
        $('#producto_seleccionado').val(id);
        $('#producto_'+id).addClass('elemento_activo');
	peticion_ajax('?opcion=ventas&a=formulario_'+categoria,'','',pintar_formulario,id);
}


function pintar_formulario(contenido,id){
	$("#contenido_formulario").html(contenido);

	//if(id_anterior != 0){
	//$("#elemento_"+id_anterior).css("font-weight","normal");    	
	//}
	//$("#elemento_"+id).css("font-weight","bold");    	
	$("#producto").val(id); 

	id_anterior = id;

}

function cambiar_valor(monto){
	$("#valor").val(monto);
	formatear_numero('valor');	
}

function validarStock(id){
    cantidad = $('#'+id+'_add_cant').val();
    peticion_ajax('?opcion=ventas&a=validar_stock&type=ajax_part&id='+id+'&cantidad='+cantidad,'','',respuesta_validacion);
}
function respuesta_validacion(msj){
    if(msj !== 'OK'){
        alert(msj);
    }
}