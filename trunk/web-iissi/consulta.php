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

//Añade producto al carrito
if(isset($_POST["aniadir"]))
{
	if(isset($_SESSION["shopping_cart"]))
	{
		$item_array_id = array_column($_SESSION["shopping_cart"], "item_id");
		if(!in_array($_GET["CODIGO"], $item_array_id))
		{
//La , con la funcion number_format da error ya que la toma como texto, así que aquí la convertimos en un .			
			$precioF = str_replace(array(","),array("."),$_POST["hidden_price"]);
//Se toman valores del form. La variable $count es la que nos indica el ID del carrito
			$count = count($_SESSION["shopping_cart"]);
			$item_array = array(
				'item_id'			=>	$_GET["CODIGO"],
				'item_name'			=>	$_POST["hidden_name"],
				'item_price'		=>	$precioF,
				'cantidad'		=>	$_POST["cantidad"]
			);
			$_SESSION["shopping_cart"][$count] = $item_array;
			
    }else{
			foreach($_SESSION["shopping_cart"] as $keys => $values)
		{
			if($values["item_id"] == $_GET["CODIGO"])
			{
				$precioF = str_replace(array(","),array("."),$_POST["hidden_price"]);	
				$cantidad = $values["cantidad"];
				$item_array = array(
				'item_id'			=>	$_GET["CODIGO"],
				'item_name'			=>	$_POST["hidden_name"],
				'item_price'		=>	$precioF,
				'cantidad'		=>	$_POST["cantidad"] +$cantidad
			);
			$_SESSION["shopping_cart"][$keys] = $item_array;
			}
		}
	}
		
	}else{
		
		//Si no hay un carrito se crea uno con id 0
		$precioF = str_replace(
        array(","),
		array("."),
		$_POST["hidden_price"]);
		$item_array = array(
			'item_id'			=>	$_GET["CODIGO"],
			'item_name'			=>	$_POST["hidden_name"],
			'item_price'		=>	$precioF,
			'cantidad'		=>	$_POST["cantidad"]
		);
		$_SESSION["shopping_cart"][0] = $item_array;
		}
}
//Funcion eliminar producto del carrito
if(isset($_GET["action"]))
{
	if($_GET["action"] == "delete")
	{
		foreach($_SESSION["shopping_cart"] as $keys => $values)
		{
			if($values["item_id"] == $_GET["CODIGO"])
			{
				unset($_SESSION["shopping_cart"][$keys]);
			}
		}
	}
}

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
	<div id="wrapper">
		<?php
		include_once ("cabecera.php");
		include_once ("menu.php");
		include_once ("carrito.php");
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
			<form method="post" action="consulta.php?action=add&CODIGO=<?php echo $fila["CODIGO"]; ?>">	
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
						<input type="text" name="cantidad" value="1" class="form-control" />

						<input type="hidden" name="hidden_name" value="<?php echo $fila["NOMBRE"]; ?>" />

						<input type="hidden" name="hidden_price" value="<?php echo $fila["PRECIO"]; ?>" />
					
					<div class="botones"
					
					<p> <button id="aniadir" name="aniadir" type="submit" class="aniadir">
						Añadir al carrito
					</button> </p>
					</form>
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
</div>
	</body>

</html>