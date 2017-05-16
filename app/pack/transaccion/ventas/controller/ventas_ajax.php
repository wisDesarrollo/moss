<?php

session_start();
define('PATH_APP_CONFIG','fw/lib/config/app_config.class.php');
require_once('../../../../../'.PATH_APP_CONFIG);
// SQL server connection information

$config = new App_Config();

$sql_details = array(
    'user' => $config->_get('usuario'),
    'pass' => $config->_get('clave'),
    'db' => $config->_get('base_datos'),
    'host' => $config->_get('host')
);

$datos = $_SESSION[$config->_get('session')]['configuracion'];
// DB table to use
$table = 'producto';

// Table's primary key
$primaryKey = 'id_producto';

$columns = array(
    array('db' => 'p.id_producto', 'dt' => 0, 'field' => 'id_producto'),
    array('db' => 'p.referencia', 'dt' => 1, 'field' => 'referencia'),
    array('db' => 'p.barcode', 'dt' => 2, 'field' => 'barcode'),
    array('db' => 'p.nombre', 'dt' => 3, 'field' => 'nombre'),
    array('db' => 'ps.stock', 'dt' => 4, 'field' => 'stock'),
    array('db' => 'p.precio', 'dt' => 5, 'field' => 'precio',
        'formatter' => function( $d, $row ) {
            return '$' . number_format($d);
        }),
    array('db' => 'p.id_producto', 'dt' => 6, 'field' => 'input', 'as' => 'input',
        'formatter' => function( $d, $row ) {
            return '<input id=' . $d . '_add_cant class="add_cant" type="text" value="1" onchange="">';
        }),
    array('db' => 'p.id_producto', 'dt' => 7, 'field' => 'boton', 'as' => 'boton',
        'formatter' => function( $d, $row ) {
            $onclick = 'onclick="TrxAddProduct(\'' . $d . '\',\'ventas\');"';
            return '<button type="button" class="add_button" ' . $onclick . ' title="adicionar" onfocus="this.blur();">+</button>';
        }),
);

$joinQuery = " FROM producto p 
                LEFT JOIN producto_stock ps ON ps.producto_id = p.id_producto";
$extraWhere = "p.interlocutor_id='" . $datos['id_interlocutor'] . "' and p.estado_id <> 3 and ps.stock >= 0";
$groupBy = "";

require('../../../../../fw/lib/plugin/_inc/js/DataTables/scripts/ssp.customized.class.php' );
echo json_encode(
        SSP::simple($_GET, $sql_details, $table, $primaryKey, $columns, $joinQuery, $extraWhere, $groupBy)
);
