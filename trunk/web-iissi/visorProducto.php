<?php
session_start();
require_once ("gestionBD.php");
require_once ("gestionConsultas.php");
if (isset($_GET["mas"])) {
	$codigo = $_GET["mas"];
} else {
	echo "no se encontro el producto";
}

require_once ("gestionBD.php");

//Abre Conexion DB
$conexion = crearConexionBD();

//Consulta DB
$query = "SELECT * FROM PRODUCTOS WHERE CODIGO = '$codigo'";
$filas = consulta($conexion,$query);
cerrarConexionBD($conexion);
?>
<!DOCTYPE html>
<html lang="es">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" type="text/css" href="css/plantilla.css"/>
		<script type="text/javascript" src="./js/boton.js"></script>
		<title> SAIND - HOME </title>
	</head>

	<body >
		<?php
		include_once ("cabecera.php");
		include_once ("menu.php");
		?>
	<?php 
	foreach($filas as $fila) {

	}?>
	<div class="visorProducto">		
		<img class= "visorImagen" src = "<?php echo $fila["URLIMG"] ?>" alt= "Imagen del Producto" 
				onerror="this.src='images/noimage.jpg'"/> 
			<div class= "visorDatos">
				<p class = "visorNombre">
					<?php echo $fila["NOMBRE"]?>
				</p>
				<p class = "visorMode">
					Modelo:
					<?php echo $fila["MODELO"]?>
				</p>
				<p class = "visorPN">
					Part number: 
					<?php echo $fila["PARTNUMBER"]?>
				</p>
					<p class = "visorDesc">
					<?php echo $fila["DESCRIPCION"]?>
				</p>
				<p><a href="<?php echo $fila["URLDOCU"] ?>"> <img class="visorDocu" alt="Documentación del producto" src="images/Adobe_Reader_PDF.png"> </a>
				</p>
				</div>
			<div class="visorMenu">
					<p class= "visorPrecio" >
					<?php echo $fila["PRECIO"] ?>€
					
			<div>
				<label for="cantidad">Cantidad: </label>
				<form method="get" action="visorProducto.php">
				<input type="text" name="cantidad" id="cantidad" placeholder="1" />
				<p><button id="Add" name="	Add" type="submit" value="<?php echo $fila["CODIGO"] ?>" 
						class="Add"> +
					</button> </p>
				<p><button id="sub" name="sub" type="submit" value="<?php echo $fila["CODIGO"] ?>" 
						class="sub"> -
				</button> </p>
				
					</form>
				
				</div>
					
				<div class="botonAdd"
					<form method="get" action="visorProducto.php">
					<p><button id="visorAdd" name="visorAdd" type="submit" value="<?php echo $fila["CODIGO"] ?>" 
						class="visorAdd"> Añadir al Carrito 
					</button> </p></form>	
					</div>					
				</div> 
			
		</div>
		<main>

<?php

include_once ("pie.php");
?>
	</body>
</html>