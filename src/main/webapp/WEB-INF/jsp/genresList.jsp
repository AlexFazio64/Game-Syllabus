<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Genres</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../../css/genresList.css">
	<link rel="stylesheet" href="../../css/common.css">
	<script src="../../javascript/genresListScript.js"></script>
</head>
<body>
<div id="nav-placeholder">
</div>
<script>
	$(function () {
		$("#nav-placeholder").load("http://localhost:8080/getNavbar");
	});
</script>

<main class="container">
	<div class="listaGeneri">
		<h1>Genres list</h1>
	</div>
	<div class="loader place"></div>
	<div class="containerGeneri" id="contGens">
		<div id="col0" class="column"></div>
		<div id="col1" class="column"></div>
		<div id="col2" class="column"></div>
		<div id="col3" class="column"></div>
	</div>
</main>
<script src="../../javascript/Vibrant.min.js"></script>
<script defer type="text/javascript">
	listaGeneri();
	function getColors(img) {
		var vibrant = new Vibrant(img, 128, 1);
		var swatches = vibrant.swatches();
		var a = [];
		
		for (const s in swatches) {
			if (!swatches[s])
				continue;
			a.push(swatches[s]);
		}
		a.sort((c1, c2)=>{return c1.population - c2.population;});
		return a;
	}
	
</script>
</body>
</html>