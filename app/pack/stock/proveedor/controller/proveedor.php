<?php

class proveedor2 extends Maestro{

    public $tipo_contenido = self::TYPE_HTML;
    private $clase_maestro = '3';
            
    public function __construct($db = "", $modulo = "") {
        $this->modulo = strtolower(__CLASS__);
        $this->nombre_tabla = 'fw_interlocutor';
        $this->primary_key = 'id_interlocutor';
        
        $this->actualizacion_ajax=self::TYPE_AJAX;
        parent::__construct($db, $this->modulo);
        $campos_formulario[$this->primary_key] = array('tipo' => 'hidden', 'valor' => '', 'complemento' => 'required', 'campo' => 'descripcion', 'label' => 'id');
        $campos_formulario['interlocutor_clase_id'] = array('tipo' => 'hidden', 'valor' => $this->clase_maestro, 'complemento' => 'required');
        $campos_formulario['nombre'] = array('tipo' => 'text', 'valor' => '', 'complemento' => 'required');
		$campos_formulario['apellido'] = array('tipo' => 'text', 'valor' => '', 'complemento' => 'required');
        $campos_formulario['num_documento'] = array('label' => 'Cedula', 'tipo' => 'text', 'valor' => '', 'complemento' => 'required');
        $campos_formulario['direccion'] = array('tipo' => 'text', 'valor' => '', 'complemento' => "");
        $campos_formulario['telefono'] = array('tipo' => 'number', 'valor' => '', 'complemento' => 'required minlength="7" maxlength="10"');
        $campos_formulario['celular'] = array('tipo' => 'number', 'valor' => '', 'complemento' => 'minlength="10" maxlength="15"');
		$campos_formulario['email'] = array('tipo' => 'email', 'valor' => '', 'complemento' => "");
        $campos_formulario['estado_id'] = array('tipo' => 'hidden', 'valor' => '1');
        $this->campos_formulario = $campos_formulario;
    }

    function home() {
        $interlocutor_id_actual = $this->gn->get_data_loged('id_interlocutor'); //id del Interlocutor actual
        $tablas = $this->nombre_tabla . ' i, fw_estado est';
        $campos = array('i.'.$this->primary_key." AS empty", 'CONCAT(i.nombre, " ", i.apellido) AS nombre','i.num_documento AS documento', "i.telefono AS `Teléfono`");
        $condicion = "i.estado_id=est.id_estado AND interlocutor_clase_id= ".$this->clase_maestro." AND i.estado_id <>" . self::ESTADO_ELIMINADO." AND i.interlocutor_id = ".$interlocutor_id_actual;
        $order= "";
        $this->iniciar_maestro($campos, $tablas,$condicion,'',$order);
    }
   
    function formulario_edicion($campos_formulario = null) {
        $this->tipo_contenido = '';
        $parametros = $this->gn->traer_parametros('GET');
		if ($campos_formulario === null) {
			$campos_formulario = $this->campos_formulario;
		}
        
        $accion = "guardar_creacion";
        $encabezado = "Crear Proveedor";

        if (isset($parametros->id) && (int) $parametros->id > 0) {
            $accion = "guardar_edicion";
            $campos=array();
            foreach ($campos_formulario as $nombre_campo => $input){
                array_push($campos,$nombre_campo);  //llena el array con le nombre de los campos
            }
            $elemento = $this->db->selectone($campos,$this->nombre_tabla, $parametros->id.' = ' .$this->primary_key); //Obtiene el valor de los campos de la tabla en  bd
            $encabezado = $parametros->id . ' ' . $elemento['nombre'] . ' ' . $elemento['apellido'];
            foreach ($elemento as $key => $value) {
                $campos_formulario[$key]['valor'] = $value;    //Guardando el valor del input en el array $campos_formulario
            }
        }else{
            unset($campos_formulario['id_interlocutor']);
        }
        require_once(PATH_PLUGIN_MAESTRO_VIEW2);
        FormHTML::formulario_dinamico($campos_formulario, $accion, $this->modulo, $this->db,'', $campos_personalizados=array(), $parametros,$retorno='',$encabezado,'',$this->actualizacion_ajax);
    }
}