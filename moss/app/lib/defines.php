<?php
/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/*
CONST PATH_CONTROLLER = "fw/template/standard/controller/";
CONST PATH_EXT_PLUGIN = "fw/lib/plugin/_inc/";
CONST PATH_JS_LIB = "fw/lib/js/";
CONST PATH_TEMPLATE = "fw/template/standard/";
CONST PATH_FW_DEFAULT = "fw/template/_default/";
CONST PATH_FW_PACK = "fw/pack/modulo/";
 * */

/*WIS FW TIPO MODULO*/



/* WIS APP PLUGIN PATHS */
define('PATH_APPLIB_OPERACIONES','app/lib/class/operaciones.class.php');
define('PATH_APP_PLUGINS','app/lib/plugin/');


/* WIS APP PLUGIN  */
define('APP_PLUGIN_OPERACIONES','operaciones/controller/operaciones.class.php');
define('APP_PLUGIN_OPERACIONES_VIEW','operaciones/view/operaciones.html.php');


/* APP TITULOS */
define('TITULO_COMPRAS_REGISTRO', 'Registrar Compra'); 


/* APP CONFIGURACION PARAMETROS LABOR COMERCIAL */
define('SERVICIO_COMISION', 0.1); 
define('IVA', 0.16); 
define('FACTURA_SUBTOTAL', 'factura_subtotal');