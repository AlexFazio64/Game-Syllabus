<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Developers</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script type="text/javascript" src="/js/igdbQuery.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/developersStyle.css">
    <script type="text/javascript" src="../../js/developersScript.js"> </script>
</head>
<body>
<div id="nav-placeholder">
</div>
<script>
    $(function () {
        $("#nav-placeholder").load("navbar.html");
    });
</script>
<script defer>

</script>

<main id="developers">
    <h3>Developers<br></h3>
    <div id="row0" class="row" style="height: 15px"></div>
    <div id="row1" class="row" style="height: 15px"></div>
    <div id="row2" class="row" style="height: 15px"></div>
    <div id="row3" class="row" style="height: 15px"></div>
    <div id="row4" class="row" style="height: 15px"></div>
</main>
<div class="center">
    <div id="numPage" class="pagination">

        <a id="page1"></a>
        <a id="page2" class="active"></a>
        <a id="page3"></a>
        <a id="page4"></a>
        <a id="page5"></a>
        <a id="page6"></a>

    </div>
</div>
<footer>
    <p>Site made for <strong>Software Engineering and Web Computing exams</strong>.</p>
    <p>Used public database: <a href="https://www.igdb.com/discover">IGDB</a></p>
</footer>
<script type="text/javascript" defer>
    loadDevelopers('${start}');
</script>
<script>
    loadPagination('${start}');
</script>
</body>
</html>