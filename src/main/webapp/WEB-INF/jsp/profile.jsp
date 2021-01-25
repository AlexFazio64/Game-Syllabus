<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="it">
<head>
	<meta charset="UTF-8">
	<title>${username}</title>
	<link rel="stylesheet" href="../../css/profile.css">
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script type="text/javascript" src="../../javascript/personalListScript.js"></script>
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

    function filesize() {
        const uploadField = $("#file")[0];
        if (uploadField.files[0].size > (8 * 1024 * 1024)) {
            alert("File is too big! Use an image file smaller than 8MB!");
            uploadField.value = "";
        }
    }
</script>
<main>
	<div class="background"></div>
	<section>
		<section class="account-options">
			<div>
				<c:if test="${immagine == null}">
					<img src="http://localhost:8080/images/avatars/style${style}.png" alt="avatar" class="avatar-img">
				</c:if>
				<c:if test="${immagine != null}">
					<img src="${immagine}" alt="avatar" class="avatar-img">
				</c:if>
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
			<section class="reviews">
				<c:if test="${reviews.size()==0}">
					<div class="review">
						<span class="no-reviews">You haven't reviewed any game</span>
					</div>
				</c:if>
				<c:if test="${reviews.size()>0}">
					<script defer>
                        fetchGamesAndUpdate()
					</script>
					<c:forEach var="rev" items="${reviews}">
						<div class="review" id="${rev.getIdGioco()}">
							<div class="game-img">
								<img src="http://localhost:8080/images/notFound.png" onclick="window.location.href='http://localhost:8080/game?id=${rev.getIdGioco()}'" alt="game-cover">
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
				</c:if>
			</section>
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
					<input type="file" name="image" id="file" accept="image/*" onchange="filesize()">
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
			<section id="game-list">
				<c:if test="${showlist.size()>0}">
					<script defer>
                        var idGiochi = [];
                        <c:forEach var="game" items="${showlist}">
                        idGiochi.push(${game.getIdGioco()});
                        </c:forEach>
                        populateList(idGiochi);
					</script>
				</c:if>
			</section>
		</section>
	</section>
</main>
<footer>
	<p>Site made for <strong>Software Engineering and Web Computing exams</strong>.</p>
	<p>Used public database: <a href="https://www.igdb.com/discover">IGDB</a></p>
</footer>
</body>
</html>