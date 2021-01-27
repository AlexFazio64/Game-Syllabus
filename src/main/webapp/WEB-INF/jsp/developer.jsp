<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${developer}</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <link rel="stylesheet" href="../../css/developerStyle.css">
    <script type="text/javascript" src="../../javascript/developerScript.js"></script>
</head>
<body>

<div id="nav-placeholder">
</div>
<script>
    $(function () {
        $("#nav-placeholder").load("http://localhost:8080/getNavbar");
    });
</script>


<script type="text/javascript" defer>
    searchInfo('${developer}');
</script>


<main class="container">
    <section class="info-grid">
        <figure class="dev-logo" id="logo-developer"></figure>
        <div class="casa-vg">
            <H1 id="name"></H1>
        </div>
        <div class="info-casa">
            <div class="info-uno">
                <h2>ESTABLISHED:</h2>
                <p id="date"></p>
            </div>
            <div class="info-uno">
                <h2>COUNTRY:</h2>
                <p id="contryCode"></p>
            </div>

            <div class="info-due">
                <h2>STATUS:</h2>
                <p>Active</p>
            </div>

            <div class="info-due">
                <h2 id="website">OFFICIAL WEBSITE:<br></h2>
            </div>

        </div>
    </section>

    <div class="lista-giochi" id="list">
        <h1> Games list</h1>
        <div class="loader place" id="loader_developer"></div>
        <div id="col0" class="column"></div>
        <div id="col1" class="column"></div>
        <div class="card" id="card">
        </div>
    </div>
</main>
<div class="buttonShow">
    <a href="#bottom" id="showButton" class="showMore">Show more</a>
</div>
<a href="#nav-placeholder" class="material-icons back-to-top">arrow_upward</a>
<footer>
<p>Site made for <strong>Software Engineering and Web Computing exams</strong>.</p>
<p>Used public database: <a href="https://www.igdb.com/discover">IGDB</a></p>
</footer>
</body>
</html>