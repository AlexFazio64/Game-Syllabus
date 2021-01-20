<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Error</title>
    <link rel="stylesheet" href="../../css/regError.css">
</head>
<body>
<div class="testo">
    <h1 class="parametro">${errorType}</h1>
    <h1>already used. You will be redirected in</h1>
    <h1 id="countdown" class="parametro">3</h1>
</div>

<script defer>
    setTimeout(redirect,3000);
    function redirect() {
        window.location.href = "http://localhost:8080/regPage";
    }
    var startSeconds = 3;
    const countdownEl = document.getElementById("countdown");

    function updateCountdown(){
        if (startSeconds > 0) {
            startSeconds--;
            countdownEl.innerText = startSeconds;
        }
    }
    setInterval(updateCountdown,1000);

</script>
</body>
</html>