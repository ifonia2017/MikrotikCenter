<?php
/**
 * Dailyscript - Web | App | Media
 *
 * Descripcion: Controlador para el panel principal de los usuarios logueados
 *
 * @category    
 * @package     Controllers 
 * @author      Iván D. Meléndez (ivan.melendez@dailycript.com.co)
 * @copyright   Copyright (c) 2013 Dailyscript Team (http://www.dailyscript.com.co) 
 */
use PEAR2\Net\RouterOS;
Load::lib('PEAR2/Autoload');
Load::models('mikrotik/nas');
class IndexController extends BackendController {
    
    public $page_title = 'Dashboard';
    
    public $page_module = 'Dashboard';
    
    protected function before_filter()
    {

    }
    public function index() {
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

        $recursos = $util->setMenu('/system resource');
        $this->free_mem = $recursos->get(NULL, 'free-memory');
        $this->free_hdd = $recursos->get(NULL, 'free-hdd-space');
        $this->cpu = $recursos->get(NULL, 'cpu-load');
        
        $salud = $util->setMenu('/system health');
        $this->therm = $salud->get(NULL, 'temperature');
        $this->activos = $util->setMenu('/ppp active');

    }

}
