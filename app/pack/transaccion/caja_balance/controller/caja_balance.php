<?php

//require_once('fw/controlador/php/modulos/maestro.class.php');
Class Caja {

    public $base = 0;
    public $compras = 0;
    public $ventas = 0;
    public $interlocutor_id = 0;
    public $fecha = '';
    public $hora = '';
    public $estado_id = 0;

    function __construct(){
        $this->fecha = date('Y-m-d');
        $this->hora = date('H:i:s');
        $this->estado_id = ESTADO_VIGENTE;
    }

    function setCaja($datos) {
        foreach ($datos as $campo => $valor){
            if (isset($datos[$campo])){
                $this->$campo = $valor;
            }   
        }
    }
}

Class CajaBalance extends Maestro {

    public $tipo_contenido = 'html';
    public $caja;

    public function __construct($db = "", $modulo = "") {
        $this->herramientas = array();
        parent::__construct($db, $modulo);
        $this->nombre_tabla = 'caja';
        $this->primary_key = 'id_' . $this->nombre_tabla;
        $this->caja = New Caja();
    }

    function home($id_caja = 0) {
        $interlocutor_id_actual = $this->gn->get_data_loged('id_interlocutor'); //id del Interlocutor actual

        $tablas = $this->nombre_tabla . ' c, fw_estado est';
        $campos = array(
            'c.fecha_apertura AS `Fecha Apertura`',
            'c.hora_apertura AS `Hora Apertura`',
            ' CONCAT("$",FORMAT(c.base, 0)) AS base',
            ' CONCAT("$",FORMAT(c.ventas, 0)) AS ventas',
            ' CONCAT("$",FORMAT(c.compras, 0)) AS compras',
            ' CONCAT("$",FORMAT(c.efectivo, 0)) AS efectivo',
            ' CONCAT("$",FORMAT(c.caja, 0)) AS caja',
            ' CONCAT("$",FORMAT(c.servicio, 0)) AS servicio',
            'est.descripcion AS estado ');
        $condicion = "c.interlocutor_id = " . $interlocutor_id_actual . " "
                . " AND c.estado_id = est.id_estado "
				. " AND c.estado_id <>  ".ESTADO_ELIMINADO
				. " ORDER BY fecha_apertura DESC ";

        $this->balance_dia($id_caja);
        $this->iniciar_maestro($campos, $tablas, $condicion, '');
    }

    function balance_dia($id_caja = 0){
        $interlocutor_id_actual = $this->gn->get_data_loged('id_interlocutor'); //id del Interlocutor actual

        $caja_dia = $this->consultar_caja($interlocutor_id_actual);
        $this->caja->setCaja($caja_dia);

        unset($caja_dia['id_caja']);
        $caja_dia['base'] = "$" . number_format($this->caja->base);
        $caja_dia['compras'] = "$" . number_format($this->caja->compras);
        $caja_dia['ventas'] = "$" . number_format($this->caja->ventas);
        $caja_dia['caja'] = "$" . number_format($this->caja->caja);

        $caja_estado = $caja_dia['estado_id'];
        unset($caja_dia['estado_id']);
        $this->get_module_view_path('transaccion');
        CajaBalanceHTML::ver_balance_form($caja_dia, $caja_estado, $id_caja);
    }

    function crear_registro($owner, $base = 0) {
        $campos = array(
            'base' => $base,
            'compras' => 0,
            'ventas' => 0,
            'caja' => $base,
            'interlocutor_id' => $owner,
            'fecha_apertura' => date('Y-m-d'),
            'hora_apertura' => date('H:i:s'),
            'estado_id' => ESTADO_VIGENTE
        );
        $result = $this->db->insert($campos, $this->nombre_tabla);
        return $result;
    }

    function consultar_caja($owner, $estado = null) {
        $condicion_estado = " AND c.estado_id = " . $estado;
        if (is_null($estado)) {
            $condicion_estado = " AND c.estado_id <> " . ESTADO_ELIMINADO;
        }

        $tablas = $this->nombre_tabla . ' c, fw_estado est';
        $campos = array(
            'c.fecha_apertura AS `Fecha Apertura`',
            'c.hora_apertura AS `Hora Apertura`',
            'c.id_caja',
            'c.fecha_cierre',
            'c.hora_cierre',
            'c.id_caja',
            'c.base',
            'c.compras',
            'c.ventas',
            'c.caja',
            'c.estado_id',
            'est.descripcion AS estado'
        );
        $condicion = "c.interlocutor_id = " . $owner . " "
                . " AND c.estado_id = est.id_estado "
                . $condicion_estado;

        $caja_dia = $this->db->selectOne($campos, $tablas, $condicion, " c.id_caja DESC ", false);

        return $caja_dia;
    }

    function abrir_caja($owner = null) {
        if (is_null($owner)) {
            $owner = $this->gn->get_data_loged('id_interlocutor');
        }
        $parametros = $this->gn->traer_parametros('GET');

        $registro_creado = $this->crear_registro($owner, $parametros->base);
        if ($registro_creado) {
            //$caja_dia = $this->consultar_caja($owner, ESTADO_VIGENTE);
            //return $caja_dia;
            $this->home();
        } else {
            return false;
        }
    }

    function cerrar_caja($owner = null) {
        if (is_null($owner)) {
            $owner = $this->gn->get_data_loged('id_interlocutor');
        }
        $parametros = $this->gn->traer_parametros('GET');
        $parametros->efectivo_cierre = 0;
        $caja_vigente = $this->consultar_caja($owner, ESTADO_VIGENTE);
        $caja_cerrada = $this->consultar_caja($owner, ESTADO_CAJA_CERRADA);
        $ventas = $this->gn->traer_datos_ventas($caja_cerrada['fecha_cierre']." ".$caja_cerrada['hora_cierre']);
        
        $caja_saldo = $caja_vigente['base'] + $ventas['ventas'];

        $campos = array(
            'ventas' => $ventas['ventas'],
            'caja' => $caja_saldo,
            'efectivo' => $parametros->efectivo_cierre,
            'servicio' => $ventas['servicio'],
            'fecha_cierre' => date('Y-m-d'),
            'hora_cierre' => date('H:i:s'),
            'estado_id' => ESTADO_CAJA_CERRADA
        );

        $condicion = " estado_id = " . ESTADO_VIGENTE
                . " AND interlocutor_id = " . $owner;
        $result = $this->db->update($campos, $this->nombre_tabla, $condicion, false, false);
        $caja_cerrada = $this->consultar_caja($owner, ESTADO_CAJA_CERRADA);
        echo $caja_vigente['id_caja'];
        //$this->home($caja_vigente['id_caja']);
    }
    function actualizar_caja($owner = null) {
        if (is_null($owner)) {
            $owner = $this->gn->get_data_loged('id_interlocutor');
        }
        $parametros = $this->gn->traer_parametros('GET');
        
        $caja_saldo = $caja_vigente['base'] + $ventas['ventas'];

        $campos = array(
            'efectivo' => $parametros->efectivo_cierre
        );

        $condicion = " id_caja = " . $parametros->id_caja;
        $result = $this->db->update($campos, $this->nombre_tabla, $condicion, false, false);
        $this->home();
    }
}
