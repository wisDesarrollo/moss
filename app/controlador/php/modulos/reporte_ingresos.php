<?php



require_once('fw/controlador/php/modulos/modulo.class.php');



class ReporteIngresos extends Modulo {



    public $tipo_contenido = 'html';



    CONST TRX_INGRESO = 6;

    CONST TRX_SALIDA = 7;



    function home() {



        $id_interlocutor = $this->gn->get_data_loged('id_interlocutor');



        

        $campos = array("concat(t.fecha,' ',t.hora) as fecha", 't.id_transaccion as Transaccion', 'CONCAT(c.nombre, " ", c.apellido1) colaborador', 'tt.descripcion tipo','et.descripcion estado');

        $tablas = "transaccion  t, estado_transaccion et, colaborador c, transaccion_tipo tt";

        $condicion = " t.estado = et.id_estado_transaccion AND t.colaborador_id = c.id_colaborador AND t.transaccion_tipo_id = tt.id_transaccion_tipo AND t.transaccion_tipo_id IN ('".self::TRX_INGRESO."', '".self::TRX_SALIDA."') AND t.interlocutor_id='" . $id_interlocutor . "'  order by fecha desc";

        $this->pintar_tabla($campos, $tablas, $condicion);

    }



}

