<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Error</title>
</head>
<body>
    <h1>${errorType} already used. You will be redirected in 3s..</h1>
    <script defer>
            setTimeout(redirect,3000);
            function redirect(){
                window.location.href = "http://localhost:8080/regPage";
        }
    </script>
</body>
</html>