<?php

class Comandas extends Modulo {

    function home() {
        $marcablanca = $this->gn->get_data_loged('marca_blanca');
        $id_interlocutor = $this->gn->get_data_loged('id_interlocutor');
        $campos = array("m.id_mesa","m.nombre as mesa", "p.id_pedido", "p.mesero_id as mesero", "p.tiempo_despacho", "TIMEDIFF(NOW(), p.fecha_publicacion) as tiempo");
        $tables1 = 'mesa m, pedido p,fw_estado est, fw_interlocutor_condicion ic';
        $condicion = "m.id_mesa=p.mesa_id and p.estado_id IN (15, 16) and est.id_estado=p.estado_id and p.interlocutor_id=$id_interlocutor AND ic.interlocutor_id=p.interlocutor_id AND ic.marca_blanca=" . $marcablanca;
        $datos_pedidos = $this->db->select($campos, $tables1, $condicion, 'p.fecha_publicacion ');

        $condicion_punto_atencion = "";
        $perfil = $this->gn->get_data_loged('perfil');
        if(MULTIPLES_PUNTOS_DESPACHO){
            if (in_array($perfil, array(4, 5, 6, 7))) {
                /* LAS SIGUIENTES LINEAS ESTAN COMENTADAS POR QUE NO ESTÁ TERMINADO: Validación para separar jugos de los almuerzos MENU DEL DIA*/
                //if ($perfil == 6) {
                    //$condicion_punto_atencion =  ' AND (pc.usuario_perfil_id = '.$perfil.' OR pi.producto_id IN (292, 318))  ';
                //}
                $condicion_punto_atencion = ' AND pc.usuario_perfil_id = ' . $perfil . ' ';
            }
        }

        $tables = "producto p,pedido pe, pedido_item pi LEFT JOIN observacion o ON pi.observacion_id = o.id_observacion, producto_categoria pc, fw_interlocutor_condicion ic";
        $condicion = 'pi.pedido_id = pe.id_pedido'
                . ' AND p.producto_categoria_id=pc.id_producto_categoria '
                . $condicion_punto_atencion
                . ' AND pi.estado_id IN (15, 16)'
                . ' AND p.id_producto=pi.producto_id'
                . ' AND pe.estado_id IN (15, 16)'
                . ' AND ic.interlocutor_id=pe.interlocutor_id'
                . ' AND ic.marca_blanca=' . $marcablanca
                . ' AND pe.interlocutor_id=' . $id_interlocutor;

        $pedidos = $this->db->select(
                array('pe.id_pedido',
            'pi.id_pedido_item',
            'pi.cantidad',
            'p.nombre AS Producto',
            'o.nombre AS observacion',
            'pi.cantidad',
            'pi.estado_id'), $tables, $condicion, 'pi.id_pedido_item', false, false
        );

        if (!$pedidos) {
            $tables = "producto p, pedido_item pi,pedido pe, producto_categoria pc , fw_interlocutor_condicion ic";
            $pedidos = $this->db->select(
                    array('pe.mesa_id as Mesa,pi.pedido_id', 'p.nombre as Producto', 'pi.cantidad'), $tables, 'pi.pedido_id=pe.id_pedido '
                    . ' AND pi.estado_id=16 '
                    . ' AND p.id_producto=pi.producto_id and pe.estado_id=16 '
                    . ' AND p.producto_categoria_id=pc.id_producto_categoria '
                    . ' AND pc.usuario_perfil_id = 6 '
                    . ' AND ic.interlocutor_id=pe.interlocutor_id '
                    . ' AND ic.marca_blanca=' . $marcablanca . ' '
                    . ' AND pe.interlocutor_id=' . $id_interlocutor, 'pi.id_pedido_item'
            );
        }
        
        $pedido_orden = array();
        if ($pedidos) {
            foreach ($pedidos as $pedido) {
                $id = $pedido['id_pedido'];
                unset($pedido['id_pedido']);
                $pedido_orden[$id]['items'][] = $pedido;
            }
        }

        if ($datos_pedidos) {
            foreach ($datos_pedidos as $pedido) {
                $prioridad = $this->gn->getPriorityColor($pedido['tiempo']);
                $pedido['tiempo_despacho'] = $pedido['tiempo'];
                $pedido['prioridad'] = $prioridad;
                $pedido_orden[$pedido['id_pedido']]['datos'] = $pedido;
            }
        }
        
        require_once($this->get_view_path());
        comandasHTML::home($pedido_orden, $this->modulo);
    }

    function cancelar_pedido() {
        $id_interlocutor = $this->gn->get_data_loged('id_interlocutor');
        $parametros = $this->gn->traer_parametros('GET');
        $id_pedido = $parametros->id_pedido;
        $id_mesa = $parametros->id_mesa;
        $update_mesa = $this->db->update(array('estado_id' => 11), 'mesa', 'nombre=' . $id_mesa . ' and interlocutor_id=' . $id_interlocutor);
        $update_pedido = $this->db->update(array('estado_id' => 3), 'pedido', 'id_pedido=' . $id_pedido);
        $campos = array('pi.id_pedido_item');
        $tables = "pedido_item pi,pedido pe,producto p";
        $pedidos = $this->db->select($campos, $tables, 'pi.pedido_id=pe.id_pedido and pi.estado_id=16 and pe.estado_id=15 and id_pedido=' . $id_pedido, 'id_pedido_item');
        foreach ($pedidos as $key => $value) {
            $resultado_update_pedido_item = $this->db->query("UPDATE pedido_item SET estado_id=3 WHERE id_pedido_item= " . $value['id_pedido_item']);
        }
        $this->home();
    }

    function despachar_pedido() {
        $parametros = $this->gn->traer_parametros('GET');
        $id_pedido = $parametros->id_pedido;
        $id_interlocutor = $this->gn->get_data_loged('id_interlocutor');
        $update_pedido = $this->db->update(array('estado_id' => 15), 'pedido', 'id_pedido=' . $id_pedido . " AND interlocutor_id=" . $id_interlocutor);
        $campos = array('pi.id_pedido_item');
        $tables = "pedido_item pi,pedido pe,producto p";
        $pedidos = $this->db->select($campos, $tables, 'pi.pedido_id=pe.id_pedido and pi.estado_id=16 and pe.estado_id=15 and id_pedido=' . $id_pedido, 'id_pedido_item');
        if ($pedidos) {
            foreach ($pedidos as $key => $value) {
                $resultado_update_pedido_item = $this->db->query("UPDATE pedido_item SET estado_id=15 WHERE id_pedido_item= " . $value['id_pedido_item']);
            }
        }
        $this->home();
    }

    function despachar_pedido_item() {
        $parametros = $this->gn->traer_parametros('GET');
        $id_pedido_item = $parametros->id_pedido_item;
        $nuevo_estado = $parametros->estado;

        // TODO: Maquina de estados
        /* Se debe evaluar que estado tiene el item en el momnento
          Consultar que estado sigue en la maquina de estado
         * Traer el nuyevo estado
         * Actualizar el item
         * */

        $estado_item = $this->db->selectOne(array('estado_id'), 'pedido_item', 'id_pedido_item=' . $id_pedido_item);

        $this->gn->set_data_loged('comanda_recovery_items', $id_pedido_item);
        $this->gn->set_data_loged('comanda_recovery_estado', $estado_item['estado_id']);
        $update_pedido = $this->db->update(array('estado_id' => $nuevo_estado), 'pedido_item', 'id_pedido_item=' . $id_pedido_item);
        $this->home();
    }

    function recuperar_pedido_item() {
        $id_pedido_item = $this->gn->get_data_loged('comanda_recovery_items');
        $id_estado = $this->gn->get_data_loged('comanda_recovery_estado');

        if ($id_pedido_item > 0) {
            $this->gn->set_data_loged('comanda_recovery_items', NULL);
            $this->gn->set_data_loged('comanda_recovery_estado', NULL);
            $update_pedido = $this->db->update(array('estado_id' => $id_estado), 'pedido_item', 'id_pedido_item=' . $id_pedido_item);
        }

        $this->home();
    }

    function cancelar_pedido_item() {
        $parametros = $this->gn->traer_parametros('GET');
        $id_pedido_item = $parametros->id_pedido_item;
        $update_pedido = $this->db->update(array('estado_id' => ESTADO_ELIMINADO), 'pedido_item', 'id_pedido_item = ' . $id_pedido_item);
        $this->home();
    }

    function RestarHoras($horaini, $horafin) {
        $horai = substr($horaini, 0, 2);
        $mini = substr($horaini, 3, 2);
        $segi = substr($horaini, 6, 2);

        $horaf = substr($horafin, 0, 2);
        $minf = substr($horafin, 3, 2);
        $segf = substr($horafin, 6, 2);

        $ini = ((($horai * 60) * 60) + ($mini * 60) + $segi);
        $fin = ((($horaf * 60) * 60) + ($minf * 60) + $segf);

        $dif = $fin - $ini;
        $difh = floor($dif / 3600);
        $difm = floor(($dif - ($difh * 3600)) / 60);
        $difs = $dif - ($difm * 60) - ($difh * 3600);
        return date("H-i-s", mktime($difh, $difm, $difs));
    }

}
