<?php

class TransaccionForm extends Operaciones {

    public function __construct($db = "", $modulo = "") {

        parent::__construct($db, $modulo);
        $this->tipo_contenido = 'ajax';
        $this->modulo = 'compras';
        $this->transaccion_tipo = self::COMPRA;
        $this->comercio_clase = self::PROVEEDOR;
        $this->encabezado = array('REFERENCIA', 'BARCODE', 'PRODUCTO', 'CANTIDAD', 'IVA', 'IVA INCLUIDO', 'COSTO', 'COSTO IVA', 'SUBTOTAL');
        $this->encabezado_flotante = array('ID', 'REFERENCIA', 'BARCODE','PRODUCTO', 'STOCK', 'COSTO', 'CANTIDAD', 'ADD');
    }

    function home($titulo = ''){
        parent::home(TITULO_COMPRAS_REGISTRO);
    }

    function registrar(){
        require_once 'fw/lib/class/transacciones.class.php';
        $transaccion = new Transacciones($this->db);
        $this->gn->set_data_loged('datos_trx', NULL);
        $id_interlocutor = $this->gn->get_data_loged('id_interlocutor');
        $post = $this->gn->traer_parametros('POST');
        $productos = array();
        $cliente = array();

        foreach ($post as $key => $value){
            if(substr($key, 0, 8) == 'cliente_'){
                $cliente[substr($key, 8)] = $value;
                unset($post->$key);
            }
        }
        
        $observacion = $cliente['observacion'];
        unset($cliente['observacion']);

        if($cliente['id_interlocutor'] == ''){
            require_once 'fw/pack/base/interlocutor/controller//interlocutor.php';
            $interlocutor = new Interlocutor($this->db, 'interlocutor');
            $cliente['interlocutor_id'] = $id_interlocutor;
            $cliente['interlocutor_clase_id'] = self::PROVEEDOR;
            $cliente['id_interlocutor'] = $interlocutor->guardar_interlocutor($cliente);
        }
        
        if(!isset($cliente['id_interlocutor']) || !($cliente['id_interlocutor'] > 0)){
            $this->nc->set_notificacion('Error al crear el proveedor');
            header('location:?opcion=' . $this->modulo);
            return;
        }
        
        foreach ($post as $item => $value){
            $item = explode('_', $item);
            $productos[$item[0]]->$item[1] = $value;
        }
        
        $venta = $transaccion->compra($id_interlocutor, $cliente['id_interlocutor'], $observacion, $productos);
        
        if(!$venta){
            $this->nc->set_notificacion('Error al registrar la compra' . serialize($venta));
            header('location:?opcion=' . $this->modulo);
            return;
        }

        $this->nc->set_notificacion('Compra registrada exitosamente');
        header('location:?opcion=' . $this->modulo);
        return;
    }

    function trx_agregar_producto($campo = 'costo') {
        parent::trx_agregar_producto($campo);
    }
}
