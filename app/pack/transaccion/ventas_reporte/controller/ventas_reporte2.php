<?php

require_once('fw/lib/class/reporte.class.php');

class VentasReporte extends Reporte {

    public $tipo_contenido = 'html';
    CONST VENTAS = 1;

    public function __construct($db = "", $modulo = "") {

        $this->modulo = $modulo;
        $this->nombre_tabla = "transaccion";
        $this->actualizacion_ajax='ajax';
        parent::__construct($db, $this->modulo);
        //$clase = $this->gn->get_data_loged('clase');   
		$marcablanca=$this->gn->get_data_loged('marca_blanca');
        //$id_interlocutor = $this->gn->get_data_loged('id_interlocutor'); //id del Interlocutor actual
        $this->tablas = $this->nombre_tabla .' t, fw_interlocutor i,fw_interlocutor_condicion ic';
        $this->campos = array('t.fecha as Fecha, t.id_transaccion as Transaccion,i.nombre as Negocio, CONCAT("$", FORMAT(t.total, 0)) AS total');
        $this->condicion = "t.estado_id <> ".self::ESTADO_ELIMINADO
                    ." AND t.interlocutor_id=i.id_interlocutor"
                    ." AND t.transaccion_tipo_id=".self::VENTAS
                    ." AND ic.interlocutor_id=t.interlocutor_id"
                    ." AND ic.marca_blanca=".$marcablanca;
		$this->group_by=' t.id_transaccion';
		$this->mostrar_resumen = true;	
        //$this->iniciar_reporte($campos, $tablas,$condicion,$group_by);
    }

    function home2() {
        $marcablanca=$this->gn->get_data_loged('marca_blanca');
        
        $tablas = $this->nombre_tabla .' t, fw_interlocutor i,fw_interlocutor_condicion ic';
        $campos = array('t.fecha as Fecha, t.id_transaccion as Transaccion,i.nombre as Negocio, CONCAT("$", FORMAT(t.total, 0)) AS total');
        $condicion = "t.estado_id <> ".self::ESTADO_ELIMINADO
                    ." AND t.interlocutor_id=i.id_interlocutor"
                    ." AND t.transaccion_tipo_id=".self::VENTAS
                    ." AND ic.interlocutor_id=t.interlocutor_id"
                    ." AND ic.marca_blanca=".$marcablanca;
		$group_by=' t.id_transaccion';

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

        /*$marcablanca=$this->gn->get_data_loged('marca_blanca');
        $id_interlocutor = $this->gn->get_data_loged('id_interlocutor'); //id del Interlocutor actual
        $tablas = $this->nombre_tabla .' t, transaccion_tipo tt, fw_interlocutor_condicion ic';
        $campos = array('t.fecha as Fecha','tt.nombre');//.);//'sum(ti.valor_unitario * ti.cantidad)'
        $condicion = "t.transaccion_tipo_id=tt.id_transaccion_tipo AND t.interlocutor_id=".$id_interlocutor." AND ic.interlocutor_id=t.interlocutor_id AND ic.marca_blanca=".$marcablanca;
        $group_by="";*/
        /*
        // LLAMDO AJAX SIN FORMATEAR ALGUN CAMPO
        $encabezado = array('Codigo Producto','Referencia','producto','Iva','Categoria','Costo');
        $campos = array(
            array( 'db' => 'p.id_producto', 'dt' => 0, 'field' => 'id_producto' ),
            array( 'db' => 'p.referencia',  'dt' => 1, 'field' => 'referencia' ),
            array( 'db' => 'p.nombre',   'dt' => 2, 'field' => 'nombre' ),
            array( 'db' => 'p.iva',     'dt' => 3, 'field' => 'iva'),
            array( 'db' => 'pc.nombre',     'dt' => 4, 'field' => 'categoria','as'=>'categoria' ),
            array( 'db' => 'p.costo',     'dt' => 5, 'field' => 'costo')
            );

        $from = "FROM producto AS p JOIN producto_categoria AS pc ON (pc.id_producto_categoria = p.producto_categoria_id)";
        $where = "";        
        $groupBy = "";

        $this->pintar_reporte('producto','id_producto',$encabezado,$campos,$from,$where,$groupBy);*/

       /* 
    // LLAMADO AJAX FORMATEANDO UN CAMPO
       $encabezado = array('Codigo Producto','Referencia','producto','Iva','Categoria','Costo');
        $this->pintar_tabla_ajax($encabezado,'app/controlador/php/modulos/reporte_ventas_ajax.php');*/