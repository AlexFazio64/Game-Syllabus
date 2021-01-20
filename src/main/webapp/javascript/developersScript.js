function loadDevelopers(start){
    $.ajax({
        url: "https://game-syllabus-proxy.group64.workers.dev/?https://api.igdb.com/v4/involved_companies",
        type: "POST",
        crossDomain: true,
        headers: {
            'Accept': 'application/json',
            "Client-ID": "h78bpc6nx4cn1tct87c0w9wc6jknv7",
            "Authorization": "Bearer vlng3tiiqsmjhc5spoog9544193m62"
        },
        data: 'fields id,company.name,company.logo.image_id; limit 40; sort id asc; where developer = true & id >'+start+'; ',
        dataType: "json",
        success: function (results) {
            var alreadyPresent = [];
            var datas = JSON.stringify(results);
            var dev = [];
            dev = JSON.parse(datas);
            var finish = false;
            var cont = 0;
            if (dev.length > 0) {
                for (var j = 0; j < 5; j++) {
                    if (finish)
                        break;
                    for (var i = 0; i < 4 && !finish;) {
                        if (!(alreadyPresent.includes(dev[cont].company.name))) {
                            alreadyPresent.push(dev[cont].company.name);
                            var DevContainer = document.createElement('section');
                            DevContainer.className = "column card";
                            var devName = document.createElement('div')
                            devName.innerHTML = dev[cont].company.name;
                            devName.className = "name container";
                            var DevLogo = document.createElement('img');
                            if (!("logo" in dev[cont].company) == 0) {
                                DevLogo.src = "//images.igdb.com/igdb/image/upload/t_logo_med/" + dev[cont].company.logo.image_id + ".png";
                            } else {
                                DevLogo.src = "/images/devLogoNotFound.webp";
                                DevLogo.height = 150;
                                DevLogo.width = 35;
                            }
                            DevLogo.className = "comp-logo";
                            DevContainer.appendChild(DevLogo);
                            DevContainer.appendChild(devName);
                            document.getElementById("row" + j).appendChild(DevContainer);
                            i++;
                            if (alreadyPresent.length >= 20) {
                                finish = true;
                                lastIndex = cont;
                                break;
                            }

                        }
                        cont++;
                    }
                }
            }
        }, error: function (xhr, status, error) {
            alert(status);
        }
    });
}
function loadPagination(start){
    var s = parseInt(start);
    if (s < 20) {
        document.getElementById("page1").className = "active";
        document.getElementById("page2").classList.replace("active", null);
        document.getElementById("page2").href = "http://localhost:8080/developers?start=20";
        document.getElementById("page3").href = "http://localhost:8080/developers?start=40";
        document.getElementById("page4").href = "http://localhost:8080/developers?start=60";
        document.getElementById("page5").href = "http://localhost:8080/developers?start=80";
        document.getElementById("page6").href = "http://localhost:8080/developers?start=100";
        document.getElementById("page1").innerHTML = 0;
        document.getElementById("page2").innerHTML = 1;
        document.getElementById("page3").innerHTML = 2;
        document.getElementById("page4").innerHTML = 3;
        document.getElementById("page5").innerHTML = 4;
        document.getElementById("page6").innerHTML = 5;
    } else {
        var currentPage = parseInt(s / 20);
        var starts = [parseInt(s - 20), parseInt(s + 20), parseInt(s + 40), parseInt(s + 60), parseInt(s + 80), parseInt(s + 100)];
        if (starts[0] < 20)
            starts[0] = 0;
        document.getElementById("page1").href = "http://localhost:8080/developers?start=" + starts[0];
        document.getElementById("page2").href = "http://localhost:8080/developers?start=" + starts[1];
        document.getElementById("page3").href = "http://localhost:8080/developers?start=" + starts[2];
        document.getElementById("page4").href = "http://localhost:8080/developers?start=" + starts[3];
        document.getElementById("page5").href = "http://localhost:8080/developers?start=" + starts[4];
        document.getElementById("page6").href = "http://localhost:8080/developers?start=" + starts[5];
        document.getElementById("page1").innerText = (currentPage - 1).toString();
        document.getElementById("page2").innerText = (currentPage).toString();
        document.getElementById("page3").innerText = (currentPage + 1).toString();
        document.getElementById("page4").innerText = (currentPage + 2).toString();
        document.getElementById("page5").innerText = (currentPage + 3).toString();
        document.getElementById("page6").innerText = (currentPage + 4).toString();
    }
}