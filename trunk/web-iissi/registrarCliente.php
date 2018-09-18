<?php
session_start();
require_once("gestionBD.php");
require_once("gestionarDireccion.php");
$conexion = crearConexionBD();
// Comprobar que hemos llegado a esta página porque se ha rellenado el formulario
if (isset($_SESSION["formulario"])) {
 		$nuevoUsuario["nif"] = $_REQUEST["nif"];
		$nuevoUsuario["nombre"] = $_REQUEST["nombre"];
		$nuevoUsuario["apellidos"] = $_REQUEST["apellidos"];
		$nuevoUsuario["calle"] = $_REQUEST["calle"];
		$nuevoUsuario["municipio"] = $_REQUEST["municipio"];
		$nuevoUsuario["provincia"] = $_REQUEST["provincia"];
		$nuevoUsuario["email"] = $_REQUEST["email"];
		$nuevoUsuario["pass"] = $_REQUEST["pass"];
		$nuevoUsuario["confirmpass"] = $_REQUEST["confirmpass"];
		
	$_SESSION["formulario"] = $nuevoUsuario;
	
	$errores = validarDatosUsuario($conexion, $nuevoUsuario);
	
	if (count($errores)> 0) {	
	$_SESSION["errores"] = $errores;
	Header("Location:registro.php");
	}else{	
	Header("Location: exitoRegistro.php");
	}}
cerrarConexionBD($conexion);
/////////////////// EJERCICIO 1
// Validación en servidor del formulario de alta de usuario
function validarDatosUsuario($conexion, $nuevoUsuario) {
	$errores = array();
	// Validación del Nombre
	if (empty($nuevoUsuario["nombre"])){
		$errores[] = "<p> El Nombre no puede estar vacío.</p>";
	}
	// Validación del NIF
	if (empty($nuevoUsuario["nif"])){
		$errores[] = "<p> El NIF no puede estar vacío.</p>";
	}else if (!preg_match("/^[0-9]{8}[A-Z]/", $nuevoUsuario["nif"])){
		$errores[] = "<p> El NIF debe estar compuesto por 8 numeros seguido de una letra.</p>";
	}
		
	
	// Validación del email
	if (empty($nuevoUsuario["email"])){
		$errores[] = "<p> El Correo electrónico no puede estar vacio.</p>";
	}else if (!filter_var($nuevoUsuario["email"],FILTER_VALIDATE_EMAIL)){
		$errores[] = "<p> Coreo electrónico no valido.</p>";
	}
	// Validación de la contraseña
	if(empty($nuevoUsuario["pass"])){
		$errores[] = "<p> La contraseña no puede estar vacía.</p>";
	}else{
	if (strlen($nuevoUsuario["pass"]<8)) 
		$errores[] = "<p> La contraseña debe tener al menos 8 caracteres.</p>";
	if (!preg_match("/[A-Za-z]/", $nuevoUsuario["pass"])||
	!preg_match("/[0-9]/", $nuevoUsuario["pass"]))
	$errores[] = "<p> La contraseña debe contener al menos una letra mayuscula o minuscula y al menos un digito.</p>";
	
	if($nuevoUsuario["pass"] != $nuevoUsuario["confirmpass"])
	$errores[] = "<p> La contraseña y su confirmacion deben de ser iguales.</p>";
	}
	// Validación de la dirección
	if (empty($nuevoUsuario["calle"]))
		$errores[] = "<p> La calle no puede estar vacía.</p>";
	
	
	$error = validarProvinciaMunicipio($conexion, $nuevoUsuario["provincia"], $nuevoUsuario["municipio"]);
		if ($error != "") {
			$errores[] = $error;
		}
	return $errores;
}
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