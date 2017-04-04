/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var wf_subtotal = 0;
var wf_total = 0;
var wf_impuestos = 0;
var wf_servicio = 0;
var wf_factura_items;
function facturaPedidoPonerItem(modulo, contenedor, id_producto) {
	if ($('#tm_item_cantidad_' + id_producto).length) {
		cantidad = $('#tm_item_cantidad_' + id_producto).val();
		nueva_cantidad = parseInt(cantidad) + 1;
		$('#tm_item_cantidad_' + id_producto).val(nueva_cantidad);
		$('#tm_item_cantidad_view_' + id_producto).html(nueva_cantidad);

		precio = $('#tm_item_vu_' + id_producto).val();

		subtotal = (parseInt(precio) * parseInt(nueva_cantidad));
		//subtotal = numberFormat(subtotal, 3);
		$('#wis_factura_subtotal_' + id_producto).html('$' + numFormat(subtotal));
		wf_subtotal = parseInt(precio) + parseInt(wf_subtotal);
		calcularFacturaResumen(id_producto);
	} else {
		peticion_ajax('?opcion=' + modulo + '&a=pintarPedidoItem&id_producto=' + id_producto + '&type=ajax_part', '', '', 'contenedorAddItem', {contenedor: contenedor, id: id_producto});
	}
}
function facturaPedidoRestarItem(modulo, contenedor, id_producto) {
	if ($('#tm_item_cantidad_' + id_producto).length) {
		cantidad = $('#tm_item_cantidad_' + id_producto).val();
		if(cantidad > 1){
			nueva_cantidad = parseInt(cantidad) - 1;
			$('#tm_item_cantidad_' + id_producto).val(nueva_cantidad);
			$('#tm_item_cantidad_view_' + id_producto).html(nueva_cantidad);

			precio = $('#tm_item_vu_' + id_producto).val();

			subtotal = (parseInt(precio) * parseInt(nueva_cantidad));
			//subtotal = numberFormat(subtotal, 3);
			$('#wis_factura_subtotal_' + id_producto).html('$' + numFormat(subtotal));
			wf_subtotal = parseInt(wf_subtotal) - parseInt(precio);
			calcularFacturaResumen(id_producto);
		}else{
			wf_subtotal = parseInt(wf_subtotal) - parseInt(precio);
			calcularFacturaResumen(id_producto);
			facturaRemoverItem(id_producto);
		}
	} else {
		peticion_ajax('?opcion=' + modulo + '&a=pintarPedidoItem&id_producto=' + id_producto + '&type=ajax_part', '', '', 'contenedorAddItem', {contenedor: contenedor, id: id_producto});
	}
}
function contenedorAddItem(response, parametros) {
	$('#' + parametros.contenedor).append(response);
	precio = $('#tm_item_vu_' + parametros.id).val();
	cantidad = $('#tm_item_cantidad_' + parametros.id).val();
	subtotal = (parseInt(precio) * parseInt(cantidad));
	wf_subtotal = parseInt(precio) + parseInt(wf_subtotal);
	//wf_impuestos = parseInt(precio*impuesto) + parseInt(wf_impuestos);
	calcularFacturaResumen();
}
function numberFormat(n, x) {
	var re = '\\d(?=(\\d{' + (x || 3) + '})+' + (n > 0 ? '\\.' : '$') + ')';
	return this.toFixed(Math.max(0, ~~n)).replace(new RegExp(re, 'g'), '$&,');
}

function calcularFacturaResumen() {
	$('#wf_subtotal').html(numFormat(wf_subtotal));
	$('#wf_subtotal_dato').val(wf_subtotal);
	$('#wf_impuestos').html(numFormat(wf_impuestos));
	$('#wf_impuestos_dato').val(wf_impuestos);
	wf_servicio = parseInt(wf_subtotal) * 0.1;
	$('#wf_servicio').html(numFormat(wf_servicio));
	$('#wf_servicio_dato').val(wf_servicio);	

	wf_total = parseInt(wf_subtotal) + parseInt(wf_impuestos) + parseInt(wf_servicio);
	$('#wf_total').html(numFormat(wf_total));
	$('#wf_wf_total_dato').val(wf_total);	
}
function facturaItemSelected(element, id){
	if ($(element).hasClass('selected')){
		$(element).removeClass('selected');
		$('#tm_item_select_'+id).val(0);
	} else {
		$("." + element.class).removeClass('selected');
		$(element).addClass('selected');
		$('#tm_item_select_'+id).val(1);
	}
}

function numFormat(num, simbol) {
		separador= ","; // separador para los miles
		sepDecimal= '.';
		simbol = simbol ||'';
		num += '';
		var splitStr = num.split('.');
		var splitLeft = splitStr[0];
		var splitRight = splitStr.length > 1 ? sepDecimal + splitStr[1] : '';
		var regx = /(\d+)(\d{3})/;
		while (regx.test(splitLeft)) {
			splitLeft = splitLeft.replace(regx, '$1' + separador + '$2');
		}
		return simbol + splitLeft + splitRight;
}

function facturaLimpiar(id){
	$( ".selected" ).remove();
}
function facturaRemoverItem(id){
	$("#factura_item_"+id).remove();
}

function factureItemDecrement(id){
	cantidad = $('#tm_item_cantidad_' + id).val();
	if(cantidad > 0){
		cantidad = (parseInt(cantidad) - parseInt(1));
	}
	$('#tm_item_cantidad_view_'+id).html(cantidad);
	$('#tm_item_cantidad_' + id).val(cantidad);
}

function factureItemIncrement(id){
	cantidad = $('#tm_item_cantidad_' + id).val();
	cantidad = (parseInt(cantidad) + parseInt(1));
	$('#tm_item_cantidad_view_'+id).html(cantidad);
	$('#tm_item_cantidad_' + id).val(cantidad);
}

function facturaIncluirServicio(input){
	if(document.getElementById(input).checked){
		$subtotal = $('#wf_subtotal_dato').val();
		$servicio = parseInt($subtotal) * 0.1;
		$('#wf_servicio').html(numFormat($servicio));
		$('#wf_servicio_dato').val($servicio);
	}else{
		$('#wf_servicio_dato').val($servicio);
		$('#wf_servicio').html('0');
	}
}
function pedido_recoleccion_accion(id, estado,modulo) {
    peticion_ajax('?opcion='+modulo+'&a=mostrar_menu&type=ajax&id=' + id, '', 'area_trabajo');
    //peticion_ajax('?opcion='+modulo+'&a=estado_menu&type=ajax&id=' + id + '&estado=' + estado, '', 'area_trabajo');
    clearTimeout(t);
}