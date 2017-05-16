<?php

class Facturar extends Modulo {

    CONST ERROR_PEDIDO = "053";
    CONST PEDIDO_VACIO = "054";
    CONST ERROR_LIBERAR = "055";
    CONST IMPRIMIR = "056";

    public $tipo_contenido = 'html';

    public function __construct($db = "", $modulo = "", $ruta_cron = "", $modulo_info = null, $WISQueries = null, $appQry = null) {
        $this->modulo = strtolower(__CLASS__);
        $this->nombre_tabla = 'mesa';
        $this->primary_key = 'id_' . 'mesa';
        $this->actualizacion_ajax = 'ajax';
        parent::__construct($db, $this->modulo, $ruta_cron, $modulo_info, $WISQueries, $appQry);

        $this->encabezado = array('COD', 'REFERENCIA', 'PRODUCTO', 'CANTIDAD', 'IVA', 'IVA INCLUIDO', 'VALOR', 'VALOR IVA', 'SUBTOTAL');
        $this->encabezado_flotante = array('CODIGO', 'REFERENCIA', 'PRODUCTO', 'STOCK', 'PRECIO', 'CANTIDAD', 'ADD');
    }

    function home() {
        $interlocutor_id_actual = $this->gn->get_data_loged('id_interlocutor'); //id del Interlocutor actual
        $campos = array('m.' . $this->primary_key . " as ID", 'm.mesa_id', 'm.nombre as Mesa', 'm.descripcion as Descripcion', 'm.mesero_id as Mesero', 'm.orden as Orden', 'est.descripcion as Estado');
        $tablas = $this->nombre_tabla . ' m, fw_estado est';
        
        require_once 'app/pack/pedido/mesa/view/mesa.html.php';
        mesaHTML::mesas_contneedor_ini($this->modulo);
        $this->pintar_mesas($campos, $tablas, $this->modulo);
        mesaHTML::mesas_contneedor_fin();
        require_once 'app/pack/transaccion/facturar/view/factura.html.php';
        FacturaHTML::refresh();
    }

    function estado_menu() {
        $parametros = $this->gn->traer_parametros('GET');
        $id = $parametros->id;
        $estado = $parametros->estado;
        $interlocutor_actual = $this->gn->get_data_loged('id_interlocutor');
        if ($estado == 11) {
            $opciones = array("reservar" => "$id", "liberar" => "$id");
        } elseif ($estado == 12) {
            $opciones = array("confirmar-reserva" => "$id", "liberar" => "$id");
        } elseif ($estado == 13) {
            $opciones = array("ver_pedido" => "$id", "liberar" => "$id");
        }
        $this->traer_pedido();
    }

    function cambiar_estado($redirect = true, $parametros = null) {
        if (is_null($parametros)) {
            $parametros = $this->gn->traer_parametros('GET');
        }

        $op = $parametros->op;
        $id = $parametros->id;
        if ($op == 1) {
            $cambio_est = $this->db->update(array('estado_id' => 11), 'mesa', "id_mesa=$id");
        } elseif ($op == 2) {
            $cambio_est = $this->db->update(array('estado_id' => 12), 'mesa', "id_mesa=$id");
        }
        $this->home();
    }
    function set_estado_pedido($parametros = null) {
        if (is_null($parametros)) {
            $parametros = $this->gn->traer_parametros('GET');
        }
        $id = $parametros->id;
        $cambio_est = $this->db->update(array('estado_id' => ESTADO_ELIMINADO), 'pedido_item', "id_pedido_item=$id");
        echo $parametros->id_mesa;
    }

    function traer_pedido() {
        $id_interlocutor = $this->gn->get_data_loged('id_interlocutor');
        $parametros = $this->gn->traer_parametros('GET');
        $resumen = array();
        $id_mesa = $parametros->id;

        $id_cuenta = $this->appQry->ejecutarQuery('consultar_cuenta_x_mesa', array('id_mesa' => $id_mesa));
        $pedidos = $this->appQry->ejecutarQuery('consultar_pedidos_x_cuenta', array('id_cuenta' => $id_cuenta, 'estado_id' => "(" . ESTADO_PEDIDO_TOMADO . "," . ESTADO_PEDIDO_SERVIDO . ")", 'id_owner' => $id_interlocutor));

        //TODO: Validar que todos los pedidos esten servidos(Despachados)

        if (isset($parametros->return) && !$pedidos) {
            //header('location:?opcion=facturar&a=cambiar_estado&type=ajax&id='. $id .'&op=1');
        } else {
            $total = 0;
            foreach ($pedidos as $pedido) {
                $detalle = $this->appQry->ejecutarQuery('consultar_pedido_detalle_x_pedido', array('id_pedido' => $pedido['id_pedido'], 'id_owner' => $id_interlocutor));
                $pedidos_detalle[$pedido['id_pedido']] = $detalle;

                if (isset($detalle)) {
                    foreach ($detalle as $item) {
                        $total += $item['precio'] * $item['cantidad'];
                    }
                }
            }
        }

        if (isset($parametros->return) && !$pedidos) {
            $update_pedido = $this->db->update(array('estado_id' => ESTADO_PEDIDO_ENTREGADO), 'pedido', 'mesa_id=' . $id_mesa . ' AND estado_id=16 AND interlocutor_id=' . $id_interlocutor);
            header('location:?opcion=facturar&a=cambiar_estado&type=ajax&id=' . $id_mesa . '&op=1');
            exit;
        } elseif (isset($parametros->return) && $pedidos) {
            $mensaje = $this->nc->traer_mensaje_respuesta(self::ERROR_LIBERAR);
            $this->nc->set_notificacion(utf8_encode($mensaje['descripcion']));
            header('location:?opcion=facturar&a=home&type=ajax');
        }

        $resumen = $this->factura_calcular_totales($total);
        $resumen['impuesto'] = 0;
        $mesa = $this->appQry->ejecutarQuery('consultar_mesa', array('id_mesa' => $id_mesa));
        $cuenta = array('id_mesa' => $id_mesa, 'mesa' => $mesa['mesa'], 'id_cuenta' => $id_cuenta);
        $descuentos = $mesa = $this->appQry->ejecutarQuery('consultar_descuentos_owner', array('interlocutor_id' => $id_interlocutor));
        
        require_once('app/pack/transaccion/facturar/view/factura.html.php');
        FacturaHTML::mostrar_pedido($this->modulo, $cuenta, $pedidos, $pedidos_detalle, $resumen, 1, '', '', '', $id_mesa, $descuentos);
    }

    function factura_calcular_totales($subtotal) {
        $parametros = $this->gn->traer_parametros('GET');
        $resumen = array();
        $descuento_porcentaje = 1;
        $resumen['subtotal'] = $subtotal;
        $resumen['id_descuento'] = 0;
        if (isset($parametros->servicio) && $parametros->servicio == 'true') {
            $resumen['servicio'] = $parametros->valor_servicio;
            if($resumen['servicio'] > ($subtotal * SERVICIO_COMISION)){
                $resumen['servicio'] = $subtotal * SERVICIO_COMISION;
            }
            $resumen['check_value'] = "checked";
        } else {
            $resumen['servicio'] = 0;
            $resumen['check_value'] = "";
        }
        if(TIPO_IMPUESTO == 'comun'){
            $resumen['impuesto'] = $subtotal * IVA;
        }else{
            $resumen['impuesto']  = 0;
        }
        $resumen['descuento_valor']= 0;
        if(isset($parametros->id_descuento)){
            $resumen['id_descuento']= $parametros->id_descuento;
            $descuento = $this->appQry->ejecutarQuery('consultar_descuentos_owner_id', array('id_descuento' => $parametros->id_descuento));
            if(isset($descuento['descuento'])){
                $descuento_porcentaje = $descuento_porcentaje-($descuento['descuento']/100);
                $resumen['descuento_porcentaje']= $descuento['descuento'];
                $resumen['descuento_valor']= $subtotal*($descuento['descuento']/100);
            }
        }
        
        $resumen['total'] = ($subtotal-$resumen['descuento_valor']) + $resumen['servicio'] + $resumen['impuesto'];

        $this->gn->set_data_loged(FACTURA_SUBTOTAL, $subtotal);
        return $resumen;
    }

    function factura_mostrar_totales($subtotal = null) {
        $id_interlocutor = $this->gn->get_data_loged('id_interlocutor');
        if (is_null($subtotal)) {
            $subtotal = $this->gn->get_data_loged(FACTURA_SUBTOTAL);
        }
        $resumen = $this->factura_calcular_totales($subtotal);
        $resumen['impuesto'] = 0;
        $descuentos = $mesa = $this->appQry->ejecutarQuery('consultar_descuentos_owner', array('interlocutor_id' => $id_interlocutor));
        require_once('app/pack/transaccion/facturar/view/factura.html.php');
        FacturaHTML::factura_totales($resumen['subtotal'], $resumen['servicio'], $resumen['impuesto'], $resumen['total'], $resumen['check_value'], $descuentos, $resumen['id_descuento']);
    }

    function facturar(){
        $interlocutor_actual = $this->gn->get_data_loged('id_interlocutor');
        $parametros = $this->gn->traer_parametros('POST');
        $id_cuenta = $parametros->id_cuenta;
        $id_mesa = $parametros->id_mesa;
        
        $descuento = $parametros->factura_descuento; 
        unset($parametros->id_cuenta);
        unset($parametros->factura_descuento);
        unset($parametros->id_mesa);
        $pedidos_cerrados = 0;
        $items = array();
        
        foreach ($parametros as $campo => $valor) {
            $campo_array = explode("_", $campo);
            $id_item = $campo_array[0];
            //$campo_real = $campo_array[1];
            $campo_real = substr($campo, (strlen($id_item) + 1));
            $items[$id_item][$campo_real] = $valor;
        }

        /* VALIDACION: Todos los pedidos deben estar despachados */
        $pedidos = $this->appQry->ejecutarQuery('consultar_pedidos_x_cuenta', array('id_cuenta' => $id_cuenta, 'estado_id' => "(" . ESTADO_PEDIDO_TOMADO . "," . ESTADO_PEDIDO_SERVIDO . ")", 'id_owner' => $interlocutor_actual));
        //$pedidos = $this->appQry->ejecutarQuery('consultar_pedidos_detalle_x_cuenta', array('id_cuenta' => $id_cuenta));
        $total_items = array();
        foreach ($pedidos as $pedido) {
            $detalle = $this->appQry->ejecutarQuery('consultar_pedido_detalle_x_pedido_estado', array('id_pedido' => $pedido['id_pedido'], 'id_owner' => $interlocutor_actual));
            $pedidos_detalle[$pedido['id_pedido']] = $detalle;

            if (isset($detalle)) {
                foreach ($detalle as $item) {
                    if (!isset($total_items[$item['estado_id']])) {
                        $total_items[$item['estado_id']] = 0;
                    }
                    $total_items[$item['estado_id']] += 1;
                }
            }
        }

        if (isset($total_items[ESTADO_PEDIDO_TOMADO]) && ($total_items[ESTADO_PEDIDO_TOMADO] > 0)) {
            $this->nc->set_notificacion('Aún no puede facturar esta mesa. Tiene pedidos pendientes');
            //$this->home();
            header("location:?opcion=inicio");
            return;
        }

        require_once 'fw/lib/class/transacciones.class.php';
        $transaccion = new Transacciones($this->db);

        $factura_numeracion = $transaccion->numeracion_factura($interlocutor_actual);

        if (!$factura_numeracion) {
            $this->nc->set_notificacion('Numeración de facturas no disponible');
            $this->home();
            return;
        }
        
        if(isset($parametros->factura_servicio)){
            $servicio = $parametros->factura_servicio;
        }else{
            $servicio = 0;
        }
        $transaccion_id = $transaccion->venta($factura_numeracion, $interlocutor_actual, $id_mesa, null, $items, $id_cuenta, $servicio, $descuento);
        
        if (!$transaccion_id) {
            $this->nc->set_notificacion('Error al registrar la venta');
            header('location:?opcion=' . $this->modulo);
            return;
        }

        /* GENERAR TRANSACCION */
        //$transaccion_id = $this->generar_transaccion($id_cuenta, $items);
        $pedidos = $this->appQry->ejecutarQuery('consultar_pedidos_detalle_x_cuenta', array('id_cuenta' => $id_cuenta));
        $conteo = array();
        foreach ($pedidos as $pedido) {
            $conteo[$pedido['id_pedido']][$pedido['estado_id']] = $pedido['cantidad'];
        }

        /* PEDIDO: ACTUALIZACION DE PEDIDO PARA MARCAR COMO FACTURADOS */
        //TODO: esta condicion pretende verificar que todos los pedidos esten en estado facturable. Debe validarse antes de generar parte de la transaccion en la linea 163 (VENTA)
        foreach ($conteo as $id_pedido => $conteo_estado) {
            if (!isset($conteo_estado[ESTADO_PEDIDO_TOMADO]) && !isset($conteo_estado[ESTADO_PEDIDO_SERVIDO])) {
                $resultado_pedido = $this->db->query("UPDATE pedido SET estado_id=" . ESTADO_FACTURADO . " WHERE id_pedido= " . $id_pedido, false);
                if (!$resultado_pedido) {
                    $mensaje = $this->nc->traer_mensaje_respuesta($this->ERROR_EDICION);
                    $this->nc->set_notificacion(utf8_encode($mensaje['descripcion']));
                }
                $pedidos_cerrados += 1;
            }
        }

        //CUENTA: ACTUALIZACION DE CUENTA PARA MARCARLA COMO CERRADA
        if (count($conteo) === $pedidos_cerrados) {
            $resultado_cuenta = $this->db->query("UPDATE cuenta SET estado_id=" . ESTADO_CUENTA_CERRADA . " WHERE id_cuenta= " . $id_cuenta, false);
            if (!$resultado_cuenta) {
                $mensaje = $this->nc->traer_mensaje_respuesta($this->ERROR_EDICION);
                $this->nc->set_notificacion(utf8_encode($mensaje['descripcion']));
            }
            $resultado_mesa = $this->db->query("UPDATE mesa SET estado_id=" . ESTADO_DISPONIBLE . " WHERE id_mesa=" . $id_mesa, false);
        }
        /* TRX: CALCULO DE DATOS COMPLEMENTARIOS */
        $total = 0;
        foreach ($items as $key => $value) {
            $total += $value['precio'] * $value['cantidad'];
        }

        /* TRX: ACTUALIZACION DE DATOS COMPLEMENTARIOS */
        //$resultado_update_transaccion = $this->db->query("UPDATE transaccion SET total='" . $total . "' WHERE id_transaccion= " . $transaccion_id, false);

        /* TRX: Consulta de datos de transaccion */
        $campos = array('ti.producto_id', 'ti.id_transaccion_item as id_pedido_item', 'p.nombre_corto', 'ti.cantidad', 'p.precio');
        $tables = "transaccion_item ti,transaccion t,producto p";
        $transacciones = $this->db->select($campos, $tables, 'ti.transaccion_id=t.id_transaccion '
                . ' AND ti.estado_id=' . ESTADO_ACTIVO
                . ' AND p.id_producto=ti.producto_id '
                . ' AND t.estado_id=' . ESTADO_ACTIVO . ' '
                . ' AND id_transaccion=' . $transaccion_id
                , 'id_transaccion_item', false, false);

        $info_negocio = $this->db->selectOne(
                'CONCAT(nombre,apellido) AS negocio,num_documento,direccion,telefono', 'fw_interlocutor', 'id_interlocutor=' . $interlocutor_actual
        );

        $inf_neg = array();
        $transa = array();
        foreach ($info_negocio as $key => $value) {
            array_push($inf_neg, $value);
        }

        foreach ($transacciones as $key => $value) {
            foreach ($value as $k => $v) {
                if ($k != 'id_pedido_item' && $k != 'producto_id') {
                    array_push($transa, $v);
                }
            }
        }

        $this->tipo_contenido = self::TYPE_AJAX_PART;

        //$this->crear_factura($id_mesa, $transaccion_id);
        header("location:?opcion=".$this->modulo."&a=crear_factura&id_mesa=".$id_mesa."&transaccion=".$transaccion_id."&type=ajax_part");
        //header('location:?opcion=facturar&type=html');
        //require_once('app/pack/transaccion/facturar/view/factura.html.php');
        //FacturaHTML::mostrar_factura($this->modulo, $cuenta, $pedidos, $pedidos_detalle, $total, 1, $id_mesa);
    }
    function validar_mesa_facturable(){
        $interlocutor_actual = $this->gn->get_data_loged('id_interlocutor');
        $parametros = $this->gn->traer_parametros('POST');
        $id_cuenta = $parametros->id_cuenta;
        
        /* VALIDACION: Todos los pedidos deben estar despachados */
        $pedidos = $this->appQry->ejecutarQuery('consultar_pedidos_x_cuenta', array('id_cuenta' => $id_cuenta, 'estado_id' => "(" . ESTADO_PEDIDO_TOMADO . "," . ESTADO_PEDIDO_SERVIDO . ")", 'id_owner' => $interlocutor_actual));
        //$pedidos = $this->appQry->ejecutarQuery('consultar_pedidos_detalle_x_cuenta', array('id_cuenta' => $id_cuenta));
        $total_items = array();
        foreach ($pedidos as $pedido) {
            $detalle = $this->appQry->ejecutarQuery('consultar_pedido_detalle_x_pedido_estado', array('id_pedido' => $pedido['id_pedido'], 'id_owner' => $interlocutor_actual));
            $pedidos_detalle[$pedido['id_pedido']] = $detalle;

            if (isset($detalle)) {
                foreach ($detalle as $item) {
                    if (!isset($total_items[$item['estado_id']])) {
                        $total_items[$item['estado_id']] = 0;
                    }
                    $total_items[$item['estado_id']] += 1;
                }
            }
        }

        if (isset($total_items[ESTADO_PEDIDO_TOMADO]) && ($total_items[ESTADO_PEDIDO_TOMADO] > 0)) {
            return 'Aún no puede facturar esta mesa. Tiene pedidos pendientes';
        }else{
            return 1;
        }
    }
    function crear_factura() {
        $parametros = $this->gn->traer_parametros('GET');
        if(isset($parametros->id_mesa)){
            $id_mesa = $parametros->id_mesa;
        }
        $id_transaccion = $parametros->transaccion;
        
        $id_interlocutor = $this->gn->get_data_loged('id_interlocutor');
        $info_negocio = $this->db->selectOne('concat(nombre," ",apellido) as negocio,num_documento,direccion,telefono', 'fw_interlocutor', 'id_interlocutor=' . $id_interlocutor);
        
        
        $transaccion = $this->db->selectOne(
                array('t.fecha', "t.id_transaccion", "t.cuenta_id","t.factura_numero","t.servicio", "t.descuento","t.total", "c.punto_atencion_id AS mesa_id"), 
                'transaccion t, cuenta c',
                ' t.cuenta_id = c.id_cuenta'
                . ' AND t.id_transaccion=' . $id_transaccion);
        
        if(!isset($parametros->id_mesa)){
            $id_mesa = $transaccion['mesa_id'];
        }
        
        $info_mesa = $this->db->selectOne('concat(nombre," ") as mesa', 'mesa', 'id_mesa=' . $id_mesa);
        
        $transacciones = $this->db->select(array('p.nombre_corto AS producto, ti.cantidad, ti.valor_unitario, (ti.cantidad*ti.valor_unitario) AS valor'),
                'transaccion t, transaccion_item ti, producto p ',
                ' t.id_transaccion = ti.transaccion_id AND ti.producto_id = p.id_producto AND t.id_transaccion = ' . $id_transaccion,
                false, false, false, false);
        
        $consecutivo = $id_transaccion;
        
        $impresion = ' 
        <html>       
            <head>
                <title></title>
            </head>
        <body>
        <p>FACTURA No- ' . $consecutivo . '</p>
        <p>-----------------------------------------</p>
        <table style"border:1px dashed">
        <tr>
            <td colspan="2" style="text-align:center; font-size:30px;">' . $info_negocio['negocio'] .'</td>
        </tr>
        <tr>
            <th>NIT</th>
            <td>' . $info_negocio['num_documento'] . '</td>
        </tr>
        <tr>
            <th>Direcci&oacute;n</th>
            <td>' . $info_negocio['direccion'] . '</td>
        </tr>
        <tr>
            <th>Tel&eacute;fono</th>
            <td>' . $info_negocio['telefono'] . '</td>
        </tr>
        <tr>
            <th>Fecha</th>
            <td>' . $transaccion['fecha'] . '</td>
        </tr>
        <tr>
            <th>Mesa</th>
            <td>' . $info_mesa['mesa'] . '</td>
        </tr>
        </table>
        <br>
        <table id="factura_print_detalle" style"border:1px dashed">
        <tr>
            <th>Descripci&oacute;n</th>
            <th>Cantidad</th>
            <th>Valor</th>
            <th>Subtotal</th>
        </tr>';
        $total = 0;
        foreach ($transacciones as $key => $trx) {
            $impresion .= '<tr>';
           $total += $trx['valor'];
            foreach ($trx as $k => $v) {
                $impresion .= '<td>';
                if($k == 'valor' || $k == 'valor_unitario'){
                    $v = "$".number_format($v);
                }
                $impresion .= $v;
                $impresion .= '</td>';
            }
            $impresion .= '</tr>';
        }

        $impresion .= '</tr> 
            <tr>
                <th></th>
                <th>Servicio </th>
                <th colspan="2" style="text-align:right;">$'. number_format($transaccion['servicio']).' </th>
            </tr>
            <tr>
                <th></th>
                <th>TOTAL </th>
                <th colspan="2" style="text-align:right;">$'. number_format($total+$transaccion['servicio']-$transaccion['descuento']).' </th>
            </tr>
            
        </table>        
        <p>-----------------------------------------</p>
		<table >        
			 <tr>
				<td colspan="4">Reg. simplificado del impuesto al consumo</td>
			</tr>
			<tr>
            	<td colspan="5" style="font-size:10px; text-align:justify;width: 200px;">
					<br>------------ADVERTENCIA DE PROPINA--------------
					<br>Establecimiento de comercio sugiere una propina correspondiente al 10% del valor de la cuenta, el cual podra ser aceptado, rechazado o modificado por ud, de acuerdo con su valoracion del servicio
					prestado. Al momento de solicitar la cuenta, indiquele a la persona que lo atiende si quiere que dicho valor sea o no incluido en la factura.
					En caso de algun inconveniente con el cobro de la 
					propina, comuniquese con la super intendencia de 
					industria y comercio
					linea gratuita nacional 018000910165.
				</td>
			</tr>
        </table>
        <br><br>
        <a class="nover" onclick="window.print();">IMPRIMIR</</a>
        </html>
		<style type="text/css" media="print">
			.nover {
				display:none;
			}
			table#factura_print_detalle tr td{
				padding: 2px 5px;
			}
		</style>
		';
        $factura = utf8_encode($impresion);
        //$this->gn->set_data_loged('factura', $factura);
        print_r($factura);
        //$this->imprimir_pdf();
        exit;
    }

    function imprimir_pdf() {
        $factura = $this->gn->get_data_loged('factura');
        require_once('fw/lib/plugin/_inc/dompdf/dompdf_config.inc.php');
        $dompdf = new DOMPDF();
        $dompdf->load_html($factura);
        $dompdf->render();
        ini_set("memory_limit", "128M");
        $dompdf->stream("factura.pdf");
    }

    function imprimir() {
        $factura = $this->gn->get_data_loged('factura');
        print_r($factura);
    }
    function traer_factura_numero() {
        $id_interlocutor = $this->gn->get_data_loged('id_interlocutor');
        $campos = array('factura_actual');
        $tables = "factura_numeracion";
        $factura_actual = $this->db->select($campos, $tables, ' interlocutor_id = ' . $id_interlocutor . " AND estado_id = 18");
        if (!isset($factura_actual)) {
            return 0;
        }
        return $factura_actual['factura_numero'];
    }

    function generar_factura_numero() {
        $id_interlocutor = $this->gn->get_data_loged('id_interlocutor');
        $actual = $this->traer_factura_numero();
        if ($actual == 0) {
            return 0;
        }

        $actual = $actual + 1;
        $campos = array('factura_actual' => $actual);
        $tables = "factura_numeracion";
        $factura_actual = $this->db->update($campos, $tables, ' interlocutor_id = ' . $id_interlocutor . " AND estado_id = 18");
        return $actual;
    }

    function generar_transaccion($id_cuenta, $items) {
        $id_transaccion = $this->crear_transaccion($id_cuenta);
        if (!$id_transaccion) {
            $mensaje = $this->nc->traer_mensaje_respuesta($this->ERROR_CREACION);
            $this->nc->set_notificacion(utf8_encode($mensaje['descripcion']));
        }

        foreach ($items as $item) {
            $this->crear_transaccion_item($id_transaccion, $item);
            //TODO: organizar control de inventario
            //$update = $this->db->query('UPDATE producto_stock SET stock = stock - ' . $value['cantidad'] . ' WHERE producto_id = ' . $value['producto_id'], true);
        }
        return $id_transaccion;
    }

    function crear_transaccion($id_cuenta) {
        $id_usuario = $this->gn->get_data_loged('id_usuario');
        $interlocutor_actual = $this->gn->get_data_loged('id_interlocutor');

        $factura_numero = $this->generar_factura_numero();
        $campos = array(
            'transaccion_tipo_id' => TRX_VENTA,
            "cuenta_id" => $id_cuenta,
            "responsable_id" => $id_usuario,
            "interlocutor_id" => $interlocutor_actual,
            'factura_numero' => $factura_numero,
            "estado_id" => ESTADO_ACTIVO
        );
        $transaccion_insert = $this->db->insert($campos, 'transaccion');
        if (!$transaccion_insert) {
            return false;
        }
        $transaccion_id = $this->db->insertId();
        return $transaccion_id;
    }

    function crear_transaccion_item($transaccion_id, $item) {
        $campos = array(
            'transaccion_id' => $transaccion_id,
            'pedido_item_id' => $item['id_pedido_item'],
            'producto_id' => $item['id_producto'],
            "cantidad" => $item['cantidad'],
            "valor_unitario" => $item['precio'],
            "iva" => 0,
            "estado_id" => ESTADO_ACTIVO
        );
        $resultado_insert = $this->db->insert($campos, 'transaccion_item');
        if ($resultado_insert) {
            $resultado_update_pedido_item = $this->db->query("UPDATE pedido_item SET estado_id=" . ESTADO_FACTURADO . " WHERE id_pedido_item= " . $item['id_pedido_item'], false);
        }
        return $resultado_insert;
    }

    function pintar_mesas($campos, $tablas, $modulo = '') {
        $id_interlocutor = $this->gn->get_data_loged('id_interlocutor');
        $campos = array('id_mesa', 'nombre', 'mesa_id', 'descripcion', 'estado_id', 'mesero_id', 'orden');
        $mesas = $this->db->select($campos, 'mesa', 'estado_id ='.ESTADO_OCUPADO.' AND interlocutor_id=' . $id_interlocutor, 'id_mesa', false, false);
        $observaciones = $this->db->select(array('id_observacion', 'nombre'), 'observacion', '', 'orden', false, false);
        $tema_interlocutor = $this->db->selectOne('t.descripcion', 'fw_tema t,fw_interlocutor_condicion i', 'i.tema_id=t.id_tema and i.interlocutor_id=' . $id_interlocutor);

        require_once 'app/pack/pedido/mesa/view/mesa.html.php';
        mesaHTML::home($mesas, $tema_interlocutor['descripcion'], $modulo, $observaciones);
    }

    function generarPdf($empresa, $transaccion, $productos, $productos_cantidad, $cliente = null) {
        $factura_altura = 80 + ($productos_cantidad * 5);
        $factura_productos = "";
        foreach ($productos as $item) {
            $item['producto2'] = substr($item['producto2'], 0, 16);
            $subtotal = $item['valor_unitario'] * $item['cantidad'];
            $transaccion['total'] += ($item['valor_unitario'] * $item['cantidad']);

            $subtotal_aux = '.....';

            while (strlen($item['producto2']) < 26) {
                $item['producto2'] .= '.';
            }
            $factura_productos .= "" . $item['producto2'] . "  " . $item['cantidad'] . "    " . $subtotal_aux . " $" . number_format($subtotal) . "\n";
            //$transaccion['total'] += $transaccion['subtotal'];
        }


        $factura_cabecera = "";
        //$factura_cabecera = "Nit: ".$empresa['NIT'] . "\n".
        //                   "Tel: ".$empresa['telefono'] . "\n\n";

        $factura_cabecera_cliente = "";
        //$factura_cabecera_cliente = "Cliente:        ".$cliente['nombre']."\n". 
        //                            "CC/Nit:         ".$cliente['documento']." "."\n";

        $factura_cabecera_prod = "   CONCEPTO                    CANT.    TOTAL    " . "\n";

        $factura_footer = " TOTAL           $ " . number_format($transaccion['total']) . "\n";

        require_once 'fw/lib/class/wis_pdf.php';

        $pdf = new wis_pdf('P', 'mm', array(80, $factura_altura));

        $pdf->SetMargins(4, 3);
        $pdf->AddPage();
        $pdf->SetFont('Arial', '', 14);
        //$pdf->Cell(70, 5, $empresa['empresa'], 0, 2, "C");

        $pdf->SetFont('Arial', '', 9);
        $pdf->MultiCell(70, 4, utf8_decode($factura_cabecera), 0, "C", false);

        $datos = utf8_decode("Factura No.:       " . $transaccion['factura_numero'] . "\n" . "Fecha:  2016/05/20");
        $pdf->MultiCell(70, 4, $datos, 0, "C", false);

        $pdf->MultiCell(70, 5, utf8_decode($factura_cabecera_cliente), 0, "J", false);

        $pdf->SetFont('Arial', '', 8);
        $pdf->MultiCell(70, 5, utf8_decode($factura_cabecera_prod), 1, "J", false);
        $pdf->MultiCell(70, 5, utf8_decode($factura_productos . "\n"), 1, "J", false);
        $pdf->MultiCell(70, 5, utf8_decode($factura_footer), 1, "C", false);
        /* DATOS WIS */
        $pdf->SetFont('Arial', '', 5);
        $pdf->Cell(70, 4, utf8_decode('By  WIS S.A.S. www.wisgroup.com.co'), 0, 2, "R");

        $pdf->autoprint(true);
        echo " TEST 3";
        $pdf->Output();
        echo " TEST 4";
    }

    function traer_zonas() {
        $interlocutor_id_actual = $this->gn->get_data_loged('id_interlocutor'); //id del Interlocutor actual
        $campos = array("m.id_mesa", "m.nombre as mesa", "est.descripcion");
        $tables = 'mesa m, fw_estado est';
        $condicion = " m.estado_id=est.id_estado "
                . " AND m.mesa_id = 0 "
                . " AND m.interlocutor_id=$interlocutor_id_actual";
        $zonas = $this->db->select($campos, $tables, $condicion, 'm.id_mesa', false, false);
        return $zonas;
    }
    

}
/*
 * <br>-------------GRACIAS POR SU COMPRA--------------
        <br>------------ADVERTENCIA DE PROPINA--------------
        <br>Establecimiento de comercio sugiere una propina
        <br>correspondiente al 10% del valor de la cuenta,
        <br>el cual podra ser aceptado, rechazado o modificado
        <br>por ud, de acuerdo con su valoracion del servicio
        <br>prestado.
        <br>Al momento de solicitar la cuenta, indiquele a la 
        <br>persona que lo atiende si quiere que dicho valor
        <br>sea o no incluido en la factura.
        <br>En caso de algun inconveniente con el cobro de la 
        <br>propina, comuniquese con la super intendencia de 
        <br>industria y comercio
        <br>linea gratuita nacional 018000910165.
        <br>-------------------------------------
 */