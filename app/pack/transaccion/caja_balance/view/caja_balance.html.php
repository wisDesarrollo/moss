<?php

Class CajaBalanceHTML {

    static function ver_balance_form($caja, $caja_estado, $id_caja) {
        ?>
        <div id="caja_contenedor" class="container-fluid">
            <div class="row">
                <?php
                foreach ($caja as $campo => $valor) {
                    //self::balance_item($campo, $valor);
                }
                ?>
            </div>
            <div>
                <?php if ($caja_estado == ESTADO_VIGENTE) { ?>
                    <div id="form_nueva_caja">
                        <button type="button"  onclick="cajaCerrar();">Cerrar Caja</button>
                    </div>
                <div id="form_caja_actualizar" class="hidden">
                        <label>Efectivo</label>
                        <input type="number" name="efectivo_cierre" id="efectivo_cierre" >
                        <input type="hidden" name="id_caja" id="id_caja" value="<?php echo $id_caja; ?>">
                        <button type="button"  onclick="actualizarCaja();">Actualizar Caja</button>
                    </div>
                <?php } else { ?>
                    <div id="form_nueva_caja">
                        <label>Nueva Base</label>
                        <input type="number" name="base_nueva" id="base_nueva">
                        <button type="button" onclick="cajaAbrir();">Abrir Caja</button>
                    </div>
                <?php } ?>
            </div>
        </div>
        <?php
    }

    static function balance_item($label, $valor){ ?>
        <div class="col-xs-6 col-sm-4 col-md-3 col-lg-1 caja_balance_item">
            <label><?php echo $label; ?></label>
            <p><?php echo $valor; ?></p>
        </div>
        <?php
    }

}
