<?php

Class Transacciones {
    /* @var Mysql */

    private $db;
    private $stock;
    private $appQry;

    function __construct($db) {
        $this->db = $db;

        require_once('stock.class.php');
        $this->stock = new Stock($this->db);
        require_once 'modelo/app_queries/app_control_queries.class.php';
        $this->appQry = new AppControlQueries($this->db);
    }

    public function numeracion_factura($interlocutor) {

        $factura = $this->db->selectOne(array('id_factura_numeracion', 'factura_actual'), 'factura_numeracion', 'estado_id =' . ESTADO_VIGENTE . ' '
                . ' AND interlocutor_id = ' . $interlocutor
        );

        if (!$factura) {
            return false;
        }

        $numeracion = $factura['factura_actual'] + 1;
        $this->db->update(array('factura_actual' => $numeracion), 'factura_numeracion', 'id_factura_numeracion = ' . $factura['id_factura_numeracion']);

        return $numeracion;
    }

    public function venta($factura, $interlocutor, $cliente, $observacion, $productos, $cuenta_id = 0, $servicio = 0, $descuento = 0) {

        if($descuento > 0){
            $datos_descuento = $this->appQry->ejecutarQuery('consultar_descuentos_owner_id', array('id_descuento' => $descuento));
        }
        $datos_transaccion = array(
            "factura_numero" => $factura,
            "cuenta_id" => $cuenta_id,
            "transaccion_tipo_id" => TRX_VENTA,
            "interlocutor_externo" => $cliente,
            "interlocutor_id" => $interlocutor,
            "observacion" => $observacion,
            "servicio" => $servicio,
            "descuento_porcentaje" => $datos_descuento['descuento'],
            "estado_id" => ESTADO_ACTIVO
        );

        $id_transaccion = $this->registrar_transaccion($datos_transaccion);
        $total = 0;
		
        if ($id_transaccion) {
            foreach ($productos as $id_producto => $producto) {
                if ($id_producto > 0) {
                    $this->db->insert(
                            array(
                        'transaccion_id' => $id_transaccion,
                        'producto_id' => $producto['id_producto'],
                        'cantidad' => $producto['cantidad'],
                        'valor_unitario' => $producto['precio'],
                        'iva' => $producto['iva'],
                        'estado_id' => ESTADO_ACTIVO
                            ), 'transaccion_item'
                    );
                    $total += ($producto['cantidad'] * $producto['precio']);

                    $this->stock->actualizar_stock($id_producto, $producto['cantidad'], ' - ');
                }
            }
            $campos = array(
                "descuento" => $total*($datos_descuento['descuento']/100),
                'total' => $total
            );
            $this->actualizar_transaccion($campos, $id_transaccion);
            $this->caja_actualizar('ventas', $total, '+', $interlocutor);
        }

        return $id_transaccion;
    }

    public function compra($interlocutor, $proveedor, $observacion, $productos) {
        //TODO: Verificar los datos que se envian para registrar transaccion
        $datos_transaccion = array(
            "transaccion_tipo_id" => TRX_COMPRA,
            "interlocutor_externo" => $proveedor,
            "interlocutor_id" => $interlocutor,
            "observacion" => $observacion,
            "estado_id" => ESTADO_ACTIVO);

        $id_transaccion = $this->registrar_transaccion($datos_transaccion);

        if ($id_transaccion) {
            $total = 0;
            foreach ($productos as $id_producto => $producto) {

                $datos_transaccion_item = array(
                    'transaccion_id' => $id_transaccion,
                    'producto_id' => $id_producto,
                    'cantidad' => $producto->cantidad,
                    'valor_unitario' => $producto->valor,
                    'iva' => $producto->iva,
                    'estado_id' => ESTADO_ACTIVO);

                $id_transaccion_item = $this->registrar_transaccion_item($datos_transaccion_item);
                $total = $total + ($producto->valor * $producto->cantidad);

                $this->stock->actualizar_stock($id_producto, $producto->cantidad, ' + ');
                //$resultado_update_transaccion = $this->db->query("UPDATE transaccion SET total='" . $total . "' WHERE id_transaccion= " . $id_transaccion, false);
            }
            $campos = array(
                'total' => $total
            );
            $this->actualizar_transaccion($campos, $id_transaccion);
            $this->caja_actualizar('compras', $total, '-', $interlocutor);
        }

        return $id_transaccion;
    }

    public function registrar_transaccion($campos) {
        $insert = $this->db->insert($campos, 'transaccion', false);
        if ($insert) {
            $id = $this->db->insertId();
            return $id;
        } else {
            return false;
        }
    }

    public function registrar_transaccion_item($campos) {
        $insert = $this->db->insert($campos, 'transaccion_item');
        if ($insert) {
            $id = $this->db->insertId();
            return $id;
        } else {
            return false;
        }
    }

    public function actualizar_transaccion($campos, $id) {
        $result = $this->db->update($campos, 'transaccion', " id_transaccion = " . $id);
        return $result;
    }

    public function caja_actualizar($campo, $valor, $operacion, $owner = null) {

        $campos = array(
            $campo => $campo . ' + ' . $valor,
            'caja' => ' caja ' . $operacion . ' ' . $valor
        );

        $condicion = " estado_id = " . ESTADO_VIGENTE
                . " AND interlocutor_id = " . $owner;
        $result = $this->db->update_number($campos, 'caja', $condicion, false, false);
        return $result;
    }

}
