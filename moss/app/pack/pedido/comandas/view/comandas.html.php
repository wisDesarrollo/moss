<?php

class comandasHTML {

	static function home($pedidos, $modulo) {
		?>
		<div id="comandas-container">
			<div class="pedidos-ver">
				<?php
				if ($pedidos && $pedidos != '') {
					$i = 0;
					foreach ($pedidos as $id_pedido => $pedido) {
						if((isset($pedido['items'])) && count($pedido['items'])>0){
						?>		    			
						<div class="comanda-pedido">
							<img src="app/vista/img/tache.png" class="img-responsive" alt="Image">			    			
							<table class="comanda-tbdatos">
								<tr>
									<th>Pedido</th>
									<td><?php echo $id_pedido; ?></td>
								</tr>
								<tr>
									<th>Mesa</th>
									<td><?php echo $pedido['datos']['mesa']; ?></td>
								</tr>
								<tr>
									<th>Mesero</th>
									<td><?php echo $pedido['datos']['mesero']; ?></td>
								</tr>
							</table>
							<table class="comanda-tbitems">
								<tr>
									<th>Producto</th>
									<th>Obs.</th>
									<th>Cant.</th>
								</tr>
								<?php 
								foreach ($pedido['items'] as $item) {
									?>
									<tr>
										<?php
										foreach ($item as $llave => $valor) {
											if ($llave != 'estado_id' && $llave != 'id_pedido_item'  && $llave != 'Mesa') {
												?>
												<td>
													<?php echo $valor; ?>
												</td>
												<?php
											}
										}
										?>
										<td>
											<?php if($item['estado_id']== ESTADO_PEDIDO_TOMADO){ ?>
												<button onclick="despachar_pedido_item(<?php echo $item['id_pedido_item']; ?>, <?php echo ESTADO_PEDIDO_SERVIDO; ?>)" class="comanda-button button">
													<span class="glyphicon glyphicon-ok">Servir</span>
												</button>
											<?php } ?>
											<?php if($item['estado_id']== ESTADO_PEDIDO_SERVIDO){ ?>
												<button onclick="despachar_pedido_item(<?php echo $item['id_pedido_item']; ?>, <?php echo ESTADO_PEDIDO_ENTREGADO; ?>)" class="comanda-button button">
													<span class="glyphicon glyphicon-ok">Despachar</span>
												</button>
											<?php } ?>
										</td>
										<td>
											<button onclick="cancelar_pedido_item(<?php echo $id_pedido; ?>,<?php echo $datos_pedidos[0]['Mesa'] ?>)" class="comanda-button  red-button">
												<span class="glyphicon glyphicon-remove"></span>
											</button>
										</td>
									</tr>
									<?php
								}
								?>
							</table>
							
							</button>
						</div>
						<?php
						}
					}
				} else {
					?>
					<p> No se encontraron Pedidos activos </p>
				<?php } ?>
			</div>
		</div>
		<script>
			modulo_refrescar('<?php echo $modulo; ?>', true, 15000, false);
		</script>
		<?php
	}
}
