<?php

class mesaHTML {

	static function home($mesas, $tipo_negocio, $modulo = '', $obs) {
		?>

		<div class="centra-contenido aside_vertical wis_bloque <?php echo $modulo; ?>">
			<div class="tables_container">           
				<?php
				if ($mesas) {
					foreach ($mesas as $key => $value) {
						?>
						<div class="mesas_contenedor"  onmouseover="this.style.opacity = 0.7" onmouseout="this.style.opacity = 1" onclick="<?php echo $modulo; ?>_accion(<?php echo $value['id_mesa'] ?>,<?php echo $value['estado_id'] ?>, '<?php echo $modulo; ?>');">
							<div id="mesa_<?php echo $value['id_mesa'] ?>" class="item-mesa">
				<?php if ($value['estado_id'] == 11) { ?>
									<div class="mesa-estado">
										<img src="fw/themes/<?php echo $tipo_negocio; ?>/img/disponible.png">
									</div>
				<?php } elseif ($value['estado_id'] == 12) { ?>
									<div class="mesa-estado">
										<img src="fw/themes/<?php echo $tipo_negocio; ?>/img/reservado.png">
									</div>
				<?php } else { ?>
									<div class="mesa-estado">
										<img src="fw/themes/<?php echo $tipo_negocio; ?>/img/ocupado.png">
									</div>
				<?php } ?>
								<div class="mesa-icono">
									<img src="fw/themes/<?php echo $tipo_negocio; ?>/img/mesa2.png">
								</div>
								<span id="texto-mesa"><?php echo $value['nombre']; ?></span>
							</div>
						</div>
					<?php
					}
				} else {
					?>
					<p>NO HAY MESAS CREADAS</p>
		<?php } ?>           
			</div>
		</div>
		<div id="subarea_trabajo" class="wis_bloque"></div>
		<?php
	}

	static function pintar_fila($parametros, $observacion) {
		?>
		<input id="<?php echo $parametros->id ?>_input" name="<?php echo $parametros->id ?>_nombre_corto" class="pedido-columna" value="<?php echo $parametros->nombre_corto ?>" readonly>
		<input type="hidden" id="<?php echo $parametros->id ?>_prodid" name="<?php echo $parametros->id ?>_prodid" value="<?php echo $parametros->id ?>">
		<select name="<?php echo $parametros->id ?>_observacion" id="<?php echo $parametros->id ?>_observacion" class="pedido-columna">
			<?php foreach ($observacion as $key => $value) { ?>        
				<option value="<?php echo $value['id_observacion'] ?>"><?php echo $value['nombre'] ?></option>
		<?php } ?>
		</select>
		<input class="pedido-columna pedido-precio" name="<?php echo $parametros->id ?>_precio" value="<?php echo $parametros->precio ?>" readonly>
		<!--<input onchange="adicionar_hide(this.value,this.id)" id="<?php echo $parametros->id ?>_producto_cantidad" class="pedido-costo pedido-columna" value="<?php echo $parametros->cant ?>">-->
		<div id="<?php echo $parametros->id ?>_producto_cantidad" class="pedido-costo pedido-columna"><?php echo $parametros->cant ?>
		</div>
		<input class="unica_producto_hide" id="<?php echo $parametros->id ?>_producto_cantidad_hide" type="hidden" name="<?php echo $parametros->id ?>_cantidad" value="<?php echo $parametros->cant ?>">
		<button type="button" onclick="removeProducto(<?php echo $parametros->id ?>,<?php echo $parametros->precio ?>, 'numerico_total_pedido')" class="red-button">X</button>
		</div> <!--este div cierra el div que se abre desde js que se llama pedido-fila-->       
		<?php
	}

	//--------------------------------------------------------------- Toolbar segun Estado ----------------------------------------------------------//
	//----------------------------------------------------------- Menu Ver Pedido-------------------------------------------------------------//

	static function mostrar_pedido($modulo, $cuenta, $pedidos = array(),$pedidos_detalle = array(), $total = 0, $var, $id_transaccion = '', $info_negocio = '', $transa = '') {
		if ($cuenta['id_cuenta']) {
			?>
			<div class="factura_cabecera">	
				<table class="header-section">
					<tr>
						<th>
							<div class="factura_cuenta">
								<p> Cuenta</p>           
							</div>
						</th>	
						<td>
							<div class="factura_cuenta factura_cuenta_numero">
								<p><?php echo $cuenta['id_cuenta'] ?></p>           
							</div>
						</td>	
					</tr>
					<tr>
						<th>
							<p> Mesa</p>
						</th>
						<td>
							<p><?php
								if (isset($cuenta['mesa']) && $cuenta['mesa'] != '') {
									echo $cuenta['mesa'];
								}
								?>
							</p>
						</td>
					</tr>
					<tr>
						<th>
							<p> Mesero </p>
						</th>
						<td>
							<p><?php echo $cuenta['mesero']; ?></p>
						</td>
					</tr>
				</table>
				<!--
				<div class="cerrar_pedidos">
					<button onclick="ocultar_pedido()" type="button" class="red-button cerrar_pedido" >Cerrar</button>
				</div>
				-->
			</div>
			<div class="vista_pedido">
				<div id="productos_container_pedidos_factura" class="productos_container">
					<?php
					require_once('app/vista/html/menu.html.php');
					menuHTML::parametros_producto();
					?>       
				</div>            
				<form id="pedido_producto_form" action="?opcion=facturar&a=facturar&id_cuenta=<?php echo $cuenta['id_cuenta'] ?>" method="post">
					<div id="pedidos_container_ver">
						<table>
						<?php
						if ($cuenta && $pedidos) {
							foreach ($pedidos as $pedido) { ?>
								<tr>
									<td>
										<label>Pedido : <?php echo $pedido['id_pedido']; ?></label>
										<table>
											<?php
											foreach ($pedidos_detalle[$pedido['id_pedido']] as $k => $item) { ?>
												<tr id="<?php echo $item['id_producto'] ?>_pedido" class="pedido-fila">
													<?php foreach ($item as $campo => $valor) { ?>
														<input type="hidden" name="<?php echo $valor."_".$campo; ?>" value="<?php echo $valor; ?>">
													<?php } ?>
													<td><?php echo $item['nombre_corto'] ?></td>
													<td>$<?php echo $item['precio_format']; ?></td>
													<td><?php echo $item['cantidad'] ?></td>
													<td>$<?php echo number_format($item['precio'] * $item['cantidad']); ?></td>
													<td>
														<a onclick="restarProducto(<?php echo $item['id_producto'] ?>,<?php echo $item['precio'] ?>, 'numerico-total-ver-pedido', 'pedido')" class="red-button">-</a>
														<button onclick="removePedido(<?php echo $item['id_producto'] ?>,<?php echo $item['precio'] ?>)" class="red-button">X</button>          
													</td>
												</tr>
											<?php } ?>
										</table>
										</td>
								</tr>
						<?php } ?>
							</table>
						</div>
						<input type="hidden" name="id_pedido_hide" value="<?php echo $cuenta['id_cuenta'] ?>">
						<div class="facturar_resumen">
							<div class="total-pedidos">
								<p class="letra-total letra-resumen"> Subtotal: </p>
								<p class="letra-total letra-resumen">$<?php echo number_format($total, 0); ?></p>
							</div>
							<div class="total-pedidos ">
								<p class="letra-total letra-resumen"> Servicio: </p>
								<p class="letra-total letra-resumen">$<?php echo number_format($total, 0); ?></p>
							</div>
							<div class="total-pedidos">
								<p class="letra-total"> TOTAL: </p>
								<p id="numerico-total-ver-pedido" class="letra-total letra-valor-final">$<?php echo number_format($total, 0); ?></p>
							</div>
						</div>
					<?php } else { ?>
						<p> No tiene pedidos activos</p>
			<?php } ?>
					<div class="button-container">
						<button onclick="volver_mesasV('<?php echo $modulo; ?>')" type="button" class="opcion-button" >volver</button>

						<?php if ($var == 1) { ?>
							<button id="boton-facturar-factura" type="submit" class="opcion-button" >Facturar</button>
						<?php } elseif ($var == 2 && $id_transaccion != '') { ?>
							<button id="boton-imprimir-factura" type="button" onclick="crear_factura(<?php echo $cuenta['id_mesa'] ?>,<?php echo $id_transaccion ?>,<?php echo $total ?>)" class="opcion-button">Imprimir</button>
						<?php } elseif ($var == 2 && $id_transaccion == '') { ?>
							<button id="boton-imprimir-factura" onclick="crear_factura(<?php echo $cuenta['id_mesa'] ?>, '',<?php echo $total ?>)" class="opcion-button">Imprimir</button>
			<?php } ?>
					</div> 
				</form>
			</div>
			<script type="text/javascript">
				var datos_negocio = <?php echo json_encode($info_negocio) ?>;
			</script>
			<script type="text/javascript">
				var items = <?php echo json_encode($transa) ?>;
			</script>                  
			<?php
		}
	}

}
