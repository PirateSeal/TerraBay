<?php

	require_once("../controller/db_connexion.php");
	$sql ='select id_user from users where pseudo = "'.$_SESSION['pseudo'].'"';
	$req = $db_connexion->query($sql);
	$id = $req->fetch();



	$sql = 'select id_article, unit_price, species.name from users inner join articles on users.id_user = articles.id_user inner join species on articles.id_specie = species.id_specie where users.id_user = "'.$id['id_user'].'"';
	$req = $db_connexion->query($sql);

	$i=0;
	while ($row = $req->fetch()){
		$data[$i]=$row;
		$i++;
	}
	$req->closeCursor();


?>