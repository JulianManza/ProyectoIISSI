<?php

    function consultarTodosProductos($conexion) {
	$consulta = "SELECT * FROM PRODUCTOS"
		. " ORDER BY NOMBRE";
    return $conexion->query($consulta);
}
	
	function quitar_producto($conexion,$id) {
	try {
		$stmt=$conexion->prepare('ELIMINA_PRODUCTO(:id)');
		$stmt->bindParam(':id',$id);
		$stmt->execute();
		return "";
	} catch(PDOException $e) {
		return $e->getMessage();
    }
}

?>