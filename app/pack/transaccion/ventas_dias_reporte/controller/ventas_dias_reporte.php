<?php

require_once('fw/lib/class/reporte.class.php');

class VentasDiasReporte extends Reporte {

    public $tipo_contenido = 'html';

    public function __construct($db = "", $modulo = "") {
        $this->modulo = $modulo;
        $this->nombre_tabla = "transaccion";
        $this->actualizacion_ajax = 'ajax';
        parent::__construct($db, $this->modulo);
        //$clase = $this->gn->get_data_loged('clase');   
        $marcablanca = $this->gn->get_data_loged('marca_blanca');
        $interlocutor_id_actual = $this->gn->get_data_loged('id_interlocutor'); //id del Interlocutor actual    
        $funcion = $this->gn->crearCampoEvento('onclick', 'reporteMostrarDetalle', 't.transaccion', array('param1'));

        $this->tablas = $this->nombre_tabla . ' t';
        $this->campos = array(
            "DATE_FORMAT(t.fecha,'%Y-%m-%d') AS Fecha", 
            'FORMAT(COUNT(t.total), 0) AS Cantidad',
            'CONCAT("$", FORMAT(SUM(t.total), 0)) AS Ventas',
            'CONCAT("$", FORMAT(SUM(t.servicio), 0)) AS Servicio'
        );
        $this->group_by = ' GROUP BY 1  DESC';
        $this->condicion = "t.estado_id <> " . ESTADO_ELIMINADO
                . " AND t.fecha > DATE('2017-04-13') "
                . " AND t.interlocutor_id = '$interlocutor_id_actual' "
                . " AND t.transaccion_tipo_id=" . TRX_VENTA. $this->group_by;
                
        
        $this->mostrar_resumen = true;
        $this->trx_tipo = TRX_VENTA;
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

}
