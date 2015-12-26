-- phpMyAdmin SQL Dump
-- version 3.3.9
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 26-12-2015 a las 02:43:16
-- Versión del servidor: 5.5.8
-- Versión de PHP: 5.4.45

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `wispcenter`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `acceso`
--

CREATE TABLE IF NOT EXISTS `acceso` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador del acceso',
  `usuario_id` int(11) NOT NULL COMMENT 'Identificador del usuario que accede',
  `tipo_acceso` int(1) NOT NULL DEFAULT '1' COMMENT 'Tipo de acceso (entrata o salida)',
  `ip` varchar(45) DEFAULT NULL COMMENT 'Dirección IP del usuario que ingresa',
  `registrado_at` datetime DEFAULT NULL COMMENT 'Fecha de registro del acceso',
  PRIMARY KEY (`id`),
  KEY `fk_acceso_usuario_idx` (`usuario_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabla que registra los accesos de los usuarios al sistema' AUTO_INCREMENT=1 ;

--
-- Volcar la base de datos para la tabla `acceso`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `backup`
--

CREATE TABLE IF NOT EXISTS `backup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) NOT NULL,
  `denominacion` varchar(200) NOT NULL,
  `tamano` varchar(45) DEFAULT NULL,
  `archivo` varchar(45) NOT NULL,
  `registrado_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_backup_usuario_idx` (`usuario_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabla que contiene las copias de seguridad del sistema' AUTO_INCREMENT=1 ;

--
-- Volcar la base de datos para la tabla `backup`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `chat`
--

CREATE TABLE IF NOT EXISTS `chat` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `para` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `de` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mensaje` text COLLATE utf8_unicode_ci,
  `enviado` datetime DEFAULT NULL,
  `recivido` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- Volcar la base de datos para la tabla `chat`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciudad`
--

CREATE TABLE IF NOT EXISTS `ciudad` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la ciudad',
  `ciudad` varchar(45) NOT NULL COMMENT 'Nombre de la cuidad',
  `registrado_at` datetime DEFAULT NULL COMMENT 'Fecha de registro',
  `modificado_in` datetime DEFAULT NULL COMMENT 'Fecha de la última modificación',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Tabla que contiene las ciudades que se manejan del sistema' AUTO_INCREMENT=2 ;

--
-- Volcar la base de datos para la tabla `ciudad`
--

INSERT INTO `ciudad` (`id`, `ciudad`, `registrado_at`, `modificado_in`) VALUES
(1, 'Ocumare del Tuy', '2015-11-16 14:01:06', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresa`
--

CREATE TABLE IF NOT EXISTS `empresa` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la empresa',
  `razon_social` varchar(100) NOT NULL COMMENT 'Nombre de la empresa',
  `siglas` varchar(45) DEFAULT NULL COMMENT 'Siglas del nombre de la empresa',
  `nit` varchar(15) NOT NULL COMMENT 'Número de identificación tributaria de la empresa',
  `dv` int(2) DEFAULT NULL COMMENT 'Digito de verificación del NIT',
  `representante_legal` varchar(100) NOT NULL COMMENT 'Nombre del representante legal de la empresa',
  `nuip` bigint(20) NOT NULL COMMENT 'Número de identificación personal',
  `tipo_nuip_id` int(1) NOT NULL COMMENT 'Tipo de identificación',
  `pagina_web` varchar(45) DEFAULT NULL,
  `logo` varchar(45) DEFAULT NULL,
  `registrado_at` varchar(45) DEFAULT NULL,
  `modificado_in` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_empresa_tipo_nuip_idx` (`tipo_nuip_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Tabla que contiene la información básica de la empresa' AUTO_INCREMENT=2 ;

--
-- Volcar la base de datos para la tabla `empresa`
--

INSERT INTO `empresa` (`id`, `razon_social`, `siglas`, `nit`, `dv`, `representante_legal`, `nuip`, `tipo_nuip_id`, `pagina_web`, `logo`, `registrado_at`, `modificado_in`) VALUES
(1, 'Soluciones Sergio Lankaster Rondon', 'Solucones SL', '141544566', 6, 'Sergio Lankaster Rondón', 14154456, 4, 'http://www.solucionessl.com.ve', 'default.png', '2013-01-01 00:00:01', '2015-11-16 13:59:44');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_usuario`
--

CREATE TABLE IF NOT EXISTS `estado_usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador del estado del usuario',
  `usuario_id` int(11) NOT NULL COMMENT 'Identificador del usuario',
  `estado_usuario` int(11) NOT NULL COMMENT 'Código del estado del usuario',
  `descripcion` varchar(100) NOT NULL COMMENT 'Motivo del cambio de estado',
  `fecha_estado_at` datetime DEFAULT NULL COMMENT 'Fecha del cambio de estado',
  PRIMARY KEY (`id`),
  KEY `fk_estado_usuario_usuario_idx` (`usuario_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Tabla que contiene los estados de los usuarios' AUTO_INCREMENT=3 ;

--
-- Volcar la base de datos para la tabla `estado_usuario`
--

INSERT INTO `estado_usuario` (`id`, `usuario_id`, `estado_usuario`, `descripcion`, `fecha_estado_at`) VALUES
(1, 1, 2, 'Bloqueado por ser un usuario sin privilegios', '2013-01-01 00:00:01'),
(2, 2, 1, 'Activo por ser el Super Usuario del sistema', '2013-01-01 00:00:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

CREATE TABLE IF NOT EXISTS `factura` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fact_num` int(16) DEFAULT NULL,
  `persona_id` int(11) DEFAULT NULL,
  `emitido` date DEFAULT NULL,
  `vencido` date DEFAULT NULL,
  `pago` date DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_factura_persona_idx_idx` (`persona_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- Volcar la base de datos para la tabla `factura`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturaitems`
--

CREATE TABLE IF NOT EXISTS `facturaitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `factura_id` int(11) DEFAULT NULL,
  `plan_id` int(11) DEFAULT NULL,
  `servicio_id` int(11) DEFAULT NULL,
  `cantidad` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_facturaitems_factura_idx_idx` (`factura_id`),
  KEY `fk_facturaitems_plan_idx_idx` (`plan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- Volcar la base de datos para la tabla `facturaitems`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `log`
--

CREATE TABLE IF NOT EXISTS `log` (
  `logid` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(200) NOT NULL,
  `sessao` int(11) NOT NULL DEFAULT '0',
  `ip` varchar(50) NOT NULL,
  `time` datetime NOT NULL,
  `msg` text NOT NULL,
  `status` tinyint(1) NOT NULL,
  `admin` tinyint(1) NOT NULL,
  PRIMARY KEY (`logid`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=129 ;

--
-- Volcar la base de datos para la tabla `log`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menu`
--

CREATE TABLE IF NOT EXISTS `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador del menú',
  `menu_id` int(11) DEFAULT NULL COMMENT 'Identificador del menú padre',
  `recurso_id` int(11) DEFAULT NULL COMMENT 'Identificador del recurso',
  `menu` varchar(45) NOT NULL COMMENT 'Texto a mostrar del menú',
  `url` varchar(60) DEFAULT NULL COMMENT 'Url del menú',
  `posicion` int(11) DEFAULT '0' COMMENT 'Posisión dentro de otros items',
  `icono` varchar(45) DEFAULT NULL COMMENT 'Icono a mostrar ',
  `activo` int(1) NOT NULL DEFAULT '1' COMMENT 'Menú activo o inactivo',
  `visibilidad` int(1) NOT NULL DEFAULT '1' COMMENT 'Indica si el menú se muestra en el backend o en el frontend',
  PRIMARY KEY (`id`),
  KEY `fk_menu_recurso_idx` (`recurso_id`),
  KEY `fk_menu_menu_idx` (`menu_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Tabla que contiene los menú para los usuarios' AUTO_INCREMENT=20 ;

--
-- Volcar la base de datos para la tabla `menu`
--

INSERT INTO `menu` (`id`, `menu_id`, `recurso_id`, `menu`, `url`, `posicion`, `icono`, `activo`, `visibilidad`) VALUES
(1, NULL, NULL, 'Dashboard', '/dashboard', 10, 'icon-home', 1, 1),
(3, NULL, NULL, 'Sistema', '#', 900, 'icon-cogs', 1, 1),
(4, 3, 4, 'Accesos', 'sistema/acceso/listar/', 901, 'icon-exchange', 1, 1),
(5, 3, 5, 'Auditorías', 'sistema/auditoria/', 902, 'icon-eye-open', 1, 1),
(6, 3, 6, 'Backups', 'sistema/backup/listar/', 903, 'icon-hdd', 1, 1),
(7, 3, 7, 'Mantenimiento', 'sistema/mantenimiento/', 904, 'icon-bolt', 1, 1),
(8, 3, 8, 'Menús', 'sistema/menu/listar/', 905, 'icon-list', 1, 1),
(9, 3, 9, 'Perfiles', 'sistema/perfil/listar/', 906, 'icon-group', 1, 1),
(10, 3, 10, 'Permisos', 'sistema/privilegio/listar/', 907, 'icon-magic', 1, 1),
(11, 3, 11, 'Recursos', 'sistema/recurso/listar/', 908, 'icon-lock', 1, 1),
(12, 3, 12, 'Usuarios', 'sistema/usuario/listar/', 909, 'icon-user', 1, 1),
(13, 3, 13, 'Visor de sucesos', 'sistema/sucesos/', 910, 'icon-filter', 1, 1),
(14, 3, 14, 'Sistema', 'sistema/configuracion/', 911, 'icon-wrench', 1, 1),
(15, NULL, NULL, 'Configuraciones', '#', 800, 'icon-wrench', 1, 1),
(16, 15, 15, 'Empresa', 'config/empresa/', 801, 'icon-briefcase', 1, 1),
(17, 15, 16, 'Sucursales', 'config/sucursal/listar/', 802, 'icon-sitemap', 1, 1),
(18, NULL, NULL, 'Mikrotik', '#', 100, NULL, 1, 1),
(19, 18, 17, 'Usuarios', 'mikrotik/usuario/listar/', 100, 'users', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nas`
--

CREATE TABLE IF NOT EXISTS `nas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identity` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `address` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `user` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `port` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `secret_nas` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `portradius_nas` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `estado` int(2) NOT NULL DEFAULT '1',
  `group_nas` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ip_nas` (`address`),
  UNIQUE KEY `id_mkt` (`identity`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Volcar la base de datos para la tabla `nas`
--

INSERT INTO `nas` (`id`, `identity`, `address`, `user`, `password`, `port`, `secret_nas`, `portradius_nas`, `estado`, `group_nas`) VALUES
(1, 'CORE', '10.10.0.1', 'srondon', '12125412', '8798', NULL, NULL, 1, 'api_group');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `perfil`
--

CREATE TABLE IF NOT EXISTS `perfil` (
  `id` int(2) NOT NULL AUTO_INCREMENT COMMENT 'Identificador del perfil',
  `perfil` varchar(45) NOT NULL COMMENT 'Nombre del perfil',
  `estado` int(1) NOT NULL DEFAULT '1' COMMENT 'Indica si el perfil esta activo o inactivo',
  `plantilla` varchar(45) DEFAULT 'default' COMMENT 'Plantilla para usar en el sitema',
  `registrado_at` datetime DEFAULT NULL COMMENT 'Fecha de registro del perfil',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Tabla que contiene los grupos de los usuarios' AUTO_INCREMENT=2 ;

--
-- Volcar la base de datos para la tabla `perfil`
--

INSERT INTO `perfil` (`id`, `perfil`, `estado`, `plantilla`, `registrado_at`) VALUES
(1, 'Super Usuario', 1, 'default', '2013-01-01 00:00:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE IF NOT EXISTS `persona` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(100) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `nuip` bigint(20) NOT NULL COMMENT 'Número de identificación personal',
  `tipo_nuip_id` int(11) NOT NULL COMMENT 'Tipo de identificación',
  `direccion` varchar(255) DEFAULT NULL,
  `direccion1` varchar(255) DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `fotografia` varchar(45) DEFAULT 'default.png' COMMENT 'Fotografía',
  `registrado_at` datetime DEFAULT NULL,
  `modificado_in` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_persona_tipo_nuip_idx` (`tipo_nuip_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Tabla que contiene las personas que interactúan con el siste /* comment truncated */ /*ma*/' AUTO_INCREMENT=3 ;

--
-- Volcar la base de datos para la tabla `persona`
--

INSERT INTO `persona` (`id`, `nombre`, `apellido`, `email`, `nuip`, `tipo_nuip_id`, `direccion`, `direccion1`, `telefono`, `fotografia`, `registrado_at`, `modificado_in`) VALUES
(1, 'Error', 'Error', '', 1010101010, 1, NULL, NULL, NULL, 'default.png', '2013-01-01 00:00:01', NULL),
(2, 'Sergio L.', 'Rondón M.', '', 14154456, 4, NULL, NULL, NULL, 'default.png', '2013-01-01 00:00:01', '2015-11-16 13:57:28');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `plan`
--

CREATE TABLE IF NOT EXISTS `plan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plan` varchar(255) NOT NULL,
  `velocidad` varchar(255) NOT NULL,
  `costo` decimal(10,2) NOT NULL,
  `max_limit_rx` varchar(255) NOT NULL,
  `max_limit_tx` varchar(255) NOT NULL,
  `burst_rate_rx` varchar(255) NOT NULL,
  `burst_rate_tx` varchar(255) NOT NULL,
  `burst_threshold_rx` varchar(255) NOT NULL,
  `burst_threshold_tx` varchar(255) NOT NULL,
  `burst_time_rx` varchar(255) NOT NULL,
  `burst_time_tx` varchar(255) NOT NULL,
  `min_rate_rx` varchar(255) NOT NULL,
  `min_rate_tx` varchar(255) NOT NULL,
  `prioridad` varchar(2) NOT NULL,
  `creado_at` datetime DEFAULT NULL,
  `modificado_in` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Volcar la base de datos para la tabla `plan`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recurso`
--

CREATE TABLE IF NOT EXISTS `recurso` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador del recurso',
  `modulo` varchar(45) DEFAULT NULL COMMENT 'Nombre del módulo',
  `controlador` varchar(45) DEFAULT NULL COMMENT 'Nombre del controlador',
  `accion` varchar(45) DEFAULT NULL COMMENT 'Nombre de la acción',
  `recurso` varchar(100) DEFAULT NULL COMMENT 'Nombre del recurso',
  `descripcion` text NOT NULL COMMENT 'Descripción del recurso',
  `activo` int(1) NOT NULL DEFAULT '1' COMMENT 'Estado del recurso',
  `registrado_at` datetime DEFAULT NULL COMMENT 'Fecha de registro',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Tabla que contiene los recursos a los que acceden los usuari /* comment truncated */ /*os*/' AUTO_INCREMENT=18 ;

--
-- Volcar la base de datos para la tabla `recurso`
--

INSERT INTO `recurso` (`id`, `modulo`, `controlador`, `accion`, `recurso`, `descripcion`, `activo`, `registrado_at`) VALUES
(1, '*', NULL, NULL, '*', 'Comodín para la administración total (usar con cuidado)', 1, '2013-01-01 00:00:01'),
(2, 'dashboard', 'index', '*', 'dashboard/index/*', 'Página principal del sistema', 1, '2013-01-01 00:00:01'),
(3, 'sistema', 'mi_cuenta', '*', 'sistema/mi_cuenta/*', 'Gestión de la cuenta del usuario logueado', 1, '2013-01-01 00:00:01'),
(4, 'sistema', 'acceso', '*', 'sistema/acceso/*', 'Submódulo para la gestión de ingresos al sistema', 1, '2013-01-01 00:00:01'),
(5, 'sistema', 'auditoria', '*', 'sistema/auditoria/*', 'Submódulo para el control de las acciones de los usuarios', 1, '2013-01-01 00:00:01'),
(6, 'sistema', 'backup', '*', 'sistema/backup/*', 'Submódulo para la gestión de las copias de seguridad', 1, '2013-01-01 00:00:01'),
(7, 'sistema', 'mantenimiento', '*', 'sistema/mantenimiento/*', 'Submódulo para el mantenimiento de las tablas', 1, '2013-01-01 00:00:01'),
(8, 'sistema', 'menu', '*', 'sistema/menu/*', 'Submódulo del sistema para la creación de menús', 1, '2013-01-01 00:00:01'),
(9, 'sistema', 'perfil', '*', 'sistema/perfil/*', 'Submódulo del sistema para los perfiles de usuarios', 1, '2013-01-01 00:00:01'),
(10, 'sistema', 'privilegio', '*', 'sistema/privilegio/*', 'Submódulo del sistema para asignar recursos a los perfiles', 1, '2013-01-01 00:00:01'),
(11, 'sistema', 'recurso', '*', 'sistema/recurso/*', 'Submódulo del sistema para la gestión de los recursos', 1, '2013-01-01 00:00:01'),
(12, 'sistema', 'usuario', '*', 'sistema/usuario/*', 'Submódulo para la administración de los usuarios del sistema', 1, '2013-01-01 00:00:01'),
(13, 'sistema', 'sucesos', '*', 'sistema/suceso/*', 'Submódulo para el listado de los logs del sistema', 1, '2013-01-01 00:00:01'),
(14, 'sistema', 'configuracion', '*', 'sistema/configuracion/*', 'Submódulo para la configuración de la aplicación (.ini)', 1, '2013-01-01 00:00:01'),
(15, 'config', 'empresa', '*', 'config/empresa/*', 'Submódulo para la configuración de la información de la empresa', 1, '2013-01-01 00:00:01'),
(16, 'config', 'sucursal', '*', 'config/sucursal/*', 'Submódulo para la administración de las sucursales', 1, '2013-01-01 00:00:01'),
(17, 'mikrotik', 'usuario', '*', 'mikrotik/usuario/*', 'Sistema de Gestion de Mikrotiks', 1, '2015-11-16 14:19:19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recurso_perfil`
--

CREATE TABLE IF NOT EXISTS `recurso_perfil` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recurso_id` int(11) NOT NULL,
  `perfil_id` int(11) NOT NULL,
  `registrado_at` datetime DEFAULT NULL,
  `modificado_in` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_recurso_perfil_recurso_idx` (`recurso_id`),
  KEY `fk_recurso_perfil_perfil_idx` (`perfil_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Tabla que contiene los recursos del usuario en el sistema se /* comment truncated */ /*gun su perfl*/' AUTO_INCREMENT=2 ;

--
-- Volcar la base de datos para la tabla `recurso_perfil`
--

INSERT INTO `recurso_perfil` (`id`, `recurso_id`, `perfil_id`, `registrado_at`, `modificado_in`) VALUES
(1, 1, 1, '2013-01-01 00:00:01', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `soporte`
--

CREATE TABLE IF NOT EXISTS `soporte` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cod_soporte` int(7) DEFAULT NULL,
  `cliente_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `asunto` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contenido` text COLLATE utf8_unicode_ci,
  `adjunto` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fecha_soporte` datetime DEFAULT NULL,
  `estado` int(1) DEFAULT '1',
  `fecha_cierre` datetime DEFAULT NULL,
  `creado_at` datetime DEFAULT NULL,
  `actualizado_in` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_soporte_usuario_id_idx` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- Volcar la base de datos para la tabla `soporte`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sucursal`
--

CREATE TABLE IF NOT EXISTS `sucursal` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificación de la sucursal',
  `empresa_id` int(11) NOT NULL COMMENT 'Identificador de la empresa',
  `sucursal` varchar(45) NOT NULL COMMENT 'Nombre de la sucursal',
  `sucursal_slug` varchar(45) DEFAULT NULL COMMENT 'Slug de la sucursal',
  `direccion` varchar(45) DEFAULT NULL COMMENT 'Dirección de la sucursal',
  `telefono` varchar(45) DEFAULT NULL COMMENT 'Número del teléfono',
  `fax` varchar(45) DEFAULT NULL COMMENT 'Número del fax',
  `celular` varchar(45) DEFAULT NULL COMMENT 'Número de celular',
  `ciudad_id` int(11) NOT NULL COMMENT 'Identificador de la ciudad',
  `registrado_at` datetime DEFAULT NULL COMMENT 'Fecha de registro',
  `modificado_in` datetime DEFAULT NULL COMMENT 'Fecha de la última modificación',
  PRIMARY KEY (`id`),
  KEY `fk_sucursal_empresa_idx` (`empresa_id`),
  KEY `fk_sucursal_ciudad_idx` (`ciudad_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Tabla que contiene las sucursales de la empresa' AUTO_INCREMENT=2 ;

--
-- Volcar la base de datos para la tabla `sucursal`
--

INSERT INTO `sucursal` (`id`, `empresa_id`, `sucursal`, `sucursal_slug`, `direccion`, `telefono`, `fax`, `celular`, `ciudad_id`, `registrado_at`, `modificado_in`) VALUES
(1, 1, 'Oficina Principal', 'oficina-principal', 'Urb. Mata de Coco, Blq 27, Piso 4, Apto. 04-0', NULL, NULL, '04241403604', 1, '2013-01-01 00:00:01', '2015-11-16 14:01:06');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_nuip`
--

CREATE TABLE IF NOT EXISTS `tipo_nuip` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_nuip` varchar(45) NOT NULL COMMENT 'Nombre del tipo de identificación',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Tabla que contiene los tipos de identificación de las person /* comment truncated */ /*as*/' AUTO_INCREMENT=6 ;

--
-- Volcar la base de datos para la tabla `tipo_nuip`
--

INSERT INTO `tipo_nuip` (`id`, `tipo_nuip`) VALUES
(1, 'C.I.'),
(2, 'RIF.'),
(3, 'PAS.'),
(4, 'NIT.'),
(5, 'N.D.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE IF NOT EXISTS `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador del usuario',
  `sucursal_id` int(11) DEFAULT NULL COMMENT 'Identificador a la sucursal a la cual pertenece',
  `persona_id` int(11) NOT NULL COMMENT 'Identificador de la persona',
  `login` varchar(45) NOT NULL COMMENT 'Nombre de usuario',
  `password` varchar(45) NOT NULL COMMENT 'Contraseña de acceso al sistea',
  `perfil_id` int(2) NOT NULL COMMENT 'Identificador del perfil',
  `nas_id` int(11) DEFAULT NULL,
  `tema` varchar(45) DEFAULT 'default' COMMENT 'Tema aplicable para la interfaz',
  `app_ajax` int(1) DEFAULT '1' COMMENT 'Indica si la app se trabaja con ajax o peticiones normales',
  `datagrid` int(11) DEFAULT '30' COMMENT 'Datos por página en los datagrid',
  `usuario_id` int(11) DEFAULT NULL,
  `registrado_at` datetime DEFAULT NULL COMMENT 'Fecha de registro',
  `modificado_in` datetime DEFAULT NULL COMMENT 'Fecha de la última modificación',
  `estado` int(1) NOT NULL DEFAULT '1',
  `status` int(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_usuario_perfil_idx` (`perfil_id`),
  KEY `fk_usuario_persona_idx` (`persona_id`),
  KEY `fk_usuario_sucursal_idx` (`sucursal_id`),
  KEY `fk_usuario_nas_idx` (`nas_id`),
  KEY `fk_usuario_usuario_id_idx` (`usuario_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Tabla que contiene los usuarios' AUTO_INCREMENT=3 ;

--
-- Volcar la base de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `sucursal_id`, `persona_id`, `login`, `password`, `perfil_id`, `nas_id`, `tema`, `app_ajax`, `datagrid`, `usuario_id`, `registrado_at`, `modificado_in`, `estado`, `status`) VALUES
(1, NULL, 1, 'error', '963db57a0088931e0e3627b1e73e6eb5', 1, NULL, 'default', 1, 30, NULL, '2013-01-01 00:00:01', NULL, 1, 1),
(2, NULL, 2, 'admin', '7c4a8d09ca3762af61e59520943dc26494f8941b', 1, 1, 'default', 1, 30, NULL, '2013-01-01 00:00:01', '2015-11-16 13:57:28', 1, 1);

--
-- Filtros para las tablas descargadas (dump)
--

--
-- Filtros para la tabla `acceso`
--
ALTER TABLE `acceso`
  ADD CONSTRAINT `fk_acceso_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `backup`
--
ALTER TABLE `backup`
  ADD CONSTRAINT `fk_backup_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `empresa`
--
ALTER TABLE `empresa`
  ADD CONSTRAINT `fk_empresa_tipo_nuip` FOREIGN KEY (`tipo_nuip_id`) REFERENCES `tipo_nuip` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `estado_usuario`
--
ALTER TABLE `estado_usuario`
  ADD CONSTRAINT `fk_estado_usuario_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `factura`
--
ALTER TABLE `factura`
  ADD CONSTRAINT `fk_factura_persona` FOREIGN KEY (`persona_id`) REFERENCES `persona` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Filtros para la tabla `facturaitems`
--
ALTER TABLE `facturaitems`
  ADD CONSTRAINT `fk_facturaitems_factura` FOREIGN KEY (`factura_id`) REFERENCES `factura` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_facturaitems_plan` FOREIGN KEY (`plan_id`) REFERENCES `plan` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Filtros para la tabla `menu`
--
ALTER TABLE `menu`
  ADD CONSTRAINT `fk_menu_menu` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_menu_recurso` FOREIGN KEY (`recurso_id`) REFERENCES `recurso` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `persona`
--
ALTER TABLE `persona`
  ADD CONSTRAINT `fk_persona_tipo_nuip` FOREIGN KEY (`tipo_nuip_id`) REFERENCES `tipo_nuip` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `recurso_perfil`
--
ALTER TABLE `recurso_perfil`
  ADD CONSTRAINT `fk_recurso_perfil_perfil` FOREIGN KEY (`perfil_id`) REFERENCES `perfil` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_recurso_perfil_recurso` FOREIGN KEY (`recurso_id`) REFERENCES `recurso` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `soporte`
--
ALTER TABLE `soporte`
  ADD CONSTRAINT `fk_soporte_cliente_id` FOREIGN KEY (`id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_soporte_usuario_id` FOREIGN KEY (`user_id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Filtros para la tabla `sucursal`
--
ALTER TABLE `sucursal`
  ADD CONSTRAINT `fk_sucursal_ciudad` FOREIGN KEY (`ciudad_id`) REFERENCES `ciudad` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_sucursal_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresa` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `fk_usuario_nas` FOREIGN KEY (`nas_id`) REFERENCES `nas` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_usuario_perfil` FOREIGN KEY (`perfil_id`) REFERENCES `perfil` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_usuario_persona` FOREIGN KEY (`persona_id`) REFERENCES `persona` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_usuario_sucursal` FOREIGN KEY (`sucursal_id`) REFERENCES `sucursal` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_usuario_usuario_id` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;
