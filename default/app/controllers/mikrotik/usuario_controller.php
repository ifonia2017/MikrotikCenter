<?php
/**
 * KumbiaPHP web & app Framework
 *
 * LICENSE
 *
 * This source file is subject to the new BSD license that is bundled
 * with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://wiki.kumbiaphp.com/Licencia
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@kumbiaphp.com so we can send you a copy immediately.
 *
 * Helpers HTML
 *
 * @category   Usuario
 * @package    Controller
 * @copyright  Copyright (c) 2005-2009 Kumbia Team (http://www.kumbiaphp.com)
 * @license    http://wiki.kumbiaphp.com/Licencia     New BSD License
 */
use PEAR2\Net\RouterOS;
Load::lib('PEAR2/Autoload');
Load::models('mikrotik/nas');
 class UsuarioController extends BackendController
 {

	protected function before_filter() {
		//Se cambia el nombre del módulo actual
		$this->page_module = 'Gestión de usuarios';
	}

	public function index()
	{
		DwRedirect::toAction('listar');
	}
	
	public function listar()
	{
		$mikrotik = new Nas();
		$routerMk = $mikrotik->getNasSession(Session::get('id'));

		$nas = $routerMk->identity;
		$ip = $routerMk->address;
		$user = $routerMk->user;
		$pass = $routerMk->password;
		$port = $routerMk->port;

		try {
			$util = new RouterOS\Util(
			$client = new RouterOS\Client($ip, $user, $pass, $port));
		} catch (Exception $e) {
			die($e);
		}

		$this->lista = $util->setMenu('/tool user-manager user');

	}
 }