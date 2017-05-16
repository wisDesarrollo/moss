<?php

class ProductoCategoria extends Maestro {
    public $tipo_contenido = 'html';    
    public function __construct($db = "", $modulo = "") {
        $this->modulo = $this->traer_nombre(__CLASS__);
        $this->nombre_tabla = $this->modulo;
        $this->primary_key = 'id_' . $this->modulo;
        $this->actualizacion_ajax='ajax';        
        parent::__construct($db, $this->modulo);
        $clase = $this->gn->get_data_loged('clase'); 
        $marcablanca=$this->gn->get_data_loged('marca_blanca'); 
        $id_usuario1 = $this->gn->get_data_loged('id_usuario');
        $id_usuario=str_pad($id_usuario1, 10, "0", STR_PAD_LEFT); 
        $campos_formulario['id_producto_categoria'] = array('tipo' => 'hidden', 'valor' => '', 'complemento' => 'required', 'label' => 'id');
        $campos_formulario['usuario_perfil_id'] = array('tipo' => 'select', 'valor' => '0','inicial'=>'0','tag' => 'select', 'label'=>'Punto Atención',
            'tabla'=>'fw_usuario_perfil up',
            'value'=>'up.id_usuario_perfil',
            'campo' => 'up.nombre',
            'condicion' => 'up.estado_id ='.self::ESTADO_ACTIVO." ");
        $campos_formulario['nombre'] = array('tipo' => 'text', 'valor' => '', 'complemento' => 'required');        
        $campos_formulario['orden'] = array('tipo' => 'number', 'valor' => '');
        $campos_formulario['descripcion'] = array('tipo' => 'textarea', 'valor' => '', 'complemento' => 'required','tag'=>'textarea'); 
        $campos_formulario['icon_id'] = array('tipo' => 'select', 'valor' => '1','tag' => 'select', 'label'=>'Ícono',
            'tabla'=>'fw_icons fi',
            'value'=>'fi.id_icon',
            'campo' => 'fi.nombre',
            'condicion' => 'fi.estado_id ='.self::ESTADO_ACTIVO." AND fi.nombre <> ''");
        $campos_formulario['usuario_id'] = array('tipo' => 'hidden', 'valor' => $id_usuario,'complemento' => 'required');
        $campos_formulario['marca_blanca'] = array('tipo' => 'hidden', 'valor' =>$marcablanca ,'complemento' => 'required');
        $this->campos_formulario = $campos_formulario;
    }

    function home() {
        $prefijo = $this->prefijo;
        $id_usuario = $this->gn->get_data_loged('id_usuario'); //id del Interlocutor actual
        $marcablanca=$this->gn->get_data_loged('marca_blanca');
        $campos = array('pc.'.$this->primary_key." AS empty", 'pc.nombre AS nombre','pc.descripcion AS `Descripci&oacute;n`','pc.orden AS Orden','est.id_estado as Estado');
        $tablas = $this->nombre_tabla . ' pc,  fw_estado est';
        $condicion = "pc.estado_id=est.id_estado "
                . " AND pc.estado_id <>" . self::ESTADO_ELIMINADO. ' '
                . ' AND pc.marca_blanca='.$marcablanca.' ORDER BY pc.orden';
        $checkbox=array('id_estado');
        $this->iniciar_maestro($campos, $tablas,$condicion,'', $checkbox,$this->modulo,$this->nombre_tabla);         
    }

    
    function formulario_edicion($campos_formulario = null) {
        $this->tipo_contenido = '';
        $parametros = $this->gn->traer_parametros('GET');
		if ($campos_formulario === null) {
			$campos_formulario = $this->campos_formulario;
		}
        
        $accion = "guardar_creacion";
        $encabezado = "Crear Categoria";
        if (isset($parametros->id) && (int) $parametros->id > 0) { 
            $accion = "guardar_edicion&type=html";
            $campos=array();
            foreach ($campos_formulario as $key => $input){
                    array_push($campos,$key);  //Setea el array con le nombre de los campos
            }
            $elemento = $this->db->selectone($campos,$this->nombre_tabla, $parametros->id.' = id_' .$this->nombre_tabla); //Obtiene el valor de los campos de la tabla en  bd
            $encabezado = $parametros->id . '. ' . $elemento['nombre'];
            foreach ($elemento as $key => $value) {
                    $campos_formulario[$key]['valor'] = $value;    //Guardando el valor del input en el array $campos_formulario
            }
        }
        require_once(PATH_PLUGIN_MAESTRO_VIEW2);
        FormHTML::formulario_dinamico($campos_formulario, $accion, $this->modulo, $this->db,'', $campos_personalizados=array(), $parametros,$retorno='',$encabezado,'',$this->actualizacion_ajax);
    }
    function guardar_creacion($redirect = true, $parametros = null, $last_id = 0) {
        
        $this->tipo_contenido = '';
        
        if(is_null($parametros)){
            $parametros = $this->gn->traer_parametros('POST');
        }
        
        $params_get = $this->gn->traer_parametros('GET');
        $id_tabla = 'id_' . $this->nombre_tabla;
        unset($parametros->$id_tabla);
        $campos = array();

        foreach ($parametros as $key => $value) {
            $campos[$key] = $value;
        }
        
        $log = $this->registrar_log(self::LOG_CREAR,$this->nombre_tabla,$campos);
        $respuesta_edicion = $this->db->insert($campos,$this->nombre_tabla);
       
        if (!$respuesta_edicion) {
            $mensaje = $this->nc->traer_mensaje_respuesta($this->ERROR_CREACION);
            $this->nc->set_notificacion(utf8_encode($mensaje['descripcion']));
        }else{
            $last_id = $this->db->insertId();
            $mensaje = $this->nc->traer_mensaje_respuesta($this->EXITO_CREACION);
            $this->nc->set_notificacion(utf8_encode($mensaje['descripcion']));
        }

        if(!$redirect){
			if ($last_id>0) { return $last_id; } 
			else { header('location:?opcion=' . $this->modulo); }
		}

		$retorno = $this->gn->get_data_loged('retorno');

		if (isset($retorno) && $retorno!='') {
			$this->gn->set_data_loged('retorno','');
			$campo = $this->gn->get_data_loged('campo');
			$this->gn->set_data_loged('campo','');
			$this->gn->set_data_loged($campo,$last_id);
			header('location:?opcion='.$retorno);
		}else{
			if ($this->actualizacion_ajax=='ajax') {
				$this->tipo_contenido='html';
				$this->home();
			}else{
				header('location:?opcion=' . $this->modulo.'&type=html');
			}
		}
    }    
}