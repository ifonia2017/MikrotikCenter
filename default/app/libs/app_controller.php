<?php
/**
 * @see Controller nuevo controller
 */
require_once CORE_PATH . 'kumbia/controller.php';

/**
 * Controlador principal que heredan los controladores
 *
 * Todas las controladores heredan de esta clase en un nivel superior
 * por lo tanto los metodos aqui definidos estan disponibles para
 * cualquier controlador.
 *
 * @category Kumbia
 * @package Controller
 */

//Cargo los parámetros de configuración
DwConfig::Load();

class AppController extends Controller { 

    /**
    * Titulo de la página
    */
    public $page_title = 'Página sin título';

    /**
    * Nombre del módulo en el que se encuentra
    */
    public $page_module = 'Indefinido';

    /**
    * Tipo de formato del reporte
    */
    public $page_format;

    /**
     * Variable que indica el cambio de título de la página en las respuestas ajax
     */
    public $set_title = true;       

    /**
     * Callback que se ejecuta antes de los métodos de todos los controladores
     */
    final protected function initialize() {
        if(APP_UPDATE) {
            DwMessage::info('Estamos en labores de mantenimiento y actualización.');
            View::select(NULL, 'update');
        }
    }

    /**
     * Callback que se ejecuta después de los métodos de todos los controladores
     */
    final protected function finalize() {        
        
    }

}
