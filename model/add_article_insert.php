<?php
	require_once("../controller/db_connexion.php");
	$sql = "SELECT id_user FROM users WHERE pseudo = '".$_SESSION["pseudo"]."'";
	$req = $db_connexion->query($sql);
	$data = $req -> fetch();
	$id= $data[0];
	unset($data);

//RECUPERATION DE ID_SPECIE GRACE AU NAME DE L'ESPECE

	$sql2 = "SELECT id_specie FROM species WHERE name = '".$_POST["name"]."'";
	$req2 = $db_connexion->query($sql);
	$data2 = $req2 -> fetch();
	$specie = $data2[0];
	$sql= "INSERT INTO articles (id_article, id_specie, id_user, description, unit_price, stock, gender, diet, weight, size, color, age, status) VALUES (NULL, '".$specie."', '".$id."', '".$_POST['description']."', '".$_POST['price']."', '".$_POST['stock']."', '".$_POST['gender']."', '".$_POST['diet']."', '".$_POST['weight']."', '".$_POST['size']."', '".$_POST['color']."', '".$_POST['age']."', 'available')";
	$stmt = $db_connexion->prepare($sql);
	$stmt->execute();
?>