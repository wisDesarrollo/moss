<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of reporte
 *
 * @author Soldier
 */
class Reporte extends Modulo {

    public $campos;
    public $tablas;
    public $condicion;
    public $order_by;
    public $limit;
    public $filtros_campos = array();
    public $mostrar_resumen = false;
    
    public $trx_tipo = TRX_VENTA;

    function __construct($db = "", $modulo = "") {
        $this->order_by = "";
        $this->limit = "";
        parent::__construct($db, $modulo);
    }

    function mostrar_reporte($parametros = array()) {
        if(!isset($parametros)){
            $parametros = $this->gn->traer_parametros('GET');
        }
        if (isset($parametros->condicion)) {
            $this->condicion .= $parametros->condicion;
        }
        foreach ($this->filtros_campos as $campo) {
            if (isset($parametros->$campo) && ($parametros->$campo != '')) {
                $this->condicion .= " AND " . $campo . " = '" . $parametros->$campo . "'";
            }
        }
        //echo $this->condicion;
        
        if ($this->mostrar_resumen) {
            echo '<div class="store_cont_centrado">';
            //$this->resumen($this->trx_tipo);
            echo '</div>';
        }
        $function = array('ID' => 'mostrar_datos_item');
        $action = array('mostrar_datos_item' => 'mostrar_datos_item');
        echo '<div class="store_cont_centrado">';
        $this->pintar_tabla($this->campos, $this->tablas, $this->condicion, $this->order_by, $this->limit, $this->modulo, $action, $function);
        echo '</div>';
    }

    function mostrar_reporte_detalle() {
        $parametros = $this->gn->traer_parametros('GET');
        if (isset($parametros->condicion)) {
            $this->condicion .= $parametros->condicion;
        }
        foreach ($this->filtros_campos as $campo) {
            if (isset($parametros->$campo) && ($parametros->$campo != '')) {
                $this->condicion .= " AND " . $campo . " = '" . $parametros->$campo . "'";
            }
        }
        if ($this->mostrar_resumen) {
            echo '<div class="store_cont_centrado">';
            $this->resumen($this->trx_tipo);
            echo '</div>';
        }
        $function = array('ID' => 'mostrar_datos_item');
        $action = array('mostrar_datos_item' => 'mostrar_datos_item');
        echo '<div class="store_cont_centrado">';
        $this->pintar_tabla($this->campos, $this->tablas, $this->condicion, false, '', $this->modulo, $action, $function);
        echo '</div>';
    }

    function reporte_simple($campos, $tablas, $condicion, $titulo_pdf = '', $order = '', $group_by = false) {
        $this->nc->verificar_notificacion();

        $parametros = $this->gn->traer_parametros('GET');

        if (isset($parametros->type)) {
            $this->tipo_contenido = $parametros->type;
        }

        $accion = array('radio_edicion' => 'formulario_edicion');
        $this->pintar_reporte($campos, $tablas, $condicion, $group_by, $order, $this->modulo, $accion, $function, $titulo_pdf, 'tabla_' . $this->modulo);
    }

    function pintar_tabla($campos, $tabla, $condicion, $group_by = false, $order = '', $modulo = '', $accion = '', $function = array(), $titulo_pdf = '', $id_tabla = 'example', $tipo_modulo = 'maestro') {

        $id_interlocutor = $this->gn->get_data_loged('id_interlocutor');
        if ($tipo_modulo == 'maestro') {
            $contenido = $this->db->selectDistinct($campos, $tabla, $condicion, $group_by, $order, false, false); //linea problema//OJO CAMBIE EL SELECT POR SELECTDISTINCT
        } elseif ($tipo_modulo == 'reporte') {
            $contenido = $this->db->select($campos, $tabla, $condicion, $group_by, $order, false);
        }

        $filas = $this->db->countRows();
        //if (intval($filas) > 5000) {
        /* $this->gn->set_data_loged('campos_csv', $campos);
          $this->gn->set_data_loged('tabla_csv', $tabla);
          $this->gn->set_data_loged('condicion_csv', $condicion);
         *///require_once 'fw/vista/html/datatable.html.php';
        //DatatableHTML::btn_descargar();
        //} else {
        //echo "<pre>";
        //print_r($contenido);
        if (!empty($contenido)) {
            foreach ($contenido[0] as $key => $value) {
                $encabezado[] = $key;       //Obtengo los campos de la consulta
            }
        } else {
            $contenido = '';
            $encabezado = '';
        }
        //print_r($contenido);
        require_once PATH_PLUGIN_TABLE_VIEW;
        DatatableHTML::home($encabezado, $contenido, $modulo, $accion, $function, '', $titulo_pdf, $id_tabla);
        //}
    }

    function resumen($trx_tipo) {
        $resumen['venta_total']['titulo'] = 'Total';
        $resumen['venta_total']['datos'] = $this->resumenItem('venta_total', $trx_tipo);

        //ÚLTIMO MES
        $resumen['venta_mes']['titulo'] = 'Último Mes';
        $resumen['venta_mes']['datos'] = $this->resumenItem('venta_mes', $trx_tipo);
        //$datos = $this->db->selectOne($campos, $tablas, $condicion);
        //ÚLTIMA SEMANA
        $resumen['venta_semana']['titulo'] = 'Última Semana';
        $resumen['venta_semana']['datos'] = $this->resumenItem('venta_semana', $trx_tipo);

        require_once("fw/template/reporte/view/reporte.html.php");
        ReporteHTML::resumen($resumen);
    }

    function filtros() {
        require_once("fw/template/reporte/view/reporte.html.php");
        ReporteHTML::filtros();
    }

    function filtro($filtros = null) {
        $modulo = $this->modulo;
        $interlocutor_id = 1;
        $fecha_ini = '';
        $fecha_fin = '';
        $usuarios = '';
        $campos_usuario = 0;
        $usuario_seleccionado = '';

        require_once("fw/template/reporte/view/reporte.html.php");
        ReporteHTML::filtro($modulo, $interlocutor_id, $filtros, $fecha_ini, $fecha_fin, $usuarios, $campos_usuario, $usuario_seleccionado);
    }

    function resumenItem($nombre, $trx_tipo = TRX_VENTA, $fecha_ini = '', $fecha_fin = '', $producto_id = '') {
        $moneda = "$";
        $campos = array('CONCAT("' . $moneda . '", FORMAT(SUM(ti.valor_unitario), 0)) AS valor');
        $tablas = "transaccion t, transaccion_tipo tt, transaccion_item ti";
        $condicion = "ti.transaccion_id=t.id_transaccion
                  AND t.transaccion_tipo_id= tt.id_transaccion_tipo AND t.transaccion_tipo_id=" . $trx_tipo;
        if ($nombre == 'venta_semana') {
            $this->condicion .= " AND t.fecha > CURRENT_DATE() - INTERVAL 7 day ";
        }
        if ($nombre == 'venta_mes') {
            $this->condicion .= " AND t.fecha BETWEEN date_sub(now(), interval 1 month)  AND NOW() ";
        }

        if ($fecha_ini != '' AND $fecha_fin != '') {
            $condicion .= " AND ti.fecha BETWEEN '".$fecha_ini."' AND '".$fecha_fin."' ";
        }
        if ($producto_id != '') {
            $condicion .= " AND ti.producto_id = " . $producto_id . "  ";
        }

        $datos = $this->db->selectOne($campos, $tablas, $condicion, '', false);
        
        if (!isset($datos['valor']) || ($datos['valor'] == '')) {
            $datos['valor'] = '$0';
        }
        return $datos;
    }

    function traerProductos() {
        $id_interlocutor = $this->gn->get_data_loged('id_interlocutor');

        $campos = array('id_producto AS ID', 'nombre', 'precio');
        $tablas = "producto";
        $condicion = "interlocutor_id=" . $id_interlocutor . " ";

        $response['lista'] = $this->db->select($campos, $tablas, $condicion);
        $response['campos'] = $campos;
        return $response;
    }

    function mostrar_datos_item() {
        $parametros = $this->gn->traer_parametros('GET');
        $id_interlocutor = $this->gn->get_data_loged('id_interlocutor');
        //TODO: traer los datos de la transaccion y mostrarlos posteriormente en la vista

        $campos = array('t.fecha', 't.factura_numero', 't.total');
        $tablas = "transaccion t";
        $condicion = "interlocutor_id=" . $id_interlocutor . " "
                . " AND t.id_transaccion =" . $parametros->id;
        $transaccion['trx'] = $this->db->selectOne($campos, $tablas, $condicion);

        $campos = array('ti.transaccion_id', 'ti.cantidad', 'ti.valor_unitario', 'p.referencia', 'p.nombre');
        $tablas = " transaccion_item ti, producto p";
        $condicion = "ti.producto_id = p.id_producto "
                . " AND ti.transaccion_id =" . $parametros->id;
        $transaccion['items'] = $this->db->select($campos, $tablas, $condicion);

        require_once("fw/template/reporte/view/reporte.html.php");
        ReporteHTML::mostrar_datos_item($transaccion);
    }

}
