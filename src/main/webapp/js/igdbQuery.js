

function loadGameBasicInfo() {

    gameName=document.getElementById("gameName").textContent;
    console.log(gameName);
    $.ajax({
        url: "https://cors-anywhere.herokuapp.com/https://api.igdb.com/v4/games",
        type: "POST",
        crossDomain: true,
        headers: {
            'Accept': 'application/json',
            "Client-ID": "h78bpc6nx4cn1tct87c0w9wc6jknv7",
            "Authorization": "Bearer vlng3tiiqsmjhc5spoog9544193m62"
        },
        data: "fields name, release_dates, websites, summary, screenshots, videos, age_ratings; where category = 0 ;search "+gameName+"; limit 1;",
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

            document.getElementById("name").innerHTML = gameName;
            document.getElementById("summary").innerHTML = txt.summary;
            gameid = txt.id;
            console.log("ok");
        },
        error: function (xhr, status, error) {
            alert(status);
        }
    });
}

function loadScreenshots(gameId) {
    $.ajax({
        url: "https://cors-anywhere.herokuapp.com/https://api.igdb.com/v4/screenshots",
        type: "POST",
        crossDomain: true,
        headers: {
            'Accept': 'application/json',
            "Client-ID": "h78bpc6nx4cn1tct87c0w9wc6jknv7",
            "Authorization": "Bearer vlng3tiiqsmjhc5spoog9544193m62"
        },
        data: "fields url,height,width;where game= " + gameId + ";",
        dataType: "json",
        success: function (results) {
            var datas = JSON.stringify(results);
            console.log("image: \n" + datas);
            var screeshots = [];
            screeshots = JSON.parse(datas);
            if (screeshots.length > 0) {

                for (var i = 0; i < screeshots.length; i++) {
                    var newImg = document.createElement('img');
                    newImg.className = 'item';
                    newImg.height=screeshots.height;
                    newImg.width=screeshots.width;
                    newImg.src = screeshots[i].url;
                    document.getElementById("screenshots").append(newImg);

                }
            }
        },
        error: function (xhr, status, error) {
            alert(status);
        }
    });
}

function loadVideos(gameId) {
    $.ajax({
        url: "https://cors-anywhere.herokuapp.com/https://api.igdb.com/v4/game_videos",
        type: "POST",
        crossDomain: true,
        headers: {
            'Accept': 'application/json',
            "Client-ID": "h78bpc6nx4cn1tct87c0w9wc6jknv7",
            "Authorization": "Bearer vlng3tiiqsmjhc5spoog9544193m62"
        },
        data: "fields video_id;where game=" + gameId + ";",
        dataType: "json",
        success: function (results) {
            var datas = JSON.stringify(results);
            console.log("video: \n" + datas);
            var videos = [];
            videos = JSON.parse(datas);
            if (videos.length > 0) {
                for (var i = 0; i < videos.length; i++) {
                    var newPlayer = document.createElement('iframe');
                    newPlayer.width = 480;
                    newPlayer.height = 270;
                    newPlayer.frameBorder = "0";
                    newPlayer.allow = "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                    newPlayer.src = "https://www.youtube.com/embed/" + videos[i].video_id;
                    document.getElementById("videos").append(newPlayer);

                }
            }
        },
        error: function (xhr, status, error) {
            alert(status);
        }
    });
}

function loadWebsites(gameId) {
    $.ajax({
        url: "https://cors-anywhere.herokuapp.com/https://api.igdb.com/v4/websites",
        type: "POST",
        crossDomain: true,
        headers: {
            'Accept': 'application/json',
            "Client-ID": "h78bpc6nx4cn1tct87c0w9wc6jknv7",
            "Authorization": "Bearer vlng3tiiqsmjhc5spoog9544193m62"
        },
        data: "fields url,category;where game= " + gameId + "; sort category asc; limit 18;",
        dataType: "json",
        success: function (results) {
            var datas = JSON.stringify(results);
            console.log("web: \n" + datas);
            var websites = [];
            var type = ["official", "wikia", "wikipedia", "facebook", "twitter", "twitch", "instagram", "youtube", "iphone", "ipad", "android", "steam", "reddit", "itch", "epicgames", "gog", "discord"];
            websites = JSON.parse(datas);
            if (websites.length > 0) {
                document.getElementById("websites").textContent = "Websites";
                for (var i = 0; i < websites.length; i++) {
                    var newLink = document.createElement('a');
                    newLink.href = websites[i].url;
                    newLink.text = type[i];
                    document.getElementById("websites").append(newLink);

                }
            }
        },
        error: function (xhr, status, error) {
            alert(status);
        }
    });
}

function loadReleaseDate(gameId) {
    $.ajax({
        url: "https://cors-anywhere.herokuapp.com/https://api.igdb.com/v4/release_dates",
        type: "POST",
        crossDomain: true,
        headers: {
            'Accept': 'application/json',
            "Client-ID": "h78bpc6nx4cn1tct87c0w9wc6jknv7",
            "Authorization": "Bearer vlng3tiiqsmjhc5spoog9544193m62"
        },
        data: "fields date; where game = " + gameId + "; ",
        dataType: "json",
        success: function (results) {
            var dates = JSON.stringify(results);
            console.log(dates);
            var d = [];
            d = JSON.parse(dates);
            console.log(d);
            var regionDate = [];
            for (var i = 0; i < d.length; i++) {
                var c = new Date((d[i].date * 1000));
                regionDate.push(c.toLocaleDateString().substring(c.toLocaleString(), c.toLocaleString().indexOf(",")));
            }
            if (regionDate.length > 0) {
                document.getElementById("release_date").textContent = "Release Dates: ";
                var datesEntered = [];
                for (var i = 0; i < regionDate.length; i++) {
                    if (!datesEntered.includes(regionDate[i])) {
                        datesEntered.push(regionDate[i]);
                        var newSpan = document.createElement('span');
                        newSpan.className = 'item';
                        newSpan.innerHTML = regionDate[i];
                        document.getElementById("release_date").append(newSpan);
                    }
                }
            }
        },
        error: function (xhr, status, error) {
            alert(status);
        }
    });
}