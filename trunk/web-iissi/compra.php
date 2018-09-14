<?php

require_once ("gestionBD.php");
require_once ("gestionProductos.php");
require_once ("gestionClientes.php");
	
	$conexion = crearConexionBD();

if(isset($_POST["comprar"])){
    {
    crear_carrito($conexion, $_POST["hidden_id"], $_POST["hidden_total"]);
    }
}



cerrarConexionBD($conexion);

?>

<html lang="es">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" type="text/css" href="css/plantilla.css"/>
		<script type="text/javascript" src="./js/boton.js"></script>
		<title> SAIND - HOME </title>
	</head>
	<body >
	<div id="wrapper">
		<?php
		include_once ("cabecera.php");
		include_once ("menu.php");
		?>
		<main>

	 EXITO
</main>
	<?php
include_once ("pie.php");
?>
</div>
	</body>

</html>