function loadComingSoon() {
    var today = Math.round(new Date().getTime() / 1000);
    $.ajax({
        url: "https://game-syllabus-proxy.group64.workers.dev/?https://api.igdb.com/v4/games",
        type: "POST",
        crossDomain: true,
        headers: {
            'Accept': 'application/json',
            "Client-ID": "yjev1wy79vlnwcv35gbdcvz91tg47u",
            "Authorization": "Bearer b6tr4i9lufeysqmxcvkclmirl4b8zj"
        },
        data: 'fields name,first_release_date ,platforms.name,cover.url,release_dates.human, status; limit 80   ; ' +
            'where first_release_date > ' + today + ';sort first_release_date asc;',
        dataType: "json",
        success: function (result) {
            for (var k = 0; k < 2; k++) {
                for (var i = parseInt(k * result.length / 2); i < parseInt((result.length / 2)) * (k + 1); i++) {
                    var date = document.createElement('li');
                    var card = document.createElement('div');
                    card.className = "game-card";
                    var image = document.createElement('img');
                    var info = document.createElement('div');
                    var lista = document.createElement('ul');
                    lista.className = "list";
                    var platform = document.createElement('li');
                    var name = document.createElement('li');
                    name.className = "game-title";
                    if (!('name' in result[i]) == 0) {
                        name.innerHTML = result[i].name;
                    } else {
                        name.innerHTML = "Missing name.."
                    }
                    if (!('cover' in result[i]) == 0) {
                        image.src = result[i].cover.url;
                    } else {
                        image.src = "../../images/missing.png"
                    }
                    if (!('first_release_date' in result[i]) == 0) {
                        date.innerHTML = new Date(result[i].first_release_date * 1000).toDateString();
                    } else {
                        date.innerHTML = "Missing dates.."
                    }
                    var listaConsole = "";
                    if (!('platforms' in result[i]) == 0) {
                        for (var j = 0; j < result[i].platforms.length && j < 2; j++) {
                            var collegamento = document.createElement('a');
                            collegamento.innerHTML = listaConsole.concat(result[i].platforms[j].name);
                            collegamento.href = "#";
                            platform.appendChild(collegamento);
                            if (j == 0 && result[i].platforms.length > 1) {
                                collegamento.innerHTML = collegamento.innerHTML.concat(", ");
                            }
                        }
                        if (result[i].platforms.length > 2)
                            platform.innerHTML = platform.innerHTML.concat("...");
                    } else {
                        platform.innerHTML = "Missing platforms.."
                    }
                    card.appendChild(image);
                    lista.appendChild(name);
                    lista.appendChild(date);
                    lista.appendChild(platform);
                    info.appendChild(lista);
                    card.appendChild(info);
                    var link = document.createElement('a');
                    link.href = "http://localhost:8080/game?id=" + result[i].id;
                    link.innerHTML = "More";
                    card.appendChild(link);
                    document.getElementById("col" + i % 2).appendChild(card);
                }
            }
        },
        error: function (xhr, status, error) {
            alert(status);
        }
    });
}

