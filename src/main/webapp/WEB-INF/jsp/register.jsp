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
<button onclick="window.location.href='http://localhost:8080/';" class="bottone color-purple">Back</button>
<!--<div id="nav-placeholder">
</div>


<script>
    $(function () {
        $("#nav-placeholder").load("navbar.html");
    });
</script>
-->

<div class="form">
    <div>
        <div class="syllabus">
        </div>
        <form method="post" action="http://localhost:8080/register">
            <div class="form-group">
                <label for="email">Email address:</label>
                <input type="email" class="form-control" placeholder="Enter email" id="email" name="email">
            </div>
            <div class="form-group">
                <label for="usr">Username:</label>
                <input type="text" class="form-control" placeholder="Enter username" id="usr" name="username">
            </div>
            <div class="form-group">
                <label for="pwd">Password:</label>
                <input type="password" class="form-control" placeholder="Enter password" id="pwd" name="password">
            </div>
            <div class="divBottone">
                <button type="submit" class="bottone color-purple">Submit</button>
            </div>
        </form>
        <div class="oppure">
            <h3>Oppure accedi con:</h3>
        </div>

        <script>
            function signOut() {
                var auth2 = gapi.auth2.getAuthInstance();
                auth2.signOut().then(function () {
                    console.log('User signed out.');
                });
            }
        </script>
        <div class="loginButtons">
            <div class="fb-login-button" data-width="" data-size="medium" data-button-type="login_with"
                 data-layout="default" data-auto-logout-link="false" data-use-continue-as="false"></div>
            <div id="my-signin2"></div>
            <script>

                function onSuccess(googleUser) {
                    console.log('Logged in as: ' + googleUser.getBasicProfile().getName());
                    var profile = googleUser.getBasicProfile();
                    console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
                    console.log('Name: ' + profile.getName());
                    console.log('Image URL: ' + profile.getImageUrl());
                    console.log('Email: ' + profile.getEmail()); // This is null if the 'email' scope is not present.
                    scegliUsername();
                }

                function onFailure(error) {
                    console.log(error);
                }

                function scegliUsername() {
                    window.location.href = 'http://localhost:8080/chooseUsername';

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
        </div>

        <script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>

    </div>
</div>
</body>
</html>