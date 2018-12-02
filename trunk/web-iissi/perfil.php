<?php
session_start();
require_once ("gestionBD.php");
require_once ("gestionarDireccion.php");
require_once ("gestionClientes.php");
require_once ("gestionConsultas.php");


if (!isset($_SESSION['login'])){
Header("Location: login.php");}
	$email = $_SESSION['login'];
//Consulta a la bbdd
require_once ("gestionBD.php");
$conexion = crearConexionBD();
$query = "SELECT * FROM CLIENTES WHERE EMAIL = '$email'";
$filas = consulta($conexion,$query);
if (!isset($_SESSION["usuarioMOD"])) {
	$usuarioMOD["nif"] = " ";
	$usuarioMOD["nombre"] = " ";
	$usuarioMOD["apellidos"] = " ";
	$usuarioMOD["calle"] = " ";
	$usuarioMOD["municipio"] = " ";
	$usuarioMOD["provincia"] = " ";
	$usuarioMOD["email"] = " ";
	$usuarioMOD["pass"] = " ";
	$usuarioMOD["id"] = " ";
	
	$_SESSION["usuarioMOD"] = $usuarioMOD;
}	else{
	$usuarioMOD = $_SESSION["usuarioMOD"];
}
if (isset($_SESSION["errores"])){
	$errores = $_SESSION["errores"];
	unset($_SESSION["errores"]);
}

	cerrarConexionBD($conexion);
?>


<!DOCTYPE html>
<html lang="es">
	<head>
		<meta charset="utf-8">
		<link rel="stylesheet" type="text/css" href="css/plantilla.css" />
		<script src="https://code.jquery.com/jquery-3.1.1.min.js" type="text/javascript"></script>
		<script src="js/validacion_cliente_alta_usuario.js" type="text/javascript"></script>
		<title>Saind: Gestion de Usuarios</title>
	</head>

	<body>
		<script>
		// Inicialización de elementos y eventos cuando el documento se carga completamente
			$(document).ready(function() {
				// EJERCICIO 3: Manejador de evento del color de la contraseña
				$("#pass").on("keyup", function() {
					// Calculo el color
					passwordColor();
				});
				// EJERCICIO 4: Uso de AJAX con JQuery para cargar de manera asíncrona los municipios según la provincia seleccionada
				// Manejador de evento sobre el campo de provincias
				$("#provincia").on("input", function() {
					// Llamada AJAX con JQuery, pasándole el valor de la provincia como parámetro
					$.get("cambio_provincia.php", {
						provinciaMunicipio : $('#provincia').val()
					}, function(data) {
						// Borro los municipios que hubiera antes en el datalist
						$("#opcionesMunicipios").empty();
						// Adjunto al datalist la lista de municipios devuelta por la consulta AJAX
						$("#opcionesMunicipios").append(data);
					});
				});
			});
		</script>
		
		<?php
		include_once("cabecera.php");
		include_once("menu.php");
		
if (isset($errores))	{
echo "<div class='error'>";
foreach ($errores as $error) echo $error;
echo "</div>";
}	
		?>
		<?php
		foreach($filas as $cliente){
			
		}?>
		<form id="altaUsuario" method="get" action="modificarusuario.php">
			  		<p><i>Los campos obligatorios están marcados con </i><em>*</em></p>
  		<fieldset id="datosFormu" name="datosFormu" class="datosFormu">
  			
    <div class="nameUser"><label for="nombre">Nombre:<em>*</em></label>
			<input id="nombre" name="nombre" type="text" size="40" value="<?php echo $cliente["NOMBRE_CLI"];?>"/>
	</div>
    
    <div><label for="apellidos">Apellidos:</label>
			<input id="apellidos" name="apellidos" type="text" size="80" value="<?php echo $cliente["APELLIDOS"];?>"/>
	</div>
	
	<div><label for="nif">NIF	<em>*	</em></label>
			<input id="nif" name="nif" type="text" placeholder="12345678X" pattern="^[0-9]{8}[A-Z]" title="Ocho dígitos seguidos de una letra mayúscula" value="<?php echo $cliente["DNI"];?>" required>
	</div>

    <div><label for="email">Email:	<em>*</em></label>
			<input id="email" name="email"  type="email" placeholder="usuario@dominio.extension" value="<?php echo $cliente["EMAIL"];?>" required/ readonly><br>
	</div>
	
    <div><label for="pass">Password:	<em>*</em></label>
            <input type="password" name="pass" id="pass" placeholder="Mínimo 8 caracteres entre letras y dígitos" required oninput="passwordValidation(); "/>
	</div>
	
    <div><label for="confirmpass">Confirmar Password:	</label>
			<input type="password" name="confirmpass" id="confirmpass" placeholder="Confirmación de contraseña"  oninput="passwordConfirmation();" required"/>
	</div>
	<div><label for="calle">Calle/Avda.:	<em>*</em></label>
			<input id="calle" name="calle" type="text" size="80" value="<?php echo $cliente["DIRECCION"];?>" required />
			<input id="idU" name="idU" type="hidden" size="80" value="<?php echo $cliente["IDCLIENTE"];?>" required />
	</div>
	<div><label for="provincia">Provincia:	<em>*</em></label>
			<input list="opcionesProvincias" name="provincia" id="provincia" required value="<?php echo "";?>"/>
			<datalist id="opcionesProvincias">
			  	<?php
			  		$provincias = listarProvincias($conexion);
			  		foreach($provincias as $provincia) {
			  			echo "<option label='".$provincia["NOMBRE"]."' value='".$provincia["IDPROVINCIA"]."'>";
					}
				?>
			</datalist>
	</div>
	<div><label for="municipio">Municipio:	<em>*</em></label>
			<input id="municipio" name="municipio" type="text" list="opcionesMunicipios" required value="<?php echo "";?>">
			<datalist id="opcionesMunicipios">
			</datalist>
	</div>
	<div class="button" >
        <input type="submit" id="editar" name="editar" value="Editar" />
    </div>
    </fieldset>
		</form>
		<?php
		include_once ("pie.php");
		?>
	</body>
</html>