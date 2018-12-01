<?php
    session_start();
   require_once("gestionBD.php");
   
   if (isset($_SESSION["shopping_cart"]) && isset($_SESSION["login"])) {
		// Recogemos los datos del formulario
		$conexion = crearConexionBD();
		$email = $_SESSIO["login"];
		
	}
	else{
		Header("Location: index.php");
	}
	
	try{ 
		$consulta = "INSERT INTO carritos (IDCLIENTE) 
        VALUES(:id)";
		$id = consultarIDUsuario($conexion, $email);
	} catch(PDOException $e) {
		$_SESSION['excepcion'] = $e->GetMessage();
		header("Location: excepciones.php");
    }
	Header("Location: index.php");
?>
