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

function modificar_cliente($conexion, $usuario){
	
$sql = "UPDATE clientes SET NOMBRE_CLI = :nombre_cli,
 APELLIDOS = :apellidos, 
 DNI = :dni,
 PASS = :pass,
 IDMUNICIPIO = :idmunicipio,
 DIRECCION = :direccion
 WHERE EMAIL = :email";
$stmt = $conexion->prepare($sql);
$stmt->bindParam(':nombre_cli', $usuario["nombre"], PDO::PARAM_STR);
$stmt->bindParam(':apellidos', $usuario["apellidos"], PDO::PARAM_STR);
$stmt->bindParam(':dni', $usuario["nif"], PDO::PARAM_STR);
$stmt->bindParam(':pass', $usuario['pass'], PDO::PARAM_STR);
$stmt->bindParam(':idmunicipio', $usuario['municipio']);
$stmt->bindParam(':direccion', $usuario["calle"], PDO::PARAM_STR);
$stmt->bindParam(':email', $usuario["email"], PDO::PARAM_STR);
$stmt->execute();
	/*try{
	$consulta = "CALL UPDATE_CLIENTE(:emailUP; :nombreUP, :appUP, :dniUP, :passUP, :dirUP)";

	$stmt=$conexion->prepare($consulta);
	$stmt->bindParam(':emailUP',$usuario["email"]);
	$stmt->bindParam(':nombreUP',$usuario["nombre"]);
	$stmt->bindParam(':appUP',$usuario["apellidos"]);
	$stmt->bindParam(':dniUP',$usuario["dni"]);
	$stmt->bindParam(':passUP',$usuario['pass']);
	$stmt->bindParam(':dirUP',$usuario["direccion"]);
 	$stmt->execute();
		return "";
	} catch(PDOException $e) {
		$_SESSION['excepcion'] = $e->GetMessage();
		header("Location: excepciones.php");
    }
*/
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



