async function searchPlatform(platform) {
    $.ajax({
        url: "https://game-syllabus-proxy.group64.workers.dev/?https://api.igdb.com/v4/platforms",
        type: "POST",
        crossDomain: true,
        headers: {
            'Accept': 'application/json',
            "Client-ID": "hz61ow2zgltsan4v3gza0l3aex4euk",
            "Authorization": "Bearer vnshkav90zd6ngdjrjnw3zsiqa3kml"
        },

        data: 'fields id,  name, alternative_name, abbreviation, generation, websites.url, summary, platform_logo.image_id, versions.id, versions.name, versions.summary, versions.platform_logo.image_id, versions.platform_version_release_dates.human ; limit 1; where versions.name = "' + platform + '" | name= "' + platform + '" | abbreviation = "' + platform + '" | alternative_name= "' + platform + '";',
        dataType: "json",
        success: async function (result) {

            var img = document.createElement('img');
            var link = document.createElement('a');

            for (var i = 0; i < result[0].versions.length; i++) {
                if ((platform == result[0].versions[i].name) || (platform == result[0].abbreviation) || (platform == result[0].name)) {

                    /*Inserimento nome*/
                    document.getElementById("name").innerHTML = result[0].versions[i].name + addName(result[0].versions[i].name);

                    /*Inserimento Logo*/
                    if (result[0].versions[i].platform_logo != undefined) {
                        img.src = "https://images.igdb.com/igdb/image/upload/t_logo_med/" + result[0].versions[i].platform_logo.image_id + ".png";

                    } else {
                        img.src = img.src = "../../images/notFound.png";
                    }

                    /*Inserimento descrizione*/
                    if (result[0].versions[i].summary != undefined) {
                        document.getElementById("description").innerHTML = result[0].versions[i].summary;

                    } else {
                        document.getElementById("description").innerText = ("Description not available");
                    }

                    /*Inserimento date*/
                    if (result[0].versions[i].platform_version_release_dates[0].human != undefined) {
                        document.getElementById("date").innerHTML = result[0].versions[i].platform_version_release_dates[0].human;
                    } else {
                        document.getElementById("date").innerText = ("Date not available");
                    }

                    /*Inserimento Generazione (comune)*/
                    if (result[0].generation != undefined) {
                        document.getElementById("generation").innerText = result[0].generation + " generation"
                    } else {
                        document.getElementById("generation").innerText = ("Generation not available");
                    }


                    /*Inserimento Sito (comune)*/
                    if (result[0].websites != undefined) {
                        link.setAttribute("class", "material-icons");
                        link.innerHTML = "language";
                        link.href = result[0].websites[0].url;
                    } else {
                        document.getElementById("website").innerText = ("Website not available");
                    }

                    break;
                }
            }

            document.getElementById("logo-platform").appendChild(img);
            document.getElementById("website").appendChild(link);


            if (result[0].name != undefined)
                searchGame(result[0].name);

        },
        error: function (xhr, status, error) {
            alert(status);
        }
    });

    /*Specifica il nome della piattaforma nel caso in cui il nome fosse vago*/
    function addName(x) {
        if (x != platform) {
            return " (" + platform + ")";
        } else
            return "";
    }
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

        data: 'fields name, platforms.name, release_dates.human, cover.url, involved_companies.company.name, involved_companies.developer, platforms.id, category; limit 300; where platforms.name = "' + stringa + '";',
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

