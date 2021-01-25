<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${search}</title>
    <link rel="stylesheet" href="../../css/searchStyle.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script type="text/javascript" src="../../javascript/searchScript.js"></script>
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
    firstResearch('${search}');
</script>

<main id="container">
    <section class="layout_button">
        <div class="btn">
            <span id="search_result"></span>
            <a href="#" onclick="showList()">List</a>
            <a href="#" onclick="showGrid()">Grid</a>
        </div>
    </section>
    <hr class="line">
    <div class="research_box_list" id="research_box_id"></div>
</main>

</body>
</html>