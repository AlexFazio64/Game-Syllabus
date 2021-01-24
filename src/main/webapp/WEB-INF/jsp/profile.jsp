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
    function deleteAccount() {
        $.ajax({
            url: "http://localhost:8080/account/delete",
            type: "DELETE",
            crossOrigin: false,
            headers: {
                "username": "alexfazio67"
            },
            success: function (result) {
                window.location.href = "http://localhost:8080" + result;
            }
        });
    }

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
    <div class="background"></div>
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
            <section class="reviews">
                <div class="review">
                    <div class="game-img">
                        <img src="../../images/imagesBackground/2.jpg" alt="game-mugshot">
                    </div>
                    <div class="rev-info">
                        <h2>Game Name</h2>
                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusamus, adipisci amet commodi
                            doloribus ducimus, fuga illum impedit ipsa magnam magni minima modi molestiae nam natus non
                            nostrum officia optio qui quo rerum sapiente suscipit tempora tempore ullam voluptatum?
                            Blanditiis delectus dicta et exercitationem fuga ipsum iste, labore maiores minima, optio
                            praesentium, provident quasi qui quis quod sunt veniam. Hic ipsum modi, odit praesentium
                            quod rerum sapiente sed suscipit voluptatibus! Alias aut distinctio, eligendi expedita hic,
                            ipsum minus porro praesentium quaerat quis quo quod quos reprehenderit sequi sunt tempore
                            vitae. Eos nulla porro quam. Culpa magnam, similique! Ex hic libero molestias.</p>
                    </div>
                </div>
                <div class="review">
                    <div class="game-img">
                        <img src="../../images/imagesBackground/2.jpg" alt="game-mugshot">
                    </div>
                    <div class="rev-info">
                        <h2>Game Name</h2>
                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi, aperiam beatae consectetur
                            cum cupiditate dolorem dolores doloribus earum, hic illo libero maxime odio placeat ratione
                            recusandae temporibus voluptatibus? Alias aliquid, cupiditate error, harum laboriosam libero
                            placeat provident quaerat quia rerum temporibus vitae. Ab ad asperiores assumenda cumque
                            dolorem dolorum eius exercitationem harum ipsa ipsum magnam maxime molestias nisi, nobis,
                            placeat porro reiciendis sit tenetur totam unde velit veritatis voluptates. Accusamus,
                            accusantium ad alias asperiores, atque cupiditate enim est excepturi facilis inventore
                            laborum magni minima nam neque nisi, numquam odit officia omnis optio perspiciatis qui
                            reprehenderit saepe sed sint ullam unde veniam voluptas. Accusantium aliquid atque culpa
                            cupiditate dicta dolorem dolores earum, excepturi, expedita hic id illo iste labore
                            laboriosam modi nisi nulla odio quasi recusandae reprehenderit temporibus ullam unde vero
                            voluptas, voluptatem. Animi aperiam, asperiores aspernatur at blanditiis consectetur culpa
                            debitis, dicta doloribus ea eius eligendi error excepturi explicabo facere incidunt iure
                            labore maxime minima minus modi molestias natus nemo nostrum quae quam quisquam
                            reprehenderit sapiente sed tempore tenetur ullam veritatis voluptatem. A aliquam architecto
                            consequuntur dolores dolorum enim, eum fugiat illo ipsam laborum minima minus molestiae
                            nesciunt officiis pariatur quae quaerat quis repellat reprehenderit rerum sequi sint,
                            suscipit totam vero vitae, voluptas voluptate. Assumenda autem dicta doloribus excepturi
                            facere id quae quis ratione tempore. Aspernatur consectetur ducimus eligendi enim esse
                            excepturi iste libero odit repellendus velit. Aliquid architecto, assumenda autem commodi
                            consequatur, dolorem facere harum hic incidunt inventore ipsam, magnam molestiae mollitia
                            placeat quidem soluta sunt tenetur velit voluptas voluptatum. Aliquid est in reprehenderit
                            repudiandae voluptates! Amet, aperiam atque debitis dicta laboriosam necessitatibus quod.
                            Blanditiis cum dolore doloribus error esse et fugiat illo incidunt ipsum, iste iure, magni
                            nemo, nisi nulla numquam obcaecati officia sed soluta vel voluptatibus. Aliquid amet animi
                            aspernatur, assumenda at aut cum debitis delectus distinctio dolor dolore dolores dolorum
                            earum est eveniet ex excepturi in inventore iure iusto labore laudantium magnam maxime
                            molestiae natus nemo nobis officia optio possimus praesentium quam quo saepe soluta tempora
                            vel veritatis voluptatibus! A, accusamus accusantium amet aperiam consequatur dolorem
                            dolores ea eaque eligendi enim harum labore modi pariatur quam qui, saepe tempora. Fuga
                            ipsam laudantium, molestiae natus perferendis placeat praesentium provident quo vel. Ad
                            beatae consequuntur, cumque dolore doloribus eius hic impedit minima non officia pariatur
                            quas quo, reiciendis reprehenderit soluta velit vero voluptatibus voluptatum! Aliquid
                            cupiditate dolorum eligendi facere illum, impedit qui unde. Commodi, dolorem eius esse hic
                            neque officiis optio quisquam sed tenetur voluptate? At beatae ex impedit itaque nobis porro
                            rem sapiente sequi sint unde. Animi aperiam consequuntur enim exercitationem illo illum in
                            magnam modi, placeat qui! Accusamus adipisci, architecto aspernatur assumenda eum ex, ipsam
                            iusto molestias non, quis repellat sequi vitae. Aliquam ex facere fugit illum iure mollitia
                            necessitatibus non odit sapiente sunt? A ab consequuntur deleniti deserunt expedita hic
                            molestiae nemo nostrum qui voluptatem. Ad aliquam amet animi, beatae commodi corporis cum
                            cumque, delectus dolorum eius enim eos eum ex exercitationem explicabo facere facilis
                            laboriosam laudantium minima numquam quae, quas quod reprehenderit saepe sed temporibus
                            veniam? Alias architecto commodi corporis, cumque doloribus ducimus ex explicabo incidunt
                            ipsam minus, nobis omnis perferendis praesentium quasi quia quibusdam sapiente tempore? Ab
                            accusantium aspernatur error expedita perspiciatis possimus sapiente voluptatibus? Accusamus
                            consequatur debitis, doloribus, eius eligendi eos expedita fugiat ipsa ipsum laudantium
                            necessitatibus pariatur quisquam quod voluptas voluptatem. Animi cumque cupiditate dolorum
                            exercitationem fugit laborum molestias nam nostrum officia, optio porro, repellendus, sed
                            tempore totam ullam? Ab accusamus beatae, consectetur dolore error illo ipsa ipsam iste
                            laudantium minima minus mollitia neque officiis optio perferendis possimus, provident
                            similique sint suscipit temporibus velit voluptates voluptatum! Amet aspernatur
                            consequuntur, dignissimos, dolorem et fugit iste laboriosam, nihil obcaecati quaerat saepe
                            unde vitae voluptatum. Architecto commodi dolor dolore hic minima quam quas quisquam quos,
                            suscipit veritatis vitae voluptatibus. Accusamus accusantium amet culpa distinctio doloribus
                            eius eos et eum exercitationem facilis fugiat hic illum in inventore ipsum laborum
                            laudantium magni maxime nihil nobis provident quae, quas suscipit ullam voluptates. Amet
                            assumenda earum, eos fugiat molestias placeat, quas quasi quos ratione sit unde vero
                            voluptatem. Ab, ducimus exercitationem iure labore laboriosam laudantium quae quibusdam
                            quidem sed sint. A aliquam cum dignissimos dolore hic ipsum laudantium libero necessitatibus
                            pariatur perferendis quam repellat, sapiente vitae voluptatibus voluptatum. Ad alias aliquid
                            consequatur, culpa cum debitis dolorem ex fugiat inventore mollitia, nemo neque possimus
                            quidem quod tempore voluptatem voluptates? Aliquam, cum, in. Ducimus eum fugit magnam
                            molestiae veritatis! Autem expedita id ipsa iste minus necessitatibus pariatur perspiciatis.
                            Aspernatur blanditiis cum debitis delectus dignissimos eaque eligendi enim et labore,
                            laudantium modi nostrum perferendis, quasi ratione, saepe suscipit ut vero. Assumenda at
                            beatae, delectus deleniti dolores eveniet excepturi explicabo harum id illo illum laborum
                            magnam modi molestiae nostrum odio porro quae quas quis, reiciendis saepe similique sint
                            soluta totam, ut veniam voluptatum! Blanditiis cum cupiditate dignissimos, distinctio dolor,
                            eveniet facere, fugit iste iure laudantium maiores molestiae molestias nobis quaerat rem
                            repellat saepe tempore temporibus totam voluptatem! Aspernatur dolores eveniet impedit
                            incidunt magni optio quia, quidem similique veritatis vitae? Aliquam aliquid animi aperiam
                            architecto asperiores at aut beatae blanditiis consequuntur cumque deleniti dolor doloremque
                            exercitationem expedita explicabo harum illum impedit in ipsam, nam necessitatibus non nulla
                            officia omnis optio pariatur perferendis quas qui quisquam reiciendis rem sunt suscipit
                            tenetur ullam ut vel vero. Fugit laudantium mollitia, perferendis quaerat reiciendis velit.
                            Aperiam corporis dignissimos illum libero neque perferendis praesentium, repellendus
                            voluptate? Adipisci at consequuntur eaque explicabo facere in ipsa ipsam iusto magni nisi,
                            placeat quasi quia quod totam voluptate voluptatem voluptatum. Ab architecto beatae deleniti
                            doloremque eaque et expedita inventore ipsum iure libero magni molestiae molestias nisi
                            nobis, officiis placeat quas, quis quisquam quos ratione reprehenderit, velit voluptatem!
                            Adipisci, aut consectetur delectus deleniti dignissimos dolore, dolorum earum eius esse
                            fugit id impedit ipsam libero minus mollitia nemo nobis obcaecati officiis omnis pariatur
                            provident quae quibusdam quisquam quo, quos reprehenderit rerum sequi sunt voluptate
                            voluptatibus! Asperiores corporis delectus dolores eveniet, nesciunt nisi obcaecati
                            temporibus. Dolorum ducimus error explicabo illum incidunt quo, soluta unde! Exercitationem
                            ipsum nemo qui quod quos rem rerum sed unde ut!</p>
                    </div>
                </div>

                <div class="review">
                    <div class="game-img">
                        <img src="../../images/background.webp" alt="game-mugshot">
                    </div>
                    <div class="rev-info">
                        <h2>Game Name</h2>
                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet architecto asperiores atque
                            aut cum dolore eaque eos ipsam nisi nulla placeat provident, quibusdam quidem saepe
                            similique! A accusamus adipisci aut consectetur consequatur, cum cumque dignissimos dolores
                            eaque fugiat in iste maxime modi nam perferendis placeat quidem rem vel veniam
                            voluptate!</p>
                    </div>
                </div>

                <div class="review">
                    <div class="game-img">
                        <img src="../../images/notFound.png" alt="game-mugshot">
                    </div>
                    <div class="rev-info">
                        <h2>.</h2>
                        <p>.</p>
                    </div>
                </div>

                <div class="review">
                    <div class="game-img">
                        <img src="../../images/profile_picture.jpg" alt="game-mugshot">
                    </div>
                    <div class="rev-info">
                        <h2>Game Name</h2>
                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aliquid inventore nobis pariatur
                            quae sequi suscipit. Aperiam deserunt error iusto repellat sed! Accusantium alias aliquid
                            asperiores aut cum cumque distinctio doloremque ducimus hic iure natus, nemo nostrum nulla
                            officia provident quidem quisquam quos recusandae rerum tempora! Illum labore optio saepe
                            voluptate? Atque deleniti, ea, eligendi magni maiores minima nam optio praesentium
                            reiciendis repellendus soluta tempora tenetur voluptatibus. Ab aut commodi deleniti
                            doloribus eos est harum libero non odit, placeat! Animi aut beatae, cumque deserunt dolorum
                            inventore ipsa laboriosam laudantium minima nisi optio placeat qui quidem quod soluta
                            suscipit tempora unde velit voluptas voluptatibus? A at est facilis fuga impedit maxime modi
                            molestias nam neque, nisi odit perferendis porro quaerat, quos repudiandae temporibus
                            tenetur veniam. Alias aperiam aspernatur cupiditate deserunt dicta dolor dolores doloribus
                            ex facere hic illum, inventore iste laudantium maiores mollitia nihil nobis numquam officiis
                            quaerat, qui reiciendis saepe sequi similique totam veniam vitae voluptas voluptatem. Eum
                            nesciunt optio reprehenderit. Cupiditate dicta expedita impedit inventore iste itaque nulla
                            odit quae rem sunt. Accusamus aliquid consectetur dolorem dolores doloribus eaque earum
                            expedita fuga ipsa, ipsam laborum molestiae, necessitatibus, nemo quam saepe temporibus
                            ullam veritatis voluptatem? Accusantium ad alias asperiores assumenda corporis deserunt
                            dicta dolores eaque, eius facilis fuga illo iste itaque, iusto maiores minima natus nesciunt
                            odit possimus quam quia quod ratione reprehenderit sapiente temporibus velit voluptatibus?
                            Aliquid consequatur delectus in inventore natus non optio quibusdam repudiandae vel
                            voluptatem. Amet consectetur eligendi excepturi facilis fugit harum labore libero neque
                            officiis optio perspiciatis, quaerat quibusdam, quos repellat tempora. A amet, assumenda,
                            commodi consequatur deleniti deserunt earum eos facere harum incidunt inventore laborum
                            minus nobis nostrum numquam obcaecati odio, provident quod rem repellat rerum sed sequi sunt
                            unde voluptatibus. Aliquid consectetur cum iste nemo porro quibusdam quidem repudiandae sit
                            soluta, sunt unde vitae.</p>
                    </div>
                </div>
            </section>
        </section>
        <section class="edit-about-panel">
            <form method="post" action="http://localhost:8080/account/edit" class="info-edit-panel"
                  enctype="multipart/form-data">
                <div class="info">
                    <p>Username</p>
                    <input type="text" name="username" value="${username}">
                    <p>Old Password</p>
                    <input type="password" name="password">
                    <p>New Password</p>
                    <input type="password" name="new_password">
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