<?php

class NavHTML {

    static function home($opciones) {
        ?>
        <div class="hidden-xs" >
        <?php foreach ($opciones as $key => $opcion) { ?>
                <div class="menu_opcion" id="menu_opcion_<?php echo $opcion['id_opcion'] ?>" onclick="validarItemMenu('subopcion', 'id',<?php echo $opcion['id_opcion'] ?>)"  onmouseover="over_submenu(1, '<?php echo $opcion['id_opcion'] ?>', '<?php echo $opcion['imagen'] ?>', 'opcion')"  onmouseleave="over_submenu(0,'<?php echo $opcion['id_opcion'] ?>','<?php echo $opcion['imagen'] ?>','opcion'); ">		
                    <div class="menu_imagen">

                    </div>
                    <div class="menu_descripcion">
            <?php echo utf8_encode($opcion['descripcion']); ?>
                    </div>
                </div>	
        <?php } ?>
            <div class="menu_opcion" id="menu_opcion_salir" onclick="cerrarSesionConfirmar();" >
                <div class="menu_imagen">

                </div>
                <div class="menu_descripcion">
                    Salir
                </div>
            </div>	
        </div>
    <?php
    }

}
