function cancelar_pedido(id_pedido, mesa){
	peticion_ajax('?opcion=comandas&a=cancelar_pedido&type=ajax&id_pedido='+id_pedido+'&id_mesa='+mesa,'','area_trabajo');
	
}
function despachar_pedido(id_pedido){
	peticion_ajax('?opcion=comandas&a=despachar_pedido&type=ajax&id_pedido='+id_pedido,'','area_trabajo');
	
}
function cancelar_pedido_item(id_pedido_item, mesa){
	peticion_ajax('?opcion=comandas&a=cancelar_pedido_item&type=ajax&id_pedido_item='+id_pedido_item+'&id_mesa='+mesa,'','area_trabajo');
	
}
function despachar_pedido_item(id_pedido_item, nuevo_estado){
	peticion_ajax('?opcion=comandas&a=despachar_pedido_item&type=ajax&id_pedido_item='+id_pedido_item+'&estado='+nuevo_estado,'','area_trabajo');
	
}
function recuperar_pedido_item(){
	peticion_ajax('?opcion=comandas&a=recuperar_pedido_item&type=ajax','','area_trabajo');
}