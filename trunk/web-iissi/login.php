<?php
	session_start();
  	
  	include_once("gestionBD.php");
 	include_once("gestionClientes.php");
	
	if (isset($_POST['submit'])){
		$email= $_POST['email'];
		$pass = $_POST['pass'];

		$conexion = crearConexionBD();
		$num_usuarios = consultarUsuario($conexion,$email,$pass);
		cerrarConexionBD($conexion);	
	
		if ($num_usuarios == 0)
			$login = "error";	
		else {
			$_SESSION['logueado'] = TRUE;
			$_SESSION['login'] = $email;
			Header("Location: index.php");
		}	
	}

?>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="utf-8">
<link rel="stylesheet" type="text/css" href="css/plantilla.css" />
  <title>Gestión de clientes: Login</title>
</head>

<?php
	include_once("cabecera.php");
?>
<body>


<div name = "contenido">
		<?php if (isset($login)) {
		echo "<div class=\"error\">";
		echo "Error en la contraseña o email.";
		echo "</div>";
	}	
	?>
	<form name="login" action="login.php" method="post">
		<fieldset class= "login">
		<div class = "LoginMail"><label for="email">Email: </label><input type="text" name="email" id="email" /></div>
		<div><label for="pass">Contraseña: </label><input type="password" name="pass" id="pass" /></div>
		<div class= "enter"><input type="submit" name="submit" value="Aceptar" />
		</div>
		<div class="textemsg">
			<p>¿No estás registrado? <a href="registro.php">¡Registrate!</a></p>
		</div>
		</fieldset>
		
	</form>
</body>


<?php
			include_once("pie.php");
		?>
</html>

