<?php

class inventarioReporte extends Maestro {

    public function __construct($db = "", $modulo = ""){
        $this->modulo = $modulo;
        $this->nombre_tabla = strtolower(__CLASS__);
        $this->primary_key = 'id_' . strtolower(__CLASS__);
        $this->actualizacion_ajax='ajax';
        
        parent::__construct($db, $this->modulo);
    }

    function home(){
        $id_interlocutor=$this->gn->get_data_loged('id_interlocutor');
        $this->nombre_tabla = "producto";
        $tablas = $this->nombre_tabla . ' pr, producto_stock ps, producto_categoria pc, fw_estado est';
        
        $campos = array(
            'pr.referencia AS Referencia', 
            'pr.barcode AS `Código de Barras`', 
            'pr.nombre AS Producto', 
            'pc.nombre AS `Categoría`', 
            'FORMAT(ps.stock,0) AS Cantidad',
            'ps.stock_minimo AS `Inventario Mínimo`',
            'ps.stock_maximo AS `Inventario Máximo`'
        );
     
        $condicion = " pr.estado_id = est.id_estado "
                . " AND ps.producto_id = pr.id_producto "
                . " AND pr.producto_categoria_id = pc.id_producto_categoria "
                . " AND pr.stock_control = '".SI."' "
                . " AND pr.interlocutor_id = ".$id_interlocutor." "
                . " AND pr.estado_id <>" . ESTADO_ELIMINADO;
        
        $this->herramientas = array();//alser reportes no son editables
        $this->iniciar_maestro($campos, $tablas,$condicion,'');
    }
    
    function formulario_edicion(){
        require_once("fw/vista/html/maestro2.html.php");
        FormHTML::formulario_dinamico($campos_formulario, $accion, $this->modulo, $this->db,'', $campos_personalizados=array(), $parametros,$retorno='',$encabezado,'',$this->actualizacion_ajax);
    }
}