<?php

class InvFisicoHTML{
    function home($encabezado='',$contenido,$proveedor,$modulo=''){
        ?> 
        <div class=" bg_form formulario_auxiliar">
            <div class="formulario_auxiliar_bloque">
                <h1>Lectura R&aacute;pida</h1>
                <input type="text" name="<? echo $campo; ?>_ingreso" id="<? echo $campo; ?>_ingreso" title="<? echo $campo; ?>" placeholder="<? echo $campo; ?>" onchange="request_function('?opcion=productos_inventario&a=buscar&campo=<? echo $campo; ?>&valor=', 'codigo_barras_ingreso', this);">
                <input type="button" name="" id="" value="-->" title=""  onclick="request_function('?opcion=productos_inventario&a=buscar&campo=<? echo $campo; ?>&valor=', 'codigo_barras_ingreso', this);">
                <div id="mensaje"></div>
            </div>
            <div id="lectura_detalles" class="formulario_auxiliar_bloque">
                <table>
                    <tr>
                        <td></td>
                        <td></td>
                    </tr>
                </table>
            </div>
            
        </div>  
 	<?php } 
}
   ?> 