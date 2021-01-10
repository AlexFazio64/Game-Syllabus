<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Game</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/indexStyle.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script>
        $.ajax({
            url: "https://cors-anywhere.herokuapp.com/https://api.igdb.com/v4/games",
            type: "POST",
            crossDomain: true,
            headers: {
                'Accept': 'application/json',
                "Client-ID": "h78bpc6nx4cn1tct87c0w9wc6jknv7",
                "Authorization": "Bearer vlng3tiiqsmjhc5spoog9544193m62"
            },
            data: 'fields name, release_dates, websites, summary, release_dates, screenshots, videos, age_ratings; where category = 0 ;search  "Assassins Creed II"; limit 1;',

            dataType: "json",

             success: function (result) {
                // alert(JSON.stringify(result));
                 var string = JSON.stringify(result);
                 var name = string.substring(string.indexOf(':"',string.indexOf('"name":"'))+2, string.indexOf('","release_dates"'));
                 document.getElementById("Name").innerHTML=name;
                 var summary = string.substring(string.indexOf(':"',string.indexOf('"summary":"'))+2, string.indexOf('","videos"'));
                 document.getElementById("Summary").innerHTML=summary;
             },
            error: function (xhr, status, error) {
                alert(status);
            }
        });
    </script>

</head>

<body>
<p id="Name"></p>
<p id="Summary"></p>
</body>
</html>