<?php
?>
<!DOCTYPE html>
<html>
<head>
	<title>product details</title>
</head>
<body>
	<?php

		echo "<form action='../controller/home_controller.php'><button>back</button></form>";

		echo "<form action='../controller/caddy_controller.php'><button>caddy</button></form>";


		echo "<br><table border=1px>
		<tr><td>image</td><td>".$data[0]."</td></tr>
		<tr><td>".$data[1]."$ </td><td>Stock :".$data[2]."</td></tr>
		<tr><td>Age :".$data[8]."</td><td>".$data[4]."</td></tr>
		<tr><td>Weight :".$data[5]."</td><td>Color :".$data[7]."</td></tr>
		<tr><td>Vendor :".$data[9]." ".$data[10]."</tr></td>
		</table>";

		echo "<form action='../model/add_caddy.php?id=".$_GET["id"]."' method='POST'><button>Add to caddy</button></form>"; 
	?>

</body>
</html>
