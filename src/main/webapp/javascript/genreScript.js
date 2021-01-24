
function genreInfo(genere) {
    $.ajax({

        url: "https://game-syllabus-proxy.group64.workers.dev/?https://api.igdb.com/v4/games",
        type: "POST",
        crossDomain: true,
        headers: {
            'Accept': 'application/json',
            "Client-ID": "yjev1wy79vlnwcv35gbdcvz91tg47u",
            "Authorization": "Bearer b6tr4i9lufeysqmxcvkclmirl4b8zj"
        },
        data: 'fields name, platforms.name, release_dates.human, cover.url, status; limit 300; where genres.name="' + genere + '" & release_dates.date < 1614556800 ;sort first_release_date desc;',
        dataType: "json",
        success: function (result) {
            $(".loader")[0].remove();
            var content = JSON.stringify(result).replaceAll("'", " ");
            //content = content.replace("[", "");
            //content = content.substring(0, content.lastIndexOf("]"));
            var txt = [];
            txt = JSON.parse(content);
            document.getElementById("showButton").onclick = showMore;
            var tempLimit = 0;
            var limitBeforeChange = 0;
            function showMore() {
                if (tempLimit + 50 < txt.length) {
                    limitBeforeChange = tempLimit;
                    tempLimit += 50;
                    loadContent();
                } else {
                    limitBeforeChange = tempLimit;
                    tempLimit = txt.length;
                    loadContent()
                }
                if (tempLimit === txt.length)
                    document.getElementById("showButton").style.display = "none";
            }
            showMore();
            function loadContent() {
                for (var i = limitBeforeChange; i < tempLimit; i++) {
                    var card = document.createElement('div');
                    card.className = "cardInside";
                    var image = document.createElement('img');
                    if (!('cover' in txt[i]) == 0) {
                        image.src = txt[i].cover.url;
                    } else {
                        image.src = "../../images/missing.png"
                    }
                    var info = document.createElement('div');
                    var lista = document.createElement('ul');
                    lista.className = "elencoLista";
                    var date = document.createElement('li');
                    var platform = document.createElement('li');
                    var name = document.createElement('li');
                    if (!('name' in txt[i]) == 0) {
                        name.innerHTML = txt[i].name;
                    } else {
                        name.innerHTML = "Missing name.."
                    }
                    var listaConsole = "";
                    if (!('platforms' in txt[i]) == 0) {
                        for (var j = 0; j < txt[i].platforms.length && j < 2; j++) {
                            var collegamento = document.createElement('a');
                            collegamento.innerHTML = listaConsole.concat(txt[i].platforms[j].name);
                            collegamento.href = "http://localhost:8080/platform?name="+txt[i].platforms[j].name;
                            platform.appendChild(collegamento);
                            if (j == 0 && txt[i].platforms.length > 1) {
                                collegamento.innerHTML = collegamento.innerHTML.concat(", ");
                            }
                        }
                        if (txt[i].platforms.length > 2)
                            platform.innerHTML = platform.innerHTML.concat("...");
                    } else {
                        platform.innerHTML = "Missing platforms.."
                    }
                    if (!('release_dates' in txt[i]) == 0) {
                        date.innerHTML = txt[i].release_dates[0].human;
                    } else {
                        date.innerHTML = "Missing dates.."
                    }

                    card.appendChild(image);
                    lista.appendChild(name);
                    lista.appendChild(date);
                    lista.appendChild(platform);
                    info.appendChild(lista);
                    card.appendChild(info);
                    var link = document.createElement('a');
                    link.href = "http://localhost:8080/game?id=" + txt[i].id;
                    link.innerHTML = "More";
                    card.appendChild(link);
                    document.getElementById("col" + i % 2).appendChild(card);
                }
            }
            if (tempLimit === txt.length)
                document.getElementById("showButton").style.display = "none";
            else
                document.getElementById("showButton").style.display = "flex";

            document.getElementById("backTop").style.display = "inline-block";
        },
        error: function (xhr, status, error) {
            alert(status);
        }
    });
}

