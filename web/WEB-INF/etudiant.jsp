<%--
  Created by IntelliJ IDEA.
  User: vincent
  Date: 08/06/17
  Time: 17:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Student</title>

    <style type="text/css">
        body
        {
            font-family: arial;
        }

        th,td
        {
            margin: 0;
            text-align: center;
            border-collapse: collapse;
            outline: 1px solid #e3e3e3;
        }

        td
        {
            padding: 5px 10px;
        }

        th
        {
            background: #666;
            color: white;
            padding: 5px 10px;
        }

        td:hover
        {
            cursor: pointer;
            background: #666;
            color: white;
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
        var Etu = JSON.stringify("");
        var Edt = JSON.stringify("");

        function getEtu(id) {
            var xmlhttp = new XMLHttpRequest();

            xmlhttp.onreadystatechange = function() {
                if (xmlhttp.readyState == XMLHttpRequest.DONE ) {
                    if (xmlhttp.status == 200) {
                        data = JSON.parse(xmlhttp.responseText);
                        Etu = JSON.stringify(data,null,2);
                        document.getElementById("pre1").innerHTML = Etu;
                        img = document.createElement("img");
                        img.setAttribute("src", "https://demeter.utc.fr/portal/pls/portal30/portal30." +
                            "get_photo_utilisateur?username=" + data.login);
                        document.body.prepend(img);
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

            xmlhttp.open("GET",'http://localhost:' + port + '/Edt_jee_war_exploded/etudiants/' + id, true);
            xmlhttp.setRequestHeader('Authorization','Bearer ' + token);
            xmlhttp.send();
        }


        /*function getEtuPhoto(login) {
            $.ajax({
                type: 'GET',
                url: "https://demeter.utc.fr/portal/pls/portal30/portal30.get_photo_utilisateur?username=" + login,
                crossDomain: true,
                success: function (data, textStatus, xhr) {
                    console.log(data);
                    console.log(typeof(data));
                },
                error: function (xhr, textStatus, errorThrown) {
                    console.log(xhr.status);
                    console.log(textStatus);
                    console.log(errorThrown);
                }
            });
        }*/

        function getEdt(id) {
            var xmlhttp = new XMLHttpRequest();

            xmlhttp.onreadystatechange = function() {
                if (xmlhttp.readyState == XMLHttpRequest.DONE ) {
                    if (xmlhttp.status == 200) {
                        data = JSON.parse(xmlhttp.responseText);
                        Edt = JSON.stringify(data, null, 2);
                        document.getElementById("pre2").innerHTML = Edt;
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

            xmlhttp.open("GET",'http://localhost:' + port + '/Edt_jee_war_exploded/edt/' + id, true);
            xmlhttp.setRequestHeader('Authorization','Bearer ' + token);
            xmlhttp.send();
        }


        document.addEventListener("DOMContentLoaded", function(event) {
            var id = document.getElementById("getEtuId").value;
            if (id === "null") {
                window.location.href = ("http://localhost:" + port + "/Client_war_exploded/search.jsp")
            }
            getEtu(id);
            getEdt(id);
        });

    </script>
</head>
<body>
<input type="hidden" id="getEtuId" value="<%= request.getParameter("id") %>" />

<pre id="pre1"></pre>
<pre id="pre2"></pre>


</body>
</html>
