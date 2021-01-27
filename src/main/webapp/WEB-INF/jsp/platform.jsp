<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${platform}</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <link rel="stylesheet" href="../../css/platformStyle.css">
    <script type="text/javascript" src="../../javascript/platformScript.js"></script>
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
    searchPlatform('${platform}');
</script>


<main class="container">
    <section class="info-grid">

        <figure class="platform-logo" id="logo-platform"></figure>

        <div class="platform-name">
            <H1 id="name"></H1>
        </div>

        <div class="platform-description">
            <p id="description"></p>
        </div>

        <div class="other-info">
            <div class="other-one">
                <h2>GENERATION:</h2>
                <p id="generation"></p>
            </div>

            <div class="other-two">
                <h2 id="website">OFFICIAL WEBSITE:<br></h2>
            </div>

            <div class="other-three">
                <h2>RELEASE DATE:</h2>
                <p id="date"></p>
            </div>
        </div>
    </section>

    <div class="lista-giochi" id="list">
        <h1> Games list</h1>
        <div class="loader place" id="loader_platform"></div>
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