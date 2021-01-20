<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>${game}</title>
    <link rel="stylesheet" href="css/gameStyle.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script type="text/javascript" src="../../javascript/gameScript.js"></script>
    <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"
          integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>


<div id="nav-placeholder">
</div>
<script>
    $(function () {
        $("#nav-placeholder").load("navbar.html");
    });
</script>

<script>
    function textAreaAdjust(element) {
        element.style.height = "1px";
        element.style.height = (25 + element.scrollHeight) + "px";
    }
</script>
<script>
    function sendReview() {
        console.log(document.getElementById("reviewText").value);
    }
</script>
<main id="main">
    <div id="bkg" class="bkgcolor" style="background-image:url('../../images/devLogoNotFound.webp') "></div>
    <div id="all-info" style="opacity: 1">
        <img id="cover"
             src="https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png">
        <ul id="basicInformation">
            <li><span class="gameName">${game} </span></li>
            <li><span id="release_date" onclick="loadReleaseDate()"><strong>Release Date: </strong></span></li>
            <li><span id="gameplay-type" onclick="loadGameplayType()"><strong>Gameplay Type: </strong> </span></li>
            <li><span id="console"><strong>Available for:</strong></span></li>
            <li><span id="gameGenres" onclick="loadGenres()"><strong>Genres: </strong></span></li>
            <li id="Developer" onclick="loadDeveloper()"><strong>Developers: </strong></li>
            <li><span id="websites" onclick="loadWebsites()"><strong>Websites: </strong></span></li>
            <li><span id="dlc" onclick="loadDLCName()"><strong>DLCs: </strong></span></li>

        </ul>
    </div>
    <section class="other-info">
        <p id="summary"></p>
        <h3 class="Arguments" onclick="loadVideos()">Video</h3>
        <div id="videos"></div>

        <h3 class="Arguments" onclick="loadScreenshots()">Screenshot</h3>
        <div id="screenshots"></div>

        <div>

            <h3 class="Arguments">Reviews</h3>
            <div class="review">
                <section>
                    <span>Write your review</span>
                    <span class="fa fa-star checked"></span>
                    <span class="fa fa-star checked"></span>
                    <span class="fa fa-star checked"></span>
                    <span class="fa fa-star"></span>
                    <span class="fa fa-star"></span>
                </section>
                <section>
                    <textarea onkeyup="textAreaAdjust(this)" cols="40" style="resize: none" id="reviewText"></textarea>
                    <button onclick="sendReview()">Invia</button>
                </section>
            </div>
            <div id="review-container">
                <div class="review">
                    <span></span>
                    <span class="fa fa-star checked"></span>
                    <span class="fa fa-star checked"></span>
                    <span class="fa fa-star checked"></span>
                    <span class="fa fa-star"></span>
                    <span class="fa fa-star"></span>
                    <p>Sweet! So, what do you wanna do today?</p>
                </div>
                <div class="review">
                    <span></span>
                    <span class="fa fa-star checked"></span>
                    <span class="fa fa-star checked"></span>
                    <span class="fa fa-star checked"></span>
                    <span class="fa fa-star"></span>
                    <span class="fa fa-star"></span>
                    <p>Sweet! So, what do you wanna do today?</p>
                </div>
                <div class="review">
                    <span></span>
                    <span class="fa fa-star checked"></span>
                    <span class="fa fa-star checked"></span>
                    <span class="fa fa-star checked"></span>
                    <span class="fa fa-star"></span>
                    <span class="fa fa-star"></span>
                    <p>Sweet! So, what do you wanna do today?</p>
                </div>
                <div class="review">
                    <span></span>
                    <span class="fa fa-star checked"></span>
                    <span class="fa fa-star checked"></span>
                    <span class="fa fa-star checked"></span>
                    <span class="fa fa-star"></span>
                    <span class="fa fa-star"></span>
                    <p>Sweet! So, what do you wanna do today?</p>
                </div>
            </div>
        </div>
    </section>
    <footer>
        <p>Site made for <strong>Software Engineering and Web Computing exams</strong>.</p>
        <p>Used public database: <a href="https://www.igdb.com/discover">IGDB</a></p>
    </footer>
</main>
<script type="text/javascript" defer>
    loadGameBasicInfo("${game}");
</script>

</body>

</html>