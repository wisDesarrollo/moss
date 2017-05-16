<?php

require_once('fw/controlador/php/clases/reporte.class.php');

class ReporteCompras extends Reporte {

    public $tipo_contenido = 'html';
    
    
    CONST COMPRAS = 2;
    CONST ESTADO_ELIMINADO = 3;

    public function __construct($db = "", $modulo = "") {

        $this->modulo = $modulo;
        $this->nombre_tabla = "transaccion";
        $this->actualizacion_ajax='ajax';
        parent::__construct($db, $this->modulo);
        //$clase = $this->gn->get_data_loged('clase');   
		$marcablanca=$this->gn->get_data_loged('marca_blanca');
        $funcion = $this->gn->crearCampoEvento('onclick', 'reporteMostrarDetalle', 't.transaccion', array('param1'));
		
		
        $this->tablas = $this->nombre_tabla .' t, fw_interlocutor i,fw_interlocutor_condicion ic';
        $this->campos = array('t.fecha as Fecha, t.id_transaccion AS ID ,i.nombre as Negocio, CONCAT("$", FORMAT(t.total, 0)) AS total');
        $this->condicion = "t.estado_id <> ".self::ESTADO_ELIMINADO
                    ." AND t.interlocutor_id=i.id_interlocutor"
                    ." AND t.transaccion_tipo_id=".self::COMPRAS
                    ." AND ic.interlocutor_id=t.interlocutor_id"
                    ." AND ic.marca_blanca=".$marcablanca;
		$this->group_by=' t.id_transaccion';
		$this->mostrar_resumen = true;	
    }

    function home2() {
        $marcablanca=$this->gn->get_data_loged('marca_blanca');
        $id_interlocutor = $this->gn->get_data_loged('id_interlocutor'); //id del Interlocutor actual
        $tablas = $this->nombre_tabla .' t,transaccion_item ti,fw_interlocutor i,fw_interlocutor_condicion ic';
        $campos = array('t.fecha as Fecha, CONCAT("<a inclick=\"alert(\'",t.id_transaccion,"\');\">", t.id_transaccion, "</a>") AS Transaccion ,i.nombre as Negocio,sum(ti.cantidad * ti.valor_unitario) as total');//.);//'sum(ti.valor_unitario * ti.cantidad)'
        $condicion = "t.estado_id <> ".self::ESTADO_ELIMINADO
                    ." and ti.estado_id <> ".self::ESTADO_ELIMINADO
                    ." and t.interlocutor_id=i.id_interlocutor"
                    ." and ti.transaccion_id=t.id_transaccion"
                    ." and t.transaccion_tipo_id=".self::COMPRAS
                    ." and i.id_interlocutor=$id_interlocutor"
                    ." and ic.interlocutor_id=t.interlocutor_id"
                    ." and ic.marca_blanca=".$marcablanca;
        $group_by='ti.transaccion_id';
        $this->iniciar_reporte($campos, $tablas,$condicion,$group_by);
    }
	function home() {
        
		echo '<div class="store_cont_centrado">';
			//$filtros['fecha']='';
			$filtros['id_producto']= $this->traerProductos();
			
			//$this->filtro($filtros);
		echo '</div>';
		echo '<div id="area_reporte">';
			$this->mostrar_reporte();
		echo '</div>';
    }
}