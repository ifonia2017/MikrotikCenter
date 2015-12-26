<?php 

/**
* 
*/
class Nas extends ActiveRecord
{
	
	public function getListadoNas()
	{
		return $this->find("order: identity ASC");
	}

	public function getNasSession($id)
	{
		$columnas ='usuario.nas_id, nas.*';
 		$join = 'INNER JOIN usuario ON usuario.nas_id = nas.id';
 		$condicion = "usuario.id = $id";
 		return $this->find_first("columns: $columnas", "join: $join", "conditions: $condicion");
	}

	/**
	 * Método para setear
	 * @param string $method Método a ejecutar (create, update, save)
	 * @param array $data Array con la data => Input::post('model')
	 * @param array $otherData Array con datos adicionales
	 * @return Obj
	 */
	public static function setNas($method, $data, $optData=null) {
		//Se aplica la autocarga
		$obj = new Nas($data);
		//Se verifica si contiene una data adicional para autocargar
		if ($optData) {
			$obj->dump_result_self($optData);
		}  
		$rs = $obj->$method();
		
		return ($rs) ? $obj : FALSE;
	}
}