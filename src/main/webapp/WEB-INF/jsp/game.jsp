<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Game</title>
    <link rel="stylesheet" href="../../css/gameStyle.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script type="text/javascript" src="../../javascript/gameScript.js"></script>
    <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"
          integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

</head>

<body>
<div id="nav-placeholder">
</div>
<script>
    $(function () {
        $("#nav-placeholder").load("http://localhost:8080/getNavbar");
    });
</script>
<script>
    function remove() {
        window.location.href = "http://localhost:8080/removeFrom?id=${game}";
    }
</script>
<script>
    function textAreaAdjust(element) {
        element.style.height = "1px";
        element.style.height = (25 + element.scrollHeight) + "px";
    }
</script>
<main id="main" class="bkgcolor" style="background-image:url('../../images/notFound.png') ">
    <div id="bkg"></div>
    <div id="all-info" style="opacity: 1">
        <ul>
            <li>
                <img id="cover"
                     src="../../images/notFound.png">
            </li>
            <li>
                <button id="list" onclick=addToList('${emailLogged}','${game}')>Add to game List</button>
            </li>
        </ul>
        <ul id="basicInformation">
            <li><span id="game-name" class="gameName"> </span>
            </li>
            <%--<c:if test="${emailLogged==null}">
                <script defer>
                var button = document.getElementById('delete');
                button.parentNode.removeChild(button);
                </script>
            </c:if>--%>
            <%--<c:if test="${intoList==null}">
                <script defer>
                    var button = document.getElementById('delete');
                    button.parentNode.removeChild(button);
                </script>
            </c:if>--%>
            <c:if test="${added!=null}">
                <script>
                    swal("Success!", "Game added to your list", "success");
                </script>
            </c:if>
            <c:if test="${intoList!=null}">
                <script defer>
                    var listItem = document.getElementById('list');
                    listItem.parentNode.removeChild(listItem);
                    var addRemoveContainer = document.createElement('li');
                    var addRemove = document.createElement('button');
                    addRemove.className = "add-remove"
                    addRemove.addEventListener("click", remove);
                    addRemoveContainer.append(addRemove);
                    var coverid = document.getElementById("cover");
                    coverid.parentNode.append(addRemoveContainer);
                </script>
            </c:if>

            <li><span id="game-rate"><strong>Rate: </strong></span></li>
            <li><span id="release_date"><strong>Release Date: </strong></span></li>
            <li><span id="gameplay-type"><strong>Gameplay Type: </strong> </span></li>
            <li><span id="console"><strong>Available for:</strong></span></li>
            <li><span id="gameGenres"><strong>Genres: </strong></span></li>
            <li id="Developer"><strong>Developers: </strong></li>
            <li><span id="websites"><strong>Websites: </strong></span></li>
            <li><span id="dlc"><strong>DLCs: </strong></span></li>
        </ul>
    </div>
    <section class="other-info">
        <h3 id="summary-section" class="arguments">Summary</h3>
        <p id="summary"></p>
        <h3 id="videos-section" class="Arguments">Video</h3>
        <div id="videos"></div>
        <h3 id="screenshots-section" class="Arguments">Screenshot</h3>
        <div id="screenshots"></div>
        <div id="media-and-reviews">
            <h3 class="Arguments">Reviews</h3>
            <c:if test="${personalReview == null}">
                <div class="review">
                    <section>
                        <span>Write your review with a rating from 1 to 10 </span>
                        <input type="number" id="quantity" name="quantity" min="1" max="10">
                    </section>
                    <section>
                        <textarea onkeyup="textAreaAdjust(this)" cols="72" style="resize: none"
                                  id="reviewText" maxlength="255"></textarea>
                        <button class="sendButton" onclick=sendReview("${personalReview}","${emailLogged}","${game}")>
                            Send
                        </button>
                    </section>
                </div>
            </c:if>
            <c:if test="${personalReview !=null}">
                <div id="userReview" class="Myreview">
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
    <footer>
        <p>Site made for <strong>Software Engineering and Web Computing exams</strong>.</p>
        <p>Used public database: <a href="https://www.igdb.com/discover">IGDB</a></p>
    </footer>
</main>
<script type="text/javascript" defer>
    loadGameBasicInfo("${game}");
</script>
<script>
    loadGameRate("${averageRate}");
</script>

</body>

</html>
