<?php

require_once ("gestionBD.php");
require_once ("gestionProductos.php");
require_once ("gestionClientes.php");

if (!isset($_SESSION['login'])){
Header("Location: login.php");}
	$conexion = crearConexionBD();
	$email = $_SESSION['login'];
	$id = consultarIDUsuario($conexion,$email);
	cerrarConexionBD($conexion);

?>
		<div id = "miCarrito">
	<br />
			<h3>Detalles del pedido</h3>
			<div class="tabla">
				<table class="table">
					<tr>
						<th width="40%">Nombre</th>
						<th width="10%">Cantidad</th>
						<th width="20%">Precio</th>
						<th width="15%">Total</th>
						<th width="5%">Action</th>
					</tr>
					<?php
					if(!empty($_SESSION["shopping_cart"]))
					{
						$total = 0;
						foreach($_SESSION["shopping_cart"] as $keys => $values)
						{
					?>
					<tr>
						<td><?php echo $values["item_name"]; ?></td>
						<td><?php echo $values["cantidad"]; ?></td>
						<td > <?php echo $values["item_price"]; ?>€</td>
						<td > <?php echo number_format((float)$values["cantidad"] * $values["item_price"], 2);?>€</td>
						<td ><a href="consulta.php?action=delete&CODIGO=<?php echo $values["item_id"]; ?>"><span class="text-danger">Eliminar</span></a></td>
					</tr>
					<?php
							$total =(float) $total + ($values["cantidad"] * $values["item_price"]);
						}
					?>
					<tr>
						<td colspan="3" align="right">Total</td>
						<td align="right"> <?php echo number_format((float)$total, 2); ?>€</td>
						<td></td>
					</tr>
					
					<?php
					}
					?>
				<form action="compra.php" method="post">
				<input type="hidden" name="hidden_id" value="<?php echo (int)$id; ?>" />
				<input type="hidden" name="hidden_total" value="<?php echo $total; ?>" />
				<button id="comprar" name="comprar" type="submit" class="comprar">Comprar</button>
				</form>
				</table>
			</div>
</div>