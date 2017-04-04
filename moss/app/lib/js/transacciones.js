/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function factura_validar_servicio(check) {
    if (check.checked){
        servicio = 'true';
    }else{
        servicio = 'false';
    }
    peticion_ajax('?opcion=facturar&a=factura_mostrar_totales&servicio=' + servicio + '&type=ajax', '', 'factura_resumen_totales', null, null, null);
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

function cajaAbrir(){
    base = $('#base_nueva').val();
    peticion_ajax('?opcion=caja_balance&a=abrir_caja&base='+base+'&type=ajax', '', 'area_trabajo', null, null, null);
}
function cajaCerrar(){
    peticion_ajax('?opcion=caja_balance&a=cerrar_caja&type=ajax', '', 'area_trabajo', null, null, null);
}