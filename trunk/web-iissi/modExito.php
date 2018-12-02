<?php
    session_start();

	require_once("gestionBD.php");
	require_once("gestionClientes.php");
	
// Comprobar que hemos llegado a esta página porque se ha rellenado el formulario
	if (isset($_SESSION["usuarioMOD"])) {
		$usuarioMODI = $_SESSION["usuarioMOD"];
		$_SESSION["usuarioMOD"] = null;
		$_SESSION["errores"] = null;
	}
	else 
		Header("Location: perfil.php");	

	$conexion = crearConexionBD(); 

?>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <title>Saind: Modificación de Usuario realizada con éxito</title>
</head>

<body>
	<?php
		include_once("cabecera.php");
	?>

	<main>
		<?php 
		if (modificar_cliente($conexion, $usuarioMODI)) { 
				$_SESSION['login'] = $usuarioMODI['email'];
				$_SESSION['logueado'] = TRUE;
		?>
				<h1>Hola <?php echo $usuarioMODI["nombre"]; ?>, gracias por registrarte</h1>
				<div >	
			   		Pulsa <a href="index.php">aquí</a> para acceder a la web.
				</div>
		<?php } else { ?>
				<h1>Cambios aplicados con éxito</h1>
				<br>Debes volver a entrar para continuar.<br>
				<div >	
					Pulsa <a href="login.php">aquí</a> para volver al formulario.
				</div>
		<?php } ?>

	</main>

	<?php
		include_once("pie.php");
	?>
</body>
</html>
<?php
	cerrarConexionBD($conexion);
?>

