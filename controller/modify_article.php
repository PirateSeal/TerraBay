<?php
	require_once("../controller/loged_or_not.php");


	$good = 0;
	if (!isset($_GET['go'])) {
		$idarticle = $_GET['id'];
		include("../view/header.php");
		require_once("../model/modify_article_data.php");
		require_once("../view/modify_article.php");
	} elseif (isset($_GET['go']) && $_GET['go']=="modify") {
		$verif = ["description", "name", "unit_price", "gender", "diet", "weight", "size", "color", "age"];
		$good = 0;
		for ($i=0; $i < count($verif); $i++) {
			if (!isset($_POST[$verif[$i]])) {
				$good=1;
			}
		}
		if (!isset($_POST['stock']) && intval($_POST['stock'])==0) {
			$good=1;
		}
 		if ($good == 1) {
			$idarticle = $_POST['id'];
			require_once("../model/modify_article_data.php");
			require_once("../view/modify_article.php");
		} else {
			$idarticle = $_POST['id'];
			require_once("../model/modify_article.php");
			require_once("../model/modify_article_data.php");
			$good=0;
			header("location:../controller/my_article.php");
		}
	}

?>
