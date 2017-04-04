<?php
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

class PedidoRecoleccionHTML {

	static function pintarProductos($productos) {
		?>
		<div class="categoria_item">
			<ul>
				<?php
				foreach ($productos as $key => $producto) {
					self::pintarProductoItem($producto);
				}
				?>
			</ul>
		</div>
		<div id="subarea_trabajo" class="wis_bloque">
			<div id="wis_cuenta_detalle">
				<div></div>
				<ul>
					<li class="">
						<ul>
							<li>
								
							</li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
		<?php
	}

	static function pintarProductoItem($producto) {
		?>
		<li class="producto_item" onclick="facturaPedidoPonerItem('pedido_recoleccion', 'wis_factura_item_container', '<?php echo $producto['id_producto']; ?>');">
			<div class="producto_imagen">
				<img src="app/vista/img/producto/big/<?php echo $producto['imagen']; ?>" alt="<?php echo $producto['nombre_producto']; ?>" width="105" height="auto">
			</div>
			<div class="producto_costo">$<?php echo number_format($producto['precio']); ?></div>
			<p><?php echo $producto['nombre_producto']; ?></p>
		</li>
		<?php
	}

	static function pedidoContenedor($mesa) {
		?>
		<div id="pedido_cliente_contenedor" class="wis_bloque">
			<form action="?opcion=pedido_recoleccion&a=confirmar_pedido" method="POST">
				<input type="hidden" name="id_mesa" id="id_mesa" value="<?php echo $mesa['id_mesa']; ?>">
				<div class="wis_factura">
					<ul id="wis_factura_item_container">

					</ul>
					<div class="factura_resumen">
						
						<div class="factura_resumen_datos">
							<p class="wis_factura_subtotal">
								Subtotal $<span id="wf_subtotal">0</span>
								<input id="wf_subtotal_dato" name="wf_subtotal_dato" type="hidden" value="0" >
							</p>
							<p class="wis_factura_total_complemento">
								IVA $<span id="wf_impuestos">0</span>
								<input id="wf_impuestos_dato" name="wf_impuestos_dato" type="hidden" value="0" >
							</p>
							<p class="wis_factura_total_complemento">
								Servicio $<span id="wf_servicio">0</span>
								<input id="wf_servicio_dato" name="wf_servicio_dato" type="hidden" value="0" >
							</p>
							<p class="wis_factura_total">
								TOTAL <span>$</span><span id="wf_total">0</span>
								<input id="wf_total_dato" name="wf_total_dato" type="hidden" value="0" >
							</p>
						</div>
					</div>
				</div>
				<div class="wis_factura_line accion_boton">
					<button type="button" class="glyphicon glyphicon-remove" onclick="facturaLimpiar()"></button>
					<button type="submit" class="glyphicon glyphicon-ok"></button>
					<p><?php echo "MESA " . utf8_encode(ucfirst($mesa['nombre'])); ?></p>
				</div>
				<script>
					wf_subtotal = 0;
				</script>
			</form>
		</div>
		<?php
	}

	static function pintarPedidoItem($producto) {
		?>
		<li id="factura_item_<?php echo $producto['id_producto']; ?>" class="wis_factura_line wis_factura_line_item" onclick="facturaItemSelected(this, <?php echo $producto['id_producto']; ?>);" >
			<div class="wis_factura_desc">
				<input type="hidden" id="tm_item_cantidad_<?php echo $producto['id_producto']; ?>" name="tm_item_cantidad_<?php echo $producto['id_producto']; ?>" value="1">
				<input type="hidden" id="tm_item_vu_<?php echo $producto['id_producto']; ?>" name="tm_item_vu_<?php echo $producto['id_producto']; ?>" value="<?php echo $producto['precio']; ?>">
				<input type="hidden" id="tm_item_imp_<?php echo $producto['id_producto']; ?>" name="tm_item_imp_<?php echo $producto['id_producto']; ?>" value="<?php echo $producto['iva']; ?>">
				<input type="hidden" id="tm_item_select_<?php echo $producto['id_producto']; ?>" name="tm_item_select_<?php echo $producto['id_producto']; ?>" value="0">
				<div class="desc_producto">
					<p><?php echo $producto['nombre_producto']; ?></p>
					<?php self::controlCant($producto['id_producto']); ?>
				</div>
				<div class="valor_unitario">$<?php echo number_format($producto['precio']); ?> c/u</div>
			</div>
			<div class="wis_factura_subtotal" id="wis_factura_subtotal_<?php echo $producto['id_producto']; ?>">
				$<?php echo number_format($producto['precio']); ?>
			</div>
		</li>
		<?php
	}

	static function controlCant($id) {
		?>
		<div class="input-group">
			<span class="input-group-btn">
				<button type="button" onclick="facturaPedidoRestarItem('pedido_recoleccion', 'wis_factura_item_container', '<?php echo $id; ?>');" class="btn waves-effect waves-light btn-primary">
					<i class="glyphicon glyphicon-minus"></i>
				</button>
			</span>
			<span class="form-control ng-binding" id="tm_item_cantidad_view_<?php echo $id; ?>">1</span>
			<span class="input-group-btn">
				<button type="button" onclick="facturaPedidoPonerItem('pedido_recoleccion', 'wis_factura_item_container', '<?php echo $id; ?>');" class="btn waves-effect waves-light btn-primary">
					<i class="glyphicon glyphicon-plus"></i>
				</button>
			</span>
		</div>
		<?php
	}

}
