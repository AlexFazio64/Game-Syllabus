

function getCommon(){
    var todayDate =  Math.round(new Date().getTime()/1000);
    $.ajax({
        url: "https://game-syllabus-proxy.group64.workers.dev/?https://api.igdb.com/v4/games",
        type: "POST",
        crossDomain: true,
        headers: {
            'Accept': 'application/json',
            "Client-ID": "yjev1wy79vlnwcv35gbdcvz91tg47u",
            "Authorization": "Bearer b6tr4i9lufeysqmxcvkclmirl4b8zj"
        },
        data: 'fields name, cover.image_id, rating, first_release_date; limit 15; where first_release_date<='+todayDate+' & aggregated_rating_count >= 1; sort first_release_date desc;',
        dataType: "json",
        success: function (result) {
            for (var i = 0; i < result.length; i++) {
                var card = document.createElement('div');
                card.classList.add("cardInside");
                card.classList.add("color1");
                var link = document.createElement('a');
                link.className ="linkMod";
                link.href = "http://localhost:8080/game?id="+result[i].id;

                var bgImage = document.createElement('div');
                bgImage.className = "bgImage";
                var divName = document.createElement('div');
                divName.className = "name";
                var name = document.createElement('p');

                if (!('name' in result[i]) == 0) {
                    name.innerHTML = result[i].name;
                }
                if (!('cover' in result[i]) == 0) {
                    //bgImage.setAttribute("style", "background-image: url("+result[i].cover.url+")");
                    bgImage.setAttribute("style", "background-image: url(https://images.igdb.com/igdb/image/upload/t_cover_big/" + result[i].cover.image_id + ".png)");
                }

                card.appendChild(bgImage);
                divName.appendChild(name);
                card.appendChild(divName);
                link.appendChild(card);
                document.getElementById("common").appendChild(link);
            }
        },
        error: function (xhr, status, error) {
            alert(status);
        }
    })
    ;
}


function getTrending () {
    setTimeout(trending, 1200);
    function trending() {
        $.ajax({
            url: "https://game-syllabus-proxy.group64.workers.dev/?https://api.igdb.com/v4/games",
            type: "POST",
            crossDomain: true,
            headers: {
                'Accept': 'application/json',
                "Client-ID": "h78bpc6nx4cn1tct87c0w9wc6jknv7",
                "Authorization": "Bearer vlng3tiiqsmjhc5spoog9544193m62"
            },
            data: 'fields name, cover.image_id, rating, first_release_date; limit 15; where rating >= 90 & aggregated_rating_count > 10 ; sort first_release_date desc;',
            dataType: "json",
            success: function (result) {
                for (var i = 0; i < result.length; i++) {
                    var card = document.createElement('div');
                    card.classList.add("cardInside");
                    card.classList.add("color2");
                    var bgImage = document.createElement('div');
                    bgImage.className = "bgImage";
                    var divName = document.createElement('div');
                    divName.className = "name";
                    var name = document.createElement('p');

                    var link = document.createElement('a');
                    link.className ="linkMod";
                    link.href = "http://localhost:8080/game?id="+result[i].id;

                    if (!('name' in result[i]) == 0) {
                        name.innerHTML = result[i].name;
                    }
                    if (!('cover' in result[i]) == 0) {
                        //bgImage.setAttribute("style", "background-image: url("+result[i].cover.url+")");
                        bgImage.setAttribute("style", "background-image: url(https://images.igdb.com/igdb/image/upload/t_cover_big/" + result[i].cover.image_id + ".png)");
                    }
                    card.appendChild(bgImage);
                    divName.appendChild(name);
                    card.appendChild(divName);
                    link.appendChild(card);
                    document.getElementById("mostVoted").appendChild(link);
                }
            },
            error: function (xhr, status, error) {
                alert(status);
            }
        })
        ;
    }
}


