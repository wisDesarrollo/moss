<?php
Class Producto extends Maestro {

    CONST WIDHT = "100";
    CONST HEIGHT = "100";
    CONST CARPETA = "app/vista/img/producto/";
    public $tipo_contenido = 'html';

    public function __construct($db = "", $modulo = "") {
        $this->modulo = strtolower(__CLASS__);
        $this->nombre_tabla = strtolower(__CLASS__);
        $this->primary_key = 'id_' . strtolower(__CLASS__);
        $this->actualizacion_ajax = 'ajax';
        parent::__construct($db, $this->modulo);
        $id_interlocutor_actual = $this->gn->get_data_loged('id_interlocutor'); //id del Interlocutor actual
        $id_usuario = $this->gn->get_data_loged('id_usuario');
        $marcablanca=$this->gn->get_data_loged('marca_blanca');
        $clase = $this->gn->get_data_loged('clase');
        $campos_formulario['id_producto'] = array('tipo' => 'hidden', 'valor' => '', 'complemento' => 'required', 'label' => 'id');
        $campos_formulario['nombre'] = array('tipo' => 'text', 'valor' => '', 'complemento' => 'required');
        $campos_formulario['nombre_corto'] = array('tipo' => 'text', 'valor' => '', 'complemento' => 'required');
        $campos_formulario['referencia'] = array('tipo' => 'text', 'valor' => '');
        $campos_formulario['barcode'] = array('tipo' => 'text', 'valor' => '', 'label'=>'Código de Barras');
        $campos_formulario['producto_categoria_id'] = array('tipo' => 'select', 'valor' => '','tag' => 'select', 'label'=>'Categoria',
                                                            'tabla'=>'producto_categoria pc, fw_usuario u, fw_interlocutor i, fw_interlocutor_condicion ic',
                                                            'value'=>'pc.id_producto_categoria',
                                                            'campo' => 'pc.nombre',
                                                            'condicion' => 'pc.estado_id ='.self::ESTADO_ACTIVO."                                                                             
                                                                            AND pc.usuario_id=$id_usuario AND pc.usuario_id=u.id_usuario AND u.interlocutor_id=i.id_interlocutor AND ic.interlocutor_id=i.id_interlocutor AND ic.marca_blanca= $marcablanca");
        $campos_formulario['iva'] = array('tipo' => 'number', 'valor' => '16', 'complemento' => 'required', 'label' => 'IVA');
        $campos_formulario['precio'] = array('tipo' => 'number', 'valor' => '0', 'complemento' => 'required', 'label' => 'Valor Venta');
        $campos_formulario['stock_control'] = array('tipo' => 'select', 'fila'=>'unico','valor' => 'N','tag'=>'select', 'opciones'=>array('S' => 'SI' ,'N'=>'NO'), "label"=>'Control Inventario');
        $campos_formulario['descripcion'] = array('tipo' => 'textarea', 'fila'=>'unico','valor' => '','tag'=>'textarea');
        $campos_formulario['interlocutor_id'] = array('tipo' => 'hidden', 'valor' => $id_interlocutor_actual);
        $campos_formulario['imagen'] = array('tipo'=>'img','ruta'=>self::CARPETA.'big/','tag'=>'img');
        $campos_formulario['imagen_pre'] = array('tipo'=>'file','complemento'=>' onchange="visualizar_img(this,'."'".'imagen'."'".','."'".'50'."'".','."'".'50'."'".')"','label'=>'','info'=>'la imagen debe tener las siguientes dimensiones:');
        $tipo_negocio = $this->gn->get_data_loged('tipo_negocio');
        if ($tipo_negocio == 1) {
            //TODO: verifica si es un comercio y le da la posibilidad de agregar el stock
            //$campos_formulario['stock'] = array('tipo' => 'int', 'valor' => '0', 'label'=>'Cantidad' );
            //$campos_formulario['unidad_medida_id'] = array('tipo' => 'select', 'valor' => '1', 'complemento' => 'required', 'campo' => 'nombre', 'condicion' => 'estado_id = 1 ', 'tag' => 'select');
            //$campos_formulario['estante'] = array('tipo' => 'text', 'valor' => '', 'complemento' => '', 'campo' => 'descripcion', 'label' => 'No. Estante');        
        
        }
        $this->campos_formulario = $campos_formulario;
    }

    function home() {
        $marcablanca=$this->gn->get_data_loged('marca_blanca');
        $imagen = '<img class=\"preview\" id=\"img_producto_preview_';
        $ima=' src=\"app/vista/img/producto/big/';
        $img=' onerror=\"default_imagen(\'img_producto_preview_';
        $im='\',\'app/vista/img/producto/big/default.jpg'.'\');\"';
        $imagen2 = '\">';
        $interlocutor_id_actual = $this->gn->get_data_loged('id_interlocutor'); //id del Interlocutor actual        
        $campos = array('pr.' . $this->primary_key . " as ID",'pr.referencia','pr.barcode AS `Código de Barras`','CONCAT("'.$imagen.'", pr.id_producto, "'.'\"'.$ima.'", pr.id_producto, "'.'.jpg\"'.$img.'", pr.id_producto, "'.$im.$imagen2.'") AS Imagen','pr.nombre as nombre', 'pc.nombre as Categoria ','CONCAT("$", FORMAT(pr.precio, 0)) AS precio','pr.stock_control AS inventario', 'est.id_estado as Estado');
        $tablas = $this->nombre_tabla . ' pr, fw_estado est, producto_categoria pc,fw_interlocutor_condicion ic';
        $condicion = "pr.estado_id=est.id_estado AND pr.interlocutor_id='$interlocutor_id_actual'AND ic.interlocutor_id=pr.interlocutor_id AND ic.marca_blanca=".$marcablanca." AND pr.estado_id <>" . self::ESTADO_ELIMINADO.' AND pr.producto_categoria_id=pc.id_producto_categoria'; //////condicion esperando respuesta  /////////
        $checkbox=array('id_estado');
        $this->iniciar_maestro($campos, $tablas, $condicion, '', $checkbox=array(),$this->modulo,$this->nombre_tabla);
    }

    function formulario_edicion($campos_formulario = null){
        $this->tipo_contenido = '';
        $parametros = $this->gn->traer_parametros('GET');
		if ($campos_formulario === null){
			$campos_formulario = $this->campos_formulario;
		}
        
        $accion = "guardar_creacion";
        $encabezado = "Crear Producto";
        if (isset($parametros->id) && (int) $parametros->id > 0){
            $accion = "guardar_edicion&id=".$parametros->id;
            $campos = array(); 

            foreach ($campos_formulario as $key => $input){
                if ($key && $input['tipo']!= 'file'){
                    array_push($campos, $key);  //Setea el array con le nombre de los campos
                }
            }
            $elemento = $this->db->selectone($campos, $this->nombre_tabla, $parametros->id . ' = id_' . $this->nombre_tabla); //Obtiene el valor de los campos de la tabla en  bd
            $encabezado = 'Edicion Producto';
            foreach ($elemento as $key => $value){
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
        
        foreach ($parametros as $key => $value) {
            $campos[$key] = $value;
        }
        $tipo_negocio=$this->gn->get_data_loged('tipo_negocio');
        if(isset($campos['stock'])){
            $stock = $campos['stock'];
            unset($campos['stock']);
		}else{
			$stock = 0;
		}
        
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
            if (isset($_FILES['imagen_pre'])) {
                $id_producto = $last_id;
                $resultado = $this->gn->generar_imagenes(self::CARPETA, self::WIDHT, self::HEIGHT, $_FILES['imagen_pre'],false,$id_producto);
                
                $resultado_imagen = $this->db->update(array('imagen' => $id_producto.'.jpg'), 'producto', 'id_producto=' . $last_id);
                if (!$resultado_imagen) {
                    $mensaje = $this->nc->traer_mensaje_respuesta(self::ERROR_CREACION);
                    $this->nc->set_notificacion($mensaje['descripcion']);
                    header('location:?opcion=' . $this->modulo);
                    return;
                }
            }
        }
        $this->tipo_contenido = 'html';
        $this->home();
    }
    function guardar_edicion($redirect = true, $parametros = null){
		if (is_null($parametros)) {
			$parametros = $this->gn->traer_parametros('POST');
		}
        $par=$this->gn->traer_parametros('GET');
        parent::guardar_edicion(true,$parametros);
        $last_id = $par->id;
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
            if (isset($_FILES['imagen_pre'])) {
                $id_producto = $last_id;
                $resultado = $this->gn->generar_imagenes(self::CARPETA, self::WIDHT, self::HEIGHT, $_FILES['imagen_pre'],false,$id_producto);
                
                $resultado_imagen = $this->db->update(array('imagen' => $id_producto.'.jpg'), 'producto', 'id_producto=' . $last_id);
                if (!$resultado_imagen) {
                    $mensaje = $this->nc->traer_mensaje_respuesta(self::ERROR_CREACION);
                    $this->nc->set_notificacion($mensaje['descripcion']);
                    header('location:?opcion=' . $this->modulo);
                    return;
                }
            }
        }
       
    }
    
    
    function cargar_csv(){
        $this->tipo_contenido = '';
        $parametros = $this->gn->traer_parametros('GET');


        $marca_blanca = $this->gn->get_data_loged('marca_blanca') ;
        
        $campos['grupo_id'] = array(  'tipo' => 'select', 'valor' => '','complemento' => "required", 'tag'=>'select','personalizado' ,
                                                'tabla'=>'grupos m, usuario u, interlocutor_condicion ic',
                                                'value'=>'m.id_grupo',
                                                'campo' => "concat(m.codigo ,' ', m.nombre_grupo) ",
                                                'condicion' => 'm.estado_id ='.self::ESTADO_ACTIVO.' 
                                                AND m.usuario_id=u.id_usuario 
                                                                AND u.interlocutor_id = ic.interlocutor_id 
                                                                AND ic.marca_blanca = '.$marca_blanca); 
        $campos['archivo']=  array('tipo'=>'file','valor'=> '','complemento' => "required");

        

        require_once("vista/html/maestro2.html.php");
        FormHTML::formulario_dinamico($campos,'verificar_csv', $this->modulo, $this->db,'','','','','Cargar Csv');
        
    }
    function lanzador_import(){
        require_once("fw/vista/html/maestro2.html.php");
        FormHTML::lanzador_import($this->modulo);
    }
    function leer_archivo($archivo = ''){
        
        $path_upload = "media/productos/productos.csv".$archivo;
        $archivo = array();
        
        if (($gestor = fopen($path_upload, "r")) !== FALSE) {
            $cantidad = count($gestor);
            while (($datos = fgetcsv($gestor, 1000, ";")) !== FALSE) { //Windows
                $archivo[]=$datos;
                //$respuesta_insercion = $this->db->insert($campos, $this->nombre_tabla);
            }
            fclose($gestor);
        }
        $encabezado = $archivo[0];
        
        array_shift($archivo); // Eliminando el encabezado
        
        $this->gn->set_data_loged('csv_encabezado', $encabezado);
        $this->gn->set_data_loged('csv_archivo', $archivo);
        $this->gn->set_data_loged('csv_cantidad', count($archivo));
        $this->gn->set_data_loged('csv_pagina_actual', 0);
        $this->tipo_contenido = 'ajax';
        echo $this->modulo.":0:".count($archivo);
    }   
    
    function import_file(){
        $this->tipo_contenido = 'ajax';
        $interlocutor_id_actual = $this->gn->get_data_loged('id_interlocutor'); //id del Interlocutor actual        
        
        $filas = 0;
        
        $encabezado = $this->gn->get_data_loged('csv_encabezado');
        $archivo = $this->gn->get_data_loged('csv_archivo' );
        $cantidad_filas = $this->gn->get_data_loged('csv_cantidad' );
        $pagina_actual = $this->gn->get_data_loged('csv_pagina_actual');
        $filas_x_pagina = 500;
        $paginas = round($cantidad_filas / $filas_x_pagina);
        
        if((int)$pagina_actual < (int)$paginas){
            
            for($i = 0; $i < $filas_x_pagina ; $i++ ){
                $posicion_actual = ($pagina_actual*$filas_x_pagina) + $i;
                $fila_actual = $pagina_actual * $filas_x_pagina;
                $fila = $archivo[$posicion_actual];
                
                $cantidad = array();
                $unidad = array();
                $producto = array();
                foreach ($fila as $posicion => $campo) {
                    $posicion = $encabezado[$posicion];
                    if($posicion === 'cantidad' ){
                        $cantidad['stock']=$campo;
                    }else if($posicion === 'unidad_medida' ){
                        $unidad['nombre']= $campo;
                        $elemento = $this->db->selectone(array('nombre', 'id_unidad_medida'), 'unidad_medida', ' nombre = "'.$campo.'" ');

                        if(!isset($elemento['id_unidad_medida'])){
                            $respuesta_stock = $this->db->insert($unidad, 'unidad_medida');
                            $unidad_medida_id = $this->db->insertId();
                        }else{
                            $unidad_medida_id = $elemento['id_unidad_medida'];
                        }
                        $producto['unidad_medida_id'] = $unidad_medida_id;

                    }else if(in_array ($posicion,  array('referencia2','fecha_trx', 'fecha', 'proveedor'))){

                    }else{
                        $producto[$posicion]= $campo;
                    }
                }
                $producto['nombre_corto'] = $producto['nombre'];
                $producto['interlocutor_id'] = $interlocutor_id_actual;
                $respuesta_insercion = $this->db->insert($producto, 'producto');
                $producto_id = $this->db->insertId();

                $cantidad['producto_id']= $producto_id;
                $respuesta_stock = $this->db->insert($cantidad, 'producto_stock');
            }
            $pagina_actual = $pagina_actual + 1;
            
            $this->gn->set_data_loged('csv_pagina_actual', ($pagina_actual) );
           
        }
        echo "producto:".$posicion_actual.":".count($archivo);
    }
}
