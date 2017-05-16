<?php

require_once('fw/lib/class/reporte.class.php');

class ProductoVentaReporte extends Reporte {

    public $tipo_contenido = 'html';

    public function __construct($db = "", $modulo = "") {
        $this->modulo = $modulo;
        $this->nombre_tabla = "transaccion_item";
        $this->actualizacion_ajax = 'ajax';
        
        parent::__construct($db, $this->modulo);

        $this->tablas = $this->nombre_tabla . ' ti, transaccion t , producto p';
        $this->campos = array(
            'COUNT(ti.producto_id) AS Cantidad',
            'p.nombre AS Producto'
        );
        $this->group_by = ' GROUP BY ti.producto_id';
        $this->condicion = "ti.estado_id = " . ESTADO_ACTIVO
                . " AND t.id_transaccion=ti.transaccion_id"
                . " AND t.transaccion_tipo_id=" . TRX_VENTA
                . " AND p.id_producto=ti.producto_id".$this->group_by;
        
        $this->order_by = " Cantidad Desc";
        $this->limit = " 20 ";
        $this->mostrar_resumen = true;
        $this->trx_tipo = TRX_VENTA;
    }

    function home() {
        $interlocutor_id_actual = $this->gn->get_data_loged('id_interlocutor'); //id del Interlocutor actual    
        $this->condicion = "ti.estado_id = " . ESTADO_ACTIVO
                . " AND t.id_transaccion=ti.transaccion_id"
                . " AND t.interlocutor_id = '$interlocutor_id_actual'"
                . " AND t.transaccion_tipo_id=" . TRX_VENTA
                . " AND p.id_producto=ti.producto_id".$this->group_by;
        
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
