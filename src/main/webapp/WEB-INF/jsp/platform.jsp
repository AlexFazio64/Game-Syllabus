<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${platform}</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <link rel="stylesheet" href="../../css/platformStyle.css">
    <script type="text/javascript" src="../../js/platformScript.js"></script>
</head>
<body>

    <div id="nav-placeholder">
    </div>
    <script>
        $(function () {
            $("#nav-placeholder").load("navbar.html");
        });
    </script>

    <script type="text/javascript" defer>
       /*readMore();*/
       searchPlatform('${platform}');
    </script>


    <main class="container">
        <section class="info-grid">

            <figure class="platform-logo" id="logo-platform">
                <img src="../../images/notFound.png"/>
            </figure>

            <div class="platform-name">
                <H1 id="name"> XBox 360 SPACCA CULO CIAO MAMMA AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA</H1>
            </div>

            <div class="platform-description" id="description">
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ad deleniti dicta dignissimos dolorem dolorum error esse illo ipsa iste iure,
                    molestiae natus neque, nihil nisi odit optio quam ratione sapiente similique sit suscipit tempora temporibus unde voluptate voluptatem.</p>
            </div>
            <p class="read_more"><a class="box-button" href="#">Leggi tutto</a></p>
            <div class="other-info">
                <div class="other-one">
                    <h2>GENERATION:</h2>
                    <p>Eighth generation</p>
                </div>

                <div class="other-two">
                    <h2>OFFICIAL WEBSITE:</h2>
                    <a href="#">Official Website</a>
                </div>

                <div class="other-three">
                    <h2>RELEASE DATES:</h2>
                    <div>12/12/2020</div>
                    <div>17/04/2017</div>
                    <div>01/08/2018</div>
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