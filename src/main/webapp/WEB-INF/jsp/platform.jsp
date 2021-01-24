<html lang="en">
<head>
    <meta charset="UTF-8">
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
    readMore();
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

        <%--bottone readMore--%>
        <p class="my_read_more"><a id="box-button" href="#">Read More</a></p>

        <div class="other-info">
            <div class="other-one">
                <h2>GENERATION:</h2>
                <p id="generation"></p>
            </div>

            <div class="other-two">
                <h2>OFFICIAL WEBSITE:</h2>
                <a id="website"></a>
            </div>

            <div class="other-three">
                <h2>RELEASE DATE:</h2>
                <p id="date"></p>
            </div>
        </div>
    </section>

    <div class="lista-giochi" id="list">
        <h1> Games list</h1>
        <div id="col0" class="column"></div>
        <div id="col1" class="column"></div>
        <div class="card" id="card">
        </div>
    </div>
</main>
</body>
</html>