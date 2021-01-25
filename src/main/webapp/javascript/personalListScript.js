function populateList(stringa) {
    if (stringa.length != 0) {
        $.ajax({
            url: "https://game-syllabus-proxy.group64.workers.dev/?https://api.igdb.com/v4/games",
            type: "POST",
            crossDomain: true,
            headers: {
                'Accept': 'application/json',
                "Client-ID": "hz61ow2zgltsan4v3gza0l3aex4euk",
                "Authorization": "Bearer vnshkav90zd6ngdjrjnw3zsiqa3kml"
            },

            data: "fields id, name, cover.image_id ; limit 300; where id = (" + stringa + ");",
            dataType: "json",
            success: function (result) {
                result = sortArray(stringa, result);

                for (var j = 0; j < result.length; j++) {
                    var d = document.createElement('div');
                    d.id = result[j].id;


                    if (j % 2 == 0)
                        d.className = "game-light";
                    else
                        d.className = "game-dark";

                    var img = document.createElement('img');
                    var n = document.createElement('p');
                    var i = document.createElement('i');

                    /*Inserimento logo*/
                    if (result[j].cover != undefined) {
                        img.src = "https://images.igdb.com/igdb/image/upload/t_logo_med/" + result[j].cover.image_id + ".png";

                    } else {
                        img.src = img.src = "../../images/notFound.png";
                    }

                    /*Inserimento nome*/
                    var link_game = document.createElement('a');
                    link_game.innerHTML = result[j].name;
                    link_game.href = "http://localhost:8080/game?id=" + result[j].id;
                    n.appendChild(link_game);
                    i.setAttribute("class", "material-icons");
                    i.setAttribute("onclick", "removeGame(" + result[j].id + ")");
                    i.innerHTML = "close";

                    d.appendChild(img);
                    d.appendChild(n);
                    d.appendChild(i);
                    document.getElementById("game-list").appendChild(d);
                }
            },
            error: function (xhr, status, error) {
                alert(status);
            }
        });
    }

    /*SE NON C'E' NULLA NELLA LISTA, APPARE QUESTO*/
    else{
        var placeholder = document.createElement('img');
        placeholder.className = "placeholder-list";
        placeholder.src = "../../images/error.png";
        // document.getElementById("list-panel").appendChild(placeholder);
    }

}

function removeGame(idGame) {
    var obj = document.getElementById(idGame);
    obj.remove();
    idGame.toString();
    window.location.href = "http://localhost:8080/deleteElement?idGame=" + idGame;
}

function sortArray(arr_db, arr_query) {
    arr_db.reverse();
    var newArray = [];
    for (var i = 0; i < arr_db.length; i++) {
        newArray[arr_db.indexOf(arr_query[i].id)] = arr_query[i];
    }
    return newArray;
}