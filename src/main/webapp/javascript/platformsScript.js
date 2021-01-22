var lastIndex;

function loadPlatforms(firstIndex) {
    $.ajax({
        url: "https://game-syllabus-proxy.group64.workers.dev/?https://api.igdb.com/v4/platforms",
        type: "POST",
        crossDomain: true,
        headers: {
            'Accept': 'application/json',
            "Client-ID": "h78bpc6nx4cn1tct87c0w9wc6jknv7",
            "Authorization": "Bearer vlng3tiiqsmjhc5spoog9544193m62"
        },
        data: 'fields name,platform_logo.image_id; limit 20; sort id asc; where id >' + firstIndex + '; ',
        dataType: "json",
        success: function (results) {
            console.log(results);
            var datas = JSON.stringify(results);
            var platform = [];
            var cont = 0;
            var stop = false;
            var lastIndex;
            platform = JSON.parse(datas);
            if (platform.length > 0) {
                for (var j = 0; j < 5 && !stop; j++) {
                    for (var i = 0; i < 4; i++) {
                        if (platform[cont].id > 373) {
                            stop = true;
                            break;
                        }
                        var link = document.createElement('a');
                        link.href = "http://localhost:8080/platform?name=" + platform[cont].name;
                        var container = document.createElement('section');
                        container.className = "column card";
                        var devName = document.createElement('div')
                        devName.innerHTML = platform[cont].name;
                        devName.className = "name container";
                        var logo = document.createElement('img');
                        if (!("platform_logo" in platform[cont]) == 0) {
                            logo.src = "//images.igdb.com/igdb/image/upload/t_logo_med/" + platform[cont].platform_logo.image_id + ".png";
                        } else {
                            logo.src = "/images/devLogoNotFound.webp";
                            logo.height = 150;
                            logo.width = 35;
                        }
                        logo.className = "comp-logo";
                        container.appendChild(logo);
                        container.appendChild(devName);
                        link.appendChild(container)
                        document.getElementById("row" + j).appendChild(link);
                        cont++;

                    }

                    lastIndex = platform[cont - 1].id;
                }
            }

            loadPagination(firstIndex, lastIndex);
        }, error: function (xhr, status, error) {
            alert(status);
        }
    });
}

function loadPagination(firstIndex, lastindex) {
    if (firstIndex <= 0) {
        var element = document.getElementById('previous');
        element.parentNode.removeChild(element);
        document.getElementById("next").href = "http://localhost:8080/platforms?start=" + lastindex;
        document.getElementById("next").innerHTML = '&raquo;';
    } else if (firstIndex > 165) {
        var previous = firstIndex - 20;
        var element = document.getElementById('previous');
        element.parentNode.removeChild(element);
        document.getElementById("next").href = "http://localhost:8080/platforms?start=" + previous;
        document.getElementById("next").innerHTML = '&laquo;';
    } else {
        var starts = [parseInt(firstIndex - 20), parseInt(lastindex)];
        if (starts[0] < 24)
            starts[0] = 0;
        console.log("s: " + starts);
        document.getElementById("previous").href = "http://localhost:8080/platforms?start=" + starts[0];
        document.getElementById("next").href = "http://localhost:8080/platforms?start=" + starts[1];
        document.getElementById("previous").innerHTML = '&laquo;';
        document.getElementById("next").innerHTML = '&raquo;';
    }
}