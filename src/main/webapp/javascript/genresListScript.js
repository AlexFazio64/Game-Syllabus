function listaGeneri(){
    $.ajax({
        url: "https://game-syllabus-proxy.group64.workers.dev/?https://api.igdb.com/v4/genres",
        type: "POST",
        crossDomain: true,
        headers: {
            'Accept': 'application/json',
            "Client-ID": "yjev1wy79vlnwcv35gbdcvz91tg47u",
            "Authorization": "Bearer b6tr4i9lufeysqmxcvkclmirl4b8zj"
        },
        data: 'fields name; limit 300; sort name asc;',
        dataType: "json",
        success: function (result) {
            var content = JSON.stringify(result).replaceAll("'", " ");
            //content = content.replace("[", "");
            //content = content.substring(0, content.lastIndexOf("]"));
            var txt = [];
            txt = JSON.parse(content);
            for (var i = 0; i < txt.length; i++) {
                var link = document.createElement('a');
                link.href = "http://localhost:8080/genre?genreName=" + txt[i].name;
                link.className = "linkMod";
                const card = document.createElement('div');
                card.classList.add("cardInside");
                var genInit = document.createElement('div');
                genInit.className = "genInit";
                var iniziale = document.createElement('h1');
                var name = document.createElement('p');
                if (!('name' in txt[i]) == 0 && !(txt[i].name).localeCompare("Hack and slash/Beat  em up") == 0) {
                    iniziale.innerHTML = txt[i].name[0];
                    name.innerHTML = txt[i].name;
                } else if ((txt[i].name).localeCompare("Hack and slash/Beat  em up") == 0) {
                    iniziale.innerHTML = txt[i].name[0];
                    name.innerHTML = "Hack and slash";
                    var copia = {
                        id: 25,
                        name: "Beat \u0027em up"
                    };
                    txt.push(copia);
                }
                const background = document.createElement('img');
                background.addEventListener("load", function () {
                    var arr = getColors(background);
                    card.setAttribute("style", "background-color:"+ arr[0].getHex());
                    // card.setAttribute("style", "background: radial-gradient(circle, " + arr[0].getHex() + " 0%, " + arr[Math.round(arr.length -1)].getHex() + " 30%)");
                });

                background.className = "bg";
                background.setAttribute("src", "../../images/imagesBackground/" + txt[i].id + ".jpg");
                card.appendChild(background);
                genInit.appendChild(iniziale);
                card.appendChild(genInit);
                card.appendChild(name);
                link.appendChild(card);
                document.getElementById("col" + i % 4).appendChild(link);
            }
        },
        error: function (xhr, status, error) {
            alert(status);
        }
    });
}