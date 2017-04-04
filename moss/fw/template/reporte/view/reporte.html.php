<?phpclass ReporteHTML {    function home($estados, $modulo, $title, $inicio = '', $nombre_campania = '') {        $colors = array('ENVIADO' => '00dd2f', 'PENDIENTE' => 'ff9900', 'RECHAZADO' => 'ff4040', 'FALLA_CONEXION' => 'ffdb00', 'DUPLICADO' => 'ffebcc', 'FALLIDO' => '6199df');        $src = 'http://chart.apis.google.com/chart?chs=350x150';        $cht = 'cht=p3';        $chtt = 'chtt=' . $title;        $chd = 'chd=t:';        $chdl = 'chdl=';        $chco = 'chco=';        foreach ($estados as $key => $value) {            $chd = $chd . str_replace('.', '', $value) . ',';            $chdl = $chdl . $value . ' ' . $key . '|';            $chco = $chco . $colors[$key] . ',';        }        $chco = substr($chco, 0, -1);        $chdl = substr($chdl, 0, -1);        $chd = substr($chd, 0, -1);        $src = $src . '&' . $chd . '&' . $cht . '&' . $chtt . '&' . $chdl . '&' . $chco;        ?>        <div style="margin-left:20px">            <?php if ($inicio != '') { ?>                <button onfocus="this.blur()" class="boton_datatable" onclick="<?php echo "peticion_ajax('?opcion=" . $inicio . "&type=ajax','','area_trabajo');" ?>">Inicio</button>            <?php }            ?>            <?php            if (empty($estados)) {                echo '<p>No se encotraron registros.</p>';            } else {                ?>                <button  onfocus="this.blur()"class="boton_datatable"  onclick="<?php echo "peticion_ajax('?opcion=" . $modulo . "&type=ajax','','area_trabajo');" ?>">Detalle</button>                <!-- <div style="margin-top:10px" id="piechart" ><img src="<?php echo "http://chart.apis.google.com/chart?chs=350x150&chd=t:" . $aprobados . "," . $cancelados . "," . $stand_by . "&cht=p3&chdl=" . $aprobados . " APROBADAS|" . $cancelados . " RECHAZADAS|" . $stand_by . " STAND_BY&chco=00dd2f,ff4040,ffdb00&chtt=" . $title; ?> "></div> -->                <p style="margin-top:30px"><b><?php echo $nombre_campania; ?></b> </p>                <div style="margin-top:10px; float: left;" id="piechart" ><img src="<?php echo $src; ?> "></div>                <?php            }            ?>        </div>        <?php    }    function grafico($modulo, $inicio = '', $nombre_campania = '') {        if ($inicio != '') {            ?>            <button onfocus="this.blur()"  class="boton_datatable" onclick="<?php echo "peticion_ajax('?opcion=" . $inicio . "&type=ajax','','area_trabajo');" ?>">Inicio</button>        <?php }        ?>        <button  onfocus="this.blur()" class="boton_datatable" onclick="<?php echo "peticion_ajax('?opcion=" . $modulo . "&type=ajax','','area_trabajo');" ?>" >Grafico</button>        <p style="margin-top:30px"><b><?php echo $nombre_campania; ?></b></p>        <?php    }// chart.apis.google.com/chart?chs=350×150&chd=t:45,0,5&cht=p3&chl=APROBADAS|RECHAZADAS|STAND_BY // chart.apis.google.com/chart?chs=250x100&chd=t:12.5,43.5,44.0&cht=p3&chl=Luis|Ana|Jesus// http://chart.apis.google.com/chart?chs=250x100&chd=t:12.5,43.5,44.0&cht=p3&chl=Luis|Ana|Jesus    function filtro($modulo, $interlocutor_id, $filtros, $fecha_ini = '', $fecha_fin = '', $usuarios = '', $campos_usuario, $usuario_seleccionado = '') {        ?>          <!-- <div class="encabezado_maestro">Comercio:  <?php echo $interlocutor_id ?>        </div> -->        <div class="store_cont_centrado">            <form action="<?php echo '?opcion=' . $modulo . '&a=filtro'; ?>" enctype="multipart/form-data" name="formulario_reporte" method="post" id="formulario_reporte" class="" >                 <table>                    <?php                    if ($usuarios != '') {                        ?>                        <tr>                            <td><b><?php echo $campos_usuario['label']; ?></b></td>                            <td>                                <select name='<?php echo $campos_usuario['value']; ?>' id="<?php echo $campos_usuario['value']; ?>">                                    <option value=''>Todos</option>                                    <?php                                    foreach ($usuarios as $key => $value) {                                        $selected = ($value[$campos_usuario['value']] == $usuario_seleccionado) ? "selected" : "";                                        ?>                                        <option value="<?php echo $value[$campos_usuario['value']] ?>" <?php echo $selected ?> ><?php echo utf8_encode($value[$campos_usuario['option']]); ?></option>                                        <?php                                    }                                    ?>                                </select>                            </td>                        </tr>                        <?php                    }                    ?>                    <tr>                        <td>                            <b>Desde</b>                        </td>                        <td>                            <input type="hidden" name="<?php echo $interlocutor_id['id'] ?>" value="<?php echo $interlocutor_id['value']; ?>">                            <div id="fecha_envio">                                <img id="calendario_ini"src="vista/img/calendario3.png" width="20px" height="25px">                                <input type="text" name="fecha_ini" id="fecha_ini" value="<?php echo $fecha_ini; ?>" required readonly>                            </div>                        </td>                        <td></td>                        <td>                            <b>Hasta</b>                        </td>                        <td>                            <div id="fecha_envio">                                <img id="calendario_fin"src="vista/img/calendario3.png" width="20px" height="25px">                                <input type="text" name="fecha_fin" id="fecha_fin" value="<?php echo $fecha_fin; ?>" required readonly>                            </div>                        </td>                        <td>                            <button onfocus="this.blur()" type="submit" id="guardar" class="store_button">Consultar</button>                        </td>                    </tr>                    <tr>                        <td>                            &nbsp;                        </td>                    </tr>                    <tr>                        <td>                            <b>Producto</b>                        </td>                        <td>                            <?php                            self::pintarLista('id_producto', $filtros['id_producto']['lista'], $filtros['id_producto']['campos'], $modulo);                            ?>                        </td>                    </tr>                </table>            </form>        </div>        <script type="text/javascript">            $("#fecha_ini").datetimepicker({                lang: 'es',                format: 'Y-m-d H:i:s'            });            $("#fecha_fin").datetimepicker({                lang: 'es',                format: 'Y-m-d H:i:s'            });            $('#calendario_ini').click(function () {                $('#fecha_ini').datetimepicker('show');            });            $('#calendario_fin').click(function () {                $('#fecha_fin').datetimepicker('show');            });        </script>        <?php    }    function graficar($estados, $title = '') {        $colors = array('ENVIADO' => '00dd2f', 'PENDIENTE' => 'ff9900', 'RECHAZADO' => 'ff4040', 'FALLA_CONEXION' => 'ffdb00', 'DUPLICADO' => 'ffebcc', 'FALLIDO' => '6199df',            'Elibom' => '00dd2f', 'SmartD' => 'ff9900', 'Conexred' => 'ff4040', 'Solidda' => 'ffdb00', 'Claro' => 'ffebcc');        $src = 'http://chart.apis.google.com/chart?chs=350x150';        $cht = 'cht=p3';        $chtt = 'chtt=' . $title;        $chd = 'chd=t:';        $chdl = 'chdl=';        $chco = 'chco=';        foreach ($estados as $key => $value) {            // $chd=$chd.$value.',';            $chd = $chd . str_replace('.', '', $value) . ',';            $chdl = $chdl . $value . ' ' . $key . '|';            $chco = $chco . $colors[$key] . ',';        }        $chco = substr($chco, 0, -1);        $chdl = substr($chdl, 0, -1);        $chd = substr($chd, 0, -1);        $src = $src . '&' . $chd . '&' . $cht . '&' . $chtt . '&' . $chdl . '&' . $chco;        ?>        <div style="margin-left:20px">            <?php            if (empty($estados)) {                // echo '<p>No se encotraron registros.</p>';            } else {                ?>                <div style="margin-top:10px; float: left;" id="piechart" ><img src="<?php echo $src; ?> "></div>                <?php            }            ?>        </div>        <?php    }    function filtro_gasto($modulo, $fecha_ini = '', $fecha_fin = '', $usuarios = '', $campos_usuario, $usuario_seleccionado = '', $interlocutores = '', $campos_interlocutor = '', $interlocutor_seleccionado = '') {        ?>          <form action="<?php echo '?opcion=' . $modulo . '&a=filtro'; ?>" enctype="multipart/form-data" name="formulario_reporte" method="post" id="formulario_reporte" class="" >             <table>                <?php                if ($usuarios != '') {                    ?>                    <tr>                        <td><b><?php echo $campos_usuario['label']; ?></b></td>                        <td>                            <select name='<?php echo $campos_usuario['name']; ?>' id="<?php echo $campos_usuario['name']; ?>" onchange='traer_clientes(this);' >                                <option value=''>Todos</option>                                <?php                                foreach ($usuarios as $key => $value) {                                    $selected = ($value[$campos_usuario['value']] == $usuario_seleccionado && $usuario_seleccionado != '') ? "selected" : "";                                    ?>                                    <option value="<?php echo $value[$campos_usuario['value']] ?>" <?php echo $selected ?> ><?php echo utf8_encode($value[$campos_usuario['option']]); ?></option>                                    <?php                                }                                ?>                            </select>                        </td>                    </tr>                    <?php                }                // if ($interlocutores!='') {                ?>                <tr>                    <td><b><?php echo $campos_interlocutor['label']; ?></b></td>                    <td>                        <select name='<?php echo $campos_interlocutor['name']; ?>' id="<?php echo $campos_interlocutor['name']; ?>">                            <option value='' >Todos</option>                            <?php                            foreach ($interlocutores as $key => $value) {                                $selected = ($value[$campos_interlocutor['value']] == $interlocutor_seleccionado && $interlocutor_seleccionado != '') ? "selected" : "";                                ?>                                <option value="<?php echo $value[$campos_interlocutor['value']] ?>" <?php echo $selected ?> ><?php echo utf8_encode($value[$campos_interlocutor['option']]); ?></option>                                <?php                            }                            ?>                        </select>                    </td>                </tr>                <?php                // }                ?>                <tr>                    <td>                        <b>Desde</b>                    </td>                    <td>                            <!-- <input type="hidden" name="<?php echo $interlocutor_id['id'] ?>" value="<?php echo $interlocutor_id['value']; ?>"> -->                        <div id="fecha_envio">                            <img id="calendario_ini"src="vista/imagenes/calendario3.png" width="20px" height="25px">                            <input type="text" name="fecha_ini" id="fecha_ini" value="<?php echo $fecha_ini; ?>" required readonly>                        </div>                    </td>                    <td></td>                    <td>                        <b>Hasta</b>                    </td>                    <td>                        <div id="fecha_envio">                            <img id="calendario_fin"src="vista/imagenes/calendario3.png" width="20px" height="25px">                            <input type="text" name="fecha_fin" id="fecha_fin" value="<?php echo $fecha_fin; ?>" required readonly>                        </div>                    </td>                    <td>                        <button onfocus="this.blur()" type="submit" id="guardar" value="Guardar" class="guardar">                    </td>                </tr>            </table>        </form>        <script type="text/javascript">            $("#fecha_ini").datetimepicker({                lang: 'es',                format: 'Y-m-d H:i:s'            });            $("#fecha_fin").datetimepicker({                lang: 'es',                format: 'Y-m-d H:i:s'            });            $('#calendario_ini').click(function () {                $('#fecha_ini').datetimepicker('show');            });            $('#calendario_fin').click(function () {                $('#fecha_fin').datetimepicker('show');            });        </script>        <?php    }    function pintar_option($option) {        ?><option value='' >Todos</option><?php foreach ($option as $value) { ?>            <option value="<?php echo $value['id_interlocutor'] ?>"><?php echo($value['nombre']) ?></option>            <?php        }    }    function pintarLista($nombre, $lista_elementos, $campos, $modulo) {        ?>        <select name='<?php echo $nombre; ?>' id="<?php echo $nombre; ?>" onchange='validarFiltro(this, "<?php echo $modulo; ?>", "pintar_reporte");'>            <option value=''>Todos</option>            <?php            foreach ($lista_elementos as $key => $item) {                $selected = '';                //$selected = ($value[$campos_usuario['value']] == $usuario_seleccionado) ? "selected" : "";                ?>                <option value="<?php echo $item['ID'] ?>" <?php echo $selected ?> ><?php echo utf8_encode($item['nombre']); ?></option>                <?php            }            ?>        </select>        <?php    }    static function resumen($resumen) {        ?>        <div class="reporte_resumen store_cont_centrado">            <h6>Resumen</h6>            <ul>                <?php                foreach ($resumen as $item) {                    ?>	                    <li class="reporte_resumen_item">                        <h5><?php echo $item['titulo']; ?></h5>                        <b><?php echo $item['datos']['valor']; ?></b>                    </li>                <?php }                ?>            </ul>        </div>        <?php    }    static function filtros() {        ?>        <div>            <form>                <div>                    <select>                        <option id="0">Ninguno</option>                    </select>                </div>            </form>        </div>        <?php    }    static function mostrar_datos_item($transaccion) {        ?>        <div class="reporte_detalle">            <div id="reporte_detalle_cabecera">                <table>                    <?php foreach ($transaccion['trx'] as $campo => $dato) { ?>                        <tr>                            <th><?php echo $campo; ?></th>                            <td><?php echo $dato; ?></td>                        </tr>                    <?php } ?>                </table>            </div>            <div id="reporte_detalle_items">                <table>                    <tr>                    <?php foreach ($transaccion['items'][0] as $campo => $valor) { ?>                            <th><?php echo $campo; ?></th>                    <?php } ?>                            </tr>                    <?php foreach ($transaccion['items'] as $dato) { ?>                        <tr>                        <?php foreach ($dato as $campo => $valor) { ?>                            <td><?php echo $valor; ?></td>                    <?php } ?>                            </tr>                <?php } ?>                </table>            </div>        </div>        <?php    }}