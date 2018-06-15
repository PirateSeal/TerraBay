<?php
  require("../controller/db_connexion.php");
  $req_bid ="SELECT * FROM discounts WHERE id_discount = ( SELECT Max(id_discount) from discounts );";
  $data = $db_connexion->query($req_bid)->fetch();

  // RÉCUPÉRATION DE MES VARIABLES
  $year = date("Y");
  $month = date("m");
  $day = date("d");
  $hour = date("H");
  $minute = date("i");
  $second = date("s");
  $h = $hour+1;
  $hh = $hour+2;
  $h1 =$year."-".$month."-".$day." ".$h.":00:00";
  $h2 =$year."-".$month."-".$day." ".$hh.":00:00";
  $time_start =$data[3];
  $time_now =$year."-".$month."-".$day." ".$hour.":".$minute.":".$second;
  $time_end = $data[4];

  $date_time_start = explode(" ", $time_start);
  //echo "deb :".$time_start."<br>";
  //echo $date_time_start[0]."<br>";
  $date_start = explode("-",$date_time_start[0]);
  //echo $date_start[0]."<br>";
  //echo $date_start[1]."<br>";
  //echo $date_start[2]."<br>";
  $hour_start = explode(":",$date_time_start[1]);
  //echo $hour_start[0]."<br>";
  //echo $hour_start[1]."<br>";
  //echo $hour_start[2]."<br>";

  $date_time_end = explode(" ", $time_end);
  //echo "fin :".$time_end."<br>";
  $date_end = explode("-",$date_time_end[0]);
  //echo $date_end[0]."<br>";
  //echo $date_end[1]."<br>";
  //echo $date_end[2]."<br>";
  $hour_end = explode(":",$date_time_end[1]);
  //echo $hour_end[0]."<br>";
  //echo $hour_end[1]."<br>";
  //echo $hour_end[2]."<br>";
  if ($hour_end[0] === "23" ){
    $day_up = $date_end[2]+1;
    $new_end = $date_end[0]."-".$date_end[1]."-".$day_up." 00:".$hour_end[1].":".$hour_end[2];
    //echo $new_end."NEWW<br>";
  } else {
    $hour_up = $hour_end[0]+1;
    $new_end = $date_end[0]."-".$date_end[1]."-".$date_end[2]." ".$hour_up.":".$hour_end[1].":".$hour_end[2];
    //echo $new_end."NEWW<br>";
  }

  $date_time_now = explode(" ", $time_now);
  //echo "now :".$time_now."<br>";
  $date_now = explode("-",$date_time_now[0]);
  //echo $date_now[0]."<br>";
  //echo $date_now[1]."<br>";
  //echo $date_now[2]."<br>";
  $hour_now = explode(":",$date_time_now[1]);
  //echo $hour_now[0]."<br>";
  //echo $hour_now[1]."<br>";
  //echo $hour_now[2]."<br>";

  $req_random = "SELECT id_article FROM articles ORDER BY RAND() LIMIT 1";
  $rand = $db_connexion->query($req_random)->fetch();
  $req_bid ="SELECT * FROM discounts WHERE id_discount = ( SELECT Max(id_discount) from discounts );";
  $data = $db_connexion->query($req_bid)->fetch();
  $old_id = $data[1];
  $new_id = $rand[0];
  //echo "New id :".$new_id."<br>";
  //echo "Old id :".$old_id."<br>";

  // ALGO
  //echo $day."=".$date_end[2]."et".$hour.">=".$hour_end[0];
  if ($day === $date_end[2] && $hour >= $hour_end[0] || $day > $date_end[2]){
    if ( $old_id === $new_id){
      header("location:../controller/bid_controller.php");
    } else {
      $req_select_random = "SELECT * FROM articles WHERE id_article='".$new_id."'";
      $price = $db_connexion->query($req_select_random)->fetch();

      $true_price = $price[4];
      //echo "Vrai prix :".$true_price."<br>";

      $disc_price = $true_price-(20/100*$true_price);
      //echo "Disc prix :".$disc_price."<br>";

      // MODIFICATION DE L'ANCIEN DISCOUNT PRIX PAR DEFAULT .
      // '".$data[4]."', '".$new_end."' modifier a l'heure actuel et l'heure +1
      $req_old_price = "UPDATE articles SET unit_price = '".$data[5]."' WHERE id_article = '".$data[1]."'" ;
      $db_connexion->exec($req_old_price);
      $req_low_status = "UPDATE discounts SET status = '0' WHERE id_article = '".$data[1]."'" ;
      $db_connexion->exec($req_low_status);
      // AJOUT DU NOUVEAU DISCOUNT
      $req_new_discount = "INSERT INTO `discounts` (`id_discount`, `id_article`, `status`, `date_start`, `date_end`, `init_price`, `disc_price`)
      VALUES (NULL, '".$new_id."', '1', '".$h1."', '".$h2."', '".$true_price."', '".$disc_price."') ";
      $db_connexion->exec($req_new_discount);

      $req_new_price = "UPDATE articles SET unit_price = '".$disc_price."' WHERE id_article = '".$new_id."'" ;
      $data = $db_connexion->query($req_new_price)->fetch();
    }
  } else {
    echo "<form action='../controller/home_controller.php' method='get'><button>Back</button></form>";
      $req_data_article = "SELECT * FROM articles where id_article = '".$data[1]."' ";
      $article = $db_connexion->query($req_data_article)->fetch();
      echo "<h1>Offer of the hour !</h1>";
      echo "Description : ".$article[3]."<br>";
      echo "Price : ".$article[4]."<br>";
      echo "Quantity : ".$article[5]."<br>";
      if ( $article[6] === 0){
        $sexe = "Male" ;
      }else if ( $article[6] === 1){
        $sexe = "Female" ;
      }else{
        $sexe = "Hermaphrodite";
      }
      echo "Sexe : ".$sexe."<br>" ;
      echo "Diet : ".$article[7]."<br>";
      echo "Weight : ".$article[8]."<br>";
      echo "Size : ".$article[9]."<br>";
      echo "Color : ".$article[10]."<br>";
      echo "Age : ".$article[11]."<br>";
      echo "<img src='".$article[13]."'><br><br>";
      echo "<form action='../model/add_caddy.php?id=".$data[1]."' method='POST'><button>Add to the caddy</button></form>";

      $data_specie ="SELECT * FROM species WHERE id_specie ='".$article[1]."'" ;
      $data_client ="SELECT * FROM users WHERE id_user='".$article[2]."'" ;
  }
  //if ( $day != $date_end && $hour !=  )
?>
