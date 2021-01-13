<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Game</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/gameStyle.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script type="text/javascript" src="/js/igdbQuery.js">
        var gameName =${game};
        var gameid;
    </script>

</head>


<div id="nav-placeholder" class="nav">
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
<main id="main">
    <div class="info">
        <span id="cover"></span>
        <ul id="basicInformation">
            <li><span>Name </span><span>${game}</span></li>
            <li id="release_date" onclick="loadReleaseDate(gameid)">Release Date</li>
            <li>valutazione</li>
            <li>generi</li>
            <li>sviluppatore</li>
            <li><span id="websites" onclick="loadWebsites(gameid)">Websites</span></li>
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
<script>
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
            var fields = ["id", "age_ratings", "name", "release_dates", "screenshots", "summary", "videos", "websites"];
            var availableField = [];
            fields.forEach(function (item, index, array) {
                if (content.includes(item))
                    availableField.push(item);
            });
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
                    var newImg = document.createElement('img');
                    newImg.className = 'item';
                    newImg.height = cover.height;
                    newImg.width = cover.width;
                    newImg.src = cover.url;
                    document.getElementById("cover").append(newImg);
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
</body>

</html>