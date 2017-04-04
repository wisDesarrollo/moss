<?php

class Ventas extends Operaciones{

    public function __construct($db = "", $modulo = "") {

        parent::__construct($db, $modulo);

        $this->tipo_contenido = 'ajax';
        $this->modulo = 'ventas';
        $this->transaccion_tipo    = TRX_VENTA;
        $this->comercio_clase      = CLASE_CLIENTE;
        $this->encabezado = array('REFERENCIA', 'BARCODE', 'PRODUCTO', 'CANTIDAD', 'IVA', 'IVA INCLUIDO', 'COSTO', 'COSTO IVA', 'SUBTOTAL');
        $this->encabezado_flotante = array('ID', 'REFERENCIA', 'BARCODE','PRODUCTO', 'STOCK', 'COSTO', 'CANTIDAD', 'ADD');
    }

    function registrar() {

        require_once 'fw/lib/class/transacciones.class.php';

        $transaccion = new Transacciones($this->db);
        $this->gn->set_data_loged('datos_trx',NULL );
        $id_interlocutor = $this->gn->get_data_loged('id_interlocutor');
        $post = $this->gn->traer_parametros('POST');

        $cliente = array();
        foreach ($post as $key => $value) {
            if (substr($key,0,8)=='cliente_') {
                $cliente[substr($key,8)] = $value;
                unset($post->$key);
            }
        }

        $observacion = $cliente['observacion'];
        unset($cliente['observacion']);

        if ($cliente['id_interlocutor']=='') {
            require_once 'fw/pack/base/interlocutor/controller//interlocutor.php';
            $interlocutor = new Interlocutor($this->db,'interlocutor');
            $cliente['interlocutor_id'] = $id_interlocutor;
            $cliente['interlocutor_clase_id'] = CLASE_CLIENTE;
            $cliente['id_interlocutor'] = $interlocutor->guardar_interlocutor($cliente);
        }

        if (!$cliente['id_interlocutor']) {
            $this->nc->set_notificacion('Error al crear el cliente');
            header('location:?opcion='.$this->modulo);
            return;
        }
        
       $factura_numeracion = $transaccion->numeracion_factura($id_interlocutor);
       
        if (!$factura_numeracion) {
            $this->nc->set_notificacion('Numeración de facturas no disponible');
            header('location:?opcion='.$this->modulo);
            return;
        }

        foreach($post as $item => $value){
            $item = explode('_', $item);
            $productos[$item[0]]->$item[1] = $value;
        }

        $venta = $transaccion->venta($factura_numeracion,$id_interlocutor,$cliente['id_interlocutor'],$observacion,$productos);

        if (!$venta) {
            $this->nc->set_notificacion('Error al registrar la venta');
            header('location:?opcion='.$this->modulo);
            return;
        }
        //TODO: Interrumpir el proceso para sacar la factura en una pestaña. 
        //Guardar los datos en variables y poner boton en interface de ventas para imprimir factura
        $this->ver_factura($venta, $cliente);
    }

    function trx_agregar_producto() {
        parent::trx_agregar_producto('precio');
  
    }

    function ver_factura($id_transaccion = NULL, $cliente = NULL) {
        $parametros = $this->gn->traer_parametros('GET');
        $id_interlocutor = $this->gn->get_data_loged('id_interlocutor');

        if ($id_transaccion === NULL) {
            $id_transaccion = $parametros->id_transaccion;
        }
        $empresa = $this->db->selectone(array('CONCAT(i.nombre, " ", i.apellido) as empresa', 'i.num_documento AS NIT', 'i.telefono'), 'fw_interlocutor i', ' i.id_interlocutor = ' . $id_interlocutor, false, false, false, false);
        $transaccion = $this->db->selectone(array('t.id_transaccion', 't.fecha', 't.factura_numero'), 'transaccion t', ' t.id_transaccion = ' . $id_transaccion, false, false, false, false);
        $transaccion['subtotal'] = 0;
        $transaccion['total'] = 0;
        $factura_productos = '';


        if (isset($transaccion['id_transaccion'])) {
            $items = $this->db->select(array('t.id_transaccion, t.fecha, ti.cantidad, ti.valor_unitario, ti.iva, p.nombre_corto AS producto, p.nombre AS producto2'), 'transaccion t, transaccion_item ti, producto p ', ' t.id_transaccion = ti.transaccion_id AND ti.producto_id = p.id_producto AND t.id_transaccion = ' . $id_transaccion, false, false, false, false);
            
            foreach ($items as $item) {
                $item['producto2'] = substr($item['producto2'], 0, 16);
                $subtotal = $item['valor_unitario'] * $item['cantidad'];
                $transaccion['total'] += ($item['valor_unitario'] * $item['cantidad']);
                
                $subtotal_aux = '.....';
                
                while(strlen($item['producto2']) < 26){
                    $item['producto2'] .= '.';
                }
                $factura_productos .="" . $item['producto2'] . "  ".$item['cantidad']."    ".$subtotal_aux." $" . number_format($subtotal) . "\n";
                //$transaccion['total'] += $transaccion['subtotal'];
            }
            $this->gn->set_data_loged('datos_trx', array('empresa'=>$empresa, 'transaccion'=>$transaccion, 'productos'=>$factura_productos, 'productos_cantidad'=>count($items), 'cliente'=>$cliente));
            //$this->generarPdf($empresa, $transaccion, $factura_productos, count($items), $cliente);
            
            $this->tipo_contenido = 'ajax';
            require_once("app/pack/transaccion/ventas/view/ventas.html.php");
            VentasHTML::ver_factura($transaccion, $items, $empresa, $cliente);
        }
    }


    function imprimir_factura_pdf(){
        $datos = $this->gn->get_data_loged('datos_trx');
        $this->generarPdf($datos['empresa'], $datos['transaccion'], $datos['productos'], $datos['productos_cantidad'], $datos['cliente']);
    }
    
    function generarPdf($empresa, $transaccion, $productos, $productos_cantidad, $cliente) {
        $factura_altura = 80 + ($productos_cantidad*5);
        
        $factura_cabecera = "Nit: ".$empresa['NIT'] . "\n".
                            "Tel: ".$empresa['telefono'] . "\n\n";
	  
        $factura_cabecera_cliente = "Cliente:        ".$cliente['nombre']."\n". 
                                    "CC/Nit:         ".$cliente['documento']." "."\n";

        $factura_cabecera_prod =    "   CONCEPTO                    CANT.    TOTAL    "."\n";

        $factura_footer =   " TOTAL           $ " . number_format($transaccion['total']) . "\n";
        
        require_once 'fw/controlador/php/lib/wis_pdf.php';

        $pdf = new wis_pdf('P', 'mm', array(80, $factura_altura));
        $pdf->SetMargins(4, 3);
        $pdf->AddPage();
        $pdf->SetFont('Arial', '', 14);
        $pdf->Cell(70, 5, $empresa['empresa'], 0, 2, "C");
        
        $pdf->SetFont('Arial', '', 9);
        $pdf->MultiCell(70, 4, utf8_decode($factura_cabecera), 0, "C", false);
        
        $datos = utf8_decode("Factura No.:       " . $transaccion['factura_numero'] . "\n" . "Fecha:  2016/05/20");
        $pdf->MultiCell(70, 4, $datos, 0, "C", false);
        
        $pdf->MultiCell(70, 5, utf8_decode($factura_cabecera_cliente), 0, "J", false);
        
        $pdf->SetFont('Arial', '', 8);
        $pdf->MultiCell(70, 5, utf8_decode($factura_cabecera_prod), 1, "J", false);
        $pdf->MultiCell(70, 5, utf8_decode($productos."\n"), 1, "J", false);
        $pdf->MultiCell(70, 5, utf8_decode($factura_footer), 1, "C", false);
        /*DATOS WIS*/
        $pdf->SetFont('Arial', '', 5);
        $pdf->Cell(70, 4, utf8_decode('By  WIS S.A.S. www.wisgroup.com.co'), 0, 2, "R");
        
        
        $pdf->autoprint(true);
        $pdf->Output();
    }

    function imprimir_pdf() {


//Recibir detalles de factura
        $id_factura = 100;
        $fecha_factura = '20/05/2015';

//Recibir los datos de la empresa
        $nombre_tienda = ' CASEL ';
        $direccion_tienda = ' AAQUIII';
        $poblacion_tienda = '   ';
        $provincia_tienda = '   ';
        $codigo_postal_tienda = '   ';
        $telefono_tienda = '   ';
        $fax_tienda = '   ';
        $identificacion_fiscal_tienda = '   ';

//Recibir los datos del cliente
        $nombre_cliente = '   ';
        $apellidos_cliente = '   ';
        $direccion_cliente = '   ';
        $poblacion_cliente = '   ';
        $provincia_cliente = '   ';
        $codigo_postal_cliente = '   ';
        $identificacion_fiscal_cliente = '   ';

//Recibir los datos de los productos
        $iva = '   ';
        $gastos_de_envio = '   ';
        $unidades = 'uno,dos,tres';
        $productos = 'uno,dos,tres';
        $precio_unidad = 'uno,dos,tres';

//variable que guarda el nombre del archivo PDF
        $archivo = "factura-$id_factura.pdf";

//Llamada al script fpdf
        require_once 'fw/controlador/php/lib/fpdf181/fpdf.php';


        $archivo_de_salida = $archivo;

        $pdf = new FPDF();  //crea el objeto
        $pdf->AddPage();  //añadimos una página. Origen coordenadas, esquina superior izquierda, posición por defeto a 1 cm de los bordes.
//logo de la tienda
        //$pdf->Image('../empresa.jpg', 0, 0, 40, 40, 'JPG', 'http://php-estudios.blogspot.com');
// Encabezado de la factura
        $pdf->SetFont('Arial', 'B', 14);
        $pdf->Cell(190, 10, "FACTURA", 0, 2, "C");
        $pdf->SetFont('Arial', 'B', 10);
        $pdf->MultiCell(190, 5, "Número de factura: $id_factura" . "\n" . "Fecha: $fecha_factura", 0, "C", false);
        $pdf->Ln(2);

// Datos de la tienda
        $pdf->SetFont('Arial', 'B', 12);
        $top_datos = 45;
        $pdf->SetXY(40, $top_datos);
        $pdf->Cell(190, 10, "Datos de la tienda:", 0, 2, "J");
        $pdf->SetFont('Arial', '', 9);
        $pdf->MultiCell(190, //posición X
                5, //posición Y
                $nombre_tienda . "\n" .
                "Dirección: " . $direccion_tienda . "\n" .
                "Población: " . $poblacion_tienda . "\n" .
                "Provincia: " . $provincia_tienda . "\n" .
                "Código Postal: " . $codigo_postal_tienda . "\n" .
                "Teléfono: " . $telefono_tienda . "\n" .
                "Fax: " . $fax_tienda . "\n" .
                "Indentificación Fiscal: " . $identificacion_fiscal_tienda, 0, // bordes 0 = no | 1 = si
                "J", // texto justificado 
                false);


// Datos del cliente
        $pdf->SetFont('Arial', 'B', 12);
        $pdf->SetXY(125, $top_datos);
        $pdf->Cell(190, 10, "Datos del cliente:", 0, 2, "J");
        $pdf->SetFont('Arial', '', 9);
        $pdf->MultiCell(
                190, //posición X
                5, //posicion Y
                "Nombre: " . $nombre_cliente . "\n" .
                "Apellidos: " . $apellidos_cliente . "\n" .
                "Dirección: " . $direccion_cliente . "\n" .
                "Población: " . $poblacion_cliente . "\n" .
                "Provincia: " . $provincia_cliente . "\n" .
                "Código Postal: " . $codigo_postal_cliente . "\n" .
                "Identificación Fiscal: " . $identificacion_fiscal_cliente, 0, // bordes 0 = no | 1 = si
                "J", // texto justificado
                false);

//Salto de línea
        $pdf->Ln(2);



// extracción de los datos de los productos a través de la función explode
        $e_productos = explode(",", $productos);
        $e_unidades = explode(",", $unidades);
        $e_precio_unidad = explode(",", $precio_unidad);

//Creación de la tabla de los detalles de los productos productos
        $top_productos = 110;
        $pdf->SetXY(45, $top_productos);
        $pdf->Cell(40, 5, 'UNIDADES', 0, 1, 'C');
        $pdf->SetXY(80, $top_productos);
        $pdf->Cell(40, 5, 'PRODUCTOS', 0, 1, 'C');
        $pdf->SetXY(115, $top_productos);
        $pdf->Cell(40, 5, 'PRECIO UNIDAD', 0, 1, 'C');

        $precio_subtotal = 0; // variable para almacenar el subtotal
        $y = 115; // variable para la posición top desde la cual se empezarán a agregar los datos
        $x = 0;
        while ($x <= count($e_productos) - 1) {
            $pdf->SetFont('Arial', '', 8);

            $pdf->SetXY(45, $y);
            $pdf->Cell(40, 5, $e_unidades[$x], 0, 1, 'C');
            $pdf->SetXY(80, $y);
            $pdf->Cell(40, 5, $e_productos[$x], 0, 1, 'C');
            $pdf->SetXY(115, $y);
            $pdf->Cell(40, 5, $e_precio_unidad[$x] . " €", 0, 1, 'C');

//Cálculo del subtotal  
            $precio_subtotal += $e_precio_unidad[$x] * $e_unidades[$x];
            $x++;

// aumento del top 5 cm
            $y = $y + 5;
        }

//Cálculo del Impuesto
        $add_iva = $precio_subtotal * $iva / 100;

//Cálculo del precio total
        $total_mas_iva = round($precio_subtotal + $add_iva + $gastos_de_envio, 2);

        $pdf->Ln(2);
        $pdf->SetFont('Arial', 'B', 10);
        $pdf->Cell(190, 5, "Gastos de envío: $gastos_de_envio €", 0, 1, "C");
        $pdf->Cell(190, 5, "I.V.A: $iva %", 0, 1, "C");
        $pdf->Cell(190, 5, "Subtotal: $precio_subtotal €", 0, 1, "C");
        $pdf->Cell(190, 5, "TOTAL: " . $total_mas_iva . " €", 0, 1, "C");


        $pdf->Output($archivo_de_salida); //cierra el objeto pdf
//Creacion de las cabeceras que generarán el archivo pdf
        header("Content-Type: application/download");
        header("Content-Disposition: attachment; filename=$archivo");
        header("Content-Length: " . filesize("$archivo"));
        $fp = fopen($archivo, "r");
        fpassthru($fp);
        fclose($fp);

//Eliminación del archivo en el servidor
        unlink($archivo);
    }
    


}

