<?php 

/**
* 
*/
Load::models('routeros/router_mk');

class Nas extends ActiveRecord
{
	const COD_ACTIVO = 1;
	const COD_INACTIVO = 2;

	const ACTIVO = 'Activo';
	const INACTIVO = 'Inactivo';
	
	public function getNas($page=1, $ppage=5)
	{
		return $this->paginate("page: $page", "per_page: $ppage","order: id desc");
	}

	/*public function conexion()
	{
		$nas_conecction = new RouterMk();

		$datos = new Nas();

		$ip = $datos->ip_nas;
		$usuario = $datos->user_nas;
		$pass = $datos->_nas;
		$port = $datos->ip_nas;
		
		try {
			$conectar = $nas_conecction->conectar($ip, $usuario, $pass, $port);
		} catch (Exception $e) {
			DwFlash::error('No se pudo conectar');
		}
	}*/
}