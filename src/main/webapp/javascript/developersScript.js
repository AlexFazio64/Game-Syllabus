function loadDevelopers(previous, start) {
    $.ajax({
        url: "https://game-syllabus-proxy.group64.workers.dev/?https://api.igdb.com/v4/involved_companies",
        type: "POST",
        crossDomain: true,
        headers: {
            'Accept': 'application/json',
            "Client-ID": "h78bpc6nx4cn1tct87c0w9wc6jknv7",
            "Authorization": "Bearer vlng3tiiqsmjhc5spoog9544193m62"
        },
        data: 'fields company.name,company.logo.image_id,company.id; limit 50;where developer = true & id >' + start + '; sort id asc;  ',
        dataType: "json",
        success: function (results) {
            var alreadyPresent = [];
            var datas = JSON.stringify(results);
            var dev = [];
            dev = JSON.parse(datas);
            var finish = false;
            var cont = 0;
            console.log(results);
            if (dev.length > 0) {
                for (var j = 0; j < 5; j++) {
                    if (finish)
                        break;
                    for (var i = 0; i < 4 && !finish;) {
                        if (!(alreadyPresent.includes(dev[cont].company.name))) {
                            alreadyPresent.push(dev[cont].company.name);
                            var link = document.createElement('a');
                            link.href = "http://localhost:8080/platform?name=" + dev[cont].company.name;
                            var container = document.createElement('section');
                            container.className = "column card";
                            var devName = document.createElement('div')
                            devName.innerHTML = dev[cont].company.name;
                            devName.className = "name container";
                            var logo = document.createElement('img');
                            if (!("logo" in dev[cont].company) == 0) {
                                logo.src = "//images.igdb.com/igdb/image/upload/t_logo_med/" + dev[cont].company.logo.image_id + ".png";
                            } else {
                                logo.src = "/images/devLogoNotFound.webp";
                                logo.height = 150;
                                logo.width = 35;
                            }
                            logo.className = "comp-logo";
                            container.appendChild(logo);
                            container.appendChild(devName);
                            link.appendChild(container);
                            document.getElementById("row" + j).appendChild(link);
                            i++;
                            if (alreadyPresent.length >= 20) {
                                finish = true;
                                lastIndex = dev[cont].id;
                                break;
                            }
                        }
                        cont++;
                    }
                }
            }
            loadPagination(start, lastIndex, previous);
        }, error: function (xhr, status, error) {
            alert(status);
        }
    });
}

function loadPagination(firstIndex, lastIndex, previous) {
    if (firstIndex <= 0) {
        var element = document.getElementById('previous');
        element.parentNode.removeChild(element);
        document.getElementById("next").href = "http://localhost:8080/developers/next?start=" + lastIndex + "&previous=0";
        document.getElementById("next").innerHTML = '&raquo;';
    } else if (firstIndex >= 111741) {
        var element = document.getElementById('next');
        element.parentNode.removeChild(element);
        document.getElementById("previous").href = "http://localhost:8080/developers?start=" + previous;
        document.getElementById("previous").innerHTML = '&laquo;';
    } else {
        var next = parseInt(lastIndex);
        if (next < 137)
            next = 0;
        document.getElementById("previous").href = "http://localhost:8080/developers?start=" + previous;
        document.getElementById("next").href = "http://localhost:8080/developers/next?start=" + next + "&previous=" + firstIndex;
        document.getElementById("previous").innerHTML = '&laquo;';
        document.getElementById("next").innerHTML = '&raquo;';
    }
}