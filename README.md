# MikrotikCenter

Sistema de Gestion de Mikrotik.
La aplicacion MikrotikCenter pretende manejar y simplificar el uso del Router WISP Mikrotik de RouterOS.
La misma usa la API_PHP_Package recomendada en el foro de Mikrotik. la misma manejara los usuarios clientes de un WISP permitiendo al Operador crear usuarios con sus contraseñas ya sean para PPoE o Hospost en el caso que los usen o simplemente crear las Queues Simples necesarias amarradas a Ip o Access List.

Manejara un sistema de facturacion.

Usara un pequeño Chat para dar Soporte Online y Manejara un sistema de Tickets para llevar las incidencias de los soportes.

podra realizar casi todas las acciones que se pueden hacer con el Winbox.

Se requiere de ayuda y sugerencias para poder terminar con exito el programa.

# Instalacion

Descargar o clonar la aplicacion en el servidor WEB de su preferencia.

Habilitar el ModRewriter de Apache para que pueda Funcionar.

Perpara la base de datos con el archivo wispcenter.sql que se encuentra en la carpeta /default/app/config/sql/wispcenter.sql

ingresar al sistema con el usuario admin, contraseña 123456.

en la base de datos modificar en la tabla NAS los datos del mikrotik a usar.
