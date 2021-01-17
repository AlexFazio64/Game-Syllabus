function loadGameBasicInfo() {

    gameName = document.getElementById("gameName").textContent;
    console.log(gameName);
    $.ajax({
        url: "https://game-syllabus-proxy.group64.workers.dev/?https://api.igdb.com/v4/games",
        type: "POST",
        crossDomain: true,
        headers: {
            'Accept': 'application/json',
            "Client-ID": "h78bpc6nx4cn1tct87c0w9wc6jknv7",
            "Authorization": "Bearer vlng3tiiqsmjhc5spoog9544193m62"
        },
        data: "fields name, release_dates, websites, summary, screenshots, videos, age_ratings; where category = 0 ;search " + gameName + "; limit 1;",
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

function loadScreenshots() {
    $.ajax({
        url: "https://game-syllabus-proxy.group64.workers.dev/?https://api.igdb.com/v4/screenshots",
        type: "POST",
        crossDomain: true,
        headers: {
            'Accept': 'application/json',
            "Client-ID": "h78bpc6nx4cn1tct87c0w9wc6jknv7",
            "Authorization": "Bearer vlng3tiiqsmjhc5spoog9544193m62"
        },
        data: "fields image_id,url,height,width;where game= " + txt.id + ";",
        dataType: "json",
        success: function (results) {
            var datas = JSON.stringify(results);
            console.log("image: \n" + datas);
            var screeshots = [];
            screeshots = JSON.parse(datas);
            if (screeshots.length > 0) {
                for (var i = 0; i < screeshots.length; i++) {
                    var newImg = document.createElement('img');
                    newImg.className = "screenshot-image";
                    newImg.src = "https://images.igdb.com/igdb/image/upload/t_original/" + screeshots[i].image_id + ".jpg";
                    document.getElementById("screenshots").appendChild(newImg);

                }
            }
        },
        error: function (xhr, status, error) {
            alert(status);
        }
    });
}

function loadVideos() {
    $.ajax({
        url: "https://game-syllabus-proxy.group64.workers.dev/?https://api.igdb.com/v4/game_videos",
        type: "POST",
        crossDomain: true,
        headers: {
            'Accept': 'application/json',
            "Client-ID": "h78bpc6nx4cn1tct87c0w9wc6jknv7",
            "Authorization": "Bearer vlng3tiiqsmjhc5spoog9544193m62"
        },
        data: "fields video_id;where game=" + txt.id + ";",
        dataType: "json",
        success: function (results) {
            var datas = JSON.stringify(results);
            console.log("video: \n" + datas);
            var videos = [];
            videos = JSON.parse(datas);
            if (videos.length > 0) {
                for (var i = 0; i < videos.length; i++) {
                    var newPlayer = document.createElement('iframe');
                    newPlayer.className = "video-player";
                    newPlayer.width = 680;
                    newPlayer.height = 300;
                    newPlayer.frameBorder = "0";
                    newPlayer.allowFullscreen = true;
                    newPlayer.allow = "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture";
                    newPlayer.src = "https://www.youtube.com/embed/" + videos[i].video_id;
                    document.getElementById("videos").appendChild(newPlayer);

                }
            }
        },
        error: function (xhr, status, error) {
            alert(status);
        }
    });
}

function loadWebsites() {
    $.ajax({
        url: "https://game-syllabus-proxy.group64.workers.dev/?https://api.igdb.com/v4/websites",
        type: "POST",
        crossDomain: true,
        headers: {
            'Accept': 'application/json',
            "Client-ID": "h78bpc6nx4cn1tct87c0w9wc6jknv7",
            "Authorization": "Bearer vlng3tiiqsmjhc5spoog9544193m62"
        },
        data: "fields url,category;where game= " + txt.id + "; sort category asc; limit 18;",
        dataType: "json",
        success: function (results) {
            var datas = JSON.stringify(results);
            console.log("web: \n" + datas);
            var websites = [];
            var type = ["official", "wikia", "wikipedia", "facebook", "twitter", "twitch", "instagram", "youtube", "iphone", "ipad", "android", "steam", "reddit", "itch", "epicgames", "gog", "discord"];
            websites = JSON.parse(datas);
            if (websites.length > 0) {
                for (var i = 0; i < websites.length; i++) {
                    var newLink = document.createElement('a');
                    newLink.href = websites[i].url;
                    newLink.text = type[i];
                    newLink.className = "info";
                    document.getElementById("websites").append(newLink);

                }
            }
        },
        error: function (xhr, status, error) {
            alert(status);
        }
    });
}

function loadReleaseDate() {
    $.ajax({
        url: "https://game-syllabus-proxy.group64.workers.dev/?https://api.igdb.com/v4/release_dates",
        type: "POST",
        crossDomain: true,
        headers: {
            'Accept': 'application/json',
            "Client-ID": "h78bpc6nx4cn1tct87c0w9wc6jknv7",
            "Authorization": "Bearer vlng3tiiqsmjhc5spoog9544193m62"
        },
        data: "fields date; where game = " + txt.id + "; ",
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
                var datesEntered = [];
                for (var i = 0; i < regionDate.length; i++) {
                    if (!datesEntered.includes(regionDate[i])) {
                        datesEntered.push(regionDate[i]);
                        var newSpan = document.createElement('span');
                        newSpan.className = "info";
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

function loadGenres() {
    $.ajax({
        url: "https://game-syllabus-proxy.group64.workers.dev/?https://api.igdb.com/v4/genres",
        type: "POST",
        crossDomain: true,
        headers: {
            'Accept': 'application/json',
            "Client-ID": "h78bpc6nx4cn1tct87c0w9wc6jknv7",
            "Authorization": "Bearer vlng3tiiqsmjhc5spoog9544193m62"
        },
        data: "fields name; where id = (" + txt.genres + "); ",
        dataType: "json",
        success: function (results) {
            var datas = JSON.stringify(results);
            console.log(datas);
            var d = [];
            d = JSON.parse(datas);
            console.log(d);

            if (d.length > 0) {
                for (var i = 0; i < d.length; i++) {
                    var newGenre = document.createElement('span');
                    console.log(d[i].name);
                    newGenre.innerHTML = d[i].name;
                    newGenre.className = "info";

                    document.getElementById("gameGenres").append(newGenre);

                }
            }
        },
        error: function (xhr, status, error) {
            alert(status);
        }
    });
}

function loadDeveloper() {
    $.ajax({
        url: "https://game-syllabus-proxy.group64.workers.dev/?https://api.igdb.com/v4/companies",
        type: "POST",
        crossDomain: true,
        headers: {
            'Accept': 'application/json',
            "Client-ID": "h78bpc6nx4cn1tct87c0w9wc6jknv7",
            "Authorization": "Bearer vlng3tiiqsmjhc5spoog9544193m62"
        },
        data: "fields name; where developed = [ " + txt.id + "]; ",
        dataType: "json",
        success: function (results) {
            var datas = JSON.stringify(results);
            console.log(datas);
            var companies = [];
            companies = JSON.parse(datas);
            console.log(companies);

            if (companies.length > 0) {
                for (var i = 0; i < companies.length; i++) {
                    var newComp = document.createElement('span');

                    newComp.innerHTML = companies[i].name;
                    newComp.className = "info";
                    document.getElementById("Developer").append(newComp);

                }
            }
        },
        error: function (xhr, status, error) {
            alert(status);
        }
    });
}

function loadGameplayType() {
    $.ajax({
        url: "https://game-syllabus-proxy.group64.workers.dev/?https://api.igdb.com/v4/game_modes",
        type: "POST",
        crossDomain: true,
        headers: {
            'Accept': 'application/json',
            "Client-ID": "h78bpc6nx4cn1tct87c0w9wc6jknv7",
            "Authorization": "Bearer vlng3tiiqsmjhc5spoog9544193m62"
        },
        data: "fields name; where id = ( " + txt.game_modes + "); ",
        dataType: "json",
        success: function (results) {
            var datas = JSON.stringify(results);
            console.log(datas);
            var gameplayType = [];
            gameplayType = JSON.parse(datas);
            console.log(gameplayType);

            if (gameplayType.length > 0) {
                for (var i = 0; i < gameplayType.length; i++) {
                    var newType = document.createElement('span');

                    newType.innerHTML = gameplayType[i].name;
                    newType.className = "info";
                    document.getElementById("gameplay-type").append(newType);

                }
            }
        },
        error: function (xhr, status, error) {
            alert(status);
        }
    });
}

function loadDLCName() {
    $.ajax({
        url: "https://game-syllabus-proxy.group64.workers.dev/?https://api.igdb.com/v4/games",
        type: "POST",
        crossDomain: true,
        headers: {
            'Accept': 'application/json',
            "Client-ID": "h78bpc6nx4cn1tct87c0w9wc6jknv7",
            "Authorization": "Bearer vlng3tiiqsmjhc5spoog9544193m62"
        },
        data: "fields name; where id = ( " + txt.dlcs + "); ",
        dataType: "json",
        success: function (results) {
            var datas = JSON.stringify(results);
            console.log(datas);
            var game = [];
            game = JSON.parse(datas);
            console.log(game);

            if (game.length > 0) {
                for (var i = 0; i < game.length; i++) {
                    var newDlc = document.createElement('span');

                    newDlc.innerHTML = game[i].name;
                    newDlc.className = "info";
                    document.getElementById("dlc").append(newDlc);

                }
            }
        },
        error: function (xhr, status, error) {
            alert(status);
        }
    });
}

