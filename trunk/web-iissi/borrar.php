<?php
session_start();
require_once("gestionBD.php");
require_once("gestionarDireccion.php");
require_once("gestionClientes.php");
$conexion = crearConexionBD();
// Comprobar que hemos llegado a esta página porque se ha rellenado el formulario
	if(isset($_SESSION["usuarioMOD"])){
		$usuarioMODI["email"] = $_REQUEST["email"];
		
		$_SESSION["usuarioMOD"] = $usuarioMODI;
		eliminar_cliente($conexion, $usuarioMODI["email"]);
		cerrarConexionBD($conexion);
	Header("Location:registro.php");

	}
	Header("Location:registro.php");

?>

<html>

<head>
</head>
<body>
Exito
</body>

</html>