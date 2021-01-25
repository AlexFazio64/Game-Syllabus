<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="it">
<head>
	<meta charset="UTF-8">
	<title>${username}</title>
	<link rel="stylesheet" href="../../css/profile.css">
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>
<div id="nav-placeholder"></div>
<script>
    $(function () {
        $("#nav-placeholder").load("http://localhost:8080/getNavbar");
    });
</script>
<script>
    function showAbout() {
        $('.about-panel').css('display', 'block');
        $('.edit-about-panel').css('display', 'none');
        $('.list-panel').css('display', 'none');
    }

    function showList() {
        $('.about-panel').css('display', 'none');
        $('.edit-about-panel').css('display', 'none');
        $('.list-panel').css('display', 'block');
    }

    function showEdit() {
        $('.about-panel').css('display', 'none');
        $('.edit-about-panel').css('display', 'block');
        $('.list-panel').css('display', 'none');
    }

    async function fetchGamesAndUpdate() {
        setTimeout(request, 1000);

        function request() {
            $.ajax({
                url: "https://game-syllabus-proxy.group64.workers.dev/?https://api.igdb.com/v4/games",
                type: "POST",
                crossDomain: true,
                dataType: "json",
                headers: {
                    "Client-ID": "eof600pvnu4zmfzrgf1mmmgwhugt72",
                    "Authorization": "Bearer dwg48lh6ge8576eju90dh266jbp40n"
                },
                data: 'f cover.image_id, name; w id=(${ids}); limit 500;',
                success: function (result) {
                    for (const res of result) {
                        if (res.cover)
                            $("#" + res.id + " > div.game-img > img")[0].src = "https://images.igdb.com/igdb/image/upload/t_cover_big/" + res.cover.image_id + ".jpg";
                        $("#" + res.id + " > div.rev-info > h2")[0].innerText = res.name;
                    }
                }
            });
        }
    }

    function deleteAccount() {
        $.ajax({
            url: "http://localhost:8080/account/${username}/delete",
            type: "DELETE",
            crossOrigin: false,
            success: function (result) {
                window.location.href = "http://localhost:8080" + result;
            }
        });
    }

    function removeReview(id) {
        $.ajax({
            url: "http://localhost:8080/account/${username}/review/" + id + "/delete",
            type: "DELETE",
            crossOrigin: false,
            success: function (result) {
                window.location.href = "http://localhost:8080" + result;
            }
        });
    }

    function removeGame(game) {
        $('#' + game).remove();
    }

    function populate(num) {
        for (let x = 0; x < num; x++) {
            var d = $("<div>").attr({"class": "game", "id": x});
            var p = $("<img>").attr("src", "");
            var n = $("<p>").html("Very LOOOOOOOOOOOOOOOONG game name [" + x + "]");
            var i = $("<i>").attr("class", "material-icons").html("close");
            i.attr("onclick", "removeGame(" + x + ")");
            d.append(p);
            d.append(n);
            d.append(i);
            $(".game-list").append(d);
        }
    }
</script>
<main>
	<div class="background">
		<script defer>
            $.ajax({
                url: "https://game-syllabus-proxy.group64.workers.dev/?https://api.igdb.com/v4/games",
                type: "POST",
                crossDomain: true,
                dataType: "json",
                headers: {
                    "Client-ID": "eof600pvnu4zmfzrgf1mmmgwhugt72",
                    "Authorization": "Bearer dwg48lh6ge8576eju90dh266jbp40n"
                },
                data: 'f artworks.image_id; w total_rating >=85 & artworks.image_id != null & artworks.width >= 720 & id <=' + Math.round(Math.random() * 100000) + '; limit 20;',
                success: function (result) {
                    var art = Math.trunc(Math.random() * 20) % result.length;
                    var ch = Math.trunc(Math.random() * 20) % result[art].artworks.length;
                    $(".background").first().css("background", 'url("https://images.igdb.com/igdb/image/upload/t_1080p/' + result[art].artworks[ch].image_id + '.jpg") no-repeat no-repeat 0 0 / cover');

                    <c:if test="${reviews!=null}">
                    fetchGamesAndUpdate();
                    </c:if>
                }
            });
		</script>
	</div>
	<section>
		<section class="account-options">
			<div>
				<img src="${immagine}" alt="avatar" class="avatar-img">
				<p class="usrnm">${username}</p>
			</div>
			<div class="btn">
				<span onclick="showAbout()">About me</span>
				<span onclick="showList()">My list</span>
				<span onclick="showEdit()" class="edit-btn">Edit</span>
			</div>
		</section>
		<section class="about-panel">
			<c:if test="${descrizione != null}">
				<h3>About</h3>
				<p class="description">${descrizione}</p>
			</c:if>
			
			<c:if test="${reviews!=null}">
				<section class="reviews">
					<c:forEach var="rev" items="${reviews}">
						<div class="review" id="${rev.getIdGioco()}">
							<div class="game-img">
								<img src="http://localhost:8080/images/notFound.png" alt="game-cover">
							</div>
							<div class="rev-info">
								<h2>Loading...</h2>
								<span>
                                    <i class="material-icons">
                                        <c:forEach begin="1" end="${rev.getValutazione()}">star </c:forEach>
                                        <c:forEach begin="${rev.getValutazione()}" end="9">star_border </c:forEach>
                                    </i>
                                </span>
								<form action="http://localhost:8080/account/${username}/review/${rev.getId()}/edit"
								      method="post">
									<c:if test="${rev.getTesto() != null}">
										<textarea name="text" maxlength="255">${rev.getTesto()}</textarea>
									</c:if>
									<c:if test="${rev.getTesto() == null}">
										<textarea name="text" maxlength="255">click to edit...</textarea>
									</c:if>
									<input type="submit" class="update" value="Update">
									<input type="number" min="1" max="10" value="1" name="stars">
									<span>Stars: </span>
									<p class="delete-btn" onclick="removeReview(${rev.getId()})">Delete review</p>
								</form>
							</div>
						</div>
					
					</c:forEach>
				</section>
			</c:if>
		</section>
		<section class="edit-about-panel">
			<form method="post" action="http://localhost:8080/account/${username}/edit" class="info-edit-panel"
			      enctype="multipart/form-data">
				<div class="info">
					<p>Username</p>
					<input type="text" name="username" value="${username}" minlength="5"
					       pattern="[a-zA-Z0-9-]+"
					       title="Use only numbers and letters">
					<c:if test="${password != null}">
						<input type="hidden" name="password" value="-1">
						<input type="hidden" name="new_password" value="-1">
					</c:if>
					<c:if test="${password == null}">
						<p>Old Password</p>
						<input type="password" name="password" required minlength="5" pattern="[a-zA-Z0-9-]+"
						       title="Use only numbers and letters">
					<p>New Password</p>
					<input type="password" name="new_password" minlength="5" pattern="[a-zA-Z0-9-]+"
					       title="Use only numbers and letters">
					</c:if>
					<p>Picture</p>
					<input type="file" name="image" accept="image/*">
					<p class="delete-btn" onclick="deleteAccount()">Delete your account</p>
					<input type="submit" value="Confirm">
				</div>
				<div class="bio">
					<p>About me</p>
					<textarea name="descrizione">${descrizione}</textarea>
				</div>
			</form>
		</section>
		<section class="list-panel">
			<section class="game-list"></section>
			<script>
                populate(10);
			</script>
		</section>
	</section>
</main>
</body>
</html>