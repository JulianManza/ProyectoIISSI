<?php
session_start();
require_once ("gestionBD.php");
require_once ("gestionConsultas.php");
if (isset($_GET["mas"])) {
	$codigo = $_GET["mas"];
} else if (isset($_POST["hidden_mas"])) {
	$codigo = $_POST["hidden_mas"];
} 
else {
	echo "no se encontro el producto";
}


require_once ("gestionBD.php");

//Abre Conexion DB
$conexion = crearConexionBD();

//Consulta DB
$query = "SELECT * FROM PRODUCTOS WHERE CODIGO = '$codigo'";
$filas = consulta($conexion,$query);

//Añade producto al carrito
if(isset($_POST["visorAdd"]))
{
	if(isset($_SESSION["shopping_cart"]))
	{
		$item_array_id = array_column($_SESSION["shopping_cart"], "item_id");
		if(!in_array($_GET["CODIGO"], $item_array_id))
		{
//La , con la funcion number_format da error ya que la toma como texto, así que aquí la convertimos en un .			
			$precioF = str_replace(
        array(","),
		array("."),
		$_POST["hidden_price"]);
		
//Se toman valores del form. La variable $count es la que nos indica el ID del carrito
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
				<form method="post" action="visorProducto.php?action=add&CODIGO=<?php echo $fila["CODIGO"]; ?>">	
				<p>
						<input type="text" name="cantidad" value="1" class="form-control" />
						<input type="hidden" name="hidden_mas" value="<?php echo $fila["CODIGO"]; ?>" />

						<input type="hidden" name="hidden_name" value="<?php echo $fila["NOMBRE"]; ?>" />

						<input type="hidden" name="hidden_price" value="<?php echo $fila["PRECIO"]; ?>" />				</p>
				
					
				
				</div>
					
				<div class="botonAdd"
					<p><button id="visorAdd" name="visorAdd" type="submit" value="<?php echo $fila["CODIGO"] ?>" 
						class="visorAdd"> Añadir al Carrito 
					</button> </p></form>	
					</div>					
				</div> 
			
		</div>
		
		
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
					<button id="comprar" name="comprar" type="submit" class="comprar">Comprar</button>
					<?php
					}
					?>
						
				</table>
			</div>
		<main>

<?php

include_once ("pie.php");
?>
	</body>
</html>