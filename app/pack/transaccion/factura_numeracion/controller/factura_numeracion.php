<?php

class FacturaNumeracion extends Maestro {

    CONST WIDHT = "250";
    CONST HEIGHT = "250";

    public $tipo_contenido = 'html';

    public function __construct($db = "", $modulo = "") {
        $this->modulo = 'factura_numeracion';
        $this->nombre_tabla = $this->modulo;
        $this->primary_key = 'id_' . $this->modulo;
        $this->actualizacion_ajax = 'ajax';
        parent::__construct($db, $this->modulo);
        $id_interlocutor_actual = $this->gn->get_data_loged('id_interlocutor'); //id del Interlocutor actual
        $clase = $this->gn->get_data_loged('clase');
        $campos_formulario[$this->primary_key] = array('tipo' => 'hidden', 'valor' => '', 'complemento' => 'required', 'label' => 'id');
        $campos_formulario['resolucion_numero'] = array('tipo' => 'text', 'valor' => '', 'complemento' => '', 'label'=>'N&uacute;mero Resoluci&oacute;n');
        $campos_formulario['factura_actual'] = array('tipo' => 'number', 'valor' => '', 'complemento' => 'readonly');
        $campos_formulario['factura_minimo'] = array('tipo' => 'number', 'valor' => '', 'complemento' => 'required onchange=setFacturaActual();', 'label'=>'Factura M&iacute;nimo');
        $campos_formulario['factura_maximo'] = array('tipo' => 'number', 'valor' => '', 'complemento' => 'required', 'label'=>'Factura M&aacute;ximo');
        $campos_formulario['interlocutor_id'] = array('tipo' => 'hidden', 'valor' => $id_interlocutor_actual);
        
        $this->campos_formulario = $campos_formulario;
    }

    function home() {
        $interlocutor_id_actual = $this->gn->get_data_loged('id_interlocutor'); //id del Interlocutor actual        
        $campos = array('pr.' . $this->primary_key . " as Codigo", 'pr.factura_actual', 'pr.factura_minimo','pr.factura_maximo', 'est.descripcion as Estado');
        $tablas = $this->nombre_tabla . ' pr, fw_estado est';
        $condicion = "pr.estado_id=est.id_estado AND pr.interlocutor_id=$interlocutor_id_actual AND pr.estado_id <>" . self::ESTADO_ELIMINADO;
        $order = "";
        $this->iniciar_maestro($campos, $tablas, $condicion, '', $order);
    }

    function formulario_edicion($campos_formulario = null) {
        $this->tipo_contenido = '';
        $parametros = $this->gn->traer_parametros('GET');
		if ($campos_formulario === null) {
			$campos_formulario = $this->campos_formulario;
		}
        
        $accion = "guardar_creacion";
        $encabezado = "Crear Resolución";
        if (isset($parametros->id) && (int) $parametros->id > 0) {
            $accion = "guardar_edicion";
            $campos = array();
            foreach ($campos_formulario as $key => $input) {
                if ($key) {
                    array_push($campos, $key);  //Setea el array con le nombre de los campos
                }
            }
            $elemento = $this->db->selectone($campos, $this->nombre_tabla, $parametros->id . ' = id_' . $this->nombre_tabla); //Obtiene el valor de los campos de la tabla en  bd
            $encabezado = 'Edicion Producto';
            foreach ($elemento as $key => $value) {
                $campos_formulario[$key]['valor'] = $value;    //Guardando el valor del input en el array $campos_formulario
            }
        }
        require_once(PATH_PLUGIN_MAESTRO_VIEW2);
        FormHTML::formulario_dinamico($campos_formulario, $accion, $this->modulo, $this->db, '', $campos_personalizados = array(), $parametros, $retorno = '', $encabezado, '', $this->actualizacion_ajax);
    }

    function guardar_creacion($redirect = true, $parametros = null, $last_id = 0) {
        if (is_null($parametros)) {
			$parametros = $this->gn->traer_parametros('POST');
		}
		
        $interlocutor_id = $this->gn->get_data_loged('id_interlocutor'); //id del Interlocutor actual
        foreach ($parametros as $key => $value) {
            $campos[$key] = $value;
        }
        $stock = $campos['stock'];
        unset($campos['stock']);
        $campos['interlocutor_id'] = $interlocutor_id;
        $log = $this->registrar_log(self::LOG_CREAR, $this->nombre_tabla, $campos);
        $respuesta_insercion = $this->db->insert($campos, $this->nombre_tabla);
        if (!$respuesta_insercion) {
            $mensaje = $this->nc->traer_mensaje_respuesta($this->ERROR_CREACION);
            $this->nc->set_notificacion(utf8_encode($mensaje['descripcion']));
        } else {
            $last_id = $this->db->insertId();
            $mensaje = $this->nc->traer_mensaje_respuesta($this->EXITO_CREACION);
            $this->nc->set_notificacion(utf8_encode($mensaje['descripcion']));
        }
        $inserta_stock = $this->db->insert(array('producto_id' => $last_id, 'stock' => $stock), 'producto_stock');

        if (count($_FILES) != 0) {
            foreach ($_FILES as $nombre_archivo => $datos_archivo) {
                if ($_FILES[$nombre_archivo]['name'] === '') {
                    unset($_FILES[$nombre_archivo]);
                }
            }
            foreach ($_FILES as $nombre_archivo => $datos_archivo) {
                if ($datos_archivo && $datos_archivo !== '') {
                    $campos[$nombre_archivo] = str_replace(' ', '_', $datos_archivo['name']);
                    $datos_archivo['name'] = $campos[$nombre_archivo];
                }
            }
            if (isset($_FILES['imagen'])) {
                $id_producto = $last_id;
                $resultado = $this->gn->generar_imagenes($id_producto, $this->modulo, 'productos', self::WIDHT, self::HEIGHT, $_FILES['imagen']);
                $resultado_imagen = $this->db->update(array('imagen' => $campos['imagen']), 'producto', 'id_producto=' . $last_id);
                if (!$resultado_imagen) {
                    $mensaje = $this->nc->traer_mensaje_respuesta(self::ERROR_CREACION);
                    $this->nc->set_notificacion($mensaje['descripcion']);
                    header('location:?opcion=' . $this->modulo);
                    return;
                }
            }
        }
        $this->tipo_contenido = 'ajax';
        header('location:?opcion=' . $this->modulo."&type=html");
    }

    function guardar_edicion($redirect = true, $parametros = null) {
        $this->tipo_contenido = '';
        if (is_null($parametros)) {
            $parametros = $this->gn->traer_parametros('POST');
        }
        $param_get = $this->gn->traer_parametros('GET');
        $id_tabla = $this->primary_key;
        $id = $parametros->$id_tabla;
        $respuesta_edicion = $this->editar_elemento($parametros, $id, $this->nombre_tabla);
        if (isset($param_get->type)) {
            $this->tipo_contenido = $param_get->type;
        }
        if (!$respuesta_edicion) {
            $mensaje = $this->nc->traer_mensaje_respuesta($this->ERROR_EDICION);
            $this->nc->set_notificacion(utf8_encode($mensaje['descripcion']));
        } else {
            $mensaje = $this->nc->traer_mensaje_respuesta($this->EXITO_EDICION);
            $this->nc->set_notificacion(utf8_encode($mensaje['descripcion']));
        }
        if ($param_get->type === 'ajax') {
            echo 'OK';
        } else if (!$redirect) {
            return $respuesta_edicion;
        } else {
            if ($this->actualizacion_ajax == 'ajax') {
                $this->home();
            } else {
                header('location:?opcion=' . $this->modulo);
            }
        }
    }
}
