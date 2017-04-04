<?php

require_once('fw/lib/class/reporte.class.php');

class VentasReporte extends Reporte {

    public $tipo_contenido = 'html';

    public function __construct($db = "", $modulo = "") {
        $this->modulo = $modulo;
        $this->nombre_tabla = "transaccion";
        $this->actualizacion_ajax = 'ajax';
        parent::__construct($db, $this->modulo);
        //$clase = $this->gn->get_data_loged('clase');   
        $marcablanca = $this->gn->get_data_loged('marca_blanca');
        $funcion = $this->gn->crearCampoEvento('onclick', 'reporteMostrarDetalle', 't.transaccion', array('param1'));

        $this->tablas = $this->nombre_tabla . ' t, fw_interlocutor i,fw_interlocutor_condicion ic';
        $this->campos = array(
            't.id_transaccion AS ID',
            't.factura_numero AS Factura',
            't.fecha AS Fecha', 
            'i.nombre as Negocio',
            'CONCAT("$", FORMAT(t.total, 0)) AS Total'
        );
        $this->condicion = "t.estado_id <> " . ESTADO_ELIMINADO
                . " AND t.interlocutor_id=i.id_interlocutor"
                . " AND t.transaccion_tipo_id=" . TRX_VENTA
                . " AND ic.interlocutor_id=t.interlocutor_id"
                . " AND ic.marca_blanca=" . $marcablanca;
        $this->group_by = ' t.id_transaccion';
        $this->mostrar_resumen = true;
        $this->trx_tipo = TRX_VENTA;
    }

    function home2() {
        $marcablanca = $this->gn->get_data_loged('marca_blanca');
        $id_interlocutor = $this->gn->get_data_loged('id_interlocutor'); //id del Interlocutor actual
        $tablas = $this->nombre_tabla . ' t,transaccion_item ti,fw_interlocutor i,fw_interlocutor_condicion ic';
        $campos = array(
            't.fecha as Fecha', 
            'CONCAT("<a inclick=\"alert(\'",t.id_transaccion,"\');\">", t.factura_numero, "</a>") AS `Factura`' ,
            'i.nombre as Negocio',
            'SUM(ti.cantidad * ti.valor_unitario) AS Total'
            ); 
        $condicion = "t.estado_id <> " . ESTADO_ELIMINADO
                . " and ti.estado_id <> " . ESTADO_ELIMINADO
                . " and t.interlocutor_id=i.id_interlocutor"
                . " and ti.transaccion_id=t.id_transaccion"
                . " and t.transaccion_tipo_id=" . TRX_VENTA
                . " and i.id_interlocutor=$id_interlocutor"
                . " and ic.interlocutor_id=t.interlocutor_id"
                . " and ic.marca_blanca=" . $marcablanca;
        $group_by = 'ti.transaccion_id';
        $this->iniciar_reporte($campos, $tablas, $condicion, $group_by);
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
