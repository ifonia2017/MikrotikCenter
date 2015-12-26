<?php
/**
 * Breadcrumb
 *
 * @package kumbiaphp
 * @author [iBet7o] - Roberto I Ramirez Navarro <robertoiran@gmail.com>
 * @copyright 2012
 * @version 1.01
 */
class Breadcrumb
{
    /**
     * Arreglo que contiene el breadcrumb
     *
     * @var    array
     * @access private
     */
    private $_path = array();

    /**
     *   Namespace en sesion donde se almacena
     * la persistencia del breadcrumb.
     *
     * @var string
     * @static
     */
    static private $namespace = 'breadcrumb';

    /**
     *   Referencia al namespace en sesion donde
     * se almacena la persistencia del breadcrumb.
     *
     * @var object
     * @static
     */
    static private $session = NULL;

    /**
     *   Matriz con la informacion necesaria para
     * configurar la salida del breadcrumb.
     *
     *   separator        => (string)Caracter que separa cada crumb.
     *   class_ul         => (string)Nombre de la clase para ul en la lista.
     *   class_separator  => (string)Nombre de la clase para li del separador.
     *   camel_case       => (bool)Activa CamelCase(ucwords) en los titulos.
     *   upper_case       => (bool)Transforma a mayusculas(strtoupper) los titulos.
     *   lower_case       => (bool)Transforma a minusculas(strtolower) los titulos.
     *   cut              => (bool)Cortar los titulos.
     *   cut_len_max      => (int)Longitud maxima del titulo.
     *
     * @var array
     * @access private
     */
    private $attrs = Array(
        'separator' => '&nbsp;&raquo;&nbsp;',
        'class_ul' => 'breadcrumb',
        'class_separator' => NULL,
        'camel_case' => TRUE,
        'upper_case' => FALSE,
        'lower_case' => FALSE,
        'cut' => FALSE,
        'cut_len_max' => 10
    );
    
    /**
     * Breadcrumb::__construct()
     *
     * @return void
     */
    public function __construct()
    {
        self::_isset();
        $this->_path = self::$session;
    }

    /**
     * Breadcrumb::__set()
     * 
     *   Metodo magico que modifica la configuracion
     * de salida para el breadcrumb.
     * 
     * @param string $key
     * @param string $value
     * @return void|bool
     */
    public function __set($key, $value)
    {
        if(!array_key_exists($key, $this->attrs))
        {
            return FALSE;
        }
        $this->attrs[$key] = $value;
    }

    /**
     * Breadcrumb::__get()
     *
     *   Metodo magico para obtener el valor del parametro,
     * de la configuracion de salida, pasado.
     *
     * @param string $key Nombre del parametro a obtener.
     * @return string|bool
     */
    public function __get($key)
    {
        if(!array_key_exists($key, $this->attrs))
        {
            return FALSE;
        }
        return $this->attrs[$key];
    }

    /**
     * Breadcrumb::_isset()
     *
     * Referencia | Definicion del namespace.
     *
     *   Define el namespace en sesion en caso de no existir;
     * de lo contrario solo hace una referencia.
     *
     * @return void
     */
    final static private function _isset()
    {
        if(!isset($_SESSION['KUMBIA_SESSION'][APP_PATH][self::$namespace]))
        {
            $_SESSION['KUMBIA_SESSION'][APP_PATH][self::$namespace] = array();
        }
        self::$session = &$_SESSION['KUMBIA_SESSION'][APP_PATH][self::$namespace];
    }

    /**
     * Breadcrumb::addCrumb()
     *
     * Agregar un nuevo item
     *
     *   Agrega un nuevo item en el indice pasado siempre y
     * cuando no esta ya definido en el arreglo. Si el indice
     * es nulo agrega al final del arreglo el item.
     *
     * @param int $key
     * @param string $title
     * @param string $url
     * @return void|bool
     */
    public function addCrumb($key = NULL, $title = NULL, $url = NULL, $icon = NULL)
    {
        if(is_null($title))
        {
            return FALSE;
        }
        if(is_null($key))
        {
            array_push($this->_path, array('title' => $title, 'url' => $url, 'icon' => $icon));
        }
        else
        {
            $this->_path[$key] = array('title' => $title, 'url' => $url);
        }
    }

    /**
     * Breadcrumb::_addCrumb()
     *
     * Agrega crumb
     *
     *   Agrega a _push_ un crumb que cuando se ejecute el metodo
     * jobs sera ingresado al _path.
     *
     * @param string $title
     * @param string $url
     * @return void|bool
     */
    static function add($title = NULL, $url = NULL)
    {
        if(is_null($title))
        {
            return FALSE;
        }
        self::_isset();
        self::$session['_push_'][] = array('title' => $title, 'url' => $url);
    }

    /**
     * Breadcrumb::_updateCrumb()
     *
     * Actualiza crumb
     *
     *   Agrega a _update_ un crumb modificado que cuando se ejecute el metodo
     * jobs sera actualizado en _path.
     *
     * @param int $key
     * @param string $title
     * @param string $url
     * @return void|bool
     */
    static function update($key = NULL, $title = NULL, $url = NULL)
    {
        if(is_null($key))
        {
            return FALSE;
        }
        self::_isset();
        self::$session['_update_'][] = array('key' => $key - 1, 'title' => $title, 'url' => $url);
    }

    /**
     * Breadcrumb::executePush()
     *
     * Agrega crumb.
     *
     *   Agrega al final del _path las crumb que se encuentran
     * en _push_, estas fueron definidas por el metodo _addCrumb.
     *
     * @return void|bool
     */
    private function _executePush()
    {
        if(!(isset($this->_path['_push_']) && count($this->_path['_push_']) > 0))
        {
            return FALSE;
        }
        foreach($this->_path['_push_'] as $crumb)
        {
            array_push($this->_path, $crumb);
        }
        unset($this->_path['_push_']);
    }

    /**
     * Breadcrumb::executeUpdate()
     *
     * Actualiza crumb.
     *
     *   Actualiza en el _path las crumb que se encuentran
     * en _update_, estas fueron definidas por el metodo _updateCrumb.
     *
     *   Si title o url son igual . se respeta el valor actual
     * de lo contrario se hace la actualizacion.
     *
     * @return void|bool
     */
    private function _executeUpdate()
    {
        if(!(isset($this->_path['_update_']) && count($this->_path['_update_']) > 0))
        {
            return FALSE;
        }
        foreach($this->_path['_update_'] as $crumb)
        {
            if(!array_key_exists($crumb['key'], $this->_path))
            {
                continue;
            }
            if($crumb['title'] != '.')
            {
                $this->_path[$crumb['key']]['title'] = $crumb['title'];
            }
            if($crumb['url'] != '.')
            {
                $this->_path[$crumb['key']]['url'] = $crumb['url'];
            }
        }
        unset($this->_path['_update_']);
    }

    /**
     * Breadcrumb::executeFormat()
     *
     * Formato al title.
     *
     *   Da formato a los titulos de crumb, segun la configuracion
     * en $this->attrs.
     *
     * @return void
     */
    private function _executeFormat()
    {
        foreach($this->_path as $key => $crumb)
        {
            $title = &$this->_path[$key]['title'];
            $this->_path[$key]['title'] = $this->attrs['camel_case'] ?
              ucwords(strtolower($title)) :
                ($this->attrs['upper_case'] ?
                  strtoupper($title) :
                    ($this->attrs['lower_case'] ?
                      strtolower($title) : $title));

            if($this->attrs['cut'] && strlen($title) > $this->attrs['cut_len_max'] && strlen($title) > $this->attrs['cut_len_max'])
            {
                $this->_path[$key]['title'] = substr($title, 0, $this->attrs['cut_len_max']) . '...';
            }
        }
    }

    /**
     * Breadcrumb::reset()
     *
     * Reinicia las matrices del breadcrumb.
     *
     * @return void
     */
    public function reset()
    {
        $this->_path = array();
        unset($_SESSION['KUMBIA_SESSION'][APP_PATH][self::$namespace]);
        self::_isset();
    }

    /**
     * Breadcrumb::jobs()
     *
     * Ejecuta algunos trabajos antes de generar el breadcrumb.
     *
     *   Ejecuta las siguientes acciones para que el breadcrumb
     * sea generado de forma correcta.
     *
     *   -> Metodo executePush.
     *   -> Metodo executeUpdate.
     *   -> Metodo executeFormat.
     *   -> Filtra action index.
     *   -> Ordena la matriz para que se pinte de forma correcta.
     *   -> Devuelve el puntero a la primera posicion de la matriz,
     *      para que sea recorrida desde el inicio.
     *   -> Hace persistente la nueva matriz.
     *
     * @return void
     */
    private function _jobs()
    {
        $this->_executePush();
        $this->_executeUpdate();
        foreach($this->_path as $key => $crumb)
        {
            if(strtolower($crumb['title']) == 'index')
            {
                unset($this->_path[$key]);
            }
        }
        $this->_executeFormat();
        ksort($this->_path);
        reset($this->_path);
        self::$session = $this->_path;
    }

    /**
     * Breadcrumb::display()
     *
     * Genera el breadcrumb
     *
     * @return string
     */
    public function display($icon='')
    {
        $this->_jobs();
        do
        {
            $crumb = current($this->_path);
            if(next($this->_path) && !empty($crumb['title']))
            {
                prev($this->_path);
                $html[] = "<li>" . "<i class='fa fa-$icon'></i>" . DwHtml::link($crumb['url'], $crumb['title']) . "</li>".PHP_EOL;
            }
            elseif(!empty($crumb['title']))
            {
                $html[] = "<li class='active'><i class='fa fa-$icon'></i> <a href='javascript: void(0)'>{$crumb['title']}</a></li>".PHP_EOL;
            }
        }while(next($this->_path));
        self::reset();
        if(is_null($this->attrs['separator']))
        {
            return "<ol class='{$this->attrs['class_ul']}'>" . implode('', $html) . '</ol>'.PHP_EOL;
        }
        else
        {
            return "<ol class='{$this->attrs['class_ul']}'>" . implode("<li class='{$this->attrs['class_separator']}'><a href='javascript: void(0)'>{$this->attrs['separator']}</a></li>".PHP_EOL, $html) . '</ol>'.PHP_EOL;
        }
    }

    /**
     * Breadcrumb::getArray()
     *
     * Regresa la matriz del path
     *
     * @return array
     */
    public function getArray()
    {
        return $this->_path;
    }
}