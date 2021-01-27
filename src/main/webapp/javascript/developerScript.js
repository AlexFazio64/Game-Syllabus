async function searchInfo(developer) {
    $.ajax({
        url: "https://game-syllabus-proxy.group64.workers.dev/?https://api.igdb.com/v4/involved_companies",
        type: "POST",
        crossDomain: true,
        headers: {
            'Accept': 'application/json',
            "Client-ID": "hz61ow2zgltsan4v3gza0l3aex4euk",
            "Authorization": "Bearer vnshkav90zd6ngdjrjnw3zsiqa3kml"
        },

        data: 'fields id, company.name, company.logo.image_id, company.websites.url, company.country, company.start_date, company.developed, game; limit 1; where developer=true & company.name= "' + developer + '";',
        dataType: "json",
        success: async function (result) {
            document.getElementById("name").innerHTML = result[0].company.name;

            /*Controllo per la data*/
            if (result[0].company.country == undefined) {
                document.getElementById("date").innerText = ("Date not available");
            } else {
                var d = new Date(result[0].company.start_date * 1000);
                document.getElementById("date").innerHTML = d.toLocaleDateString();
            }

            var img = document.createElement('img');

            /*Controllo per l'immagine*/
            if (result[0].company.logo == undefined) {
                img.src = "../../images/notFound.png";

            } else {
                img.src = "https://images.igdb.com/igdb/image/upload/t_logo_med/" + result[0].company.logo.image_id + ".png";
            }

            document.getElementById("logo-developer").appendChild(img);

            /*Controllo per il sito web*/
            if (result[0].company.websites == undefined) {
                document.getElementById("website").innerText = ("Website not available");
            } else {
                var link = document.createElement('a');
                link.setAttribute("class", "material-icons");
                link.innerHTML = "language";

                link.href = result[0].company.websites[0].url;
                document.getElementById("website").appendChild(link);
            }

            /*Controllo per la nazione*/
            if (result[0].company.country == undefined) {
                document.getElementById("contryCode").innerText = ("Country not available");
            } else {
                document.getElementById("contryCode").innerText = await searchCountry(result[0].company.country);
            }



            if(result[0].company.developed != null){
                searchGame(JSON.stringify(result[0].company.developed).replace(/[\[\]]/g, ""));
            }

            if(result[0].game != null && result[0].company.developed == null)
            searchGame(result[0].game);
        },
        error: function (xhr, status, error) {
            alert(status);
        }
    });
}

async function searchCountry(country) {

    var x = await $.ajax({
        url: "https://restcountries.eu/rest/v2/all?fields=numericCode;name",
        type: "GET",
        crossDomain: true
    });

    function searchValue(value) {
        return value.numericCode == country;
    }

    return x.filter(searchValue)[0].name;

}

function searchGame(stringa) {
    $.ajax({
        url: "https://game-syllabus-proxy.group64.workers.dev/?https://api.igdb.com/v4/games",
        type: "POST",
        crossDomain: true,
        headers: {
            'Accept': 'application/json',
            "Client-ID": "hz61ow2zgltsan4v3gza0l3aex4euk",
            "Authorization": "Bearer vnshkav90zd6ngdjrjnw3zsiqa3kml"
        },

        data: "fields id, name, platforms.name, release_dates.human, cover.url, involved_companies.company.name, involved_companies.developer, category; limit 300; where id = (" + stringa + ");",
        dataType: "json",
        success: function (newresult) {
            $(".loader")[0].remove();
            document.getElementById("showButton").onclick = showMore;
            var tempLimit = 0;
            var limitBeforeChange = 0;

            function showMore() {
                if (tempLimit + 20 < newresult.length) {
                    limitBeforeChange = tempLimit;
                    tempLimit += 20;
                    loadContent();
                } else {
                    limitBeforeChange = tempLimit;
                    tempLimit = newresult.length;
                    loadContent()
                }
                if (tempLimit === newresult.length)
                    document.getElementById("showButton").style.display = "none";
            }

            showMore();
            function loadContent() {
                for (var i = limitBeforeChange; i < tempLimit; i++) {
                    var card = document.createElement('figure');
                    card.className = "cardInside";
                    var image = document.createElement('img');
                    if (!('cover' in newresult[i]) == 0) {
                        image.src = newresult[i].cover.url;
                    } else {
                        image.src = "../../images/missing.png";
                    }

                    var info = document.createElement('div');
                    var lista = document.createElement('ul');
                    lista.className = "elencoLista";
                    var developer = document.createElement('li');
                    var date = document.createElement('li');
                    var platform = document.createElement('li');
                    var name = document.createElement('li');
                    name.className = "title_game";

                    if (!('name' in newresult[i]) == 0) {
                        name.innerHTML = newresult[i].name;
                    } else {
                        name.innerHTML = "Name not available";
                    }

                    var devFlag = true;
                    var developer_counter = 0;

                    /*Inserimento Sviluppatore*/
                    if (newresult[i].involved_companies != undefined) {
                        for (var j = 0; j < newresult[i].involved_companies.length && j < 2; j++) {
                            if (newresult[i].involved_companies[j].developer == true) {
                                devFlag = false;
                                developer_counter++;
                                var dev_link = document.createElement('a');
                                dev_link.append(newresult[i].involved_companies[j].company.name + " ");
                                dev_link.href = "http://localhost:8080/developer?name=" + newresult[i].involved_companies[j].company.name;
                                developer.appendChild(dev_link);
                            }
                        }

                        if (developer_counter > 2)
                            developer.innerHTML = developer.innerHTML.concat("...");
                    }

                    if (newresult[i].involved_companies == undefined || devFlag) {
                        developer.innerHTML = "Developer not available";
                    }

                    /*Inserimento Piattaforme*/
                    if (newresult[i].platforms != undefined) {
                        var platforms_string = "";
                        for (var j = 0; j < newresult[i].platforms.length && j < 2; j++) {
                            if (j != 0) platform.append(", ");
                            var platform_link = document.createElement('a');
                            platform_link.innerHTML = platforms_string.concat(newresult[i].platforms[j].name);
                            platform_link.href = "http://localhost:8080/platform?name=" + newresult[i].platforms[j].name;


                            platform.appendChild(platform_link);
                        }

                        if (newresult[i].platforms.length > 2)
                            platform.innerHTML = platform.innerHTML.concat("...");

                    } else {
                        platform.innerHTML = "platform not available";
                    }


                    if (!('release_dates' in newresult[i]) == 0) {
                        date.innerHTML = newresult[i].release_dates[0].human;
                    } else {
                        date.innerHTML = "Date not available";
                    }

                    card.appendChild(image);
                    lista.appendChild(name);
                    lista.appendChild(developer);
                    lista.appendChild(date);
                    lista.appendChild(platform);
                    info.appendChild(lista);
                    card.appendChild(info);

                    var link = document.createElement('a');
                    link.href = "http://localhost:8080/game?id=" + newresult[i].id;
                    link.innerHTML = "More";
                    card.appendChild(link);
                    document.getElementById("col" + i % 2).appendChild(card);
                }
            }

            if (tempLimit === newresult.length)
                document.getElementById("showButton").style.display = "none";
            else
                document.getElementById("showButton").style.display = "flex";
        },
        error: function (xhr, status, error) {
            alert(status);
        }
    });
}
