<?php

class Nav {

    private $db;

    CONST NAV_OPCION = 0;
    CONST NAV_ORDER = ' orden ASC';

    function __construct($db, $gn) {
        $this->db = $db;
        //$opciones = $gn->get_data_loged('opciones_menu');
        $clase_interlocutor = $gn->get_data_loged('perfil');
        if (!isset($opciones) || empty($opciones)) {
            $opciones = $this->db->select(array('id_opcion', 'descripcion', 'nombre_modulo', 'imagen'), 
                    'fw_opcion', 
                    "estado_id = " . ESTADO_ACTIVO . " "
                    . " AND opcion_id=" . self::NAV_OPCION, 
                    self::NAV_ORDER, false, false);
            $gn->set_data_loged('opciones_menu', $opciones);
        }
        require_once("fw/template/standard/view/nav.html.php");
        NavHTML::home($opciones);
    }

}
