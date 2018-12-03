<?php

require_once ("gestionBD.php");
require_once ("gestionProductos.php");
require_once ("gestionClientes.php");
	
	$conexion = crearConexionBD();







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
	 	<?php if(isset($_POST["hidden_total"]) & $_POST["hidden_total"]!=0){?>
	 		<div id= "DatosCompra">
	 			<h1> Compra realizada con exito.</h1>
		<h1> Detalles de la compra: 
		<br /> 
		Número de referencia: SAIND0#<?php echo $_POST["hidden_id"];?> 
		<br />
		Importe total: <?php echo $_POST["hidden_total"];?> €</h1>
		
		</div>
	<?php }else{ ?>
		<h1>
			<?php $_SESSION['excepcion'] = "No se puede realizar la compra puesto que no hay productos en el carrito.";
			 header("Location: excepciones.php");
			?>
			
		</h1>
		
	<?php } ?>
	

</main>
	<?php
include_once ("pie.php");
?>
</div>
	</body>

</html>