function getCommon() {
    var todayDate = Math.round(new Date().getTime() / 1000);
    $.ajax({
        url: "https://game-syllabus-proxy.group64.workers.dev/?https://api.igdb.com/v4/games",
        type: "POST",
        crossDomain: true,
        headers: {
            'Accept': 'application/json',
            "Client-ID": "yjev1wy79vlnwcv35gbdcvz91tg47u",
            "Authorization": "Bearer b6tr4i9lufeysqmxcvkclmirl4b8zj"
        },
        data: 'fields name, cover.image_id, rating, first_release_date; limit 15; where first_release_date<=' + todayDate + ' & aggregated_rating_count >= 1; sort first_release_date desc;',
        dataType: "json",
        success: function (result) {
            setTimeout(getTrending, 100);
            $(".loader")[0].remove();
            for (var i = 0; i < result.length; i++) {
                createGameCard(result[i], "common");
            }
            $("#common")[0].scrollLeft = $("#common").width();
        },
        error: function (xhr, status, error) {
            $(".loader")[0].remove();
            setTimeout(getTrending, 100);
            $("#common").append($("<p>").text("Something went wrong 😳😳😳"));
        }
    })
    ;
}

function getTrending() {
    setTimeout(trending, 100);

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
            data: 'fields name, cover.image_id, rating, first_release_date; limit 15; where rating >= 90 & aggregated_rating_count > 10 | name ~*"yorha"*; sort first_release_date desc;', //lol, nice find 👍
            dataType: "json",
            success: function (result) {
                setTimeout(getResults, 100);
                $(".loader")[0].remove();
                for (var i = 0; i < result.length; i++) {
                    createGameCard(result[i], "mostVoted");
                }
                $("#mostVoted")[0].scrollLeft = $("#mostVoted").width();
            },
            error: function (xhr, status, error) {
                $(".loader")[0].remove();
                setTimeout(getResults, 100);
                $("#mostVoted").append($("<p>").text("Something went wrong 😳😳😳"));
            }
        })
        ;
    }
}

async function IGN_IT() {
    var result = await $.ajax({
        url: "https://game-syllabus-proxy.group64.workers.dev/?https://it.ign.com/feed.xml",
        type: "get",
        crossDomain: true,
        error: function (xhr, status, error) {
            $("body").html(JSON.stringify(error));
        }
    });

    var titles = [];
    var categories = [];

    var items = result.getElementsByTagName("channel")[0].getElementsByTagName("item");
    for (var i = items.length - 1; i >= 0; i--) {
        var curr = items[i].children;
        titles.push(curr[0].innerHTML.toLowerCase());
        for (var j = 8; j < curr.length; j++) {
            categories.push(curr[j].innerHTML.toLowerCase().replaceAll("-", " "));
        }
    }

    return findRelevantKeywords(titles, categories);
}

function findRelevantKeywords(parsed_titles, parsed) {
    //find unique keywords
    parsed = new Array(...new Set(parsed));

    //keep keywords in titles of the news
    var in_title = [];
    for (const k of parsed) {
        for (const l of parsed_titles) {
            if (l.search(k) != -1) {
                //console.log(k, "<<<", l);
                in_title.push(k);
                break;
            }
        }
    }

    in_title = new Array(...new Set(in_title));
    return in_title;
}

async function VG247() {
    var result = await $.ajax({
        url: "https://game-syllabus-proxy.group64.workers.dev/?https://www.vg247.com/feed/",
        type: "get",
        crossDomain: true,
        error: function (xhr, status, error) {
            $("body").html(JSON.stringify(error));
        }
    });

    var parsed = [];
    var parsed_titles = [];
    var items = result.getElementsByTagName('item');
    for (var i = items.length - 1; i >= 0; i--) {
        var titles = items[i].getElementsByTagName('title');

        for (var t = titles.length - 1; t >= 0; t--) {
            parsed_titles.push(titles[t].innerHTML.toLowerCase());
        }

        var categories = items[i].getElementsByTagName('category');

        for (var j = categories.length - 1; j >= 0; j--) {
            parsed.push(categories[j].innerHTML.slice(9, -3).toLowerCase().replaceAll("-", " "));
        }
    }

    return findRelevantKeywords(parsed_titles, parsed);
}

function games(arr) {
    var serialized = "";
    // name = s (case-insensitive)
    arr.forEach(s => serialized += "name ~\"" + s + "\" | ");
    return serialized.slice(0, -3);
}

function platforms(arr) {
    var serialized = "";
    // name | alternative_name | abbreviation = s (case-insensitive)
    arr.forEach(s => serialized += "name ~\"" + s + "\" | " + "alternative_name ~\"" + s + "\" | " + "abbreviation ~\"" + s + "\" | ");
    return serialized.slice(0, -3);
}

async function getResults(argument) {
    var vg = await VG247();
    var ign = await IGN_IT();
    var keywords = new Array(...new Set(vg.concat(ign)));

    $.ajax({
        url: "https://game-syllabus-proxy.group64.workers.dev/?https://api.igdb.com/v4/multiquery",
        type: "POST",
        crossDomain: true,
        dataType: "json",
        headers: {
            "Accept": "application/json",
            "Client-ID": "eof600pvnu4zmfzrgf1mmmgwhugt72",
            "Authorization": "Bearer dwg48lh6ge8576eju90dh266jbp40n"
        },
        data: 'query games "Games"{ fields name, cover.image_id; where ' + await games(keywords) + '; limit 20;};' + 'query platforms "platforms in news"{fields name, platform_logo.image_id; where ' + await platforms(keywords) + ';};',
        success: function (result) {
            $(".loader")[0].remove();
            for (var i = 0; i < result[0].result.length; i++) {
                createGameCard(result[0].result[i], "relevant");
            }
            $("#relevant")[0].scrollLeft = $("#relevant").width();
            $(".loader")[0].remove();
            for (var i = 0; i < result[1].result.length; i++) {
                createPlatformCard(result[1].result[i], "consoles");
            }
            $("#consoles")[0].scrollLeft = $("#consoles").width();
        },
        error: function (xhr, status, error) {
            console.log(error, status);
            $(".loader")[0].remove();
            $("#relevant").append($("<p>").text("Something went wrong 😳😳😳"));
            $("#consoles").append($("<p>").text("Something went wrong 😳😳😳"));
        }
    });
}

function createGameCard(result, id) {
    var card = document.createElement('div');
    card.classList.add("cardInside");
    card.classList.add("color2");
    var bgImage = document.createElement('div');
    bgImage.className = "bgImage";
    var divName = document.createElement('div');
    divName.className = "name";
    var name = document.createElement('p');

    var link = document.createElement('a');
    link.className = "linkMod";
    link.href = "http://localhost:8080/game?id=" + result.id;

    if (result.name) {
        name.innerHTML = result.name;
    }
    if (result.cover) {
        bgImage.setAttribute("style", "background-image: url(https://images.igdb.com/igdb/image/upload/t_cover_big/" + result.cover.image_id + ".png)");
    } else {
        bgImage.setAttribute("style", "background-image: url(http://localhost:8080/images/notFound.png");
    }
    card.appendChild(bgImage);
    divName.appendChild(name);
    card.appendChild(divName);
    link.appendChild(card);
    document.getElementById(id).appendChild(link);
}

function createPlatformCard(result, id) {
    var card = document.createElement('div');
    card.classList.add("cardInside");
    card.classList.add("color2");
    var bgImage = document.createElement('div');
    bgImage.className = "bgImage";
    var divName = document.createElement('div');
    divName.className = "name";
    var name = document.createElement('p');

    var link = document.createElement('a');
    link.className = "linkMod";
    link.href = "http://localhost:8080/platform?name=" + result.name;

    if (result.name) {
        name.innerHTML = result.name;
    }
    if (result.platform_logo) {
        bgImage.setAttribute("style", "background-image: url(https://images.igdb.com/igdb/image/upload/t_cover_big/" + result.platform_logo.image_id + ".png)");
    } else {
        bgImage.setAttribute("style", "background-image: url(http://localhost:8080/images/notFound.png");
    }
    card.appendChild(bgImage);
    divName.appendChild(name);
    card.appendChild(divName);
    link.appendChild(card);
    document.getElementById(id).appendChild(link);
}