<?php

class Comandas extends Modulo {
    function home() {
        $marcablanca=$this->gn->get_data_loged('marca_blanca');
    	$id_interlocutor=$this->gn->get_data_loged('id_interlocutor');
    	$campos=array("m.nombre as mesa","p.id_pedido","p.mesero_id as mesero");       
        $tables='mesa m, pedido p,fw_estado est, fw_interlocutor_condicion ic';
        $condicion="m.id_mesa=p.mesa_id and p.estado_id IN (15, 16) and est.id_estado=p.estado_id and p.interlocutor_id=$id_interlocutor AND ic.interlocutor_id=p.interlocutor_id AND ic.marca_blanca=".$marcablanca;
        $datos_pedidos=$this->db->select($campos,$tables,$condicion,'mesa_id');
        
        $tables="producto p, pedido_item pi,pedido pe,observacion o, fw_interlocutor_condicion ic";
		
		$condicion = 'pi.pedido_id = pe.id_pedido'
				. ' AND pi.estado_id IN (15, 16)'
				. ' AND p.id_producto=pi.producto_id'
				. ' AND pe.estado_id IN (15, 16)'
				. ' AND pi.observacion_id=o.id_observacion'
				. ' AND ic.interlocutor_id=pe.interlocutor_id'
				. ' AND ic.marca_blanca='.$marcablanca
				. ' AND pe.interlocutor_id='.$id_interlocutor;
		
		$pedidos=$this->db->select(
				array('pe.id_pedido',
					'pi.id_pedido_item',
					'p.nombre_corto AS Producto',
					'o.nombre AS observacion',
					'pi.cantidad',
					'pi.estado_id'),
				$tables,$condicion,'mesa_id', false, false);
        
        if(!$pedidos){
            $tables="producto p, pedido_item pi,pedido pe, fw_interlocutor_condicion ic";
            $pedidos=$this->db->select(array('pe.mesa_id as Mesa,pi.pedido_id','p.nombre_corto as Producto','pi.cantidad'),$tables,'pi.pedido_id=pe.id_pedido and pi.estado_id=16 and p.id_producto=pi.producto_id and pe.estado_id=16 and ic.interlocutor_id=pe.interlocutor_id and ic.marca_blanca='.$marcablanca.' and pe.interlocutor_id='.$id_interlocutor,'mesa_id');
        }
        $pedido_orden=array();
        if($pedidos){
            foreach ($pedidos as  $pedido) {
				$id = $pedido['id_pedido'];
				unset($pedido['id_pedido']);
            	$pedido_orden[$id]['items'][]=$pedido;
            }     
        }
		if($datos_pedidos){
            foreach ($datos_pedidos as  $pedido) {
            	$pedido_orden[$pedido['id_pedido']]['datos']=$pedido;
            }     
        }
        require_once($this->get_view_path());
        comandasHTML::home($pedido_orden, $this->modulo);
    }

    function cancelar_pedido(){
        $id_interlocutor=$this->gn->get_data_loged('id_interlocutor');
        $parametros = $this->gn->traer_parametros('GET');
        $id_pedido=$parametros->id_pedido;
        $id_mesa=$parametros->id_mesa;
        $update_mesa=$this->db->update(array('estado_id'=>11),'mesa','nombre='.$id_mesa.' and interlocutor_id='.$id_interlocutor);
        $update_pedido=$this->db->update(array('estado_id'=>3),'pedido','id_pedido='.$id_pedido);
        $campos=array('pi.id_pedido_item');
        $tables="pedido_item pi,pedido pe,producto p";
        $pedidos=$this->db->select($campos,$tables,'pi.pedido_id=pe.id_pedido and pi.estado_id=16 and pe.estado_id=15 and id_pedido='.$id_pedido,'id_pedido_item');
        foreach ($pedidos as $key => $value) {
            $resultado_update_pedido_item=$this->db->query("UPDATE pedido_item SET estado_id=3 WHERE id_pedido_item= ".$value['id_pedido_item']);
        }
        $this->home();
    }
	
    function despachar_pedido(){
        $parametros = $this->gn->traer_parametros('GET');
        $id_pedido=$parametros->id_pedido;
        $id_interlocutor=$this->gn->get_data_loged('id_interlocutor');
        $update_pedido=$this->db->update(array('estado_id'=>15),'pedido','id_pedido='.$id_pedido." AND interlocutor_id=".$id_interlocutor);
        $campos=array('pi.id_pedido_item');
        $tables="pedido_item pi,pedido pe,producto p";
        $pedidos=$this->db->select($campos,$tables,'pi.pedido_id=pe.id_pedido and pi.estado_id=16 and pe.estado_id=15 and id_pedido='.$id_pedido,'id_pedido_item');
        if($pedidos){
            foreach ($pedidos as $key => $value) {
                $resultado_update_pedido_item=$this->db->query("UPDATE pedido_item SET estado_id=15 WHERE id_pedido_item= ".$value['id_pedido_item']);
            }
        }
        $this->home();
    }
	
	function despachar_pedido_item(){
        $parametros = $this->gn->traer_parametros('GET');
		$id_pedido_item=$parametros->id_pedido_item;
		$nuevo_estado=$parametros->estado;
        
		// TODO: Maquina de estados
		/* Se debe evaluar que estado tiene el item en el momnento
		   Consultar que estado sigue en la maquina de estado 
		 * Traer el nuyevo estado
		 * Actualizar el item
		 * */
		
        $update_pedido=$this->db->update(array('estado_id'=>$nuevo_estado),'pedido_item','id_pedido_item='.$id_pedido_item);
        $this->home();
    }
	
	function cancelar_pedido_item(){
        $parametros = $this->gn->traer_parametros('GET');
		$id_pedido_item=$parametros->id_pedido_item;
        $update_pedido=$this->db->update(array('estado_id'=>ESTADO_ELIMINADO),'pedido_item','id_pedido_item = '.$id_pedido_item);
        $this->home();
    }
}