<?php
   session_start();
   require_once("gestionBD.php");
   require_once("gestionarDireccion.php");
   
   if (isset($_SESSION["formulario"])) {
		// Recogemos los datos del formulario
		$nuevoUsuario["nif"] = $_REQUEST["nif"];
		$nuevoUsuario["nombre"] = $_REQUEST["nombre"];
		$nuevoUsuario["apellidos"] = $_REQUEST["apellidos"];
		$nuevoUsuario["calle"] = $_REQUEST["calle"];
		$nuevoUsuario["municipio"] = $_REQUEST["municipio"];
		$nuevoUsuario["provincia"] = $_REQUEST["provincia"];
		$nuevoUsuario["email"] = $_REQUEST["email"];
		$nuevoUsuario["pass"] = $_REQUEST["pass"];
		$nuevoUsuario["confirmpass"] = $_REQUEST["confirmpass"];	
	}else {// En caso contrario, vamos al formulario
		Header("Location: registro.php");
	}
	// Guardar la variable local con los datos del formulario en la sesión.
	$_SESSION["formulario"] = $nuevoUsuario;
	// Validamos el formulario en servidor
	// Si se produce alguna excepción PDO en la validación, volvemos al formulario informando al usuario
	try{ 
		$conexion = crearConexionBD(); 
		$errores = validarDatosUsuario($conexion, $nuevoUsuario);
		cerrarConexionBD($conexion);
	}catch(PDOException $e){
		// Mensaje de depuración
		$_SESSION["errores"] = "<p>ERROR en la validación: fallo en el acceso a la base de datos.</p><p>"
		 . $e->getMessage() . "</p>";
		Header('Location: registro.php');
	}
	
	// Si se han detectado errores
	if (count($errores)>0) {
		// Guardo en la sesión los mensajes de error y volvemos al formulario
		$_SESSION["errores"] = $errores;
		Header('Location: registro.php');
	} else
		// Si todo va bien, vamos a la página de éxito (inserción del usuario en la base de datos)
		Header('Location: exitoRegistro.php');

///////////////////////////////////////////////////////////
// Validación en servidor del formulario de alta de usuario
///////////////////////////////////////////////////////////
function validarDatosUsuario($conexion, $nuevoUsuario){
	$errores=array();
	// Validación del NIF
	if($nuevoUsuario["nif"]=="") 
		$errores[] = "<p>El NIF no puede estar vacío</p>";
	else if(!preg_match("/^[0-9]{8}[A-Z]$/", $nuevoUsuario["nif"])){
		$errores[] = "<p>El NIF debe contener 8 números y una letra mayúscula: " . $nuevoUsuario["nif"]. "</p>";
	}

	// Validación del Nombre			
	if($nuevoUsuario["nombre"]=="") 
		$errores[] = "<p>El nombre no puede estar vacío</p>";
	
	// Validación del email
	if($nuevoUsuario["email"]==""){ 
		$errores[] = "<p>El email no puede estar vacío</p>";
	}else if(!filter_var($nuevoUsuario["email"], FILTER_VALIDATE_EMAIL)){
		$errores[] = "<p>El email es incorrecto: " . $nuevoUsuario["email"]. "</p>";
	}
	// Validación de la contraseña
	if(!isset($nuevoUsuario["pass"]) || strlen($nuevoUsuario["pass"])<8){
		$errores [] = "<p>Contraseña no válida: debe tener al menos 8 caracteres</p>";
	}else if(!preg_match("/[a-z]+/", $nuevoUsuario["pass"]) || 
		!preg_match("/[A-Z]+/", $nuevoUsuario["pass"]) || !preg_match("/[0-9]+/", $nuevoUsuario["pass"])){
		$errores[] = "<p>Contraseña no válida: debe contener letras mayúsculas y minúsculas y dígitos</p>";
	}else if($nuevoUsuario["pass"] != $nuevoUsuario["confirmpass"]){
		$errores[] = "<p>La confirmación de contraseña no coincide con la contraseña</p>";
	}
	// Validación de la dirección
	if($nuevoUsuario["calle"]==""){
		$errores[] = "<p>La dirección no puede estar vacía</p>";	
	}
	// Validar municipio y provincia
	$error = validarProvinciaMunicipio($conexion, $nuevoUsuario["provincia"], $nuevoUsuario["municipio"]);
	if($error!="")
		$errores[] = $error;
	return $errores;	
}
	// Comprueba que la pareja municipio-provincia están en la BD
function validarProvinciaMunicipio($conexion, $provincia, $municipio){
	$error="";
	$mun = buscarMunicipioProvincia($conexion, $provincia, $municipio);
	$cont = 0;
	foreach($mun as $m){
		$cont = $cont + 1;
	}
	
	if($cont != 1){
		$error =  "<p>El municipo y la provincia no son válidos</p>";
	}
	return $error;
}
	
?>