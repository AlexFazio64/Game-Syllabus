<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="google-signin-client_id"
          content="508493289721-mi2g5njrlan5oue6n1h64b2lroc28nu4.apps.googleusercontent.com">
    <title>${genre}</title>
    <link rel="stylesheet" href="../../css/genre.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://apis.google.com/js/platform.js" async defer></script>
    <script src="../../javascript/genreScript.js"></script>
    <script src="../../javascript/utility.js"></script>

    <link href="https://fonts.googleapis.com/icon?family=Material+Icons"
          rel="stylesheet">
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


    <!--<style>
        body {
            background-image: url("/images/background.webp");
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-size: 100% 100%;
        }
    </style>-->
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
    <div class="info-grid">
        <div class="cardGenere">
            <img src="../../images/genreIcon.png" alt="" class="logoGenere">
            <div class="containerino">
                <h1>${genre}</h1>
            </div>
        </div>
    </div>
    <div class="lista-giochi" id="list">
        <h1> Games list</h1>
        <div id="col0" class="column"></div>
        <div id="col1" class="column"></div>
        <div class="card" id="card">
        </div>
    </div>
</main>

<div class="buttonShow">
    <a href="#bottom" id="showButton" class="showMore">Show more</a>
    <span onclick="window.location.href='#top'" id="backTop" class="material-icons backTop">
            arrow_circle_up
        </span>
</div>
<footer>
    <p>Site made for <strong>Software Engineering and Web Computing exams</strong>.</p>
    <p>Used public database: <a href="https://www.igdb.com/discover">IGDB</a></p>
</footer>
<script src="../../javascript/Vibrant.min.js"></script>
<script defer type="text/javascript">
    genreInfo("${genre}");
</script>
</body>
</html>