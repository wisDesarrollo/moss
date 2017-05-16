<?php

class comandasHTML {

    static function home($pedidos, $modulo) {
        ?>
        <div id="comandas-container">
            <div id="comanda_toolbar">
                <a href="#" onclick="recuperar_pedido_item()">Deshacer</a>
            </div>
            <div class="pedidos-ver">
                <?php
                if ($pedidos && $pedidos != '') {
                    $i = 0;
                    foreach ($pedidos as $id_pedido => $pedido) {
                        if ((isset($pedido['items'])) && count($pedido['items']) > 0) {
                            ?>		    			
                            <div class="comanda-pedido" >
                                <img src="app/vista/img/tache.png" class="img-responsive" alt="Image">			    			
                                <table class="comanda_header_table">
                                    <tr>
                                        <td>
                                            <table class="comanda-tbdatos">
                                                <tr>
                                                    <th><h4>Mesa</h4></th>
                                                    <td><h3><?php echo $pedido['datos']['mesa']; ?></h3></td>
                                                </tr>
                                                <tr>
                                                    <th>Pedido</th>
                                                    <td><?php echo $id_pedido; ?></td>
                                                </tr>
                                                <tr>
                                                    <th>Mesero</th>
                                                    <td><?php echo $pedido['datos']['mesero']; ?></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>

                                        </td>
                                    </tr>
                                </table>
                                <table class="comanda-tbdatos comanda_prioridad_<?php echo $pedido['datos']['prioridad']; ?>" id="comanda_tiempo">
                                    <tr>
                                        <td>
                                            <div >TIEMPO   <?php echo substr($pedido['datos']['tiempo_despacho'], 0, 5); ?></div>
                                        </td>
                                    </tr>
                                </table>

                                <table class="comanda-tbitems">
                                    <tr>
                                        <th>Cant.</th>
                                        <th>Producto</th>
                                        <th>Obs.</th>
                                    </tr>
                                    <?php
                                    foreach ($pedido['items'] as $item) {
                                        ?>
                                        <tr>
                                            <?php
                                            foreach ($item as $llave => $valor) {
                                                if ($llave != 'estado_id' && $llave != 'id_pedido_item' && $llave != 'Mesa') {
                                                    ?>
                                                    <td>
                                                        <?php echo $valor; ?>
                                                    </td>
                                                    <?php
                                                }
                                            }
                                            ?>
                                            <td>
                                                <?php if ($item['estado_id'] == ESTADO_PEDIDO_TOMADO) { ?>
                                                    <button onclick="despachar_pedido_item(<?php echo $item['id_pedido_item']; ?>, <?php echo ESTADO_PEDIDO_SERVIDO; ?>)" class="comanda-button button">
                                                        <span class="glyphicon glyphicon-ok">Preparar</span>
                                                    </button>
                                                <?php } ?>
                                                <?php if ($item['estado_id'] == ESTADO_PEDIDO_SERVIDO) { ?>
                                                    <button onclick="despachar_pedido_item(<?php echo $item['id_pedido_item']; ?>, <?php echo ESTADO_PEDIDO_ENTREGADO; ?>)" class="comanda-button button">
                                                        <span class="glyphicon glyphicon-ok">Despachar</span>
                                                    </button>
                                                <?php } ?>
                                                <?php if ($item['estado_id'] == ESTADO_PEDIDO_ENTREGADO) { ?>
                                                    <span class="glyphicon glyphicon-ok">Entregado</span>
                                                <?php } ?>
                                            </td>
                                            <td>
                                                <?php if ($item['estado_id'] != ESTADO_PEDIDO_ENTREGADO) { ?>
                                                    <button onclick="cancelar_pedido_item(<?php echo $item['id_pedido_item']; ?>,<?php echo $pedido['datos']['id_mesa']; ?>)" class="comanda-button  red-button">
                                                        <span class="glyphicon glyphicon-remove"></span>
                                                    </button>
                                                <?php } ?>
                                            </td>
                                        </tr>
                                        <?php
                                    }
                                    ?>
                                </table>
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
            modulo_refrescar('<?php echo $modulo; ?>', true, 15000, false, 'area_trabajo');
        </script>
        <?php
    }

}
