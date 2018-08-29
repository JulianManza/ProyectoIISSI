<?php
	session_start();
    
    if (isset($_SESSION['login'])){
    	unset($_SESSION['login']);
		unset($_SESSION['logueado']);
    }
        
    header("Location: index.php");
?>
