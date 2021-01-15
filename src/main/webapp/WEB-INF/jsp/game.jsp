<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>${game}</title>
    <link rel="stylesheet" href="css/gameStyle.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script type="text/javascript" src="/js/igdbQuery.js">
        var txt;
    </script>
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
<script defer>
    $.ajax({
        url: "https://game-syllabus-proxy.group64.workers.dev/?https://api.igdb.com/v4/games",
        type: "POST",
        crossDomain: true,
        headers: {
            'Accept': 'application/json',
            "Client-ID": "hz61ow2zgltsan4v3gza0l3aex4euk",
            "Authorization": "Bearer vnshkav90zd6ngdjrjnw3zsiqa3kml"
        },
        data: 'fields name, release_dates, websites, summary, screenshots, videos, age_ratings,genres,game_modes,dlcs; where category = 0 ;search "${game}"; limit 1;',
        dataType: "json",
        success: function (result) {
            var content = JSON.stringify(result).replaceAll("'", " ");
            content = content.replace("[", "");
            content = content.substring(0, content.lastIndexOf("]"));
            console.log(content);

            txt = JSON.parse(content);
            document.getElementById("summary").innerHTML = txt.summary;
            $.ajax({
                url: "https://game-syllabus-proxy.group64.workers.dev/?https://api.igdb.com/v4/covers",
                type: "POST",
                crossDomain: true,
                headers: {
                    'Accept': 'application/json',
                    "Client-ID": "yjev1wy79vlnwcv35gbdcvz91tg47u",
                    "Authorization": "Bearer b6tr4i9lufeysqmxcvkclmirl4b8zj"
                },
                data: "fields image_id;where game= " + txt.id + ";",
                dataType: "json",
                success: function (results) {
                    var datas = JSON.stringify(results).replace("[", "");
                    datas = datas.substring(0, datas.lastIndexOf("]"))
                    var cover = JSON.parse(datas);
                    var image = document.getElementById("cover");
                    image.src = "https://images.igdb.com/igdb/image/upload/t_cover_big/" + cover.image_id + ".jpg";
                },
                error: function (xhr, status, error) {
                    alert(status);
                }
            });
        },
        error: function (xhr, status, error) {
            alert(status);
        }
    })
    ;
</script>
<main id="main">
    <div id="all-info">
        <img id="cover"
             src="https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png">
        <ul id="basicInformation">
            <li><span><strong>Name </strong> ${game}</span></li>
            <li><span id="release_date" onclick="loadReleaseDate()"><strong>Release Date</strong></span></li>
            <li><span id="gameGenres" onclick="loadGenres()"><strong>Genres</strong></span></li>
            <li id="Developer" onclick="loadDeveloper()"><strong>Developers</strong> </li>
            <li><span id="websites" onclick="loadWebsites()"><strong>Websites</strong></span></li>
            <li><span id="gameplay-type" onclick="loadGameplayType()"><strong>Gameplay Type</strong> </span></li>
            <li><span id="dlc" onclick="loadDLCName()"><strong>DLCs: </strong></span></li>
            <li><span id="summary"></span></li>
        </ul>
    </div>

    <h3 class="Arguments" onclick="loadVideos()">Video</h3>
    <div id="videos"></div>

    <h3 class="Arguments" onclick="loadScreenshots()">Screenshot</h3>
    <div id="screenshots"></div>

    <div>

        <h3 class="Arguments">Reviews</h3>
        <div class="container">
            <span>write your review</span>
            <span class="fa fa-star checked"></span>
            <span class="fa fa-star checked"></span>
            <span class="fa fa-star checked"></span>
            <span class="fa fa-star"></span>
            <span class="fa fa-star"></span>
            <textarea onkeyup="textAreaAdjust(this)" cols="60" style="resize: none" id="reviewText"></textarea>
            <button onclick="sendReview()">Invia</button>
        </div>
        <div id="review-container">
            <div class="container darker">
                <span>Scrivi la tua recensione</span>
                <span class="fa fa-star checked"></span>
                <span class="fa fa-star checked"></span>
                <span class="fa fa-star checked"></span>
                <span class="fa fa-star"></span>
                <div class="fa fa-star"></div>
                <p>Hey! I'm fine. Thanks for asking!</p>
            </div>

            <div class="container">
                <span>Scrivi la tua recensione</span>
                <span class="fa fa-star checked"></span>
                <span class="fa fa-star checked"></span>
                <span class="fa fa-star checked"></span>
                <span class="fa fa-star"></span>
                <span class="fa fa-star"></span>
                <p>Sweet! So, what do you wanna do today?</p>
            </div>

            <div class="container darker">
                <span>Scrivi la tua recensione</span>
                <span class="fa fa-star checked"></span>
                <span class="fa fa-star checked"></span>
                <span class="fa fa-star checked"></span>
                <span class="fa fa-star"></span>
                <span class="fa fa-star"></span>
                <p>Nah, I dunno. Play soccer.. or learn more coding perhaps?</p>
            </div>
        </div>
    </div>
</main>
<footer>
    <p>Site made for <strong>Software Engineering and Web Computing exams</strong>.</p>
    <p>Used public database: <a href="https://www.igdb.com/discover">IGDB</a></p>
</footer>
</body>

</html>