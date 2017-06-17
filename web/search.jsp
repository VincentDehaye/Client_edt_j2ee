<%--
  Created by IntelliJ IDEA.
  User: vincent
  Date: 08/06/17
  Time: 16:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Search</title>

    <style>
        .degrade {
            background-image: linear-gradient(#2bc5cc, #003b65);
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/js-cookie/2.1.4/js.cookie.min.js"></script>
    <script type="text/javascript">

        var token = Cookies.get('token');
        var port = window.location.port;

        function makeList(array, root) {
            if (typeof root === 'undefined') {
                root = document.getElementById("list-container");
            }
            var ul = document.createElement("ul");
            ul.setAttribute("class", "list-group");
            root.appendChild(ul);
            for (var i = 0; i < array.length; i++) {
                var a = document.createElement("a");

                a.setAttribute("href",
                    'http://localhost:' +
                    port +
                    '/Client_war_exploded/etudiant?id=' +
                    array[i].idEtudiant);

                a.setAttribute('class', 'list-group-item');

                a.innerHTML = array[i].nom + ", " + array[i].prenom + ", " +
                    array[i].cursus + array[i].semestre;

                ul.appendChild(a);
                /*var pre = $("<pre>" + JSON.stringify(array[i], null, 2) + "</pre>");
                 li.append(pre);
                 a.click(function() {
                 window.location.href = "http://localhost:28080/Client_war_exploded/etudiant.jsp&id=" + array[i].id;
                 });

                 if(typeof array[i].subMenu !== 'undefined'){
                 makeList(array[i].subMenu, li);
                 }*/
            }
        }

        function search(token) {
            var searched_login = document.getElementById("login").value;
            var xmlhttp = new XMLHttpRequest();

            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == XMLHttpRequest.DONE) {
                    if (xmlhttp.status == 200) {
                        data = JSON.parse(xmlhttp.responseText);
                        list = document.getElementById("list-container");
                        while (list.firstChild) {
                            list.removeChild(list.firstChild);
                        }
                        makeList(data);
                    }
                    else if (xmlhttp.status == 401) {
                        alert("Token not valid anymore. You will be redirected to login page.");
                        window.location.href = ("http://localhost:" + port + "/Client_war_exploded/login.jsp")
                    }
                    else {
                        alert('Unknown error');
                    }
                }
            };

            xmlhttp.open("POST", 'http://localhost:' + port + '/Edt_jee_war_exploded/etudiants/search', true);
            xmlhttp.setRequestHeader('Content-Type', 'application/json;charset=utf8');
            xmlhttp.setRequestHeader('Authorization', 'Bearer ' + token);
            xmlhttp.send(JSON.stringify({login: searched_login}));
        }


        document.addEventListener("DOMContentLoaded", function (event) {
            console.log("Token : " + token);
            document.getElementById("search").addEventListener("click", function (e) {
                search(token);
            });

            document.getElementById("login").addEventListener("keypress", function (e) {
                if (e.which === 13) {
                    search(token);
                }
            });

            document.getElementsByTagName("button")[0].addEventListener("click", function (e) {
                Cookies.remove('token')
                window.location.href = ("http://localhost:" + port + "/Client_war_exploded/login.jsp")
            });

        });
    </script>
</head>
<body class="degrade">
<div class="row">
    <div class="col-sm-12">
        <div class="text-center">
            <div class="form-group">
                <button type="button" class="btn btn-danger">Log out</button>
            </div>
        </div>
    </div>
</div>


<div class="container well" style="max-width: 610px;" id="search_div">

    <form class="form-horizontal" accept-charset="UTF-8">
        <fieldset>
            <legend style="font-weight: 500;">Search for a student</legend>
            <div class="form-group">
                <label class="control-label col-lg-2" for="login">Login</label>
                <div class="col-lg-10">
                    <input class="form-control" placeholder="Login" id="login"/>
                </div>
            </div>

            <div class="form-group">
                <div class="col-lg-offset-2 col-lg-10">
                    <input value="Search" class="btn btn-default action" id="search"/>
                </div>
            </div>

        </fieldset>
    </form>
</div>

<div id="list-container">

</div>

</body>
</html>
