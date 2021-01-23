<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="google-signin-client_id"
          content="508493289721-mi2g5njrlan5oue6n1h64b2lroc28nu4.apps.googleusercontent.com">

    <title>Sign up</title>
    <link rel="stylesheet" href="../../css/registerStyle.css">
    <link rel="stylesheet" href="../../css/indexStyle.css">

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://apis.google.com/js/platform.js" async defer></script>

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
</head>
<body>
<div id="fb-root"></div>
<script async defer crossorigin="anonymous"
        src="https://connect.facebook.net/it_IT/sdk.js#xfbml=1&version=v9.0&appId=904598133610405&autoLogAppEvents=1"
        nonce="e8iPCl2W"></script>

<%--<div class="back">
    <button onclick="window.location.href='http://localhost:8080/';" class="bottone color-purple">Back</button>
</div>--%>
<!--<div id="nav-placeholder">
</div>


<script>
    $(function () {
        $("#nav-placeholder").load("navbar.html");
    });
</script>
-->
<div class="regBackground" id="bg">
</div>
<div class="divisor">
    <div class="form">
        <div class="container">
            <div class="syllabus" onclick="window.location.href='http://localhost:8080/index'" title="Go back to home-page">
            </div>
            <form method="post" action="http://localhost:8080/register" id="formReg">
                <div class="form-group">
                    <label for="email" id="stringEmail">Email address:</label>
                    <input type="email" required class="form-control" placeholder="Enter your email.." id="email" name="email">
                </div>
                <div class="form-group">
                    <label for="usr" id="stringUsername">Username:</label>
                    <%--SOLAMENTE NUMERI E LETTERE--%>
                    <input type="text" required minlength="5" class="form-control" pattern="[a-zA-Z0-9-]+"  title="Use only numbers and letters" placeholder="Enter a username.." id="usr" name="username">
                </div>
                <div class="form-group">
                    <label for="pwd" id="stringPassword">Password:</label>
                    <input type="password" required minlength="5" class="form-control" placeholder="Enter a password.." id="pwd" name="password">
                </div>
                <div class="divBottone">
                    <button type="submit" class="bottone color-purple" id="submitButton">Submit</button>
                </div>

            </form>
            <div class="oppure" id="oppure">
                <h3>Oppure registrati con:</h3>
            </div>

            <div class="loginButtons" id="loginButtons">
                <div class="fb-login-button" data-width="" data-size="medium" data-button-type="login_with"
                     data-layout="default" data-auto-logout-link="false" data-use-continue-as="false"></div>
                <div id="my-signin2"></div>
                <script>
                    function onSuccess(googleUser) {
                        var profile = googleUser.getBasicProfile();
                        document.getElementById("email").setAttribute("value", profile.getEmail());
                        document.getElementById("pwd").setAttribute("value", profile.getId());
                        document.getElementById("email").setAttribute("type", "hidden");
                        document.getElementById("pwd").setAttribute("type", "hidden");
                        document.getElementById("stringEmail").setAttribute("class", "toHide");
                        document.getElementById("stringPassword").setAttribute("class", "toHide");
                        document.getElementById("loginButtons").setAttribute("class", "toHide");
                        document.getElementById("oppure").setAttribute("class", "toHide");
                    }


                    function onFailure(error) {
                        console.log(error);
                        signOut();
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
                    //NIENTE SPAZI NEI CAMPI HAI CAPITO?
                    $('input').keypress(function( e ) {
                        if(e.which === 32)
                            return false;
                    });
                </script>
            </div>

            <script src="https://apis.google.com/js/platform.js?onload=renderButton" async></script>
            <%--AUTO LOGOUT ON PAGE CHANGE--%>
            <script>
                window.onbeforeunload = function (e) {
                    gapi.auth2.getAuthInstance().signOut();
                };

                function signOut() {
                    var auth2 = gapi.auth2.getAuthInstance();
                    auth2.signOut().then(function () {
                    });
                    document.getElementById("email").setAttribute("type", "email");
                    document.getElementById("pwd").setAttribute("type", "password");
                    document.getElementById("email").setAttribute("value", "");
                    document.getElementById("pwd").setAttribute("value", "");
                }
            </script>
        </div>
    </div>
    <div class="iscritti">
        <div class="containerInfo">
            <p>Iscriviti anche tu, ci sono gia' ${nIscritti} iscritti! </p>
        </div>
    </div>
</div>

<script>
    const gifs = [
        "https://media.giphy.com/media/S9iZRMT7341RZW9paH/source.gif", //deathstranding
        "https://media.giphy.com/media/3o7btQ9ep8sZXmfFra/source.gif", //nier
        "https://media.giphy.com/media/O1DrvejiJbwZLNBpl6/giphy.gif", //lol
        "https://media.giphy.com/media/Do5pJNQNDDAfS/giphy.gif", // mass
        "https://media.giphy.com/media/UvQ2W4OYg3EKahV5Xe/giphy.gif", // ff
        "https://media.giphy.com/media/69JWtI3j8j5miUPs4H/source.gif", //demon soul
        "https://media.giphy.com/media/l49JKCSoloVTGjmWQ/giphy.gif", // ds1
        "https://media.giphy.com/media/h5pMOQA6TyRcgrZ7cn/giphy-downsized-large.gif", // sea of thieves
        "https://media.giphy.com/media/fSpC2w245xoVyCCuVx/giphy.gif", //cynerpunk
        "https://media.giphy.com/media/izyy2cD6xSftxfGQiU/giphy.gif", //sword adn shield
        "https://media.giphy.com/media/AO5qaphTxRnyw/source.gif", //shovelknight
        "https://media.giphy.com/media/Jmn0cHknbudA5iGnrY/source.gif", //
        "https://media.giphy.com/media/fVbewaMFrOoC38gvFZ/source.gif", // castlevaina
        "https://media.giphy.com/media/LpiA8MVudQO8pitF4c/giphy.gif",
        "https://media.giphy.com/media/izyy2cD6xSftxfGQiU/giphy.gif", //unlimmited flat
        "https://media.giphy.com/media/3ohzdKgSnQwjEbkxry/giphy.gif", //unlimited cose
        "https://media.giphy.com/media/LkfPKsQwgNU3ILEOZk/giphy-downsized-large.gif", //fallout
        ];
    const random = Math.floor(Math.random()*gifs.length);
    document.getElementById("bg").style.backgroundImage = "url("+gifs[random]+")";
</script>

</body>
</html>