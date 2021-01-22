<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Game</title>
    <link rel="stylesheet" href="css/gameStyle.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script type="text/javascript" src="../../javascript/gameScript.js"></script>
    <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"
          integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
    <meta name="viewport" content="width=device-width, initial-scale=1">

</head>


<div id="nav-placeholder">
</div>
<script>
    $(function () {
        $("#nav-placeholder").load("http://localhost:8080/getNavbar");
    });
</script>

<script>
    function textAreaAdjust(element) {
        element.style.height = "1px";
        element.style.height = (25 + element.scrollHeight) + "px";
    }
</script>
<script>
    function sendReview() {
        console.log(document.getElementById("reviewText").value);
    }
</script>
<main id="main" class="bkgcolor" style="background-image:url('../../images/devLogoNotFound.webp') ">
    <div id="bkg"></div>
    <div id="all-info" style="opacity: 1">
        <img id="cover"
             src="https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png">
        <ul id="basicInformation">
            <li><span id="game-name" class="gameName"> </span></li>
            <li><span id="release_date"><strong>Release Date: </strong></span></li>
            <li><span id="gameplay-type" ><strong>Gameplay Type: </strong> </span></li>
            <li><span id="console"><strong>Available for:</strong></span></li>
            <li><span id="gameGenres" ><strong>Genres: </strong></span></li>
            <li id="Developer" ><strong>Developers: </strong></li>
            <li><span id="websites" ><strong>Websites: </strong></span></li>
            <li><span id="dlc" ><strong>DLCs: </strong></span></li>
        </ul>
    </div>
    <section class="other-info">
        <p id="summary"></p>
        <h3 class="Arguments">Video</h3>
        <div id="videos"></div>

        <h3 class="Arguments">Screenshot</h3>
        <div id="screenshots"></div>

        <div>

            <h3 class="Arguments">Reviews</h3>
            <c:if test="${personalReview == null}">
                <div class="review">
                    <section>
                        <span>Write your review</span>
                        <span class="fa fa-star checked"></span>
                        <span class="fa fa-star checked"></span>
                        <span class="fa fa-star checked"></span>
                        <span class="fa fa-star"></span>
                        <span class="fa fa-star"></span>
                    </section>
                    <section>
                        <textarea onkeyup="textAreaAdjust(this)" cols="40" style="resize: none"
                                  id="reviewText"></textarea>
                        <button onclick="sendReview()">Invia</button>
                    </section>
                </div>

             </c:if>
             <c:if test="${personalReview !=null}">
                 <div class="Myreview">
                     <section>
                         <span>Your review</span>
                         <c:forEach begin="1" end="${personalReview.getValutazione()}">
                             <span class="fa fa-star checked"></span>
                         </c:forEach>
                         <c:forEach begin="${personalReview.getValutazione()+1}" end="10">
                             <span class="fa fa-star"></span>
                         </c:forEach>
                     </section>
                     <section>
                         <p>${personalReview.getTesto()}</p>
                     </section>
                 </div>
             </c:if>
            <div id="review-container">
                <c:forEach var="rews" items="${reviews}">
                    <div class="review">
                        <span>${rews.getScrittaDa()}</span>
                        <c:forEach begin="1" end="${rews.getValutazione()}">
                            <span class="fa fa-star checked"></span>
                        </c:forEach>
                        <c:forEach begin="${rews.getValutazione()+1}" end="10">
                            <span class="fa fa-star"></span>
                        </c:forEach>
                        <p>${rews.getTesto()}</p>
                    </div>
                </c:forEach>
            </div>
        </div>

    </section>
    <footer style="filter: blur(0)">
        <p>Site made for <strong>Software Engineering and Web Computing exams</strong>.</p>
        <p>Used public database: <a href="https://www.igdb.com/discover">IGDB</a></p>
    </footer>
</main>
<script>
    load("username ${emailLogged} review${personalReview}");
</script>
<script type="text/javascript" defer>
    loadGameBasicInfo("${game}");
</script>
</body>

</html>