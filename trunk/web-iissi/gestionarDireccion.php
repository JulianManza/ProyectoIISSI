<?php
function listarProvincias($conexion){
	try{
		$consulta = "SELECT * FROM PROVINCIAS ORDER BY NOMBRE";
    	$stmt = $conexion->query($consulta);
		return $stmt;
	}catch(PDOException $e) {
		return $e->getMessage();
    }
}

function buscarProvincia($conexion, $nombre){
	try{
		$consulta = "SELECT IDPROVINCIA FROM PROVINCIAS WHERE NOMBRE LIKE :nombre";
		$stmt=$conexion->prepare($consulta);
		$stmt->bindParam(':nombre',$nombre);	
		$stmt->execute();	
		
		return $stmt;
	}catch(PDOException $e) {
		return $e->getMessage();
    }
}

function buscarMunicipioProvincia($conexion, $idprovincia, $idmunicipio){
	try{
		$consulta = "SELECT * FROM MUNICIPIOS WHERE IDPROVINCIA = :prov AND IDMUNICIPIO = :mun";
		$stmt=$conexion->prepare($consulta);
		$stmt->bindParam(':mun',$idmunicipio);
		$stmt->bindParam(':prov',$idprovincia);	
		$stmt->execute();	
		return $stmt;
	}catch(PDOException $e) {
		return $e->getMessage();
    }
}

?>