<?php


class InventarioFisico extends Maestro {

    public $tipo_contenido = 'ajax';
    
    public function __construct($db = "", $modulo = "") {

        $this->modulo = $modulo;
        $this->nombre_tabla = strtolower(__CLASS__);
        $this->primary_key = 'id_' . strtolower(__CLASS__);
        $this->actualizacion_ajax='ajax';
        
        parent::__construct($db, $this->modulo);
    }

    function home() {

         //p.cantidad, p.valor_venta, p.valor_compra, m.nombre as referencia ',  'p.nombre ASC '

        $interlocutor_id_actual = $this->gn->get_data_loged('id_interlocutor'); //id del Interlocutor actual
        $tablas = 'productos p, referencias m';
        $campos = array('p.id_productos as COD','m.nombre as Referencia','m.id_referencias as val','p.cantidad as STOCK', 'p.valor_venta','p.valor_compra');

        $this->iniciar_maestro_directo($campos, $tablas,$this->modulo);
    }
}