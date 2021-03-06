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
        data: 'fields name,platforms.name, release_dates.human, websites.url,websites.category, summary, screenshots.image_id, videos.video_id, genres.name,game_modes.name,dlcs.name,dlcs.id,involved_companies.company.name,involved_companies.developer; where id=' + game + ';',
        dataType: "json",
        success: function (result) {
            var content = JSON.stringify(result);
            content = content.replace("[", "");
            content = content.substring(0, content.lastIndexOf("]"));
            txt = JSON.parse(content);
            document.getElementById("game-name").innerText = txt.name;
            if (!(("summary" in txt) == 0))
                document.getElementById("summary").innerText = txt.summary;
            else {
                var summaryLabel = document.getElementById('summary-section');
                summaryLabel.parentNode.removeChild(summaryLabel);
                var summary = document.getElementById("summary");
                summary.parentNode.removeChild(summary);
            }
            if (!(("platforms" in txt) == 0)) {
                for (var i = 0; i < txt.platforms.length; i++) {
                    var platform = document.createElement('a');
                    platform.innerText = txt.platforms[i].name;
                    platform.className = "info";
                    platform.href = "http://localhost:8080/platform?name=" + encode(txt.platforms[i].name);
                    document.getElementById("console").appendChild(platform);
                }
            }
            if (!(("game_modes" in txt) == 0)) {
                if (txt.game_modes.length > 0) {
                    for (var i = 0; i < txt.game_modes.length; i++) {
                        var newType = document.createElement('span');
                        newType.innerHTML = txt.game_modes[i].name;
                        newType.className = "info";
                        document.getElementById("gameplay-type").append(newType);
                    }
                }
            }
            if (!(("release_dates" in txt) == 0)) {
                if (txt.release_dates.length > 0) {
                    var datesEntered = [];
                    for (var i = 0; i < txt.release_dates.length; i++) {
                        if (!datesEntered.includes(txt.release_dates[i].human)) {
                            datesEntered.push(txt.release_dates[i].human);
                            var newSpan = document.createElement('span');
                            newSpan.className = "info";
                            newSpan.innerHTML = txt.release_dates[i].human;
                            document.getElementById("release_date").append(newSpan);
                        }
                    }
                }
            }
            if (!(("genres" in txt) == 0)) {
                if (txt.genres.length > 0) {
                    for (var i = 0; i < txt.genres.length; i++) {
                        var link = document.createElement('a');
                        link.href = "http://localhost:8080/genre?genreName=" + encode(txt.genres[i].name);
                        link.className = "info";
                        var genre = document.createElement('span');
                        genre.innerHTML = txt.genres[i].name;
                        link.appendChild(genre);
                        document.getElementById("gameGenres").append(link);
                    }
                }
            }
            if (!(("websites" in txt) == 0)) {
                if (txt.websites.length > 0) {
                    var type = ["Official", "Wikia", "Wikipedia", "Facebook", "Twitter", "Twitch", " ", "Instagram", "Youtube", "Iphone", "Ipad", "Android", "Steam", "Reddit", "Itch", "Epicgames", "Gog", "Discord"];
                    for (var i = 0; i < txt.websites.length; i++) {
                        var newLink = document.createElement('a');
                        newLink.href = txt.websites[i].url;
                        newLink.text = type[txt.websites[i].category - 1];
                        newLink.className = "info";
                        document.getElementById("websites").append(newLink);
                    }
                }
            }
            if (!(("involved_companies" in txt) == 0)) {
                if (txt.involved_companies.length > 0) {
                    for (var i = 0; i < txt.involved_companies.length; i++) {
                        if (txt.involved_companies[i].developer == true) {
                            var developer = document.createElement('span');
                            var link = document.createElement('a');
                            link.className = "info";
                            link.href = "http://localhost:8080/developer?name=" + txt.involved_companies[i].company.name;
                            developer.innerHTML = txt.involved_companies[i].company.name;
                            link.appendChild(developer);
                            document.getElementById("Developer").append(link);
                        }
                    }
                }
            }

            if (!(("dlcs" in txt) == 0)) {
                if (txt.dlcs.length > 0) {
                    for (var i = 0; i < txt.dlcs.length; i++) {
                        var dlc = document.createElement('a');
                        dlc.innerText = txt.dlcs[i].name;
                        dlc.className = "info";
                        dlc.href = "http://localhost:8080/game?idGame=" + txt.dlcs[i].id;
                        document.getElementById("dlc").append(dlc);
                    }
                }
            }

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
                    if (results.length > 0) {
                        var datas = JSON.stringify(results).replace("[", "");
                        datas = datas.substring(0, datas.lastIndexOf("]"))
                        var cover = JSON.parse(datas);
                        var image = document.getElementById("cover");
                        image.src = "https://images.igdb.com/igdb/image/upload/t_cover_big/" + cover.image_id + ".jpg";
                        var bkg = document.getElementById("main");
                        bkg.setAttribute("style", "background-image: url(https://images.igdb.com/igdb/image/upload/t_cover_big/" + cover.image_id + ".jpg)");
                        bkg.style.backgroundImage = "https://images.igdb.com/igdb/image/upload/t_cover_big/" + cover.image_id + ".jpg";
                    }
                },
                error: function (xhr, status, error) {
                    console.log("error on cover and background loading");
                }
            });

            if (!(("screenshots" in txt) == 0)) {
                if (txt.screenshots.length > 0) {
                    for (var i = 0; i < txt.screenshots.length; i++) {
                        var newImg = document.createElement('img');
                        newImg.className = "screenshot-image";
                        newImg.src = "https://images.igdb.com/igdb/image/upload/t_original/" + txt.screenshots[i].image_id + ".jpg";
                        document.getElementById("screenshots").appendChild(newImg);
                    }
                }
            } else {
                var screenshotsLabel = document.getElementById('screenshots-section');
                screenshotsLabel.parentNode.removeChild(screenshotsLabel);
                var screenContainer = document.getElementById('screenshots');
                screenContainer.parentNode.removeChild(screenContainer);
            }
            if (!(("videos" in txt) == 0)) {
                if (txt.videos.length > 0) {
                    for (var i = 0; i < txt.videos.length; i++) {
                        var container = document.createElement('span');
                        container.className = "video-player";
                        var newPlayer = document.createElement('iframe');
                        newPlayer.width = 640;
                        newPlayer.height = 385;
                        newPlayer.frameBorder = "0";
                        newPlayer.allowFullscreen = true;
                        newPlayer.allow = "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture";
                        newPlayer.src = "https://www.youtube.com/embed/" + txt.videos[i].video_id;
                        container.appendChild(newPlayer);
                        document.getElementById("videos").appendChild(container);
                    }
                }
            } else {
                var videosLabel = document.getElementById('videos-section');
                videosLabel.parentNode.removeChild(videosLabel);
                var videoContainer = document.getElementById('videos');
                videoContainer.parentNode.removeChild(videoContainer);
            }

        },
        error: function (xhr, status, error) {
            alert(status);
        }

    })
    ;
}

function encode(url) {
    var codedUrl = url;
    codedUrl = codedUrl.replaceAll("&", "%26");
    codedUrl = codedUrl.replaceAll("$", "%24");
    codedUrl = codedUrl.replaceAll("+", "%2B");
    codedUrl = codedUrl.replaceAll(",", "%2C");
    codedUrl = codedUrl.replaceAll("/", "%2F");
    codedUrl = codedUrl.replaceAll(";", "3A");
    codedUrl = codedUrl.replaceAll("=", "%3D");
    codedUrl = codedUrl.replaceAll("?", "%3F");
    codedUrl = codedUrl.replaceAll("@", "%40");
    return codedUrl;
}

function sendReview(review, email, game) {
    if (review == 0 && email == 0) {
        swal("Error!", "You must be logged to send a review,log into your account and try again", "warning");
    } else if (document.getElementById('quantity').value <= 0 || document.getElementById('quantity').value > 10)
        swal("Error!", "Check your rating and try again", "warning");
    else if (document.getElementById('reviewText').value == 0)
        swal("Error!", "You must write a review before confirm the operation", "warning");
    else {
        window.location.href = "http://localhost:8080/Review?id=" + game + "&rating=" + parseInt(document.getElementById('quantity').value) + "&text=" + document.getElementById('reviewText').value;
    }
}

function loadGameRate(gameRate) {
    if (gameRate == 0)
        for (var i = 0; i < 10; ++i) {
            var star = document.createElement('span');
            star.className = "fa fa-star";
            document.getElementById("game-rate").appendChild(star);
        }
    else {
        for (var i = 0; i < parseInt(gameRate); i++) {
            var checkedStar = document.createElement('span');
            checkedStar.className = "fa fa-star checked";
            document.getElementById("game-rate").appendChild(checkedStar);
        }
        for (var i = 0; i < 10 - parseInt(gameRate); i++) {
            var star = document.createElement('span');
            star.className = "fa fa-star";
            document.getElementById("game-rate").appendChild(star);
        }
    }
}

function addToList(email, idGame) {
    if (email == 0) {
        swal("Error!", "You must be logged to add the game to your list. Log into your account and try again", "warning");
    } else {

        window.location.href = "http://localhost:8080/addTo?id=" + idGame;
    }
}
