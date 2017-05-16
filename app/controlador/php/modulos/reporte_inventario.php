<?php

require_once('fw/controlador/php/clases/reporte.class.php');

class ReporteInventario extends Reporte {

    public $tipo_contenido = 'html';

    public function __construct($db = "", $modulo = "") {
        $this->modulo = $modulo;
        $this->nombre_tabla = strtolower(__CLASS__);
        $this->primary_key = 'id_' . strtolower(__CLASS__);
        $this->actualizacion_ajax = 'ajax';

        parent::__construct($db, $this->modulo);
    }

    function home() {
        $id_interlocutor=$this->gn->get_data_loged('id_interlocutor');
        $this->nombre_tabla = "producto";
        $tablas = $this->nombre_tabla . ' pr, producto_stock ps, fw_estado est';
        $campos = array('pr.referencia Referencia','pr.nombre as Producto', 'ps.stock as cantidad');
        $condicion = "pr.estado_id = est.id_estado AND ps.producto_id = pr.id_producto "
                . " AND pr.interlocutor_id = ".$id_interlocutor
				. " AND pr.stock_control = 'S'"
				. " AND pr.estado_id <>" . self::ESTADO_ELIMINADO;
        $this->pintar_tabla($campos, $tablas, $condicion, '');
    }
}