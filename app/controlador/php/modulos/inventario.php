<?php

require_once('fw/controlador/php/modulos/maestro.class.php');

class inventario extends Maestro {

    public $tipo_contenido = 'html';
    
   
    CONST COMPRAS = 3;

    public function __construct($db = "", $modulo = "") {

        $this->modulo = strtolower(__CLASS__);
        $this->nombre_tabla = strtolower(__CLASS__);
        $this->primary_key = 'id_' . strtolower(__CLASS__);
        $this->actualizacion_ajax='ajax';
        /*$this->EXITO_CREACION = "050";
        $this->EXITO_EDICION = "051";
        $this->EXITO_ELIMINAR = "052";*/

        parent::__construct($db, $this->modulo);
        $clase = $this->gn->get_data_loged('clase');   
        /*$marca_blanca = $this->gn->get_data_loged('marca_blanca') ;*/
    }

    function home() {
        $id_interlocutor=$this->gn->get_data_loged('id_interlocutor');
        $this->nombre_tabla = "producto";
        $interlocutor_id_actual = $this->gn->get_data_loged('id_interlocutor'); //id del Interlocutor actual
        $tablas = $this->nombre_tabla . ' pr, producto_stock ps, estado est';
        
        $campos = array('pr.nombre as Producto', 'ps.stock as cantidad');
     
        $condicion = "pr.estado_id = est.id_estado AND ps.producto_id = pr.id_producto "
                . " AND pr.interlocutor_id = ".$id_interlocutor." AND pr.estado_id <>" . self::ESTADO_ELIMINADO;
        //////condicion esperando respuesta  
        //$order= "orden";
        
        unset($this->herramientas);//alser reportes no son editables
        $this->iniciar_maestro_directo($campos, $tablas,$condicion,'');
        
    }

    
    function formulario_edicion() {
        require_once("fw/vista/html/maestro2.html.php");
        
        FormHTML::formulario_dinamico($campos_formulario, $accion, $this->modulo, $this->db,'', $campos_personalizados=array(), $parametros,$retorno='',$encabezado,'',$this->actualizacion_ajax);
    }

    
}