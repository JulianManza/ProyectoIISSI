<?php
session_start();
require_once ("gestionBD.php");
require_once ("gestionProductos.php");
require_once ("gestionConsultas.php");
if (isset($_GET["maquinaria"])){
 	$tipo = $_GET["maquinaria"];
	$_SESSION["cod"] = $tipo;
 }if (isset($_GET["repuesto"])) {
 	$tipo = $_GET["repuesto"];
	$_SESSION["cod"] = $tipo;
 }if (isset($_GET["consumible"])) {
 	$tipo = $_GET["consumible"];
	$_SESSION["cod"] = $tipo;
 }
 if (!isset($tipo)){
 	$tipo = $_SESSION["cod"];
 }
 
 
//Por si hay sesion activa
if (isset($_SESSION["paginacion"]))
	$paginacion = $_SESSION["paginacion"];

$pagina_seleccionada = isset($_GET["PAG_NUM"]) ? (int)$_GET["PAG_NUM"] : (isset($paginacion) ? (int)$paginacion["PAG_NUM"] : 1);
$pag_tam = isset($_GET["PAG_TAM"]) ? (int)$_GET["PAG_TAM"] : (isset($paginacion) ? (int)$paginacion["PAG_TAM"] : 5);

if ($pagina_seleccionada < 1)
	$pagina_seleccionada = 1;
if ($pag_tam < 1)
	$pag_tam = 5;
// Antes de seguir, borramos las variables de sección para no confundirnos más adelante
unset($_SESSION["paginacion"]);


//Abre Conexion DB
$conexion = crearConexionBD();

//Consulta DB
$query = $query = "SELECT * FROM PRODUCTOS WHERE TIPOPRODUCTO = '$tipo'";

// Se comprueba que el tamaño de página, página seleccionada y total de registros son conformes.
// En caso de que no, se asume el tamaño de página propuesto, pero desde la página 1
$total_registros = total_consulta($conexion, $query);
$total_paginas = (int)($total_registros / $pag_tam);

if ($total_registros % $pag_tam > 0)
	$total_paginas++;

if ($pagina_seleccionada > $total_paginas)
	$pagina_seleccionada = $total_paginas;

// Generamos los valores de sesión para página e intervalo para volver a ella después de una operación
$paginacion["PAG_NUM"] = $pagina_seleccionada;
$paginacion["PAG_TAM"] = $pag_tam;
$_SESSION["paginacion"] = $paginacion;

$filas = consulta_paginada($conexion, $query, $pagina_seleccionada, $pag_tam);

cerrarConexionBD($conexion);

?>

<!DOCTYPE html>
<html lang="es">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" type="text/css" href="css/plantilla.css"/><br />
		<title> SAIND - HOME </title>
	</head>
	<body >
		<?php
		include_once ("cabecera.php");
		include_once ("menu.php");
		?>
		<main>

	 <nav class="navPag">

		<div id="enlaces">

			<?php

				for( $pagina = 1; $pagina <= $total_paginas; $pagina++ )

					if ( $pagina == $pagina_seleccionada) { 	?>

						<span class="current"><?php echo $pagina; ?></span>

			<?php }	else { ?>

						<a href="consulta.php?PAG_NUM=<?php echo $pagina; ?>&PAG_TAM=<?php echo $pag_tam; ?>"><?php echo $pagina; ?></a>

			<?php } ?>

		</div>

		<form method="get" action="consulta.php">

			<input id="PAG_NUM" name="PAG_NUM" type="hidden" value="<?php echo $pagina_seleccionada?>"/>

			Mostrando

			<input id="PAG_TAM" name="PAG_TAM" type="number"

				min="1" max="<?php echo $total_registros; ?>"

				value="<?php echo $pag_tam?>" autofocus="autofocus" />

			entradas de <?php echo $total_registros?>

			<input type="submit" value="Cambiar">

		</form>

	</nav>


	<?php
		foreach($filas as $fila) {
	?>
	<div class="producto">		
			<img class= "imagen" src = "<?php echo $fila["URLIMG"] ?>" alt= "Imagen del Producto" 
				onerror="this.src='images/noimage.jpg'"/> 
			<div class= "datos">
				
				<p class = "nombre">
					<?php echo $fila["NOMBRE"];	?>
				</p>
				<p><a href="<?php echo $fila["URLDOCU"]; ?>"> <img class="documento" alt="Documentación del producto" src="images/Adobe_Reader_PDF.png"> </a>
				</p>
					<p class= "precio" >
					
					<?php echo $fila["PRECIO"]; ?>€
					
					</p>
					<div class="botones"
					
					<p> <button id="aniadir" name="aniadir" type="submit" class="aniadir">
						Añadir al carrito
					</button> </p>
					<form method="get" action="visorProducto.php">
					<p><button id="mas" name="mas" type="submit" value="<?php echo $fila["CODIGO"] ?>" class="mas"> Más  
				</button> </p></form>
					
						
			</div> 
			</div>

	</div>
	<?php } ?>

</main>
		
<?php
include_once ("pie.php");
?>
	</body>
</html>