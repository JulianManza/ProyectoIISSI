<?php
	session_start();
	
	if(isset($_SESSION["usuarioMOD"])){
		$usuarioMOD = $_SESSION["usuarioMOD"];
		unset($_SESSION["usuarioMOD"]);
		
		require_once("gestionBD.php");
		require_once("gestionClientes.php");
		$conexion = crearConexionBD();
		$excepcion = modificar_cliente($conexion, $usuarioMOD["id"], $usuarioMOD["nombre"], $usuarioMOD["apellidos"], $usuarioMOD["nif"], $usuarioMOD["pass"], $usuarioMOD["calle"], $usuarioMOD["municipio"]);
		cerrarConexionBD($conexion);
		
		if($excepcion<>""){
			$_SESSION["excepcion"] = $excepcion;
			$_SESSION["destino"] = "perfil.php";
			Header("Location: excepciones.php");
		}
		else
			Header("Location: perfil.php");
	}
	else Header("Location: perfil.php");

?>