<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Game Syllabus</title>
    <link rel="stylesheet" href="../../css/indexStyle.css">
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
    <a href="#" onclick="signOut();">Sign out</a>
    <script>
        function signOut() {
            var auth2 = gapi.auth2.getAuthInstance();
            auth2.signOut().then(function () {
                console.log('User signed out.');
            });
        }
    </script>
    <div class="divBenvenuto">
        <c:if test="${emailLogged == null}">
        <h3>Welcome, visitor</h3>
        </c:if>
        <c:if test="${emailLogged != null}">
            <p>Welcome back, </p>
            <p class="utenteLogged">${emailLogged}</p>
        </c:if>
    </div>
    <div>
        <h3 class="trend">Most Recent</h3>
        <div class="mostCommon" id="common">
        </div>
    </div>

    <div>
        <h3 class="trend">Most voted of all time</h3>
        <div class="mostCommon" id="mostVoted">
        </div>
    </div>

    <div class="news">
        <div>
            <!-- start sw-rss-feed code -->
            <script type="text/javascript">
                rssfeed_url = new Array();
                rssfeed_url[0] = "https://multiplayer.it/feed/rss/news/";
                rssfeed_frame_width = "400";
                rssfeed_frame_height = "218";
                rssfeed_scroll = "on";
                rssfeed_scroll_step = "5";
                rssfeed_scroll_bar = "on";
                rssfeed_target = "_blank";
                rssfeed_font_size = "12";
                rssfeed_font_face = "";
                rssfeed_border = "on";
                rssfeed_css_url = "https://feed.surfing-waves.com/css/style6.css";
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
                rssfeed_item_title_length = "50";
                rssfeed_item_title_color = "#666";
                rssfeed_item_bgcolor = "#fff";
                rssfeed_item_bgimage = "";
                rssfeed_item_border_bottom = "on";
                rssfeed_item_source_icon = "off";
                rssfeed_item_date = "off";
                rssfeed_item_description = "on";
                rssfeed_item_description_length = "120";
                rssfeed_item_description_color = "#666";
                rssfeed_item_description_link_color = "#333";
                rssfeed_item_description_tag = "off";
                rssfeed_no_items = "0";
                rssfeed_cache = "f28fbe42ec5058bf539b461fb3d49c5d";

            </script>
            <script type="text/javascript" src="//feed.surfing-waves.com/js/rss-feed.js"></script>
            <!-- The link below helps keep this service FREE, and helps other people find the SW widget. Please be cool and keep it! Thanks. -->
            <div style="color:#ccc;font-size:10px; text-align:right; width:400px;">powered by <a
                    href="https://surfing-waves.com" rel="noopener" target="_blank" style="color:#ccc;">Surfing
                Waves</a>
            </div>
            <!-- end sw-rss-feed code -->
        </div>
        <div>
            <!-- start sw-rss-feed code -->
            <script type="text/javascript">
                rssfeed_url = new Array();
                rssfeed_url[0] = "http://feeds.feedburner.com/ign/games-all";
                rssfeed_frame_width = "400";
                rssfeed_frame_height = "218";
                rssfeed_scroll = "on";
                rssfeed_scroll_step = "5";
                rssfeed_scroll_bar = "on";
                rssfeed_target = "_blank";
                rssfeed_font_size = "12";
                rssfeed_font_face = "";
                rssfeed_border = "on";
                rssfeed_css_url = "https://feed.surfing-waves.com/css/style6.css";
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
                rssfeed_item_title_length = "50";
                rssfeed_item_title_color = "#666";
                rssfeed_item_bgcolor = "#fff";
                rssfeed_item_bgimage = "";
                rssfeed_item_border_bottom = "on";
                rssfeed_item_source_icon = "off";
                rssfeed_item_date = "off";
                rssfeed_item_description = "on";
                rssfeed_item_description_length = "120";
                rssfeed_item_description_color = "#666";
                rssfeed_item_description_link_color = "#333";
                rssfeed_item_description_tag = "off";
                rssfeed_no_items = "0";
                rssfeed_cache = "749211041512a5fa224aa6a8c0331f2c";
            </script>
            <script type="text/javascript" src="//feed.surfing-waves.com/js/rss-feed.js"></script>
            <!-- The link below helps keep this service FREE, and helps other people find the SW widget. Please be cool and keep it! Thanks. -->
            <div style="color:#ccc;font-size:10px; text-align:right; width:230px;">powered by <a
                    href="https://surfing-waves.com" rel="noopener" target="_blank" style="color:#ccc;">Surfing
                Waves</a>
            </div>
            <!-- end sw-rss-feed code -->
        </div>
        <div><!-- start sw-rss-feed code -->
            <script type="text/javascript">
                rssfeed_url = new Array();
                rssfeed_url[0] = "http://feeds.feedburner.com/ign/game-reviews";
                rssfeed_frame_width = "400";
                rssfeed_frame_height = "218";
                rssfeed_scroll = "on";
                rssfeed_scroll_step = "5";
                rssfeed_scroll_bar = "on";
                rssfeed_target = "_blank";
                rssfeed_font_size = "12";
                rssfeed_font_face = "";
                rssfeed_border = "on";
                rssfeed_css_url = "https://feed.surfing-waves.com/css/style6.css";
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
                rssfeed_item_title_length = "50";
                rssfeed_item_title_color = "#666";
                rssfeed_item_bgcolor = "#fff";
                rssfeed_item_bgimage = "";
                rssfeed_item_border_bottom = "on";
                rssfeed_item_source_icon = "off";
                rssfeed_item_date = "off";
                rssfeed_item_description = "on";
                rssfeed_item_description_length = "120";
                rssfeed_item_description_color = "#666";
                rssfeed_item_description_link_color = "#333";
                rssfeed_item_description_tag = "off";
                rssfeed_no_items = "0";
                rssfeed_cache = "621b0d67742c139b866e784d2b88484b";
            </script>
            <script type="text/javascript" src="//feed.surfing-waves.com/js/rss-feed.js"></script>
            <!-- The link below helps keep this service FREE, and helps other people find the SW widget. Please be cool and keep it! Thanks. -->
            <div style="color:#ccc;font-size:10px; text-align:right; width:230px;">powered by <a
                    href="https://surfing-waves.com" rel="noopener" target="_blank" style="color:#ccc;">Surfing
                Waves</a></div>
            <!-- end sw-rss-feed code --></div>
    </div>
</main>
<footer>
    <p>Site made for <strong>Software Engineering and Web Computing exams</strong>.</p>
    <p>Used public database: <a href="https://www.igdb.com/discover">IGDB</a></p>
</footer>
    <script defer type="text/javascript">
        getCommon();
        getTrending();
    </script>
</body>
</html>