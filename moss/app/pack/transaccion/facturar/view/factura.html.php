<?php

class FacturaHTML {

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

    static function pintar_item($items, $id_pedido) {
        ?>
        <?php foreach ($items[$id_pedido] as $k => $item) { ?>
            <tr id="<?php echo $item['id_pedido_item']; ?>_pedido_item" class="pedido-fila">
            <input type="hidden" name="<?php echo $item['id_pedido_item'] . "_id_pedido_item"; ?>" value="<?php echo $item['id_pedido_item']; ?>">
            <input type="hidden" name="<?php echo $item['id_pedido_item'] . "_id_producto"; ?>" value="<?php echo $item['id_producto']; ?>">
            <input type="hidden" name="<?php echo $item['id_pedido_item'] . "_precio"; ?>" value="<?php echo $item['precio']; ?>">
            <input type="hidden" name="<?php echo $item['id_pedido_item'] . "_cantidad"; ?>" value="<?php echo $item['cantidad']; ?>">
            <td><?php echo $item['nombre_corto'] ?></td>
            <td>$<?php echo $item['precio_format']; ?></td>
            <td><?php echo $item['cantidad'] ?></td>
            <td>$<?php echo number_format($item['precio'] * $item['cantidad']); ?></td>
            <td>
                <a onclick="restarProducto(<?php echo $item['id_pedido_item'] ?>,<?php echo $item['precio'] ?>, 'numerico-total-ver-pedido', 'pedido')" class="red-button">-</a>
                <button onclick="removePedido(<?php echo $item['id_pedido_item'] ?>,<?php echo $item['precio'] ?>)" class="red-button">X</button>          
            </td>
            </tr>
            <?php
        }
    }

    static function mostrar_pedido($modulo, $cuenta, $pedidos = array(), $pedidos_detalle = array(), $resumen = array(), $var = 1, $id_transaccion = '', $info_negocio = '', $transa = '', $id_mesa = 0) {
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
                </table>
            </div>
            <form id="pedido_producto_form" action="?opcion=facturar&a=facturar" method="post">
                <?php if ($cuenta && $pedidos) { ?>
                    <input type="hidden" name="id_cuenta" value="<?php echo $cuenta['id_cuenta'] ?>">
                    <input type="hidden" name="id_mesa" value="<?php echo $id_mesa; ?>">
                    <div class="vista_pedido">
                        <table>
                            <?php
                            self::parametros_producto();
                            foreach ($pedidos as $pedido) {
                                ?>
                                <tr>
                                    <td>
                                        <label>Pedido : <?php echo $pedido['id_pedido']; ?></label>
                                    </td>
                                </tr>
                                <?php
                                self::pintar_item($pedidos_detalle, $pedido['id_pedido']);
                            }
                            ?>
                        </table>
                    </div>
                    <div class="facturar_resumen" id="factura_resumen_totales">
                        <?php
                        self::factura_totales($resumen['subtotal'], $resumen['servicio'], $resumen['impuesto'], $resumen['total']);
                        ?>
                    </div>
                    <?php }else{ ?>
                        <p> No tiene pedidos activos</p>
                <?php } ?>
                <div class="button-container">
                    <?php if ($var == 1) { ?>
                        <button id="boton-facturar-factura" type="submit" class="opcion-button" >Facturar</button>
                    <?php } elseif ($var == 2 && $id_transaccion != '') { ?>
                        <button id="boton-imprimir-factura" type="button" onclick="crear_factura(<?php echo $cuenta['id_mesa'] ?>,<?php echo $id_transaccion ?>,<?php echo $resumen['total']; ?>)" class="opcion-button">Imprimir</button>
                    <?php } elseif ($var == 2 && $id_transaccion == '') { ?>
                        <button id="boton-imprimir-factura" onclick="crear_factura(<?php echo $cuenta['id_mesa'] ?>, '',<?php echo $resumen['total']; ?>)" class="opcion-button">Imprimir</button>
                    <?php } ?>
                </div> 
            </form>
            <script type="text/javascript">
                var datos_negocio = <?php echo json_encode($info_negocio) ?>;
            </script>
            <script type="text/javascript">
                var items = <?php echo json_encode($transa) ?>;
            </script>                  
            <?php
        }
    }

    static function parametros_producto($observacion = '') {
        ?>
        <tr class="pedido-fila pedido-header">        
            <th class="">
                <p class="letra-producto"> PRODUCTO </p>
            </th>
            <?php if ($observacion != '') { ?>
                <th class="">
                    <p class="letra-producto"> OBSERV. </p>
                </th>
            <?php } ?>
            <th class=" pedido-precio">
                <p class="letra-producto"> PRECIO </p>
            </th>
            <th class=" pedido-costo">
                <p class="letra-producto"> CANT </p>
            </th>
            <th class=" pedido-precio">
                <p class="letra-producto"> SUBTOTAL </p>
            </th>
            <th class=" pedido-precio">
                <p class="letra-producto">  </p>
            </th>
            
        </tr>
        <?php
    }

    static function factura_totales($subtotal, $servicio, $impuestos, $total, $check_value="") {
        ?>

        <div class="total-pedidos">
            <p class="letra-total letra-resumen"> Subtotal: </p>
            <p class="letra-total letra-resumen" id="factura_subtotal_formato">$<?php echo number_format($subtotal, 0); ?></p>
            <input type="hidden" id="factura_subtotal" name="factura_subtotal" value="<?php echo $subtotal; ?>">
        </div>
        <div class="total-pedidos ">
            <p class="letra-total letra-resumen"> Incluir Servicio </p>
            <input type="checkbox" id="incluir_servicio" name="incluir_servicio" onclick="factura_validar_servicio(this)" <?php echo $check_value; ?>>
        </div>
        <div class="total-pedidos ">
            <p class="letra-total letra-resumen"> Servicio: </p>
            <p class="letra-total letra-resumen" id="factura_servicio_formato">$<?php echo number_format($servicio, 0); ?></p>
            <input type="hidden" id="factura_servicio" name="factura_servicio" value="<?php echo $servicio; ?>">
        </div>
        <div class="total-pedidos ">
            <p class="letra-total letra-resumen"> Impuesto: </p>
            <p class="letra-total letra-resumen" id="factura_subtotal_formato">$<?php echo number_format($impuestos, 0); ?></p>
            <input type="hidden" id="factura_subtotal" name="factura_subtotal" value="<?php echo $impuestos; ?>">
        </div>
        <div id="factura_total_x_pagar" class="total-pedidos">
            <p class="letra-total"> TOTAL: </p>
            <p id="numerico-total-ver-pedido" class="letra-total letra-valor-final" >$<?php echo number_format($total, 0); ?></p>
            <input type="hidden" id="factura_total" name="factura_total" value="$<?php echo $total; ?>">
        </div>
        <?php
    }

}
