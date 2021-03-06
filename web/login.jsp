<%--
  Created by IntelliJ IDEA.
  User: vincent
  Date: 07/06/17
  Time: 17:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <style>
        .degrade {
            background-image:linear-gradient(#2bc5cc, #003b65);
            background-attachment: fixed;
        }
    </style>

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
          integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
          crossorigin="anonymous">

    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
            integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
            crossorigin="anonymous"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/js-cookie/2.1.4/js.cookie.min.js"></script>
    <script type="text/javascript">

        var port = window.location.port;

        function createEtu(nom, prenom, mail, semestre, cursus, niveau, login, password)
        {
            $.ajax({
                type: 'POST',
                url: 'http://localhost:' + port + '/Edt_jee_war_exploded/etudiants',
                dataType: 'json',
                data: JSON.stringify({nom: nom,
                    prenom: prenom,
                    mail: mail,
                    semestre: semestre,
                    cursus: cursus,
                    niveau: niveau,
                    login: login,
                    password: password}),
                headers:{'Authorization':'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJjYX' +
                    'Jyc3lsdiJ9.8-B-zgqci3sU0AzMfiZOfHV50MEsoT620ySXA0hf4hI'
                    ,'Content-Type':'application/json;charset=utf8',
                    'Accept':'application/json'} ,
                crossDomain: true,
                success: function (data, textStatus, xhr) {
                    console.log(xhr.status);
                    console.log(data);
                },
                error: function (xhr, textStatus, errorThrown) {
                    console.log(xhr.status);
                    console.log(textStatus);
                    console.log(errorThrown);
                }
            });
        };

        function logIn() {
            var username = document.getElementById("session_username").value;
            var password = document.getElementById("session_password").value;
            var xmlhttp = new XMLHttpRequest();

            xmlhttp.onreadystatechange = function() {
                if (xmlhttp.readyState == XMLHttpRequest.DONE ) {
                    if (xmlhttp.status == 200) {
                        data = JSON.parse(xmlhttp.responseText);
                        token = data.bearer;
                        Cookies.set('token', token);
                        window.location.href = "search.jsp"
                    }
                    else if (xmlhttp.status == 401) {
                        alert('Invalid credentials');
                    }
                    else {
                        alert('Unknown error');
                    }
                }
            };

            xmlhttp.open("POST", 'http://localhost:' + port + '/Edt_jee_war_exploded/authentification', true);
            xmlhttp.setRequestHeader('Content-Type','application/json;charset=utf8');
            xmlhttp.send(JSON.stringify({username: username, password: password}));
        }


        document.addEventListener("DOMContentLoaded", function(event) {

            document.getElementById("commit").addEventListener("click", function(e) {
                logIn();
            });

            document.getElementById("session_username").addEventListener("keypres", function(e) {
                if (e.which === 13) {
                    logIn();
                }
            })

            document.getElementById("session_password").addEventListener("keypress", function(e) {
                if (e.which === 13) {
                    logIn();
                }
            })


            /* createEtu("Berthault", "Valentin", "valentin.berthault@etu.utc.fr", "2", "GM", "branche",
            "berthval", "motdepasse") */



        });


    </script>
    <title>Login</title>
</head>
<body class="degrade">
<div class="container well" style="max-width: 610px;">

    <form class="form-horizontal" accept-charset="UTF-8">
        <fieldset>
            <legend style="font-weight: 500;">Please log in</legend>
            <div class="form-group">
                <label class="control-label col-lg-2" for="session_username">Username</label>
                <div class="col-lg-10">
                    <input class="form-control" placeholder="Username" id="session_username"/>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-lg-2" for="session_password">Password</label>
                <div class="col-lg-10">
                    <input class="form-control" placeholder="Password" type="password"
                           id="session_password"/>
                </div>
            </div>


            <div class="form-group">
                <div class="col-lg-offset-2 col-lg-10">
                    <input value="Log in" class="btn btn-default action" id="commit"/>
                </div>
            </div>

        </fieldset>
    </form>
</div>

</body>
</html>
