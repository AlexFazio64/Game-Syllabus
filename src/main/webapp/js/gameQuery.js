function loadGameBasicInfo(game) {
    $.ajax({
        url: "https://game-syllabus-proxy.group64.workers.dev/?https://api.igdb.com/v4/games",
        type: "POST",
        crossDomain: true,
        headers: {
            'Accept': 'application/json',
            "Client-ID": "hz61ow2zgltsan4v3gza0l3aex4euk",
            "Authorization": "Bearer vnshkav90zd6ngdjrjnw3zsiqa3kml"
        },
        data: 'fields name,platforms.name, release_dates, websites, summary, screenshots, videos, age_ratings,genres,game_modes,dlcs; search "' + game + '"; limit 1;',
        dataType: "json",
        success: function (result) {

            var content = JSON.stringify(result).replaceAll("'", " ");
            content = content.replace("[", "");
            content = content.substring(0, content.lastIndexOf("]"));
            txt = JSON.parse(content);
            console.log(txt.platforms);
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
                data: "fields image_id;where game= " + window.txt.id + ";",
                dataType: "json",
                success: function (results) {
                    var datas = JSON.stringify(results).replace("[", "");
                    datas = datas.substring(0, datas.lastIndexOf("]"))
                    var cover = JSON.parse(datas);
                    var image = document.getElementById("cover");
                    image.src = "https://images.igdb.com/igdb/image/upload/t_cover_big/" + cover.image_id + ".jpg";
                    var bkg = document.getElementById("bkg");
                    bkg.setAttribute("style", "background-image: url(https://images.igdb.com/igdb/image/upload/t_cover_big/" + cover.image_id + ".jpg)");
                    bkg.style.backgroundImage = "https://images.igdb.com/igdb/image/upload/t_cover_big/" + cover.image_id + ".jpg";

                },
                error: function (xhr, status, error) {
                    console.log("error on cover and background loading");
                }
            });
            for (var i = 0; i < txt.platforms.length; i++) {
                var platform = document.createElement('a');
                platform.innerText = txt.platforms[i].name;
                platform.className = "info";
                document.getElementById("console").appendChild(platform);
            }
        },
        error: function (xhr, status, error) {
            alert(status);
        }

    })
    ;
}

function loadScreenshots() {
    if (document.getElementById("screenshots").getElementsByClassName("screenshot-image").length == 0) {
        $.ajax({
            url: "https://game-syllabus-proxy.group64.workers.dev/?https://api.igdb.com/v4/screenshots",
            type: "POST",
            crossDomain: true,
            headers: {
                'Accept': 'application/json',
                "Client-ID": "h78bpc6nx4cn1tct87c0w9wc6jknv7",
                "Authorization": "Bearer vlng3tiiqsmjhc5spoog9544193m62"
            },
            data: 'fields image_id,url,height,width;where game= ' + txt.id + ';',
            dataType: "json",
            success: function (results) {
                var datas = JSON.stringify(results);
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
                alert("merda");
            }
        });
    } else console.log("Screenshots already loaded");
}

function loadVideos() {
    if (document.getElementById("videos").getElementsByClassName("video-player").length == 0) {
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
                var videos = [];
                videos = JSON.parse(datas);
                if (videos.length > 0) {
                    for (var i = 0; i < videos.length; i++) {
                        var newPlayer = document.createElement('iframe');
                        newPlayer.className = "video-player";
                        newPlayer.width = 560;
                        newPlayer.height = 345;
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
    } else console.log("Videos already loaded");
}

function loadWebsites() {
    if (document.getElementById("websites").getElementsByClassName("info").length == 0) {

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
                var websites = [];
                var type = ["Official", "Wikia", "Wikipedia", "Facebook", "Twitter", "Twitch", "Instagram", "Youtube", "Iphone", "Ipad", "Android", "Steam", "Reddit", "Itch", "Epicgames", "Gog", "Discord"];
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
    } else console.log("Websites already loaded");
}

function loadReleaseDate() {

    if (document.getElementById("release_date").getElementsByClassName("info").length == 0) {
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
                var d = [];
                d = JSON.parse(dates);
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
    } else console.log("Release dates already loaded");
}

function loadGenres() {
    if (document.getElementById("gameGenres").getElementsByClassName("info").length == 0) {

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
                var d = [];
                d = JSON.parse(datas);

                if (d.length > 0) {
                    for (var i = 0; i < d.length; i++) {
                        var newGenre = document.createElement('span');
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
    } else console.log("Genres already loaded");
}

function loadDeveloper() {
    if (document.getElementById("Developer").getElementsByClassName("info").length == 0) {
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
                var companies = [];
                companies = JSON.parse(datas);
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
    } else console.log("Developers already loaded");
}

function loadGameplayType() {
    if (document.getElementById("gameplay-type").getElementsByClassName("info").length == 0) {
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
                var gameplayType = [];
                gameplayType = JSON.parse(datas);
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
    } else console.log("Gameplay type already loaded");
}

function loadDLCName() {
    if (document.getElementById("dlc").getElementsByClassName("info").length == 0 && !("dlcs" in txt) == 0) {
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
                var game = [];
                game = JSON.parse(datas);
                if (game.length > 0) {
                    for (var i = 0; i < game.length; i++) {
                        var dlc = document.createElement('a');
                        dlc.innerHTML = game[i].name;
                        dlc.className = "info";
                        var dlcLink = document.createElement('a');
                        dlcLink.href = "http://localhost:8080/game?name=" + game[i].name;
                        dlcLink.appendChild(dlc);
                        document.getElementById("dlc").append(dlcLink);
                    }
                }
            },
            error: function (xhr, status, error) {
                alert(status);
            }
        });
    } else console.log("Dlcs already loaded");
}

