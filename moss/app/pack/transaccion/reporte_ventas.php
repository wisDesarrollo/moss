<?php
include 'classes/stdReport.php';
class Module extends stdReport{
    public function __construct(){
        $file_name = $this->getClassName(__FILE__);
        $this->modulo = $file_name;
        $this->clase = $file_name;
        $this->addControls();
        $this->setCrud('only_edit');
        $this->setFilter(array("fecha", "id"));
        $this->report_name="Reporte De Ventas";
        $this->report_table="transacciones";
        $this->report_type="4";
    }
}   
