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


if(isset($_POST["aniadir"]))
{
	if(isset($_SESSION["shopping_cart"]))
	{
		$item_array_id = array_column($_SESSION["shopping_cart"], "item_id");
		if(!in_array($_GET["CODIGO"], $item_array_id))
		{
			
			$precioF = str_replace(
        array(","),
		array("."),
		$_POST["hidden_price"]);
			$count = count($_SESSION["shopping_cart"]);
			$item_array = array(
				'item_id'			=>	$_GET["CODIGO"],
				'item_name'			=>	$_POST["hidden_name"],
				'item_price'		=>	$precioF,
				'cantidad'		=>	$_POST["cantidad"]
			);
			$_SESSION["shopping_cart"][$count] = $item_array;
		}
		else
		{
			echo "El objeto ya está añadido";
		}
	}
	else
	{
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


if(isset($_GET["action"]))
{
	if($_GET["action"] == "delete")
	{
		foreach($_SESSION["shopping_cart"] as $keys => $values)
		{
			if($values["item_id"] == $_GET["CODIGO"])
			{
				unset($_SESSION["shopping_cart"][$keys]);
				echo "Objeto Borrado";
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
		<title> SAIND - HOME </title>
	</head>
	<body >
	<div id="wrapper">
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
			<div style="clear:both"></div>
			<br />
			<h3>Detalles del pedido</h3>
			<div class="tabla">
				<table class="table table-bordered">
					<tr>
						<th width="40%">Nombre</th>
						<th width="10%">Cantidad</th>
						<th width="20%">Precio</th>
						<th width="15%">Total</th>
						<th width="5%">Action</th>
					</tr>
					<?php
					if(!empty($_SESSION["shopping_cart"]))
					{
						$total = 0;
						foreach($_SESSION["shopping_cart"] as $keys => $values)
						{
					?>
					<tr>
						<td><?php echo $values["item_name"]; ?></td>
						<td><?php echo $values["cantidad"]; ?></td>
						<td > <?php echo $values["item_price"]; ?>€</td>
						<td > <?php echo number_format((float)$values["cantidad"] * $values["item_price"], 2);?>€</td>
						<td ><a href="consulta.php?action=delete&CODIGO=<?php echo $values["item_id"]; ?>"><span class="text-danger">Eliminar</span></a></td>
					</tr>
					<?php
							$total =(float) $total + ($values["cantidad"] * $values["item_price"]);
						}
					?>
					<tr>
						<td colspan="3" align="right">Total</td>
						<td align="right"> <?php echo number_format((float)$total, 2); ?>€</td>
						<td></td>
					</tr>
					<?php
					}
					?>
						
				</table>
			</div>
</main>
	<?php
include_once ("pie.php");
?>
</div>
	</body>

</html>