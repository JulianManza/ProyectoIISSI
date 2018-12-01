<?php
  /*
     * #===========================================================#
     * #	Este fichero contiene las funciones de gestión
     * #	de usuarios de la capa de acceso a datos
     * #==========================================================#
     */

 function registro_cliente($conexion,$usuario) {
	try {
		$consulta = "CALL INSERTAR_CLIENTE(:nif, :nombre, :ape, :dir, :mun, :email, :pass)";
		$email = $usuario["email"];
		$pass  = $usuario["pass"];
		$stmt=$conexion->prepare($consulta);
		$stmt->bindParam(':nif',$usuario["nif"]);
		$stmt->bindParam(':nombre',$usuario["nombre"]);
		$stmt->bindParam(':ape',$usuario["apellidos"]);
		$stmt->bindParam(':dir',$usuario["calle"]);
		$stmt->bindParam(':mun',$usuario["municipio"]);
		$stmt->bindParam(':email',$usuario["email"]);
		$stmt->bindParam(':pass',$usuario["pass"]);
		$stmt->execute();
		return consultarUsuario($conexion, $email, $pass);
	} catch(PDOException $e) {
		$_SESSION['excepcion'] = $e->GetMessage();
		header("Location: excepciones.php");
    }
}
  
function consultarUsuario($conexion,$email,$pass) {
 	$consulta = "SELECT COUNT(*) AS TOTAL FROM CLIENTES WHERE EMAIL=:email AND PASS=:pass";
	$stmt = $conexion->prepare($consulta);
	$stmt->bindParam(':email',$email);
	$stmt->bindParam(':pass',$pass);
	$stmt->execute();
	return $stmt->fetchColumn();
}

function consultarIDUsuario($conexion,$email){
 	$consulta = "SELECT IDCLIENTE FROM CLIENTES WHERE EMAIL='$email'";
	$stmt = $conexion->prepare($consulta);
	$stmt->execute();
	return $stmt->fetchColumn();
	}
	
	
function consultarCarritoUsuario($conexion,$id){
 	$consulta = "SELECT * FROM CARRITOS WHERE IDCLIENTE='$id'";
	return $conexion->query($consulta);
	}

function consultarDatosUsuario($conexion,$email){
 	$consulta = "SELECT * FROM CLIENTES WHERE EMAIL='$email'";
	return $conexion->query($consulta);
	}
?>



