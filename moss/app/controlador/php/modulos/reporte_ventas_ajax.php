<?php

/*
UNICAMENTE UTILIZADO PARA PRUEBAS
*/

require('../../../../fw/controlador/php/lib/app_config.class.php');
// SQL server connection information

$config = new App_Config();

$sql_details = array(
	'user' => $config->_get('usuario'),
	'pass' => $config->_get('clave'),
	'db'   => $config->_get('base_datos'),
	'host' => $config->_get('host')
);

// DB table to use
$table = 'producto';

// Table's primary key
$primaryKey = 'id_producto';

$columns = array(

            array( 'db' => 'p.id_producto', 'dt' => 0, 'field' => 'id_producto' ),
            array( 'db' => 'p.referencia',  'dt' => 1, 'field' => 'referencia' ),
            array( 'db' => 'p.nombre',   'dt' => 2, 'field' => 'nombre' ),
            array( 'db' => 'p.iva',     'dt' => 3, 'field' => 'iva'),
            array( 'db' => 'pc.nombre',     'dt' => 4, 'field' => 'categoria','as'=>'categoria' ),
            array( 'db' => 'p.costo',     'dt' => 5, 'field' => 'costo', 
            	'formatter' => function( $d, $row ) {
							 return '$'.number_format($d);
				})
            );

$joinQuery = "FROM producto AS p JOIN producto_categoria AS pc ON (pc.id_producto_categoria = p.producto_categoria_id)";
$extraWhere = "";        
$groupBy = "";

require('../../../../fw/controlador/js/lib/DataTables/scripts/ssp.customized.class.php' );
echo json_encode(
	SSP::simple( $_GET, $sql_details, $table, $primaryKey, $columns, $joinQuery, $extraWhere,$groupBy)
);