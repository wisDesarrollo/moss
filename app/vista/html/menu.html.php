<?php

class menuHTML{
    static function menu($id,$categorias='',$productos='',$id_pedido,$nombre_mesa,$opciones=''){?>
            <button onclick="mostrarPedido()" type="button" class="mostrar-pedido opcion-button" ><<<</button>
            <div id="pedido-lista-oculto">
                <div id="head-pedido">
                    <button onclick="ocultarPedido()" type="button" class="ocultar-pedido opcion-button">>>></button>
                    <div class="encabezado-pedido">
                    Tomar Pedido - Mesa:<?php echo $nombre_mesa; ?>
                    -Pedido:<?php if($id_pedido != ''){ echo $id_pedido;
                                  }else{ echo "#"; }?>
                    </div>
                </div>
                <div id="cuerpo-pedido">                       
                    <?php  menuHTML::parametros_producto('observacion'); ?>
                    <form id="form_pedido" action="?opcion=mesas_visual&a=confirmar_pedido&id_mesa=<?php echo $id?>" method="post">
                        <div id="pedido-productos-lista" >

                        </div><!--este div cierra el div que se abre desde js que se llama pedido-fila-->
                        </div>
                </div>
                        <div class="total">
                                <p class="letra-total"> TOTAL: </p>
                                <p id="numerico_total_pedido" class="letra-total"> 0 </p>
                        </div>
                        <button id="cancel_button_pedido" type="button" class="opcion-button" >cancelar</button>
                        <button onclick="confirmarPedido()" type="button" class="opcion-button" >confirmar</button>
                    </form>
            </div>        
            <?php menuHTML::pintar_menu($categorias,$productos,$opciones); ?>
            <div id="ver-pedido-container">

            </div>
            <script>
            $('#cancel_button_pedido').click(function(){                
                deshacer_pedido('numerico_total_pedido');
            });
            </script>

    <?php  }
    static function pintar_toolbar_tables($opciones=''){
        if($opciones != ''){?>
            <div class="tables-toolbar">
            <?php foreach ($opciones as $key => $value) {?>        
                    <button class="opcion-button" onclick="<?php echo $key ?>(<?php echo $value ?>)"> <?php echo $key ?> </button>
            <?php } ?>
            </div>
            <?php
        }
    }
    static function parametros_producto($observacion=''){?>
		<div class="pedido-fila pedido-header">        
            <div class="pedido-columna">
                <p class="letra-producto"> PRODUCTO </p>
            </div>
            <?php if($observacion != ''){?>
            <div class="pedido-columna">
                <p class="letra-producto"> OBSERV. </p>
            </div>
            <?php } ?>
            <div class="pedido-columna pedido-precio">
                <p class="letra-producto"> PRECIO </p>
            </div>
            <div class="pedido-columna pedido-costo">
                <p class="letra-producto"> CANT </p>
			</div>
			<div class="pedido-columna pedido-precio">
                <p class="letra-producto"> SUBTOTAL </p>
			
		</div>
    <?php
    }
    static function pintar_menu($categorias='',$productos='',$opciones=''){?>
        <div class="menujq">
            <div class="header-section"><p>Menu</p></div>
            <?php menuHTML::pintar_toolbar_tables($opciones); ?>
            <ul>
                <?php if($categorias){
                    foreach ($categorias as $key => $value) {?>
                    <li><a href="javascript:void();"><?php echo $value['nombre'] ?>
                        </a>
                        <ul>
                        <?php  foreach ($productos as $k => $valor) {
                            if($valor['producto_categoria_id']==$value['id_producto_categoria']){                            
                                $nombre_corto=$valor['nombre_corto'];
                                $precio=$valor['precio'];?>
                                <li>
                                    <div id="product">
                                        <button onclick="addProduct(<?php echo $valor['id_producto']?>,<?php echo "'".$nombre_corto ."'"; ?>,<?php echo $precio;?>)" type="button" class="red-button">+</button>
                                        <button onclick="restarProducto(<?php echo $valor['id_producto']?>,<?php echo  $valor['precio']?>,'numerico_total_pedido','producto')" class="red-button">-</button>
                                        <button onclick="mostrar_preview(<?php echo $valor['id_producto']; ?>,<?php echo "'".$nombre_corto ."'"; ?>,<?php echo "'".$valor['descripcion'] ."'"; ?>,<?php echo "'".$valor['imagen'] ."'"; ?>)" class="preview-boton">Preview</button>
                                        <a onclick="addProduct(<?php echo $valor['id_producto']?>,<?php echo "'".$nombre_corto ."'"; ?>,<?php echo $precio;?>)" class="producto_nombre_corto"> <?php echo $nombre_corto ?></a> 
                                    </div>
                                </li>
                            <?php } ?>                             
                        <?php } ?>
                        </ul>
                    </li>               
              <?php }
                }else{?>
                    <p> Debe crear las categorias para su visualizacion </p>
                    <?php
                }?>
            </ul>
            </div>            
        </div>       
        <div class="preview_productos">
            <div class="producto_view">
                <div  id="titulo_producto" ><p id="encabezado_producto-preview"></p></div>
                <div id="producto_img"><img id="img_producto" src="" height="100" width="200"></div>
                <div id="descripcion_pr"><p id="producto_descripcion"></p>
                <button class="opcion-button" onclick="ocultar_preview()">Ocultar</button>
                </div>
            </div>
        </div>

    <script type="text/javascript">
        $(document).ready(function(){
            $('.menujq > ul > li:has(ul)').addClass('desplegable');
            $('.menujq > ul > li > a').click(function() {
                var comprobar = $(this).next();
                $('.menujq li').removeClass('activa');
                $(this).closest('li').addClass('activa');
                if((comprobar.is('ul')) && (comprobar.is(':visible'))){
                    $(this).closest('li').removeClass('activa');
                    comprobar.slideUp('normal');
                }
                if((comprobar.is('ul')) && (!comprobar.is(':visible'))) {
                    $('.menujq ul ul:visible').slideUp('normal');
                    comprobar.slideDown('normal');
                }
            });
        });
    </script>
<?php }
}