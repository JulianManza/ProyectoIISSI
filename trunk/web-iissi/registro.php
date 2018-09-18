<?php
session_start();
require_once ("gestionBD.php");
require_once ("gestionarDireccion.php");
if(isset($_SESSION['logueado'])){
	unset($_SESSION['login']);
	unset($_SESSION['logueado']);
}
if (!isset($_SESSION["formulario"])) {
	$formulario["nif"] = " ";
	$formulario["nombre"] = " ";
	$formulario["apellidos"] = " ";
	$formulario["calle"] = " ";
	$formulario["municipio"] = " ";
	$formulario["provincia"] = " ";
	$formulario["email"] = " ";
	$formulario["pass"] = " ";
	$formulario["confirmpass"] = " ";
	
	$_SESSION["formulario"] = $formulario;
} else {
	$formulario = $_SESSION["formulario"];
}
if (isset($_SESSION["errores"])){
	$errores = $_SESSION["errores"];
	unset($_SESSION["errores"]);
}
$conexion = crearConexionBD()
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

		<form id="altaUsuario" method="get" action="registrarCliente.php" novalidate>
			  		<p><i>Los campos obligatorios están marcados con </i><em>*</em></p>
  		<fieldset id="datosFormu" name="datosFormu" class="datosFormu">
  			
    <div class="nameUser"><label for="nombre">Nombre:<em>*</em></label>
			<input id="nombre" name="nombre" type="text" size="40" value="<?php echo $formulario['nombre'];?>"/>
	</div>
    
    <div><label for="apellidos">Apellidos:</label>
			<input id="apellidos" name="apellidos" type="text" size="80" value="<?php echo $formulario['apellidos'];?>"/>
	</div>
	
	<div><label for="nif">NIF	<em>*	</em></label>
			<input id="nif" name="nif" type="text" placeholder="12345678X" pattern="^[0-9]{8}[A-Z]" title="Ocho dígitos seguidos de una letra mayúscula" value="<?php echo $formulario['nif'];?>" required>
	</div>

    <div><label for="email">Email:	<em>*</em></label>
			<input id="email" name="email"  type="email" placeholder="usuario@dominio.extension" value="<?php echo $formulario['email'];?>" required/><br>
	</div>
	
    <div><label for="pass">Password:	<em>*</em></label>
            <input type="password" name="pass" id="pass" placeholder="Mínimo 8 caracteres entre letras y dígitos" required oninput="passwordValidation(); "/>
	</div>
	
    <div><label for="confirmpass">Confirmar Password:	</label>
			<input type="password" name="confirmpass" id="confirmpass" placeholder="Confirmación de contraseña"  oninput="passwordConfirmation();" required"/>
	</div>

	<div><label for="calle">Calle/Avda.:	<em>*</em></label>
			<input id="calle" name="calle" type="text" size="80" value="<?php echo $formulario['calle'];?>" required/>
	</div>

	<div><label for="provincia">Provincia:	<em>*</em></label>
			<input list="opcionesProvincias" name="provincia" id="provincia" required value="<?php echo $formulario['provincia'];?>"/>
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
			<input id="municipio" name="municipio" type="text" list="opcionesMunicipios" required value="<?php echo $formulario['municipio'];?>">
			<datalist id="opcionesMunicipios">
			</datalist>
	</div>
	<div class="button" >
        <input type="submit" value="Registrar" />
    </div>
    </fieldset>
		</form>
		<?php
		include_once ("pie.php");
		?>
	</body>
</html>
