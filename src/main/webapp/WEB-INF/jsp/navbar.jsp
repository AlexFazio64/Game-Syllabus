<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- css loading && GOOGLE meta injection -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
    // carica il css della pagina
    $('<link>').appendTo('head').attr({
        type: 'text/css',
        rel: 'stylesheet',
        href: 'http://localhost:8080/css/navbar.css'
    });
    $('<link>').appendTo('head').attr({
        type: 'text/css',
        rel: 'stylesheet',
        href: 'http://localhost:8080/css/common.css'
    });

    <c:if test="${usernameLogged==null}">
    $('<meta>').appendTo('head').attr({
        name: "google-signin-client_id",
        content: "508493289721-mi2g5njrlan5oue6n1h64b2lroc28nu4.apps.googleusercontent.com"
    });
    </c:if>

    async function requestSuggestion(data) {
        return $.ajax({
            url: "https://game-syllabus-proxy.group64.workers.dev/?https://api.igdb.com/v4/games",
            type: "POST",
            crossDomain: true,
            dataType: "json",
            headers: {
                "Client-ID": "eof600pvnu4zmfzrgf1mmmgwhugt72",
                "Authorization": "Bearer dwg48lh6ge8576eju90dh266jbp40n"
            },
            data: 'fields name, platforms.name, cover.image_id; search "$"; limit 4;'.replace("$", data)
        });
    }

    //ragionare sulle dimensioni-max delle parti
    async function showQueryResults() {
        if (suggestion()) {
            const arr = await requestSuggestion($(".search-box")[0].value);
            arr.forEach(a => {
                let cover;
                let platform;
                try {
                    cover = "https://images.igdb.com/igdb/image/upload/t_cover_small/$.jpg".replace("$", a.cover.image_id);
                    platform = a.platforms[0].name;
                } catch (e) {
                    console.log("missing non-critical data...");
                    platform = "no data..."
                }
                const name = a.name;

                const img = $("<div>").css("background", 'url(' + cover + ') center / contain no-repeat');
                img.css("width", '90px');
                img.css("height", '120px');
                const n = $("<p>").html(name);
                const p = $("<p>").html(platform);
                var $res = $("<span>").addClass("result-item");

                $res.append(img);
                $res.append(n);
                $res.append(p);
                var $link = $("<a>");
                $link.attr("href", "http://localhost:8080/game?id=" + a.id);
                $link.append($res);
                $(".dropdown-content").append($link);
            });
        }
    }

    function goToSearch() {
        window.location.href = "http://localhost:8080/search?name=" + $("#nav-search")[0].value;
    }

    function empty() {
        $("span.dropdown-content").empty();
    }

    //visualizza o nasconde i risultati suggeriti
    function suggestion() {
        const $x = $(".dropdown-content");
        $x.html("");
        const len = $(".search-box")[0].value.length;
        if (len >= 4) {
            $x.css("display", "flex");
            return true;
        } else {
            $x.css("display", "none");
            return false;
        }
    }

    function hamburgerMenu() {
        $(".hamburger-menu").toggleClass("visible");
    }
</script>

<c:if test="${usernameLogged==null}">
	<!-- GOOGLE -->
	<!-- forse non serve il primo?? -->
	<script src="https://apis.google.com/js/platform.js" async defer></script>
	<script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
	
	<!-- FACEBOOK -->
	<script>
        window.fbAsyncInit = function () {
            FB.init({
                appId: '{904598133610405}',
                cookie: true,
                xfbml: true,
                version: '{v9.0}'
            });
            FB.AppEvents.logPageView();
        };

        (function (d, s, id) {
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id)) {
                return;
            }
            js = d.createElement(s);
            js.id = id;
            js.src = "https://connect.facebook.net/en_US/sdk.js";
            fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));
	</script>
	<script async defer crossorigin="anonymous"
	        src="https://connect.facebook.net/it_IT/sdk.js#xfbml=1&version=v9.0&appId=904598133610405&autoLogAppEvents=1"
	        nonce="e8iPCl2W"></script>
	<div id="fb-root"></div>
</c:if>

<!-- NAVBAR -->
<nav>
	<ul class="nav">
		<li class="search">
			<!-- Esportare in 50x50 per ottimizzare -->
			<a class="logo" href="http://localhost:8080/"><img src="http://localhost:8080/images/logo.png" width="50"
			                                                   height="50" alt="logo"></a>
			<div class="dropdown">
				<input class="search-box" type="search" placeholder="Search..." id="nav-search" onemptied="empty()"
				       onsearch="showQueryResults()">
				<span class="dropdown-content"></span>
				<span class="icon" onclick="goToSearch()"><i class="material-icons">search</i></span>
			</div>
			<span class="icon hamburger" onclick="hamburgerMenu()"><i class="material-icons">menu</i></span>
			<span class="hamburger-menu">
				<a href="http://localhost:8080/comingSoon?start=0">Upcoming</a>
				<a href="http://localhost:8080/developers?start=0">Developers</a>
				<a href="http://localhost:8080/about_us.html">About Us</a>
				<a href="http://localhost:8080/platforms?start=0">Platforms</a>
				<a href="http://localhost:8080/genres">Genres</a>
				<c:if test="${usernameLogged != null}">
					<a class="item" href="http://localhost:8080/account/${usernameLogged}">${usernameLogged}</a>
					<a class="item" href="http://localhost:8080/doLogout">Logout</a>
				</c:if>
                <c:if test="${usernameLogged == null}">
	                <a class="register" href="http://localhost:8080/regPage">Register</a>
	                <a href="#" class="login" id="myBtn2" data-toggle="modal" data-target="#myModal">Login</a>
                </c:if>
			</span>
		</li>
		
		<li class="item">
			<a href="http://localhost:8080/comingSoon?start=0">Upcoming</a>
			<a href="http://localhost:8080/developers?start=0">Developers</a>
			<a href="http://localhost:8080/about_us.html">About Us</a>
			<a href="http://localhost:8080/platforms?start=0">Platforms</a>
			<a href="http://localhost:8080/genres">Genres</a>
		</li>
		
		<!-- usare showAccountInfo(true|false) -->
		<li class="item account">
			<c:if test="${usernameLogged != null}">
				<a class="item" href="http://localhost:8080/account/${usernameLogged}">
					<span class="profile-pic material-icons">account_circle</span> <!-- Cerchio?? -->
					<span class="profile-name">${usernameLogged}</span> <!-- Lunghezza massima?? -->
				</a>
				<a class="item" href="http://localhost:8080/doLogout"><i class="material-icons">exit_to_app</i></a>
			
			</c:if>
			<c:if test="${usernameLogged == null}">
				<a class="register" href="http://localhost:8080/regPage">Register</a>
				<a class="login" id="myBtn" href="#" data-toggle="modal" data-target="#myModal">Login</a>
			</c:if>
		
		</li>
	</ul>
</nav>

<!-- MODAL FORM -->
<c:if test="${usernameLogged  == null}">
	<div id="myModal" class="modal">
		<!-- Modal content -->
		<div class="modal-content">
			<div class="modal-header">
				<span class="close" onclick="modal.style.display='none';">&times;</span>
				<h1>Login</h1>
			</div>
			<div class="modal-body">
				<form method="post" action="http://localhost:8080/doLogin">
					<p class="campo">Email</p>
					<input type="email" placeholder="Insert your email.." name="email" id="email">
					<p class="campo">Password</p>
					<input type="password" placeholder="Insert your password.." name="password" id="password">
					<input type="hidden" name="googleLogin" id="google">
					<div class="loginButtons">
						<div class="fb-login-button" data-width="" data-size="medium" data-button-type="login_with"
						     data-layout="default" data-auto-logout-link="false" data-use-continue-as="false"></div>
						<div id="my-signin2"></div>
						<script>
                            function onSuccess(googleUser) {
                                console.log('Logged in as: ' + googleUser.getBasicProfile().getName());
                                var profile = googleUser.getBasicProfile();
                                document.getElementById("email").setAttribute("value", profile.getEmail());
                                document.getElementById("password").setAttribute("value", profile.getId());
                                document.getElementById("google").setAttribute("value", "yes");
                                document.getElementById("submitButton").click();
                            }

                            function onFailure(error) {
                                console.log(error);
                            }


                            function renderButton() {
                                gapi.signin2.render('my-signin2', {
                                    'scope': 'profile email',
                                    'width': 173,
                                    'height': 28,
                                    'longtitle': true,
                                    'theme': 'dark',
                                    'onsuccess': onSuccess,
                                    'onfailure': onFailure
                                });
                            }
						
						</script>
							<%--Logout on reload--%>
						<script>
                            window.onbeforeunload = function (e) {
                                gapi.auth2.getAuthInstance().signOut();
                            };

                            function signOut() {
                                var auth2 = gapi.auth2.getAuthInstance();
                                auth2.signOut().then(function () {
                                    console.log('User signed out.');
                                });
                            }
						</script>
					</div>
					<input type="submit" value="Login" class="modalLogin" id="submitButton">
				</form>
			</div>
		</div>
	</div>
	<script defer>
        // Get the button that opens the modal
        var btn = document.getElementById("myBtn");
        var btn2 = document.getElementById("myBtn2");

        // When the user clicks the button, open the modal
        btn.onclick = function () {
            modal.style.display = "block";
        }
        btn2.onclick = function () {
            modal.style.display = "block";
        }
        // Get the modal
        var modal = document.getElementById("myModal");

        // Get the <span> element that closes the modal
        var span = document.getElementsByClassName("close")[0];


        // When the user clicks on <span> (x), close the modal
        span.onclick = function () {
            modal.style.display = "none";
        }

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
	</script>
</c:if>