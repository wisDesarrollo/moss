/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function facturaClickServicioCheck(checkid, $subtotal){
    var servicio_defecto = $subtotal * 0.1;
    if ($("#"+checkid).prop('checked') === true) {
        $('#factura_servicio').val(servicio_defecto);
    }
    factura_validar_servicio(checkid);
}
function factura_validar_servicio(checkid) {
    var valor_servicio = $('#factura_servicio').val();
    var descuento = $('#factura_descuento').val();
    
    if ($("#"+checkid).prop('checked') === true) {
        
        valor_servicio = $('#factura_servicio').val();
        servicio = 'true';
        //$("#factura_servicio").prop('disabled', false);
    } else {
        valor_servicio = 0;
        servicio = 'false';
        //$("#factura_servicio").prop('disabled', true);
    }
    peticion_ajax('?opcion=facturar&a=factura_mostrar_totales&valor_servicio='+valor_servicio+'&servicio=' + servicio + '&id_descuento='+descuento+'&type=ajax', '', 'factura_resumen_totales', null, null, null);
}
/*
 * 
 * if(check.checked){
 subtotal = $('#factura_subtotal').val();
 subtotal_servicio = parseInt(subtotal)*0.1;
 $('#factura_servicio').html("$"+subtotal_servicio);
 total = parseInt(subtotal)*1.1;
 $('#factura_total').html("$"+total);
 }else{
 subtotal = $('#factura_subtotal').val();
 $('#factura_servicio').html("$0");
 $('#factura_total').html("$"+subtotal);
 }
 * 
 */

function cajaAbrir() {
    base = $('#base_nueva').val();
    peticion_ajax('?opcion=caja_balance&a=abrir_caja&base=' + base + '&type=ajax', '', 'area_trabajo', null, null, null);
}
function cajaCerrar() {
    
    efectivo = $('#efectivo_cierre').val();
    $('#form_caja_actualizar').removeClass('hidden');
    $('#form_nueva_caja').addClass('hidden');
    peticion_ajax('?opcion=caja_balance&a=cerrar_caja&efectivo_cierre='+efectivo+'&type=ajax_part', '', 'area_trabajo', 'cierre_complemento', null, null);
}
function cierre_complemento(response){
    $('#id_caja').val(response);
}
function actualizarCaja() {
    efectivo = $('#efectivo_cierre').val();
    caja = $('#id_caja').val();
    peticion_ajax('?opcion=caja_balance&a=actualizar_caja&efectivo_cierre='+efectivo+'&id_caja='+caja+'&type=ajax', '', 'area_trabajo', null, null, null);
}
function facturaGenerarFactura(form) {
	//window.location='?opcion=subopcion&id=17&type=html';
    //window.open('?opcion=facturar&a=imprimir');
}
/*$("#pedido_producto_form").submit(function (e) {
        var formObj = $(this);
        var formURL = formObj.attr("action");
        var formData = new FormData(this);
        alert('aasdas');
        $.ajax({
            url: formURL,
            type: 'POST',
            data: formData,
            mimeType: "multipart/form-data",
            contentType: false,
            cache: false,
            processData: false,
            success: function (data, textStatus, jqXHR) {
                //window.open('?opcion=factura&a=imprimir');
            },
            error: function (jqXHR, textStatus, errorThrown) {
            }
        });
        e.preventDefault(); //Prevent Default action. 
        e.unbind();
        //window.open('?opcion=factura&a=imprimir');
    });*/

function format_money(elemento){
	var nStr = $("#"+elemento.id).val();
        nStr += '';
	x = nStr.split('.');
	x1 = x[0];
	x2 = x.length > 1 ? '.' + x[1] : '';
	var rgx = /(\d+)(\d{3})/;
	while (rgx.test(x1)) {
		x1 = x1.replace(rgx, '$1' + ',' + '$2');
	}
        $("#"+elemento.id).val(x1 + x2)
}

function productoBusqueda(elemento, modulo){
    peticion_ajax('?opcion='+modulo+'&a=buscar_producto&valor='+elemento.value+'&type=ajax_part', '', 'factura_resumen_totales', null, null, null);
}