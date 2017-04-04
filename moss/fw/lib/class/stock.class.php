<?php 
/**
* 
*/
class Stock{
	/*@var Mysql*/
	private $db;
	
	function __construct($db)
	{
		$this->db = $db;
	}

	function actualizar_stock($id_producto,$cantidad,$operacion){
		$producto = $this->db->selectOne(array('stock_control'), 'producto', ' id_producto = '.$id_producto);
		if(isset($producto['stock_control']) && $producto['stock_control'] === 'S'){
			$update = $this->db->query('UPDATE producto_stock SET stock = stock '.$operacion.' '.$cantidad.' WHERE producto_id = ' . $id_producto, false);
		}
		return $update;
	}
}