<?php
	require_once("db_connexion.php");
	$pseudo= htmlspecialchars($_POST["pseudo"]);
	$firstname= htmlspecialchars($_POST["firstname"]);
	$name= htmlspecialchars($_POST["name"]);
	$password1= htmlspecialchars($_POST["password1"]);
	$password2= htmlspecialchars($_POST["password2"]);
	$email= htmlspecialchars($_POST["email"]);

	$req = mysqli_query($db_connexion, "SELECT * FROM users WHERE pseudo = '".$pseudo."'");
	if ( empty ( $pseudo ) || empty ( $firstname ) || empty ( $name )|| empty ($password1) || empty($password2) || empty ($email) ){
		header("location:../subscribe.php?error=incomplete");
	} else if ( strlen($password1) < 3 ||  strlen($pseudo) < 3 ) {
		header("location:../subscribe.php?error=tooshort");
	} else if ( $password1 != $password2 ){
		header("location:../subscribe.php?error=password");
	} else if ( mysqli_num_rows($req) == 1 ){
		header("location:../subscribe.php?error=exist");
	} else {
    $password = $password1 ;
    mysqli_query($db_connexion, "INSERT INTO users (id_user, pseudo, firstname, name, note, password, balance) VALUES (NULL, '".$pseudo."', '".$firstname."', '".$name."', '2.5', '".$password."', '0.0')");
		header("location:../subscribe.php?subscribe=confirmed");
	}
?>
