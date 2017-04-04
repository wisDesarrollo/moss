<?php

class Observacion extends Maestro {

    public $tipo_contenido = 'html';    
    public function __construct($db = "", $modulo = "") {

        $this->modulo = strtolower(__CLASS__);
        $this->nombre_tabla = strtolower(__CLASS__);
        $this->primary_key = 'id_' . strtolower(__CLASS__);
        $this->actualizacion_ajax='ajax';
        parent::__construct($db, $this->modulo);
        $clase = $this->gn->get_data_loged('clase');   
        $campos_formulario['id_observacion'] = array('tipo' => 'hidden', 'valor' => '', 'complemento' => 'required', 'label' => 'id');
        $campos_formulario['nombre'] = array('tipo' => 'text', 'valor' => '', 'complemento' => 'required');        
        $campos_formulario['orden'] = array('tipo' => 'hidden', 'valor' => '1', 'complemento' => 'required', 'campo' => 'descripcion', 'label' => 'orden');
        $this->campos_formulario = $campos_formulario;
    }

    function home() {
        $marcablanca=$this->gn->get_data_loged('marca_blanca');
        $interlocutor_id_actual = $this->gn->get_data_loged('id_interlocutor'); //id del Interlocutor actual
        $campos = array('o.'.$this->primary_key." as Codigo",'o.orden as Orden', 'o.nombre as nombre','est.id_estado as Estado');
        $tablas = $this->nombre_tabla . ' o, fw_estado est, fw_interlocutor_condicion ic';
        $condicion = "o.estado_id=est.id_estado AND o.interlocutor_id=$interlocutor_id_actual AND ic.interlocutor_id=o.interlocutor_id AND ic.marca_blanca=".$marcablanca." AND o.estado_id <>" . self::ESTADO_ELIMINADO;
        $checkbox=array('id_estado');
        $this->iniciar_maestro($campos, $tablas,$condicion,'', $checkbox=array(),$this->modulo,$this->nombre_tabla);
    }

    
    function formulario_edicion($campos_formulario = null) {
        $this->tipo_contenido = '';
        $parametros = $this->gn->traer_parametros('GET');
		if ($campos_formulario === null) {
			$campos_formulario = $this->campos_formulario;
		}
        
        $accion = "guardar_creacion&type=html";
        $encabezado = "Crear Observacion";
        if (isset($parametros->id) && (int) $parametros->id > 0) {            
            $accion = "guardar_edicion";
            $campos=array();
            foreach ($campos_formulario as $key => $input){
                    array_push($campos,$key);  //Setea el array con le nombre de los campos
            }
            $elemento = $this->db->selectone($campos,$this->nombre_tabla, $parametros->id.' = id_' .$this->nombre_tabla); //Obtiene el valor de los campos de la tabla en  bd
            $encabezado = $parametros->id . ': ' . $elemento['nombre'];
            foreach ($elemento as $key => $value) {
                    $campos_formulario[$key]['valor'] = $value;    //Guardando el valor del input en el array $campos_formulario
            }
        }
        require_once($this->ruta_cron . "fw/lib/plugin/maestro/view/maestro2.html.php");
        //MaestroHTML::formulario_dinamico($campos_formulario, $accion, $this->modulo, $this->db, '', '', '', $encabezado);
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
        $id_interlocutor=$this->gn->get_data_loged('id_interlocutor');
        $campos['interlocutor_id']=$id_interlocutor;
        
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
			if ($last_id>0) { 
				return $last_id;
			} else { 
				header('location:?opcion=' . $this->modulo); 
			}
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
				$this->home();
			}else{
				header('location:?opcion=' . $this->modulo);
			}
		}
    }
}