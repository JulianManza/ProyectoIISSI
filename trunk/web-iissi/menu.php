<?php
if (!isset($_SESSION))
	session_start();
?>
<nav>
	<ul class="topnav" id="myTopnav">
		<li><a hidefocus="space"	</a></li>
		<li><a class="home" href="consulta.php?maquinaria=equipoSoldadura">Maquinaria de soldadura</a></li>
	  	<li><a href="consulta.php?maquinaria=repuesto">Repuestos</a></li>
	  	<li><a href="consulta.php?maquinaria=consumible">Consumibles</a></li>
	  	
			<?php 
   if(isset($_SESSION['logueado'])){
 		echo   '<li><a href="logout.php">Logout</a></li>';
   } else{
   		echo '<li><a href="login.php">Login</a></li>';
   }
?>
		<li><a href="http://saind.eu/">WEB</a></li>
		<li class="icon">
				<a href="javascript:void(0);" onclick="myToggleMenu()">&#9776;</a>
				</li>
	
	</ul>
</nav>