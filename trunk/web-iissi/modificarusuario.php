<?php
session_start();
require_once("gestionBD.php");
require_once("gestionarDireccion.php");
$conexion = crearConexionBD();

	if(isset($_SESSION["usuarioMOD"])){
		$usuarioMODI["nombre"] = $_REQUEST["nombre"];
		$usuarioMODI["apellidos"] = $_REQUEST["apellidos"];
		$usuarioMODI["nif"] = $_REQUEST["nif"];
		$usuarioMODI["email"] = $_REQUEST["email"];
		$usuarioMODI["pass"] = $_REQUEST["pass"];
		$usuarioMODI["confirmpass"] = $_REQUEST["confirmpass"];
		$usuarioMODI["calle"] = $_REQUEST["calle"];
		$usuarioMODI["municipio"] = $_REQUEST["municipio"];
		$usuarioMODI["provincia"] = $_REQUEST["provincia"];
		$usuarioMODI["id"] = $_REQUEST["idU"];
		
		$_SESSION["usuarioMOD"] = $usuarioMODI;
		
	$errores = validarDatosUsuario($conexion, $usuarioMODI);
	
	if (count($errores)> 0) {	
	$_SESSION["errores"] = $errores;
	Header("Location:perfil.php");
	}else{	
	Header("Location: modExito.php");
	}}
cerrarConexionBD($conexion);
/////////////////// EJERCICIO 1
// Validación en servidor del formulario de alta de usuario
function validarDatosUsuario($conexion, $usuarioMODI) {
	$errores = array();
	// Validación del Nombre
	if (empty($usuarioMODI["nombre"])){
		$errores[] = "<p> El Nombre no puede estar vacío.</p>";
	}
	// Validación del NIF
	if (empty($usuarioMODI["nif"])){
		$errores[] = "<p> El NIF no puede estar vacío.</p>";
	}else if (!preg_match("/^[0-9]{8}[A-Z]/", $usuarioMODI["nif"])){
		$errores[] = "<p> El NIF debe estar compuesto por 8 numeros seguido de una letra.</p>";
	}
		
	
	// Validación del email
	if (empty($usuarioMODI["email"])){
		$errores[] = "<p> El Correo electrónico no puede estar vacio.</p>";
	}else if (!filter_var($usuarioMODI["email"],FILTER_VALIDATE_EMAIL)){
		$errores[] = "<p> Coreo electrónico no valido.</p>";
	}
	// Validación de la contraseña
	if(empty($usuarioMODI["pass"])){
		$errores[] = "<p> La contraseña no puede estar vacía.</p>";
	}else{
	if (strlen($usuarioMODI["pass"]<8)) 
		$errores[] = "<p> La contraseña debe tener al menos 8 caracteres.</p>";
	if (!preg_match("/[A-Za-z]/", $usuarioMODI["pass"])||
	!preg_match("/[0-9]/", $usuarioMODI["pass"]))
	$errores[] = "<p> La contraseña debe contener al menos una letra mayuscula o minuscula y al menos un digito.</p>";
	
	if($usuarioMODI["pass"] != $usuarioMODI["confirmpass"])
	$errores[] = "<p> La contraseña y su confirmacion deben de ser iguales.</p>";
	}
	// Validación de la dirección
	if (empty($usuarioMODI["calle"]))
		$errores[] = "<p> La calle no puede estar vacía.</p>";
	
	
	$error = validarProvinciaMunicipio($conexion, $usuarioMODI["provincia"], $usuarioMODI["municipio"]);
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