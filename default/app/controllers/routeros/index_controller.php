<?php 
/**
* 
*/

Load::models('routeros/router_mk');
Load::lib('ApiMikrotik/routeros_api.class');

class IndexController extends BackendController
{

	protected function before_filter() {
		//Se cambia el nombre del módulo actual
		$this->page_module = 'Cofiguracion de Nas';
	}
	
	public function index()
	{
		$this->page_title = 'Prueba de RouterMk';
	}

	public function recursos()
	{
		$recursos = new RouterMk();

		$recursos->getRecursos();
	}
}