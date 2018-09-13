<?php
session_start();

require_once ("gestionBD.php");
require_once("gestionClientes.php");

if (!isset($_SESSION['login'])){
Header("Location: login.php");}


	$conexion = crearConexionBD();
	$email = $_SESSION['login'];
	$id = consultarIDUsuario($conexion,$email);
	
	$filas = consultarCarritoUsuario($conexion,$id);





?>

<!DOCTYPE html>
<html lang="es">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" type="text/css" href="css/plantilla.css"/>
		<title> SAIND - HOME </title>
	</head>
	<body>
		<?php
		include_once ("cabecera.php");
		include_once ("menu.php");
		?>
	<main>
		


		
		
		<table id="Tcarrito">
		<h1>FACTURAS:</h1>
			<?php
		foreach( $filas as $fila ) {
	?>

		<tr><td>ID compra: <?php echo $fila["IDCARRITO"]; ?></td><td>Precio: <?php echo $fila["PRECIO"]; ?> €</td></tr>
		
			<?php } ?>

		</table>

	</main>
		
<?php
include_once ("pie.php");
?>
	</body>
</html>