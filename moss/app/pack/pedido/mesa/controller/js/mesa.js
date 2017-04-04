
function facturar_accion(id, estado, modulo){
    peticion_ajax('?opcion='+modulo+'&a=traer_pedido&type=ajax_part&id=' + id, '', 'subarea_trabajo');
    //peticion_ajax('?opcion='+modulo+'&a=estado_menu&type=ajax&id=' + id + '&estado=' + estado, '', 'area_trabajo');
    clearTimeout(t);
}
function liberar(id) {
    var a=peticion_ajax("?opcion=pedido_recoleccion&a=traer_pedido&type=ajax&return=1&id="+id,'','area_trabajo');
}
function reservar(id) {
    peticion_ajax('?opcion=pedido_recoleccion&a=cambiar_estado&type=ajax&id=' + id + '&op=' + 2, '', 'area_trabajo');
}
function ver_pedido(id) {
    $('#ver-pedido-container').show("slow");
    peticion_ajax('?opcion=pedido_recoleccion&a=traer_pedido&type=ajax_part&id=' + id, '', 'ver-pedido-container');
}
function mostrar_preview($id, $nombre, $descripcion, imagen) {
    $('.producto_view').show("slow");
    $('#encabezado_producto-preview').show("slow");
    $('#img_producto').show("slow");
    $('#producto_descripcion').show("slow");
    $('.preview_productos').show("slow");

    document.getElementById("encabezado_producto-preview").innerHTML = $nombre;
    document.getElementById("producto_descripcion").innerHTML = $descripcion;
    $('#img_producto').attr('src','app/vista/img/producto/big/'+imagen);
}
function ocultar_preview() {
    $('.producto_view').hide("slow");
    $('#encabezado_producto-preview').hide("slow");
    $('#img_producto').hide("slow");
    $('#producto_descripcion').hide("slow");
    $('#preview_productos').hide("slow");
}
function ocultarPedido() {
    $('#pedido-lista-oculto').hide("slow");
    $('.mostrar-pedido').show("slow");
}
function mostrarPedido() {
    $('#pedido-lista-oculto').show("slow");
    $('.ocultar-pedido').show("slow");
    $('.mostrar-pedido').hide("slow");

}
function addProduct(id, nombre_corto, precio) {
    var contenedor = document.getElementById('pedido-productos-lista');
    var sw_exist = document.getElementById(id + '_producto');
    var total = document.getElementById('numerico_total_pedido');
    var producto = '';
    var cant = 1;
    /*if (sw_exist === null) {
        producto = '<div id="' + id + '_producto" class="pedido-fila">';
        contenedor.innerHTML = contenedor.innerHTML + producto;
        total.innerHTML = parseInt(total.innerHTML) + precio;
        peticion_ajax('?opcion=pedido_recoleccion&a=pintar_fila&id=' + id + '&nombre_corto=' + nombre_corto + '&cant=' + cant + '&precio=' + precio, '', id + '_producto');
    } else {
        var producto_cantidad = document.getElementById(id + '_producto_cantidad');        
        var producto_cantidad_hide = document.getElementById(id + '_producto_cantidad_hide');        
        producto_cantidad.value = parseInt(producto_cantidad.value) + 1;
        producto_cantidad_hide.value = parseInt(producto_cantidad_hide.value) + 1;
        total.innerHTML = parseInt(total.innerHTML) + precio;
    }
    */
    if (sw_exist === null){     
        producto='<div id="' + id + '_producto" class="pedido-fila">';              
        contenedor.innerHTML = contenedor.innerHTML + producto;
        total.innerHTML= parseInt(total.innerHTML)+precio;
        peticion_ajax('?opcion=pedido_recoleccion&a=pintar_fila&type=ajax_part&id='+id+'&nombre_corto='+nombre_corto+'&cant='+cant+'&precio='+precio,'',id+'_producto');
    }else{
        var producto_cantidad ='';
        var producto_cantidad = document.getElementById(id + '_producto_cantidad');
        var producto_cantidad_hide = document.getElementById(id + '_producto_cantidad_hide');
        producto_cantidad.innerHTML= parseInt(producto_cantidad.innerHTML)+1;
        producto_cantidad_hide.value= parseInt(producto_cantidad_hide.value)+1;
        total.innerHTML= parseInt(total.innerHTML)+precio;
    }
}
function restarProducto(id, precio, contenedor, seccion) {
    var total = document.getElementById(contenedor);
    var producto_cantidad = '';
    producto_cantidad = document.getElementById(id + '_' + seccion + '_cantidad');
    var producto_cantidad_hide = document.getElementById(id + '_' + seccion + '_cantidad' + '_hide');
    if (producto_cantidad.innerHTML == 1) {
        var div = document.getElementById(id + '_' + seccion);
        div.parentNode.removeChild(div);
        total.innerHTML = 0;
    } else {
        total.innerHTML = parseInt(total.innerHTML) - (precio);
        producto_cantidad.value = parseInt(producto_cantidad.value) - 1;
        producto_cantidad_hide.value = parseInt(producto_cantidad_hide.value) - 1;
        if( producto_cantidad.value == 0){
            removeProducto(id, precio, contenedor);
        }
    }
}
function facturar(id, mesa) {    
    peticion_ajax('?opcion=facturar&a=facturar&type=ajax&id_cuenta=' + id + '&id_mesa=' + mesa, '', 'subarea_trabajo');
}
function corregirPedido() {
    var sub = document.getElementById('pedido_producto_form').submit();
}
function removePedido(id, precio) {
    var total = document.getElementById("numerico-total-ver-pedido");
    var cantidad = document.getElementById(id + '_pedido_cantidad').innerHTML;//inner me trae el dato que hay en el div
    var div = document.getElementById(id + "_pedido");
    total.innerHTML = parseInt(total.innerHTML) - (precio * parseInt(cantidad));
    div.parentNode.removeChild(div);
}
function removeProducto(id, precio, contenedor) {
    var total = document.getElementById(contenedor);
    var cantidad = document.getElementById(id + '_producto_cantidad').innerHTML;//inner me trae el dato que hay en el div
    var div = document.getElementById(id + "_producto");
    total.innerHTML = parseInt(total.innerHTML) - (precio * parseInt(cantidad));
    div.parentNode.removeChild(div);
}
function volver_mesasV(modulo){
	area = 'area_trabajo';
	if(modulo === 'facturar'){
		area = 'subarea_trabajo';
	}
    peticion_ajax('?opcion='+modulo+'&a=home&type=ajax', '', area);
    /*TODO: Evaluar para que es este temporizador y habilitarlo 28/04/2016*/
    /*NOTA: Probablemente es para que no se quede la interface en un pedido especifico, 
	 * sino que regrese al listado de mesas en caso de inactividad. */
	t = setTimeout(function () {
        traer_subopcion(modulo);
    }, 3000);

}

function confirmarPedido() {
    var sub = document.getElementById('form_pedido').submit();
}
function deshacer_pedido(contenedor) {
    var total = document.getElementById(contenedor);
    var a = document.getElementById('pedido-productos-lista');
    while (a.hasChildNodes())
        a.removeChild(a.firstChild);
    total.innerHTML = parseInt(total.innerHTML) * 0;

}
function ocultar_pedido() {
    $('#ver-pedido-container').hide("slow");
}
function crear_factura(mesa, transaccion, $total) {
    var body = [['Descripcion', 'Cantidad', 'Unidad']];
    var acum = [];
    for (var i = 1; i <= items.length; i++) {
        acum.push(items[i - 1]);
        if (i != 1 && i % 3 === 0) {
            body.push(acum);
            acum = [];
        }
    }
    var totalarray = ['', 'TOTAL:', " " + $total];
    body.push(totalarray);
    var docDefinition = {
        content: [
            'Fecha: \nFACTURA No-' + transaccion +
                    '\n ------------------------------------------------------------' +
                    '\nNegocio:' + datos_negocio[0] +
                    '\nnit:' + datos_negocio[1] +
                    '\nReg. simplificado del impuesto al consumo' +
                    '\nRes. 110000611713 2015/01/14' +
                    '\nDireccion:' + datos_negocio[2] + '-Tel:' + datos_negocio[3] +
                    '\nMesa:' + mesa,
            {
                table: {
                    headerRows: 1,
                    widths: ['auto', 50, 50, 50],
                    body: body
                }

            },
            '-------------GRACIAS POR SU COMPRA--------------' +
                    '\n------------ADVERTENCIA DE PROPINA--------------' +
                    '\nEstablecimiento de comercio sugiere una propina' +
                    '\ncorrespondiente al 10% del valor de la cuenta,' +
                    '\nel cual podra ser aceptado, rechazado o modificado' +
                    '\npor ud, de acuerdo con su valoracion del servicio' +
                    '\nprestado.' +
                    '\nAl momento de solicitar la cuenta, indiquele a la' +
                    '\npersona que lo atiende si quiere que dicho valor' +
                    '\nsea o no incluido en la factura.' +
                    '\nEn caso de algun inconveniente con el cobro de la' +
                    '\npropina, comuniquese con la super intendencia de ' +
                    '\nindustria y comercio' +
                    '\nlinea gratuita nacional 018000910165.'
        ]
    };
    pdfMake.createPdf(docDefinition).download('factura.pdf');
    pdfMake.createPdf(docDefinition).print();
}
function adicionar_hide(value,id){    
    var id=id.split("_",1);
    var producto_cantidad_hide = document.getElementById(id +'_producto_cantidad_hide');
    producto_cantidad_hide.value = value;
}



//pdfMake.createPdf(docDefinition).open();