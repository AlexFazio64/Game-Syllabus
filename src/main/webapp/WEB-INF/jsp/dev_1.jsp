<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<main id="daniele" class="content-bg">
	<div class="content">
		<div class="personalInfo">
			<div class="profilePic">
				<img class="sourceImg" src="../../images/aboutPage/lovaion/lovaionAvatar.jpg" alt="Eren Jaeger">
			</div>
			<div class="textInfo">
				<div class="nome">
					<h3>Daniele Avolio</h3>
				</div>
				<div class="description">
					<p>Hello. My name is Daniele Avolio and right now I'm a student at Universita' della Calabria. I'm
						getting a computer science degree and this is my third year</p>
					<p>My passions are:</p>
					<ul>
						<li>Game development 🎮</li>
						<li>Guitar 🎸</li>
						<li>Anime and Mangas 🈳</li>
						<li>Video Editing 📹</li>
					</ul>
				</div>
			</div>
		</div>
		<div class="things">
			<div class="games">
				<h3>Favourites <span>games</span></h3>
				<div class="myGames cardsCont">
					<div class="cardInside">
						<div class="bgImg">
							<img class="sourceCard" src="../../images/aboutPage/lovaion/LOL.jpg" id="lol" alt="">
						</div>
						<div class="name">
							<h3>League of Legends</h3>
						</div>
					</div>
					<div class="cardInside">
						<div class="bgImg">
							<img class="sourceCard" src="../../images/aboutPage/lovaion/ds3.jpg" id="ds3" alt="">
						</div>
						<div class="name">
							<h3>Dark Souls 3</h3>
						</div>
					</div>
					<div class="cardInside">
						<div class="bgImg">
							<img class="sourceCard" src="../../images/aboutPage/lovaion/csgo.jpg" id="cs" alt="">
						</div>
						<div class="name">
							<h3>Counter Strike: GO</h3>
						</div>
					</div>
				</div>
			</div>
			
			<h3>Favourites <span>Manga and Anime</span></h3>
			<div class="mangaAndAnime cardsCont">
				<div class="cardInside">
					<div class="bgImg">
						<img class="sourceCard" src="../../images/aboutPage/lovaion/aot.jpg" id="aot" alt="">
					</div>
					<div class="name">
						<h3>Attack On Titan</h3>
					</div>
				</div>
				<div class="cardInside">
					<div class="bgImg">
						<img class="sourceCard" src="../../images/aboutPage/lovaion/berserk.png" id="berserk" alt="">
					
					</div>
					<div class="name">
						<h3>Berserk</h3>
					</div>
				</div>
				<div class="cardInside">
					<div class="bgImg">
						<img class="sourceCard" src="../../images/aboutPage/lovaion/jojo.jpg" id="jojo" alt="">
					</div>
					<div class="name">
						<h3>JoJo</h3>
					</div>
				</div>
			</div>
			<div class="socials">
				<div class="social">
					<img src="../../images/aboutPage/lovaion/twitter.png" alt="Twitter" id="twitter" class="socialIcon">
				</div>
				<div class="social">
					<img src="../../images/aboutPage/lovaion/instagram.png" alt="Instagram" id="instagram" class="socialIcon">
				</div>
				<div class="social">
					<img src="../../images/aboutPage/lovaion/github.png" alt="Instagram" id="github" class="socialIcon">
				</div>
			</div>
		</div>
	</div>
</main>
<script>
	
	/*VISITA SOCIAL*/
	function visitaTwitter() {
		window.location.href = "https://twitter.com/avolio_daniele";
	}
	
	function visitaInstagram() {
		window.location.href = "https://www.instagram.com/oh_dagne/";
		
	}
	
	function visitaGit() {
		window.location.href = "https://github.com/lovaion/lovaion";
	}
	
	/*VISITA COSE*/
	
	function visitaBerserk() {
		window.location.href = "https://it.wikipedia.org/wiki/Berserk_(manga)";
	}
	
	function visitaAot() {
		window.location.href = "https://it.wikipedia.org/wiki/L%27attacco_dei_giganti";
	}
	
	function visitaJojo() {
		window.location.href = "https://it.wikipedia.org/wiki/Le_bizzarre_avventure_di_JoJo";
	}
	
	function visitaLoL() {
		window.location.href = "https://euw.leagueoflegends.com/en-gb/";
	}
	
	function visitaCS() {
		window.location.href = "https://blog.counter-strike.net/";
	}
	
	function visitaDS3() {
		window.location.href = "https://it.bandainamcoent.eu/dark-souls/dark-souls-iii";
	}
	
	document.getElementById("twitter").setAttribute("onclick", "visitaTwitter()");
	document.getElementById("instagram").setAttribute("onclick", "visitaInstagram()");
	document.getElementById("github").setAttribute("onclick", "visitaGit()");
	document.getElementById("aot").setAttribute("onclick", "visitaAot()");
	document.getElementById("jojo").setAttribute("onclick", "visitaJojo()");
	document.getElementById("berserk").setAttribute("onclick", "visitaBerserk()");
	document.getElementById("cs").setAttribute("onclick", "visitaCS()");
	document.getElementById("ds3").setAttribute("onclick", "visitaDS3()");
	document.getElementById("lol").setAttribute("onclick", "visitaLoL()");
</script>

<script>
	window.location.href = "#daniele";
</script>
