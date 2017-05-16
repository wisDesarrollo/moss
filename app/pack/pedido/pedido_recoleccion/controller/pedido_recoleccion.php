<?php

class pedidoRecoleccion extends Modulo {

    CONST ERROR_PEDIDO = "053";
    CONST PEDIDO_VACIO = "054";
    CONST ERROR_LIBERAR = "055";
    CONST IMPRIMIR = "056";

    public $tipo_contenido = 'html';

    public function __construct($db = "", $modulo = "", $ruta_cron = "", $modulo_info = null, $WISQueries = null, $appQry = null) {
        $this->modulo = $this->traer_nombre(__CLASS__);
        $this->nombre_tabla = 'mesa';
        $this->primary_key = 'id_' . 'mesa';
        $this->actualizacion_ajax = 'ajax';
        parent::__construct($db, $this->modulo, $ruta_cron, $modulo_info, $WISQueries, $appQry);
        $this->gn->set_data_loged('pedido_items', array());
        $campos_formulario['id_mesa'] = array('tipo' => 'hidden', 'valor' => '', 'complemento' => 'required', 'label' => 'id');
        $campos_formulario['nombre'] = array('tipo' => 'text', 'valor' => '', 'complemento' => 'required');
        $campos_formulario['descripcion'] = array('tipo' => 'textarea', 'valor' => '');
        $campos_formulario['estado_id'] = array('tipo' => 'select', 'valor' => '', 'complemento' => 'required', 'campo' => 'descripcion', 'condicion' => 'id_estado IN (1,2)', 'tag' => 'select');
        $campos_formulario['orden'] = array('tipo' => 'int', 'valor' => '', 'complemento' => 'required', 'campo' => 'descripcion', 'label' => 'orden');
        $campos_formulario['mesero_id'] = array('tipo' => 'hidden', 'valor' => '', 'complemento' => 'required', 'label' => 'Mesero');
        $this->campos_formulario = $campos_formulario;
    }

    function home() {
        $parametros = $this->gn->traer_parametros('GET');

        if (!isset($parametros->zona)) {
            $zona_actual = 0;
        } else {
            $zona_actual = $parametros->zona;
        }
        $campos = array(
            'm.' . $this->primary_key . " as ID",
            'm.nombre',
            'm.id_mesa',
            'm.descripcion AS Descripcion',
            'm.mesero_id AS Mesero',
            'm.orden AS Orden',
            'est.descripcion AS Estado',
            'm.estado_id'
        );

        $tablas = $this->nombre_tabla . ' m, fw_estado est';

        $zonas = $this->traer_zonas();

        require_once 'app/pack/pedido/mesa/view/mesa.html.php';
        mesaHTML::mesas_contneedor_ini($this->modulo);
        if(empty($zonas)){
            $this->pintar_mesas($campos, $tablas, -1, $this->modulo);
        }else{
            //foreach ($zonas as $zona) {
            $campos = array(
                'm.' . $this->primary_key . " as ID",
                'm.nombre',
                'm.id_mesa',
                'm.mesa_id',
                'm.descripcion AS Descripcion',
                'm.mesero_id AS Mesero',
                'm.orden AS Orden',
                'est.descripcion AS Estado',
                'm.estado_id'
            );

            $tablas = $this->nombre_tabla . ' m LEFT JOIN mesa mm ON (m.id_mesa = mm.mesa_id AND mm.mesa_id = 0), fw_estado est';
            $this->pintar_mesas($campos, $tablas, $zona_actual, $this->modulo);
            //$this->iniciar_maestro_directo($campos, $tablas,$this->modulo);
            //}
        }
        mesaHTML::mesas_contneedor_fin();
    }

    function estado_menu() {
        $parametros = $this->gn->traer_parametros('GET');
        $id = $parametros->id;
        $estado = $parametros->estado;
        if ($estado == 11) {
            $opciones = array("reservar" => "$id", "liberar" => "$id");
        } elseif ($estado == 12) {
            $opciones = array("confirmar-reserva" => "$id", "liberar" => "$id");
        } elseif ($estado == 13) {
            $opciones = array("ver_pedido" => "$id", "liberar" => "$id");
        }
        $this->mostrar_menu($opciones);
    }

    function cambiar_estado() {
        $parametros = $this->gn->traer_parametros('GET');
        $op = $parametros->op;
        $id = $parametros->id;
        if ($op == 1) {
            $cambio_est = $this->db->update(array('estado_id' => ESTADO_DISPONIBLE), 'mesa', "id_mesa=$id");
        } elseif ($op == 2) {
            $cambio_est = $this->db->update(array('estado_id' => ESTADO_RESERVADO), 'mesa', "id_mesa=$id");
        }
        $this->home();
    }

    function traer_pedido() {
        $id_interlocutor = $this->gn->get_data_loged('id_interlocutor');
        $parametros = $this->gn->traer_parametros('GET');
        $id = $parametros->id;
        $campos = array("m.nombre as mesa", "p.id_pedido", "p.mesa_id", "p.mesero_id", "p.fecha_publicacion", "est.descripcion");
        $tables = 'mesa m, pedido p,fw_estado est';
        $condicion = "p.mesa_id=m.id_mesa and m.id_mesa=$id and p.estado_id=est.id_estado and (p.estado_id=16 or p.estado_id=15) and p.interlocutor_id=$id_interlocutor";
        $datos_pedido = $this->db->select($campos, $tables, $condicion, '', false, false);
        if (isset($parametros->return) && !$datos_pedido) {
            header('location:?opcion=mesas_visual&a=cambiar_estado&type=ajax&id=' . $id . '&op=1');
        } else {
            $pedidos = array();
            $total = 0;
            if ($datos_pedido) {
                $id_pedido = $datos_pedido[0]['id_pedido'];
                $tables = "producto p, pedido_item pi,pedido pe";
                $pedidos = $this->db->select(array('p.id_producto', 'p.nombre_corto', 'p.descripcion', 'p.precio', 'pi.cantidad'), $tables, 'pi.producto_id=p.id_producto '
                        . ' AND pi.pedido_id=pe.id_pedido '
                        . ' AND pe.id_pedido=' . $id_pedido . ' '
                        . ' AND pe.interlocutor_id=' . $id_interlocutor . ' '
                        . ' AND pi.estado_id <> 3 '
                        . ' AND (pe.estado_id=15 OR pe.estado_id=16)', 'id_pedido_item', false, false); //pe.estado_id=16 or
                $total = 0;
                if ($pedidos) {
                    foreach ($pedidos as $key => $value) {
                        $total += $value['precio'] * $value['cantidad'];
                    }
                }
            }
        }

        if (isset($parametros->return) && !$pedidos) {
            $update_pedido = $this->db->update(array('estado_id' => 17), 'pedido', 'mesa_id=' . $id . ' AND estado_id=16 AND interlocutor_id=' . $id_interlocutor);
            header('location:?opcion=mesas_visual&a=cambiar_estado&type=ajax&id=' . $id . '&op=1');
            exit;
        } elseif (isset($parametros->return) && $pedidos) {
            $mensaje = $this->nc->traer_mensaje_respuesta(self::ERROR_LIBERAR);
            $this->nc->set_notificacion(utf8_encode($mensaje['descripcion']));
            header('location:?opcion=mesas_visual&a=home&type=ajax');
        }
        $nombre_mesa = '';
        if ($datos_pedido[0]['mesa_id'] && $datos_pedido[0]['mesa_id'] != '') {
            $nombre_mesa = $this->db->selectOne('nombre', 'mesa', 'id_mesa=' . $datos_pedido[0]['mesa_id']);
        }
        if ($nombre_mesa) {
            $datos_pedido[0]['nombre_mesa'] = $nombre_mesa['nombre'];
        }
        require_once('app/vista/html/mesas.html.php');
        mesasHTML::mostrar_pedido($this->modulo, $datos_pedido, $pedidos, $total, 1);
    }

    function mostrar_menu($opciones = null){
        $marcablanca = $this->gn->get_data_loged('marca_blanca');
        $parametros = $this->gn->traer_parametros('GET');
        $id_mesa = $parametros->id;
        
        $categorias = $this->db->select(array('id_producto_categoria AS id_tab', 'id_producto_categoria', 'pc.nombre', 'fi.icon'), 
                'producto_categoria pc, fw_icons fi',
                "pc.icon_id = fi.id_icon "
                
                . " AND pc.estado_id= " . ESTADO_ACTIVO . " "
                . " AND marca_blanca=" . $marcablanca, 'orden'); // ---> para corregir las categorias por cada interlocutor
        $mesa = $this->db->selectOne(
                array('m.nombre', 'm.id_mesa', 'estado_id'), 
                'mesa m', 
                ' m.id_mesa= ' . $id_mesa
            );
        $id_cuenta = $this->validarCuentaXMesa($id_mesa);
        
        require_once('app/vista/html/menu.html.php');
        if($categorias){
            $productos = $this->clasificarProductosCategoria();
            $id_pedido = $this->traerPedidoXMesa($id_mesa);
            $this->pintarPedidoContenedor($mesa);
            require_once('fw/lib/plugin/_inc/tab/controller/tab.php');
            $tab = New Tab();
            $tab->paintTab($categorias, $productos);
            //menuHTML::menu($id,$categorias,$productos,$id_pedido,$nombre_mesa,$opciones);
        }else{
            menuHTML::menu($id_mesa, '', '', '', $mesa['nombre'], $opciones);
        }
    }

    function traer_grupos() {
        $marcablanca = $this->gn->get_data_loged('marca_blanca');
        $grupos = $this->db->select(
            array(
                'id_producto_categoria AS id_tab',
                'id_producto_categoria',
                'pc.nombre',
                'fi.icon'
                ), 'producto_categoria pc, fw_icons fi', "pc.icon_id = fi.id_icon"
                . " AND pc.estado_id= " . ESTADO_ACTIVO . " "
                . " AND pc.producto_categoria_id = 0 "
                . " AND marca_blanca=" . $marcablanca, 'orden'); // ---> para corregir las categorias por cada interlocutor

        return $grupos;
    }

    function mostrar_menu2($opciones = null) {
        $marcablanca = $this->gn->get_data_loged('marca_blanca');
        $parametros = $this->gn->traer_parametros('GET');
        $id_mesa = $parametros->id;

        $grupos = $this->db->select(array('id_producto_categoria AS id_tab', 'id_producto_categoria', 'pc.nombre', 'fi.icon'), 'producto_categoria pc, fw_icons fi', "pc.icon_id = fi.id_icon AND pc.estado_id= " . ESTADO_ACTIVO . " AND pc.producto_categoria_id = 0 AND marca_blanca=" . $marcablanca, 'orden'); // ---> para corregir las categorias por cada interlocutor

        foreach ($grupos as $grupo) {
            $categorias[$grupo['id_producto_categoria']]['categorias'] = $grupo;
            $categorias[$grupo['id_producto_categoria']]['categorias'] = $this->db->select(array(
                'id_producto_categoria AS id_tab',
                'id_producto_categoria',
                'producto_categoria_id',
                'pc.nombre',
                'fi.icon'), 'producto_categoria pc, fw_icons fi', "pc.icon_id = fi.id_icon "
                    . " AND pc.producto_categoria_id = " . $grupo['id_producto_categoria']
                    . " AND pc.estado_id= " . ESTADO_ACTIVO . " "
                    . " AND marca_blanca=" . $marcablanca, 'orden'); // ---> para corregir las categorias por cada interlocutor
        }

        $mesa = $this->db->selectOne(
                array('m.nombre', 'm.id_mesa', 'estado_id'), 'mesa m', ' m.id_mesa= ' . $id_mesa
        );
        $id_cuenta = $this->validarCuentaXMesa($id_mesa);

        require_once('app/vista/html/menu.html.php');
        if ($grupos) {
            $productos = $this->clasificarProductosCategoria();
            $id_pedido = $this->traerPedidoXMesa($id_mesa);
            $this->pintarPedidoContenedor($mesa);
            require_once('fw/lib/plugin/_inc/tab/controller/tab.php');
            $tab = New Tab();
            $tab->paintTab($grupos, $productos);
            //menuHTML::menu($id,$categorias,$productos,$id_pedido,$nombre_mesa,$opciones);
        } else {
            menuHTML::menu($id_mesa, '', '', '', $mesa['nombre'], $opciones);
        }
    }

    function mostrarProductosGrupo() {
        $productos = $this->clasificarProductosCategoria();
        $id_pedido = $this->traerPedidoXMesa($id_mesa);
        $this->pintarPedidoContenedor($mesa);
        require_once('fw/lib/plugin/_inc/tab/controller/tab.php');
        $tab = New Tab();
        $tab->paintTab($grupos, $productos);
    }

    function traerPedidoXMesa($id_mesa) {
        $campos = array("p.id_pedido", "p.mesa_id", "p.mesero_id", "p.fecha_publicacion", "est.descripcion");
        $tables = 'mesa m, pedido p,fw_estado est';
        $condicion = "p.mesa_id=m.id_mesa "
                . " AND m.id_mesa=$id_mesa "
                . " AND p.estado_id=" . ESTADO_EN_ESPERA . " "
                . " AND est.id_estado=p.estado_id";
        $datos_pedido = $this->db->selectOne($campos, $tables, $condicion, '', false, false);
        return $datos_pedido['id_pedido'];
    }

    function traerProductosXInterlocutor($interlocutor_actual) {
        $productos = $this->db->select(array(
                'id_producto',
                'producto_categoria_id',
                'producto_categoria_id AS id_tab',
                'nombre_corto AS nombre_producto',
                'descripcion',
                'estado_id',
                'precio',
                'imagen'
            ), 
            'producto', 
            'estado_id <> ' . ESTADO_ELIMINADO . ' '
                . ' AND estado_id=' . ESTADO_ACTIVO . ' '
                . ' AND interlocutor_id=' . $interlocutor_actual, 
            'orden'
        );
        return $productos;
    }
    function traerCategoriasXInterlocutor($interlocutor_actual) {
        $categorias = $this->db->select(array(
            'id_producto_categoria',
            'producto_categoria_id',
            'producto_categoria_id AS id_tab',
            'nombre',
            'descripcion'
                ), 'producto_categoria', 'estado_id <> ' . ESTADO_ELIMINADO . ' '
                . ' AND estado_id=' . ESTADO_ACTIVO . ' '
                . ' AND producto_categoria_id = 0 '
                . ' AND marca_blanca=' . $interlocutor_actual, 'orden'
        );
        return $categorias;
    }

    function validarCuentaXMesa($id_mesa) {
        $id_cuenta = $this->appQry->ejecutarQuery('consultar_cuenta_x_mesa', array('id_mesa' => $id_mesa));

        if ($id_cuenta) {
            $cambio_est = $this->db->update(array('estado_id' => ESTADO_OCUPADO), 'mesa', "id_mesa=$id_mesa");
            return $id_cuenta;
        } else {
            $cambio_est = $this->db->update(array('estado_id' => ESTADO_DISPONIBLE), 'mesa', "id_mesa=$id_mesa");
            return 0;
        }
    }

    function clasificarProductosCategoria() {
        $interlocutor_actual = $this->gn->get_data_loged('id_interlocutor');
        $productos = $this->traerProductosXInterlocutor($interlocutor_actual);
        $productosClasificados = array();
        foreach ($productos as $key => $producto){
            $productosClasificados[$producto['producto_categoria_id']]['id_tab'] = $producto['producto_categoria_id'];
            $productosClasificados[$producto['producto_categoria_id']]['path'] = 'app/pack/pedido/pedido_recoleccion/view/pedido_recoleccion.html.php';
            $productosClasificados[$producto['producto_categoria_id']]['html_clase'] = 'PedidoRecoleccionHTML';
            $productosClasificados[$producto['producto_categoria_id']]['html_metodo'] = 'pintarProductos';
            $productosClasificados[$producto['producto_categoria_id']]['productos'][] = $producto;
            //$productosClasificados[$producto['producto_categoria_id']]['contenido']=$this->pintarProductoItem($producto);
        }
        return $productosClasificados;
    }
    function clasificarCategoriasGrupo() {
        $interlocutor_actual = $this->gn->get_data_loged('id_interlocutor');
        $categorias = $this->traerCategoriasXInterlocutor($interlocutor_actual);
        $categoriasClasificados = array();
        foreach ($categorias as $key => $categoria){
            $categoriasClasificados[$categoria['producto_categoria_id']]['id_tab'] = $categoria['producto_categoria_id'];
            $categoriasClasificados[$categoria['producto_categoria_id']]['path'] = 'app/pack/pedido/pedido_recoleccion/view/pedido_recoleccion.html.php';
            $categoriasClasificados[$categoria['producto_categoria_id']]['html_clase'] = 'PedidoRecoleccionHTML';
            $categoriasClasificados[$categoria['producto_categoria_id']]['html_metodo'] = 'pintarCategorias';
            $categoriasClasificados[$categoria['producto_categoria_id']]['productos'][] = $categoria;
        }
        return $categoriasClasificados;
    }

    function pintarProductoItem($producto) {
        require_once('app/pack/pedido/pedido_recoleccion/view/pedido_recoleccion.html.php');
        PedidoRecoleccionHTML::pintarProductoItem($producto);
    }

    function pintarPedidoContenedor($mesa) {
		$mesas_libres = $this->db->select(array('id_mesa', 'nombre'), 'mesa', ' mesa_id > 0 AND estado_id = '.ESTADO_DISPONIBLE);
		
        require_once('app/pack/pedido/pedido_recoleccion/view/pedido_recoleccion.html.php');
        PedidoRecoleccionHTML::pedidoContenedor($mesa, $mesas_libres);
    }
	function mover_mesa() {
		$parametros = $this->gn->traer_parametros('GET');
		
		$cuenta = $this->db->selectOne(array('punto_atencion_id', 'id_cuenta'), 'cuenta', ' estado_id = 20 AND punto_atencion_id = '.$parametros->id_mesa_anterior);
		
		$cambio_est = $this->db->update(array('punto_atencion_id' => $parametros->id_mesa_actual), 'cuenta', "id_cuenta=".$cuenta['id_cuenta']);
		$cambio_est = $this->db->update(array('mesa_id' => $parametros->id_mesa_actual), 'pedido', "cuenta_id=".$cuenta['id_cuenta']);
		$cambio_est = $this->db->update(array('estado_id' => ESTADO_DISPONIBLE), 'mesa', "id_mesa=$parametros->id_mesa_anterior");
		$cambio_est = $this->db->update(array('estado_id' => ESTADO_OCUPADO), 'mesa', "id_mesa=$parametros->id_mesa_actual");
		$this->home();
        
    }

    function pintarPedidoItem() {
        $parametros = $this->gn->traer_parametros('GET');
        $pedido_items = $this->gn->get_data_loged('pedido_items');

        if (!isset($pedido_items) || $pedido_items == 0) {
            $pedido_items = array();
        }
        if (!isset($pedido_items[$parametros->id_producto])) {
            $pedido_items[$parametros->id_producto] = 0;
        }
        $obs = $this->traer_observaciones();
        
        $pedido_items[$parametros->id_producto] += 1;
        $producto = $this->db->selectOne(array('id_producto', 'producto_categoria_id', 'producto_categoria_id AS id_tab', 'nombre_corto AS nombre_producto', 'descripcion', 'precio', 'iva', 'imagen'), 'producto', 'estado_id <> ' . ESTADO_ELIMINADO . ' '
                . ' AND estado_id=' . ESTADO_ACTIVO . ' '
                . ' AND id_producto =' . $parametros->id_producto, false, false);

        require_once('app/pack/pedido/pedido_recoleccion/view/pedido_recoleccion.html.php');
        //if(isset($pedido_items[$producto['id_producto']])){
        //	PedidoRecoleccionHTML::modificarPedidoItem($producto);
        //}else{
        //$pedido_items[$producto['id_producto']] = $producto;
        PedidoRecoleccionHTML::pintarPedidoItem($producto, $parametros->consecutivo, $obs);
        //}
        $this->gn->set_data_loged('pedido_items', $pedido_items);
    }

    function pintar_fila() {
        $parametros = $this->gn->traer_parametros('GET');
        $id_interlocutor = $this->gn->get_data_loged('id_interlocutor');
        $observacion = $this->db->select(array('id_observacion', 'nombre'), 'observacion', 'estado_id= ' . ESTADO_ACTIVO . ' and interlocutor_id=' . $id_interlocutor, 'orden');
        $this->tipo_contenido = 'ajax';
        require_once('app/vista/html/mesas.html.php');
        mesasHTML::pintar_fila($parametros, $observacion);
    }

    function confirmar_pedido() {
        $parametros = $this->gn->traer_parametros('POST');
        $parametros_cantidad = count((array) $parametros); //verificar que el cuadro de productos no este vacio
        $id_mesa = $parametros->id_mesa;
        unset($parametros->id_mesa);

        if ($parametros_cantidad <= 0) {
            $cambio_est = $this->db->update(array('estado_id' => ESTADO_DISPONIBLE), 'mesa', "id_mesa=$id_mesa");
            $mensaje = $this->nc->traer_mensaje_respuesta($this->PEDIDO_VACIO);
            $this->nc->set_notificacion(utf8_encode($mensaje['descripcion']));
            $this->home();
            return;
        }

        /* OBTENER CUENTA: Se crea si no existe */
        $id_cuenta = $this->validarCuentaXMesa($id_mesa);

        if (!($id_cuenta > 0)) {
            $id_cuenta = $this->crear_cuenta($id_mesa);
            $cambio_est = $this->db->update(array('estado_id' => ESTADO_OCUPADO), 'mesa', "id_mesa=$id_mesa");
        }

        /* CREACION DE PEDIDO: Se crea un pedido siempre que el cliente solicita productos */
        $id_pedido = $this->crear_pedido($id_cuenta, $id_mesa);
        $parametros_array = json_decode(json_encode($parametros), true); //convierte stdObject en array            

        foreach ($parametros_array as $key => $value) {
            $nombre_campo = explode('_', $key);
			
            if ($nombre_campo[2] == 'cantidad') {
                $items[$nombre_campo[3]][$nombre_campo[4]][$nombre_campo[2]] = $value;
                $items[$nombre_campo[3]][$nombre_campo[4]]['producto_id'] = $nombre_campo[3];
                $items[$nombre_campo[3]][$nombre_campo[4]]['pedido_id'] = $id_pedido;
                $items[$nombre_campo[3]][$nombre_campo[4]]['observacion_id'] = $id_pedido;
            }
            if ($nombre_campo[2] == 'observacion') {
                $items[$nombre_campo[3]][$nombre_campo[4]]['observacion_id'] = $value;
            }
        }

        /* CREACION PEDIDO DETALLE: Se crean los items del pedido */
        foreach ($items as $item) {
            $this->crear_pedido_item($item);
        }

        $this->nc->set_notificacion(utf8_encode('Pedido Creado Correctamente'));
        //$this->home();
        header("location:?opcion=".$this->modulo."&type=html");
    }

    function corregir_pedido() {
        $parametros = $this->gn->traer_parametros('POST');
        $id_pedido = $parametros->id_pedido_hide;
        $tables = "pedido_item pi,pedido pe,producto p";
        $pedidos = $this->db->select(array('producto_id', 'id_pedido_item'), $tables, 'pi.pedido_id=pe.id_pedido and p.id_producto=pi.producto_id and pe.estado_id=16 and id_pedido=' . $id_pedido . ' and (pi.estado_id=16 or pi.estado_id=15 or pi.estado_id=1)', 'id_pedido_item');

        if ($pedidos) {
            $parametros_array = json_decode(json_encode($parametros), true); //convierte stdObject en array
            $j = 0;
            $y = 0;
            $ids = array();
            $cant = array();
            foreach ($parametros_array as $key => $value) {
                $cantidad = strpos($key, 'cantidad');   //llena vector de ids y observaciones                    
                $idss = strpos($key, 'prodid');
                if ($idss) {//llena vector de ids y observaciones                     
                    $ids[$j] = $value;
                }
                if ($cantidad) {
                    $cant[$j] = $value;
                }
                $j++;
            }
            $ids = array_unique($ids); //hace que los ids sean unicos para saber cuales son y cuantos hay            
            $i = 0;
            $id = array();
            foreach ($ids as $key => $value) {//da indices consecutivos a las key
                $id[$i] = $value;
                $i++;
            }
            $i = 0;
            foreach ($cant as $key => $value) {//indices consecutivos
                $cantidades[$i] = $value;
                $i++;
            }
            $i = 0;
            foreach ($id as $k => $valor) {
                $buscar = $valor;
                foreach ($pedidos as $key => $value) {
                    if ($buscar == $value['producto_id']) {
                        $resultado_update_cantidad = $this->db->query("UPDATE pedido_item SET cantidad=$cantidades[$i] WHERE id_pedido_item= " . $value['id_pedido_item'], false);
                        unset($pedidos[$key]);
                    }
                }
                $i++;
            }
            foreach ($pedidos as $key => $value) {
                $elimina_productos = $this->db->query("UPDATE pedido_item SET estado_id=3 WHERE id_pedido_item= " . $value['id_pedido_item'], false);
            }
        }
        $mensaje = $this->nc->traer_mensaje_respuesta($this->EXITO_EDICION);
        $this->nc->set_notificacion(utf8_encode($mensaje['descripcion']));
        $this->home();
    }

    function facturar() {
        $id_usuario = $this->gn->get_data_loged('id_usuario');
        $parametros = $this->gn->traer_parametros('GET');
        $id_pedido = $parametros->id_pedido;
        $id_mesas = $parametros->id_mesa;
        $interlocutor_actual = $this->gn->get_data_loged('id_interlocutor');
        $campos = array('pi.producto_id', 'pi.id_pedido_item', 'p.nombre_corto', 'pi.cantidad', 'p.precio');
        $tables = "pedido_item pi,pedido pe,producto p";
        $pedidos = $this->db->select($campos, $tables, 'pi.pedido_id=pe.id_pedido and (pi.estado_id=15 or pi.estado_id=16) and p.id_producto=pi.producto_id and (pe.estado_id=15 or pe.estado_id=16) and id_pedido=' . $id_pedido, 'id_pedido_item');
        if ($pedidos && $pedidos != '') {
            $campos = array("p.id_pedido", "p.mesa_id", "p.mesero_id", "p.fecha_publicacion", "est.descripcion");
            $tables = 'mesa m, pedido p,fw_estado est';
            $condicion = "p.mesa_id=m.id_mesa and m.id_mesa=$id_mesas and (p.estado_id=15 or p.estado_id=16) and est.id_estado=p.estado_id";
            $datos_pedido = $this->db->select($campos, $tables, $condicion, '', false, false);
            foreach ($pedidos as $key => $value) {
                $resultado_update_pedido_item = $this->db->query("UPDATE pedido_item SET estado_id=17 WHERE id_pedido_item= " . $value['id_pedido_item'], false);
            }
            $resultado_pedido = $this->db->query("UPDATE pedido SET estado_id=17 WHERE id_pedido= " . $id_pedido, false);
            if (!$resultado_pedido) {
                $mensaje = $this->nc->traer_mensaje_respuesta($this->ERROR_EDICION);
                $this->nc->set_notificacion(utf8_encode($mensaje['descripcion']));
            }
            $resultado_mesa = $this->db->query("UPDATE mesa SET estado_id=11 WHERE id_mesa=" . $id_mesas, false);
            if (!$resultado_mesa) {
                $mensaje = $this->nc->traer_mensaje_respuesta($this->ERROR_EDICION);
                $this->nc->set_notificacion(utf8_encode($mensaje['descripcion']));
            }
            $campos = array('transaccion_tipo_id' => 1, "responsable_id" => $id_usuario, "interlocutor_id" => $interlocutor_actual, "estado_id" => 1);
            $transaccion_insert = $this->db->insert($campos, 'transaccion');
            if (!$transaccion_insert) {
                $mensaje = $this->nc->traer_mensaje_respuesta($this->ERROR_CREACION);
                $this->nc->set_notificacion(utf8_encode($mensaje['descripcion']));
            }
            $transaccion_id = $this->db->lastId();
            foreach ($pedidos as $key => $value) {
                $campos = array('transaccion_id' => $transaccion_id, 'producto_id' => $value['producto_id'], "cantidad" => $value['cantidad'], "valor_unitario" => $value['precio'], "iva" => 0, "estado_id" => 1);
                $resultado_update_pedido_item = $this->db->insert($campos, 'transaccion_item');
            }
            $total = 0;
            foreach ($pedidos as $key => $value) {
                $total += $value['precio'] * $value['cantidad'];
            }
            $campos = array('ti.producto_id', 'ti.id_transaccion_item as id_pedido_item', 'p.nombre_corto', 'ti.cantidad', 'p.precio');
            $tables = "transaccion_item ti,transaccion t,producto p";
            $transacciones = $this->db->select($campos, $tables, 'ti.transaccion_id=t.id_transaccion and ti.estado_id=1 and p.id_producto=ti.producto_id and t.estado_id=1 and id_transaccion=' . $transaccion_id, 'id_transaccion_item');
            $info_negocio = $this->db->selectOne('concat(nombre,apellido) as negocio,num_documento,direccion,telefono', 'fw_interlocutor', 'id_interlocutor=' . $interlocutor_actual);
            $inf_neg = array();
            $transa = array();
            foreach ($info_negocio as $key => $value) {
                array_push($inf_neg, $value);
            }
            foreach ($transacciones as $key => $value) {
                foreach ($value as $k => $v) {
                    if ($k != 'id_pedido_item' && $k != 'producto_id') {
                        array_push($transa, $v);
                    }
                }
            }

            require_once('app/vista/html/mesas.html.php');

            mesasHTML::mostrar_pedido($this->modulo, $datos_pedido, $transacciones, $total, 2, $transaccion_id, $inf_neg, $transa);
        } else {
            $mensaje = $this->nc->traer_mensaje_respuesta(self::ERROR_PEDIDO);
            $this->nc->set_notificacion(utf8_encode($mensaje['descripcion']));
        }
    }

    function crear_factura() {
        $parametros = $this->gn->traer_parametros('GET');
        $id_interlocutor = $this->gn->get_data_loged('id_interlocutor');
        $info_negocio = $this->db->selectOne('concat(nombre,apellido) as negocio,num_documento,direccion,telefono', 'interlocutor', 'id_interlocutor=' . $id_interlocutor);
        $id_mesa = $parametros->id_mesa;
        $id_transaccion = $parametros->transaccion;
        $fecha = $this->db->selectOne('fecha', 'transaccion', 'id_transaccion=' . $id_transaccion); //2015-11-10 22:22:31
        $campos = array('p.nombre_corto', 'ti.cantidad', 'p.precio');
        $tables = "transaccion_item ti,transaccion t,producto p";
        $transacciones = $this->db->select($campos, $tables, 'ti.transaccion_id=t.id_transaccion and ti.estado_id=1 and p.id_producto=ti.producto_id and t.estado_id=1 and id_transaccion=' . $id_transaccion, 'id_transaccion_item');
        $consecutivo = $parametros->transaccion;
        require_once('controlador/php/lib/dompdf/dompdf_config.inc.php');
        $impresion = '        
            <head><title></title>
            </head>
            
        <body>
        <p>FACTURA No- ' . $consecutivo . '<p>
        <p>--------------------------------------------------------
        <br>Negocio:' . $info_negocio['negocio'] . '<br>nit:' . $info_negocio['num_documento'] . '<br>Reg. simplificado del impuesto al consumo
        <br>Res. 110000611713 2015/01/14 <br> Direccion:' . $info_negocio['direccion'] . "-" . " Tel:" . $info_negocio['telefono'] .
                '<br>Fecha:' . $fecha['fecha'] .
                '<br>Mesa:' . $id_mesa . '<br>
        <table style"border:1px dashed">
        <tr>
        <td>Descripcion</td>
        <td>Cantidad</td>
        <td>Valor</td>
        </tr>';
        foreach ($transacciones as $key => $value) {
            $impresion .= '<tr>';
            foreach ($value as $k => $v) {
                $impresion .= '<td>';
                $impresion .= $v;
                $impresion .= '</td>';
            }
            $impresion .= '</tr>';
            $impresion .= '<br>';
        }

        $impresion .= '</tr>
        </table>        
        --------------------------------------------------------

        <br>-------------GRACIAS POR SU COMPRA--------------
        <br>------------ADVERTENCIA DE PROPINA--------------
        <br>Establecimiento de comercio sugiere una propina
        <br>correspondiente al 10% del valor de la cuenta,
        <br>el cual podra ser aceptado, rechazado o modificado
        <br>por ud, de acuerdo con su valoracion del servicio
        <br>prestado.
        <br>Al momento de solicitar la cuenta, indiquele a la 
        <br>persona que lo atiende si quiere que dicho valor
        <br>sea o no incluido en la factura.
        <br>En caso de algun inconveniente con el cobro de la 
        <br>propina, comuniquese con la super intendencia de 
        <br>industria y comercio
        <br>linea gratuita nacional 018000910165.
        <br>-------------------------------------
        </html>';
        $factura = utf8_encode($impresion);
        $dompdf = new DOMPDF();
        $dompdf->load_html($factura);
        $dompdf->render();
        ini_set("memory_limit", "128M");
        $dompdf->stream("factura.pdf");
        print_r("llege");
        exit;
    }

    function imprimir() {
        print_r($factura);
        exit; //$this->tipo_contenido='ajax';
        //$this->home();
    }

    function crear_cuenta($id_mesa) {
        $id_interlocutor = $this->gn->get_data_loged('id_interlocutor');

        $campos = array(
            'interlocutor_owner_id' => $id_interlocutor,
            'punto_atencion_id' => $id_mesa,
            'fecha_apertura' => 'NOW()',
            'estado_id' => ESTADO_CUENTA_ABIERTA
        );
        $insert_pedido = $this->db->insert($campos, 'cuenta'); //se hacen los inserts en pedidos
        if (!$insert_pedido) {
            $mensaje = $this->nc->traer_mensaje_respuesta($this->ERROR_CREACION);
            $this->nc->set_notificacion(utf8_encode($mensaje['descripcion']));
        } else {
            $insert_pedido = $this->db->insertId();
        }
        return $insert_pedido;
    }

    function crear_pedido($id_cuenta, $id_mesa) {
        $id_interlocutor = $this->gn->get_data_loged('id_interlocutor');
        $id_mesero = $this->gn->get_data_loged('id_usuario');

        $campos = array(
            'cuenta_id' => $id_cuenta,
            'mesero_id' => $id_mesero,
            'mesa_id' => $id_mesa,
            'interlocutor_id' => $id_interlocutor,
            'fecha_publicacion' => 'NOW()',
            'estado_id' => ESTADO_PEDIDO_TOMADO
        );
        $insert_pedido = $this->db->insert($campos, 'pedido'); //se hacen los inserts en pedidos
        if (!$insert_pedido) {
            $mensaje = $this->nc->traer_mensaje_respuesta($this->ERROR_CREACION);
            $this->nc->set_notificacion(utf8_encode($mensaje['descripcion']));
        } else {
            $insert_pedido = $this->db->insertId();
        }
        return $insert_pedido;
    }

    function crear_pedido_item($items) {
        foreach ($items as $item) {
            $item['estado_id'] = ESTADO_PEDIDO_TOMADO;
            $insert_pedido = $this->db->insert($item, 'pedido_item'); //se hacen los inserts en pedido_item
            $insert_pedido = $this->db->insertId();
        }

        if (!$insert_pedido) {
            $mensaje = $this->nc->traer_mensaje_respuesta($this->ERROR_CREACION);
            $this->nc->set_notificacion(utf8_encode($mensaje['descripcion']));
        }
        return $insert_pedido;
    }

    function traer_zonas() {
        $interlocutor_id_actual = $this->gn->get_data_loged('id_interlocutor'); //id del Interlocutor actual
        $campos = array("m.id_mesa", "m.nombre as mesa", "est.descripcion");
        $tables = 'mesa m, fw_estado est';
        $condicion = " m.estado_id=est.id_estado "
                . " AND m.mesa_id = 0 "
                . " AND m.interlocutor_id=$interlocutor_id_actual";
        $zonas = $this->db->select($campos, $tables, $condicion, '', false, false);
        return $zonas;
    }
    function traer_observaciones() {
        $interlocutor_id_actual = $this->gn->get_data_loged('id_interlocutor'); //id del Interlocutor actual
        $campos = array("o.id_observacion", "o.nombre", "est.descripcion");
        $tables = 'observacion o, fw_estado est';
        $condicion = " o.estado_id=est.id_estado "
                . " AND o.interlocutor_id=$interlocutor_id_actual";
        $zonas = $this->db->select($campos, $tables, $condicion, '', false, false);
        return $zonas;
    }

}
