<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Game</title>
    <link rel="stylesheet" href="css/gameStyle.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script type="text/javascript" src="/js/igdbQuery.js">
        var gameName =${game};
        var gameid;
    </script>

</head>


<div id="nav-placeholder" >
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
        url: "https://cors-anywhere.herokuapp.com/https://api.igdb.com/v4/games",
        type: "POST",
        crossDomain: true,
        headers: {
            'Accept': 'application/json',
            "Client-ID": "hz61ow2zgltsan4v3gza0l3aex4euk",
            "Authorization": "Bearer vnshkav90zd6ngdjrjnw3zsiqa3kml"
        },
        data: 'fields name, release_dates, websites, summary, screenshots, videos, age_ratings; where category = 0 ;search "${game}"; limit 1;',
        dataType: "json",
        success: function (result) {
            var content = JSON.stringify(result).replaceAll("'", " ");
            content = content.replace("[", "");
            content = content.substring(0, content.lastIndexOf("]"));
            console.log(content);

            var txt = JSON.parse(content);
            gameid = txt.id;
            console.log(gameid);
            document.getElementById("summary").innerHTML = txt.summary;
            $.ajax({
                url: "https://cors-anywhere.herokuapp.com/https://api.igdb.com/v4/covers",
                type: "POST",
                crossDomain: true,
                headers: {
                    'Accept': 'application/json',
                    "Client-ID": "yjev1wy79vlnwcv35gbdcvz91tg47u",
                    "Authorization": "Bearer b6tr4i9lufeysqmxcvkclmirl4b8zj"
                },
                data: "fields url,width,height;where game= " + gameid + ";",
                dataType: "json",
                success: function (results) {
                    var datas = JSON.stringify(results);
                    console.log("cover: \n" + datas);
                    var cover = JSON.parse(datas);
                    var image = document.createElement('img');
                    image.className = 'item';
                    image.style.height = cover.height;
                    image.style.width = cover.width;
                    image.style.src = cover.url;

                    var parent = document.getElementById("basicInformation").parentElement;
                    var nextElement = document.getElementById("basicInformation");
                    parent.insertBefore(image, nextElement);
                    console.log(document.getElementById("cover"));
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
    <div class="info">

        <ul id="basicInformation">
            <li><span>Name </span><span>${game}</span></li>
            <li id="release_date" onclick="loadReleaseDate(gameid)">Release Date </li>
            <li>generi</li>
            <li>sviluppatore</li>
            <li><span id="websites" onclick="loadWebsites(gameid)">Websites</span></li>
            <li><span id="gameplay-type">Gameplay Type: </span></li>
            <li><span id="dlc-availability">DLCs: </span></li>
            <li><span>Summary: </span><span id="summary"></span></li>
        </ul>
    </div>

    <h3 class="Arguments" onclick="loadVideos(gameid)">Video</h3>
    <div id="videos"></div>
    <div>
        <h3 class="Arguments" onclick="loadScreenshots(gameid)">Screenshot</h3>
        <div id="screenshots"></div>
    </div>

</main>

</body>

</html>