<?php

class mesa extends Maestro {

    public $tipo_contenido = 'html';

    public function __construct($db = "", $modulo = "") {
        $this->modulo = strtolower(__CLASS__);
        $this->nombre_tabla = strtolower(__CLASS__);
        $this->primary_key = 'id_' . strtolower(__CLASS__);
        $this->actualizacion_ajax = 'ajax';
        parent::__construct($db, $this->modulo);
        $clase = $this->gn->get_data_loged('clase');
        $interlocutor_id_actual = $this->gn->get_data_loged('id_interlocutor'); //id del Interlocutor actual
        $campos_formulario['id_mesa'] = array('tipo' => 'hidden', 'valor' => '', 'complemento' => 'required', 'label' => 'id');
        $campos_formulario['mesa_id'] = array('tipo' => 'select', 'valor' => '0', 'ninguno' => '0', 'inicial' => '-1', 'tag' => 'select', 'label' => 'Zona',
            'tabla' => 'mesa m',
            'value' => 'm.id_mesa',
            'campo' => 'CONCAT(" - ", m.nombre)',
            'condicion' => 'm.estado_id <>' . ESTADO_ELIMINADO . ""
            . " AND m.mesa_id = 0 "
            . " AND m.interlocutor_id = '$interlocutor_id_actual'");
        $campos_formulario['nombre'] = array('tipo' => 'text', 'valor' => '', 'complemento' => 'required');
        $campos_formulario['descripcion'] = array('tipo' => 'textarea', 'valor' => '');
        $campos_formulario['orden'] = array('tipo' => 'hidden', 'valor' => '1', 'complemento' => 'required', 'campo' => 'descripcion', 'label' => 'orden');
        $this->campos_formulario = $campos_formulario;
    }

    function home() {
        $marcablanca = $this->gn->get_data_loged('marca_blanca');
        $interlocutor_id_actual = $this->gn->get_data_loged('id_interlocutor'); //id del Interlocutor actual
        $campos = array('m.' . $this->primary_key . " AS empty", 'm.nombre as Mesa', 'm.descripcion as Descripcion', 'm.orden as Orden', 'est.id_estado as Estado');
        $tablas = $this->nombre_tabla . ' m, fw_estado est, fw_interlocutor_condicion ic';
        $condicion = "m.estado_id=est.id_estado "
                . " AND m.interlocutor_id=$interlocutor_id_actual "
                . " AND ic.interlocutor_id=m.interlocutor_id "
                . " AND ic.marca_blanca=" . $marcablanca . " "
                . " AND m.estado_id <>" . self::ESTADO_ELIMINADO;
        $checkbox = array('id_estado');
        $this->iniciar_maestro($campos, $tablas, $condicion, true, $checkbox = array(), $this->modulo, $this->nombre_tabla);
    }

    function guardar_creacion($redirect = true, $parametros = null, $last_id = 0) {

        $this->tipo_contenido = '';

        if (is_null($parametros)) {
            $parametros = $this->gn->traer_parametros('POST');
        }

        $params_get = $this->gn->traer_parametros('GET');
        $id_tabla = 'id_' . $this->nombre_tabla;
        unset($parametros->$id_tabla);
        $campos = array();

        foreach ($parametros as $key => $value) {
            $campos[$key] = $value;
        }
        $id_interlocutor = $this->gn->get_data_loged('id_interlocutor');
        $campos['interlocutor_id'] = $id_interlocutor;
        $log = $this->registrar_log(self::LOG_CREAR, $this->nombre_tabla, $campos);
        $respuesta_edicion = $this->db->insert($campos, $this->nombre_tabla);

        if (!$respuesta_edicion) {
            $mensaje = $this->nc->traer_mensaje_respuesta($this->ERROR_CREACION);
            $this->nc->set_notificacion(utf8_encode($mensaje['descripcion']));
        } else {
            $last_id = $this->db->insertId();
            $mensaje = $this->nc->traer_mensaje_respuesta($this->EXITO_CREACION);
            $this->nc->set_notificacion(utf8_encode($mensaje['descripcion']));
        }

        if (!$redirect) {

            if ($last_id > 0) {
                return $last_id;
            } else {
                header('location:?opcion=' . $this->modulo . '&type=html');
            }
        }

        $retorno = $this->gn->get_data_loged('retorno');

        if (isset($retorno) && $retorno != '') {
            $this->gn->set_data_loged('retorno', '');
            $campo = $this->gn->get_data_loged('campo');
            $this->gn->set_data_loged('campo', '');
            $this->gn->set_data_loged($campo, $last_id);

            header('location:?opcion=' . $retorno);
        } else {

            if ($this->actualizacion_ajax == 'ajax') {
                $this->home();
            } else {
                header('location:?opcion=' . $this->modulo . '&type=html');
            }
        }
    }

    //comentar el posible problema de actualizacion de mesas ya que trae info de la bd.
}
