
    function readMore(){
        var el, elp, ps, up, totalHeight;

        jQuery(document).ready(function(){

            jQuery("#box-button").click(function() {

                totalHeight = 0;
                el = jQuery(this);
                elp = el.parent();
                up = elp.prev();
                ps = up.find("p");
                ps.each(function() {
                    totalHeight += jQuery(this).outerHeight();
                });
                up
                    .css({
                        "height": up.height(),
                        "max-height": 9999
                    })
                    .animate({
                        "height": totalHeight
                    });
                // Rimuove il bottone read more

                elp.fadeOut();
                return false;
            });
        });
    }

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

                for( var i = 0; i < result[0].versions.length; i++) {
                    if ( (platform == result[0].versions[i].name) || (platform == result[0].abbreviation) || (platform == result[0].name)  )  {

                        /*Inserimento nome*/
                        document.getElementById("name").innerHTML = result[0].versions[i].name + addName(result[0].versions[i].name);

                        /*Inserimento Logo*/
                        if(result[0].versions[i].platform_logo != undefined){
                            img.src = "https://images.igdb.com/igdb/image/upload/t_logo_med/" + result[0].versions[i].platform_logo.image_id + ".png";

                        } else{
                            img.src = img.src = "../../images/notFound.png";
                        }

                        /*Inserimento descrizione*/
                        if(result[0].versions[i].summary != undefined){
                            document.getElementById("description").innerHTML = result[0].versions[i].summary;

                            if(document.getElementById("description").offsetHeight > 145)
                                 document.getElementById("box-button").style.display = "inline";
                        } else{
                            document.getElementById("description").innerText = ("Description not available");
                        }

                        /*Inserimento date*/
                        if(result[0].versions[i].platform_version_release_dates[0].human != undefined){
                            document.getElementById("date").innerHTML = result[0].versions[i].platform_version_release_dates[0].human;
                        } else{
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
                            link.innerText = "Official Website";
                            link.href = result[0].websites[0].url;
                        } else {
                            document.getElementById("website").innerText = ("Website not available");
                        }

                        break;
                    }
                }

            document.getElementById("logo-platform").appendChild(img);
            document.getElementById("website").appendChild(link);



             searchGame(result[0].name);
            },
            error: function (xhr, status, error) {
                alert(status);
            }
        });

        function addName (x){
            if(x != platform){
                return " (" + platform + ")";
            }

            else
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

            data: 'fields name, platforms.name, release_dates.human, cover.url, platforms.id, category; limit 300; where platforms.name = "' + stringa + '";',
            dataType: "json",
            success: function (newresult) {
                for(var i = 0; i < newresult.length; i++){
                    var card = document.createElement('figure');
                    card.className = "cardInside";
                    var image = document.createElement('img');
                    if(!('cover' in newresult[i]) == 0){
                        image.src = newresult[i].cover.url;
                    } else {
                        image.src = "../../images/missing.png";
                    }

                    var info = document.createElement('div');
                    var lista = document.createElement('ul');
                    lista.className = "elencoLista";
                    var date = document.createElement('li');
                    var platform = document.createElement('li');
                    var name = document.createElement('li');

                    if(!('name' in newresult[i]) == 0){
                        name.innerHTML = newresult[i].name;
                    } else{
                        name.innerHTML = "Name not available";
                    }

                    var listaConsole = "";

                    if(!('platforms' in newresult[i]) == 0){
                        for(var j = 0; j< newresult[i].platforms.length && j < 2; j++){
                            var collegamento = document.createElement('a');
                            collegamento.innerHTML = listaConsole.concat(newresult[i].platforms[j].name);
                            collegamento.href="http://localhost:8080/platform?name=" + newresult[i].platforms[j].name;
                            platform.appendChild(collegamento);
                            if( j==0 && newresult[i].platforms.length > 1){
                                collegamento.innerHTML = collegamento.innerHTML.concat(", ");
                            }
                        }
                        if(newresult[i].platforms.length > 2)
                            platform.innerHTML = platform.innerHTML.concat("...");
                    } else{
                        platform.innerHTML = "Platform not available";
                    }
                    if (!('release_dates' in newresult[i]) == 0){
                        date.innerHTML = newresult[i].release_dates[0].human;
                    } else{
                        date.innerHTML = "Date not available";
                    }

                    card.appendChild(image);
                    lista.appendChild(name);
                    lista.appendChild(date);
                    lista.appendChild(platform);
                    info.appendChild(lista);
                    card.appendChild(info);

                    var link = document.createElement('a');
                    link.href = "http://localhost:8080/game?id=" + newresult[i].id;
                    link.innerHTML = "More";
                    card.appendChild(link);
                    document.getElementById("col"+i%2).appendChild(card);
                }
            },
            error: function (xhr, status, error) {
                alert(status);
            }
        });
    }

