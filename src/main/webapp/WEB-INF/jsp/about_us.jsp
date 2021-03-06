<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>About Sus</title>
	<link rel="stylesheet" href="../../css/about.css">
	<link rel="stylesheet" href="../../css/lovaion.css">
	<link rel="stylesheet" href="../../css/alex_style.css">
	<link rel="stylesheet" href="../../css/DD97.css">
	<link rel="stylesheet" href="../../css/ArmorOfBerserk.css">
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>
<div id="nav-placeholder"></div>
<script>
    $.ajax({
        url: "http://localhost:8080/getNavbar",
        type: "GET",
        success: function (result) {
            $("#nav-placeholder").append(result);
            sus();
        }
    });

    function sus() {
        $(".item a")[2].innerHTML = "Among Us";
        $(".hamburger-menu a")[2].innerHTML = "Among Us";
    }

    function dev(n) {
        $("#developer-developer-developer").load("dev_" + n);
    }
</script>
<main class="ab">
	<section>
		<section class="devs-devs-devs">
			<audio id="myAudio">
				<source src="http://localhost:8080/images/aboutPage/among.mp3" type="audio/mpeg">
			</audio>
			<div onclick="dev(0)">
				<!--<a href="#developer-developer-developer"><img src="images/aboutPage/dev_0.png" alt="dev0"></a>-->
				<img src="../../images/aboutPage/dev_0.png" alt="dev0">
			</div>
			<div onclick="dev(1)">
				<!--<a href="#developer-developer-developer"><img src="images/aboutPage/dev_1.png" alt="dev1"></a>-->
				<img src="../../images/aboutPage/dev_1.png" alt="dev1">
			</div>
			<div onclick="dev(2)">
				<!--<a href="#developer-developer-developer"><img src="images/aboutPage/dev_2.png" alt="dev2"></a>-->
				<img src="../../images/aboutPage/dev_2.png" alt="dev2">
			</div>
			<div onclick="dev(3)">
				<!--<a href="#developer-developer-developer"><img src="images/aboutPage/dev_3.png" alt="dev3"></a>-->
				<img src="../../images/aboutPage/dev_3.png" alt="dev3">
			</div>
		</section>
		
		<section class="dev-dev-dev-about">
			<div id="developer-developer-developer"></div>
		</section>
	</section>
</main>
<a href="#nav-placeholder" class="material-icons back-to-top">arrow_upward</a>
<script defer>
    function startGame() {
        var about = new Set();
        while (about.size < 4) {
            about.add(Math.round(Math.random() * 100) % 4);
        }
        about = new Array(...about);
        var imgs = $(".devs-devs-devs div img");

        // for (const c of about) {
        // 	imgs[c].title = "crewmate";
        // }
        // imgs[about[3]].title = "impostor";

        var mini = "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⣶⣿⣿⣷⣶⣄⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n" + "⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣾⣿⣿⡿⢿⣿⣿⣿⣿⣿⣿⣿⣷⣦⡀⠀⠀⠀⠀⠀\n" + "⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⡟⠁⣰⣿⣿⣿⡿⠿⠻⠿⣿⣿⣿⣿⣧⠀⠀⠀⠀\n" + "⠀⠀⠀⠀⠀⠀⠀⣾⣿⣿⠏⠀⣴⣿⣿⣿⠉⠀⠀⠀⠀⠀⠈⢻⣿⣿⣇⠀⠀⠀\n" + "⠀⠀⠀⠀⢀⣠⣼⣿⣿⡏⠀⢠⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿⣿⡀⠀⠀\n" + "⠀⠀⠀⣰⣿⣿⣿⣿⣿⡇⠀⢸⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⡇⠀⠀\n" + "⠀⠀⢰⣿⣿⡿⣿⣿⣿⡇⠀⠘⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⢀⣸⣿⣿⣿⠁⠀⠀\n" + "⠀⠀⣿⣿⣿⠁⣿⣿⣿⡇⠀⠀⠻⣿⣿⣿⣷⣶⣶⣶⣶⣶⣿⣿⣿⣿⠃⠀⠀⠀\n" + "⠀⢰⣿⣿⡇⠀⣿⣿⣿⠀⠀⠀⠀⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠁⠀⠀⠀⠀\n" + "⠀⢸⣿⣿⡇⠀⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠉⠛⠛⠛⠉⢉⣿⣿⠀⠀⠀⠀⠀⠀\n" + "⠀⢸⣿⣿⣇⠀⣿⣿⣿⠀⠀⠀⠀⠀⢀⣤⣤⣤⡀⠀⠀⢸⣿⣿⣿⣷⣦⠀⠀⠀\n" + "⠀⠀⢻⣿⣿⣶⣿⣿⣿⠀⠀⠀⠀⠀⠈⠻⣿⣿⣿⣦⡀⠀⠉⠉⠻⣿⣿⡇⠀⠀\n" + "⠀⠀⠀⠛⠿⣿⣿⣿⣿⣷⣤⡀⠀⠀⠀⠀⠈⠹⣿⣿⣇⣀⠀⣠⣾⣿⣿⡇⠀⠀\n" + "⠀⠀⠀⠀⠀⠀⠀⠹⣿⣿⣿⣿⣦⣤⣤⣤⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⠀\n" + "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠻⢿⣿⣿⣿⣿⣿⣿⠿⠋⠉⠛⠋⠉⠉⠁⠀⠀⠀⠀\n" + "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠁⠀⠀⠀⠀⠀⠀";
        imgs[about[3]].onclick = function () {
            $("#myAudio")[0].play();
            console.log(mini);
        }
    }

    startGame();
</script>
</body>
</html>