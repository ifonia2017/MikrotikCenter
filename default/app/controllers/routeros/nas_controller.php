<?php 
/**
* 
*/
Load::models('routeros/nas', 'routeros/router_mk');

class NasController extends BackendController
{
	protected function before_filter() {
		//Se cambia el nombre del módulo actual
		$this->page_module = 'Configuración de Nas';
	}

	public function index()
	{
		
	}
	
}