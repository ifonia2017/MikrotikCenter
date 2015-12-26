<?php
/**
 */

class PrincipalController extends AppController {
	
	protected function before_filter() {
		//Se cambia el nombre del módulo actual
		$this->page_module = 'Soluciones SL';
	}
	
	public function index() {
		DwRedirect::to('dashboard');
	}
}
