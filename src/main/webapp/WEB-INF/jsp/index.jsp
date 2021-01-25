<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Game Syllabus</title>
	<link rel="stylesheet" href="../../css/indexStyle.css">
	<link rel="stylesheet" href="../../css/common.css">
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="../../javascript/indexScript.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body>

<div id="nav-placeholder"></div>
<c:if test="${error == true}">
	<script defer>
        swal({
            title: "Login issue!",
            text: "Invalid credentials!",
            icon: "error",
            button: "Ok",
        });
	</script>
</c:if>
<script>
    $(function () {
        $("#nav-placeholder").load("http://localhost:8080/getNavbar");
    });
</script>
<main class="content">
	<div class="divBenvenuto">
		<c:if test="${usernameLogged == null}">
			<h3>Welcome, visitor</h3>
		</c:if>
		<c:if test="${usernameLogged != null}">
			<p>Welcome back, </p>
			<p class="utenteLogged">${usernameLogged}</p>
		</c:if>
	</div>
	<div>
		<h3 class="trend">Most Recent</h3>
		<div class="mostCommon" id="common">
			<div class="loader"></div>
		</div>
	</div>
	
	<div>
		<h3 class="trend">Most voted of all time</h3>
		<div class="mostCommon" id="mostVoted">
			<div class="loader"></div>
		</div>
	</div>
	
	<div>
		<h3 class="trend">Recent updates</h3>
		<div class="mostCommon" id="relevant">
			<div class="loader"></div>
		</div>
	</div>
	
	<div>
		<h3 class="trend">Recent updates</h3>
		<div class="mostCommon" id="consoles">
			<div class="loader"></div>
		</div>
	</div>
	
	<div class="news">
		<div>
			<script type="text/javascript">
                rssfeed_url = new Array();
                rssfeed_url[0] = "https://www.vg247.com/feed/";
                rssfeed_url[1] = "https://it.ign.com/feed.xml";
                rssfeed_frame_width = "1000px";
                rssfeed_frame_height = "250";
                rssfeed_scroll = "off";
                rssfeed_scroll_step = "6";
                rssfeed_scroll_bar = "on";
                rssfeed_target = "_blank";
                rssfeed_font_size = "12";
                rssfeed_font_face = "";
                rssfeed_border = "on";
                rssfeed_css_url = "https://feed.surfing-waves.com/css/style4.css";
                rssfeed_title = "on";
                rssfeed_title_name = "";
                rssfeed_title_bgcolor = "#3366ff";
                rssfeed_title_color = "#fff";
                rssfeed_title_bgimage = "";
                rssfeed_footer = "off";
                rssfeed_footer_name = "rss feed";
                rssfeed_footer_bgcolor = "#fff";
                rssfeed_footer_color = "#333";
                rssfeed_footer_bgimage = "";
                rssfeed_item_title_length = "150";
                rssfeed_item_title_color = "#666";
                rssfeed_item_bgcolor = "#fff";
                rssfeed_item_bgimage = "";
                rssfeed_item_border_bottom = "off";
                rssfeed_item_source_icon = "off";
                rssfeed_item_date = "off";
                rssfeed_item_description = "on";
                rssfeed_item_description_length = "200";
                rssfeed_item_description_color = "#666";
                rssfeed_item_description_link_color = "#333";
                rssfeed_item_description_tag = "off";
                rssfeed_no_items = "0";
                rssfeed_cache = "582116e92aad101c848ece8e4a0c04ae";
			</script>
			<script type="text/javascript" src="//feed.surfing-waves.com/js/rss-feed.js"></script>
		</div>
	</div>
</main>
<footer>
	<p>Site made for <strong>Software Engineering and Web Computing exams</strong>.</p>
	<p>Used public database: <a href="https://www.igdb.com/discover">IGDB</a></p>
</footer>
<script defer type="text/javascript">
    //joinare tutte le query in una unica mega query
    <c:if test="${googleLogin == 'yes'}">
    console.log("loggato con google")
    </c:if>
    <c:if test="${googleLogin == null}">
    console.log("non loggato con google")
    </c:if>
    getCommon();
</script>
</body>
</html>