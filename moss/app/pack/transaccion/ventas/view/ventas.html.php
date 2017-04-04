<?php

class VentasHTML {
    
    static function ver_factura($transaccion, $items, $empresa, $cliente) {
        $total = 0;
        ?>
        <html>
        <head>
            <link rel="stylesheet"  media="print" href="fw/vista/css/factura_impresa.css" >
            <link rel="stylesheet"  media="screen" href="fw/vista/css/factura_impresa.css" >
            <link rel="stylesheet"  href="app/vista/css/transacciones.css" >
            <script type="text/javascript" src="app/controlador/js/transacciones.js"></script>
        </head>
        <body id="factura_formato_impreso">
            <div id="factura_impresa_contenedor" class="formato_tirilla">
                <div class="formato_general formato_100 formato_centrado" >
                    <table class="formato_100 formato_centrado">
                        <tr>
                            <td>
                                <h3><?php echo $empresa['empresa']; ?></h3>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <h5></h5>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <h6>NIT: <?php echo $empresa['NIT']; ?></h6>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <h6>Tel&eacute;fono: <?php echo $empresa['telefono']; ?></h6>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="formato_general formato_100">
                    <table >
                        <tr>
                            <td> <h4>FACTURA No.</h4></td>
                            <td><h6 class="factura_numero"><?php echo $transaccion['factura_numero']; ?></h6></td>
                        </tr>
                        <tr>
                            <td><b>Fecha </b></td>
                            <td><?php echo $transaccion['fecha']; ?></td>
                        </tr>
                    </table>
                </div>
                <div class="formato_general formato_100">
                    <table >
                        <tr>
                            <td><h4>CLIENTE</h4></td>
                            <td><?php echo $cliente['nombre']; ?></td>
                        </tr>
                        <tr>
                            <td><b>C&eacute;dula</b></td>
                            <td><?php echo $cliente['num_documento']; ?></td>
                        </tr>
                    </table>
                </div>
                <div class="formato_general formato_100">
                    <table id="items_tabla" >
                        <tr>
                            <td class="item_titulo">Nombre</td>
                            <td class="item_titulo ">Cantidad</td>
                            <td class="item_titulo ">Valor Unitario</td>
                            <td class="item_titulo ">Subtotal</td>
                        </tr>
                        <?php foreach ($items as $item) { ?>
                        <tr>
                            <td>
                                <?php echo $item['producto']; ?>
                            </td>
                            <td>
                                <?php echo $item['cantidad']; ?>
                            </td>
                            <td>
                                $<?php echo number_format($item['valor_unitario']); ?>
                            </td>
                            <td>
                                $<?php echo number_format($item['cantidad'] * $item['valor_unitario'], 2); ?>
                            </td>
                        </tr>
                        <?php
                        $total +=$item['cantidad'] * $item['valor_unitario'];
                    }
                    ?>
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr style="font-weight: bold;">
                        <td></td>
                        <td></td>
                        <td>TOTAL</td>
                        <td>$<?php echo number_format($transaccion['total']); ?></td>
                    </tr>
                </table>
            </div>
        </div>
        <div id="botones_accion" class="maestro_edit_form" style="float:left;width:100%;">
            <div id="" class="accion_boton">
                <button onfocus="this.blur()" type="button" id="guardar" value="Guardar" class="guardar  btn btn-success" onclick="imprimirElemento('<?php echo $transaccion['id_transaccion']; ?>');//javascript:demoFromHTML('#area_trabajo')">Vista De Impresi&oacute;n</button>
            </div>
            <div id="" class="accion_boton">
                <button onfocus="this.blur()" type="reset" id="cancelar" value="Cancelar" class="cancelar btn btn-danger"  onclick="window.location='index.php?opcion=ventas';">Regresar</button>
            </div>

        </div> 
    </body>
    </html>
    <?php
}

}
