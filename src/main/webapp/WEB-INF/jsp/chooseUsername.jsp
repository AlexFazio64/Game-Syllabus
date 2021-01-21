<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="google-signin-client_id"
          content="508493289721-mi2g5njrlan5oue6n1h64b2lroc28nu4.apps.googleusercontent.com">

    <title>Sign up</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="../../css/registerStyle.css">
    <link rel="stylesheet" href="../../css/indexStyle.css">

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>

<div class="form">
    <div>
        <div class="syllabus">
        </div>
        <form method="post" action="http://localhost:8080/register">
            <div class="form-group">
                <label for="usr">Username:</label>
                <input type="text" class="form-control" placeholder="Enter username.." id="usr" name="username">
                <input type="hidden" name="email">
                <input type="hidden" name="password">
            </div>
            <button type="submit" class="btn btn-primary color-purple">Submit</button>
        </form>
    </div>
</div>
</body>
</html>