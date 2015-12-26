<?php 
/**
* 
*/

Load::lib('ApiMikrotik/routeros_api.class');

class RouterMk 
{
	
	/**
	 * 
	 */
	public function conectar()
	{
		// $nas = new Nas();

		$Api = new RouterosAPI();
		$Api->connect('10.10.0.1', 'srondon', '12125412');	
	}

	public function getRecursos()
	{
		$API = new RouterosAPI();
		$conexion = self::conectar();

		if ($conexion) {   // Change this as necessery

			$ARRAY = $API->comm("/system/resource/print");
			$first = $ARRAY['0'];
			$memperc = ($first['free-memory']/$first['total-memory']);
			$hddperc = ($first['free-hdd-space']/$first['total-hdd-space']);
			$mem = ($memperc*100);
			$hdd = ($hddperc*100);

			// $box = '<div class="row">'.PHP_EOL;
			// $box .= '<div class="col-md-3 col-sm-6 col-xs-12">'.PHP_EOL;
			// $box .= '<div class="info-box bg-aqua">'.PHP_EOL;
			// $box .= '<span class="info-box-icon"><i class="fa fa-hdd-o"></i></span>'.PHP_EOL;
			// $box .= '<div class="info-box-content">'.PHP_EOL;
			// $box .= '<span class="info-box-text">Espacio en Disco</span>'.PHP_EOL;
			// $box .= '<span class="info-box-number">'.$first['total-hdd-space'] .'</span>'
			// return $box;

			echo "<table width=550 border=0 align=center>";

echo "<tr><td>Platform, board name and Ros version is:</td><td>" . $first['platform'] . " - " . $first['board-name'] . " - "  . $first['version'] . " - " . $first['architecture-name'] . "</td></tr><br />";
echo "<tr><td>Cpu and available cores:</td><td>" . $first['cpu'] . " at " . $first['cpu-frequency'] . " Mhz with " . $first['cpu-count'] . " core(s) "  . "</td></tr><br />";
echo "<tr><td>Uptime is:</td><td>" . $first['uptime'] . " (hh/mm/ss)" . "</td></tr><br />";
echo "<tr><td>Cpu Load is:</td><td>" . $first['cpu-load'] . " %" . "</td></tr><br />";
echo "<tr><td>Total,free memory and memory % is:</td><td>" . $first['total-memory'] . "Kb - " . $first['free-memory'] . "Kb - " . number_format($mem,3) . "% </td></tr><br />";
echo "<tr><td>Total,free disk and disk % is:</td><td>" . $first['total-hdd-space'] . "Kb - " . $first['free-hdd-space'] . "Kb - " . number_format($hdd,3) . "% </td></tr><br />";
echo "<tr><td>Sectors (write,since reboot,bad blocks):</td><td>" . $first['write-sect-total'] . " - " . $first['write-sect-since-reboot'] . " - " . $first['bad-blocks'] . "% </td></tr><br />";

echo "</table>";

		}
	}
}