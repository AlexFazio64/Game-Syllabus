<html lang="en">
<head>
    <meta charset="UTF-8">
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
        <div id="col0" class="column"></div>
        <div id="col1" class="column"></div>
        <div class="card" id="card">
        </div>
    </div>
</main>
</body>
</html>