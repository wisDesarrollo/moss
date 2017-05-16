<?php

require_once('fw/lib/class/reporte.class.php');

class PedidosReporte extends Reporte {

    public $tipo_contenido = 'html';

    public function __construct($db = "", $modulo = "") {
        $this->modulo = $modulo;
        $this->nombre_tabla = "pedido";
        $this->actualizacion_ajax = 'ajax';
        parent::__construct($db, $this->modulo);
        //$clase = $this->gn->get_data_loged('clase');   
        $marcablanca = $this->gn->get_data_loged('marca_blanca');
        $funcion = $this->gn->crearCampoEvento('onclick', 'reportePedidoMostrarDetalle', 't.pedido', array('param1'));

        
        $this->campos = array(
            't.id_pedido AS ID',
            't.fecha_publicacion AS Fecha', 
            'm.nombre as Mesa',
			'e.descripcion AS EstadoPedido' 
        );
		$this->tablas = $this->nombre_tabla . ' t, fw_interlocutor i,fw_interlocutor_condicion ic, mesa m, cuenta c, fw_estado e';
        $this->condicion = "t.estado_id <> " . ESTADO_ELIMINADO
                . " AND t.interlocutor_id=i.id_interlocutor"
				. " AND t.cuenta_id=c.id_cuenta"
				. " AND c.punto_atencion_id=m.id_mesa"
                . " AND ic.interlocutor_id=t.interlocutor_id"
				. " AND t.fecha_publicacion > DATE(NOW())"
				. " AND t.estado_id=e.id_estado "
                . " AND ic.marca_blanca=" . $marcablanca. " ORDER BY t.id_pedido DESC";
        
        $this->mostrar_resumen = true;
    }

    
    function home() {

        echo '<div class="store_cont_centrado">';
        //$filtros['fecha']='';
        $filtros['id_producto'] = $this->traerProductos();

        //$this->filtro($filtros);
        echo '</div>';
        echo '<div id="area_reporte">';
        $this->mostrar_reporte();
        echo '</div>';
    }
	function mostrar_datos_item() {
        $parametros = $this->gn->traer_parametros('GET');
        $id_interlocutor = $this->gn->get_data_loged('id_interlocutor');
        //TODO: traer los datos de la transaccion y mostrarlos posteriormente en la vista

        $campos = array('t.fecha_publicacion');
        $tablas = "pedido t";
        $condicion = "interlocutor_id=" . $id_interlocutor . " "
                . " AND t.id_pedido =" . $parametros->id;
        $transaccion['trx'] = $this->db->selectOne($campos, $tablas, $condicion);

        $campos = array('ti.pedido_id', 'm.nombre AS mesa','ti.cantidad', 'p.nombre', 'e.descripcion AS estado');
        $tablas = " pedido_item ti, producto p, pedido pe, mesa m, fw_estado e";
        $condicion = "ti.producto_id = p.id_producto "
				. " AND ti.pedido_id = pe.id_pedido "
				. " AND pe.mesa_id = m.id_mesa "
				. " AND ti.estado_id = e.id_estado "
                . " AND ti.pedido_id =" . $parametros->id;
        $transaccion['items'] = $this->db->select($campos, $tablas, $condicion);
		
        require_once("fw/template/reporte/view/reporte.html.php");
        ReporteHTML::mostrar_datos_item($transaccion);
    }


}
