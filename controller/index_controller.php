<?php

if (isset($_POST["go"])){
  if ($_POST["go"] == "login"){
    include("../view/login.php");
  } elseif ($_POST["go"] == "subscribe"){
    include("../view/subscribe.php");
  }
}
if (isset ($_GET["error"]) && $_GET["error"] == "wrong"){
    include("../view/login.php");
}
if (isset ($_GET["user"])){
  if ($_GET["user"] === "exist"){
    header("location:../index.php?user=exist");
  }
}
?>
