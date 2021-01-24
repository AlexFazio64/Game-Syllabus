
function showList() {
    $('.game_info').css('display', 'block');
    $('.game_result').css('display', 'grid');
    document.getElementById('research_box_id').className = "research_box_list";
}

function showGrid() {
    $('.game_info').css('display', 'none');
    $('.game_result').css('display', 'contents');
    document.getElementById('research_box_id').className = "research_box_grid";
}

function numOfResult(num, search){
    return num + " results for " + "\"" + search + "\"";
}

function refineSearch(result){

    var copyresult = result;

    for( var i = 0; i < result.length; i++){
        if(result[i].similar_games != undefined){
                for(var j = 0; j < result[i].similar_games.length; j++){
                        copyresult.push(result[i].similar_games[j]);
                }
            }
    }

    const result_new = [];
    const map = new Map();
    for (const item of copyresult) {
        if(!map.has(item.id)){
            map.set(item.id, true);    // set any value to Map
            result_new.push({
                id: item.id,
                name: item.name,
                cover: item.cover,
                involved_companies: item.involved_companies,
                genres: item.genres,
                release_dates: item.release_dates,
                platforms: item.platforms
            });
        }
    }

    return result_new;
}

async function firstResearch(search) {
    $.ajax({
        url: "https://game-syllabus-proxy.group64.workers.dev/?https://api.igdb.com/v4/games",
        type: "POST",
        crossDomain: true,
        headers: {
            'Accept': 'application/json',
            "Client-ID": "hz61ow2zgltsan4v3gza0l3aex4euk",
            "Authorization": "Bearer vnshkav90zd6ngdjrjnw3zsiqa3kml"
        },

        data: 'fields cover.image_id, name, involved_companies.company.name, involved_companies.developer, genres.name, release_dates.human, platforms.name, similar_games.cover.image_id, similar_games.name, similar_games.involved_companies.company.name, similar_games.involved_companies.developer, similar_games.genres.name, similar_games.release_dates.human, similar_games.platforms.name; limit 50; search "' + search + '";',
        dataType: "json",
        success: async function (raw_result) {

            var result = refineSearch(raw_result);
            document.getElementById("search_result").innerHTML = numOfResult(result.length, search);

            for (var i = 0; i < result.length; i++) {
                /* VA MESSO TUTTO DENTRO CONTAINER*/

                var game_result = document.createElement('div');
                game_result.className = "game_result";

                var figure_list = document.createElement('figure');
                figure_list.className = "figure_list";

                var figure_grid = document.createElement('figure');
                figure_grid.className = "figure_grid";

                var game_info  = document.createElement('div');
                game_info.className = "game_info";


                var title = document.createElement('ul');
                var developer = document.createElement('li');
                var genre = document.createElement('li');
                var release_date = document.createElement('li');
                var platforms = document.createElement('li');

                var img = document.createElement('img');
                var cover_image = document.createElement('div');
                cover_image.className = "game-card-overlay";
                cover_image.textContent = result[i].name;
                var link_image = document.createElement('a');
                link_image.className = "game-card";
                /*link_image = "http://localhost:8080/game?id=" + result[i].id;*/
                link_image.setAttribute('href', "http://localhost:8080/game?id=" + result[i].id);

                /*Inserimento Immagini*/
                if (result[i].cover != undefined) {
                    img.src = "https://images.igdb.com/igdb/image/upload/t_cover_big/" + result[i].cover.image_id + ".png";
                    figure_list.appendChild(link_image);
                    link_image.appendChild(img);
                    link_image.appendChild(cover_image);


                } else {
                    img.src = "../../images/notFound.png";
                    figure_list.appendChild(link_image);
                    link_image.appendChild(img);
                    link_image.appendChild(cover_image);
                }

                /*Inserimento Titolo*/
                var title_link = document.createElement('a');
                title_link.innerHTML = result[i].name;
                title_link.href = "http://localhost:8080/game?id=" + result[i].id;
                title.appendChild(title_link);



                var devFlag = true;

                /*Inserimento Sviluppatore*/
                if (result[i].involved_companies != undefined) {
                    for (var j = 0; j < result[i].involved_companies.length; j++) {
                        if (result[i].involved_companies[j].developer == true) {
                            devFlag = false;
                            var dev_link = document.createElement('a');
                            dev_link.append(result[i].involved_companies[j].company.name + " ");
                            dev_link.href = "http://localhost:8080/developer?name=" + result[i].involved_companies[j].company.name;
                            developer.appendChild(dev_link);
                        }
                    }
                }

                if (result[i].involved_companies == undefined || devFlag) {
                    developer.innerHTML = "Developer not available";
                }

                /*Inserimento Genere*/
                if (result[i].genres != undefined) {
                    var genres_string = "";
                    for(var j = 0; j < result[i].genres.length; j++){
                        if( j != 0) genre.append(", ");
                        var genre_link = document.createElement('a');
                        genre_link.innerHTML = genres_string.concat(result[i].genres[j].name);
                        genre_link.href= "http://localhost:8080/genre?genreName=" + result[i].genres[j].name;
                        genre.appendChild(genre_link);
                    }

                } else{
                    genre.innerHTML = "Genre not available";
                }

                /*Inserimento Anno_Uscita*/
                if (result[i].release_dates != undefined) {
                    release_date.innerHTML = result[i].release_dates[0].human;
                } else {
                    release_date.innerHTML = "Date not available";
                }

                /*Inserimento Piattaforme*/
                if (result[i].platforms != undefined) {
                    var platforms_string = "";
                    for(var j = 0; j < result[i].platforms.length; j++){
                        if( j != 0) platforms.append(", ");
                        var platform_link = document.createElement('a');
                        platform_link.innerHTML = platforms_string.concat(result[i].platforms[j].name);
                        platform_link.href= "http://localhost:8080/platform?name=" + result[i].platforms[j].name;

                        platforms.appendChild(platform_link);
                    }

                } else{
                    platforms.innerHTML = "platform not available";
                }


                game_info.appendChild(title);
                game_info.appendChild(developer);
                game_info.appendChild(genre);
                game_info.appendChild(release_date);
                game_info.appendChild(platforms);
                game_result.appendChild(figure_list);
                game_result.appendChild(game_info);

                document.getElementById("research_box_id").appendChild(game_result);
            }
        },
        error: function (xhr, status, error) {
            alert(status);
        }
    });
}
