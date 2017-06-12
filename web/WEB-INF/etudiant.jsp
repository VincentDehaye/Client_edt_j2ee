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
            text-align: center;
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
            color: black;
        }

        th
        {
            background: #666;
            color: white;
            padding: 5px 10px;
            text-align: center !important;
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

        function makeEdt(array){
            for (var i = 0; i < array.length; i++) {
                switch (array[i].debut){
                    case "08:00:00":
                        var row = document.getElementById("8-10");
                        break;
                    case "10:15:00":
                        var row = document.getElementById("10-12");
                        break;
                    case "14:15:00":
                        var row = document.getElementById("14-16");
                        break;
                    case "16:15:00":
                        var row = document.getElementById("16-18");
                        break;
                }

                switch(array[i].jour){
                    case "Lundi":
                        var n = 1;
                        break;
                    case "Mardi":
                        var n = 2;
                        break;
                    case "Mercredi":
                        var n = 3;
                        break;
                    case "Jeudi":
                        var n = 4;
                        break;
                    case "Vendredi":
                        var n = 5;
                        break;
                }

                var group = false;
                switch(array[i].type) {
                    case "C":
                        var colour = "blue";
                        break;
                    case "TD":
                        var colour = "yellow";
                        group = true;
                        break;
                    case "TP":
                        var colour = "red";
                        group = true;
                        break;
                }

                var cell = row.getElementsByTagName("td")[n];
                if (group){
                    cell.innerHTML = array[i].uv + ", " + array[i].salle + ", " + array[i].groupe;
                }
                else {
                    cell.innerHTML = array[i].uv + ", " + array[i].salle;
                }
                cell.style.backgroundColor = colour;
                cell.setAttribute("title", array[i].type);

            }
        };

        function getEtu(id) {
            var xmlhttp = new XMLHttpRequest();

            xmlhttp.onreadystatechange = function() {
                if (xmlhttp.readyState == XMLHttpRequest.DONE ) {
                    if (xmlhttp.status == 200) {
                        data = JSON.parse(xmlhttp.responseText);
                        Etu = JSON.stringify(data,null,2);
                        img = document.createElement("img");
                        img.setAttribute("src", "https://demeter.utc.fr/portal/pls/portal30/portal30." +
                            "get_photo_utilisateur?username=" + data.login);
                        document.body.prepend(img);
                        div = document.getElementById("etuInfo");
                        div.innerHTML = data.prenom + " " + data.nom + ", " + data.cursus + data.semestre + ", " +
                            data.mail;
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
                        makeEdt(data);
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

<h1 id="etuInfo"></h1>


<table width="80%" align="center" >
    <div id="head_nav">
        <tr>
            <th>Time</th>
            <th>Monday</th>
            <th>Tuesday</th>
            <th>Wednesday</th>
            <th>Thursday</th>
            <th>Friday</th>

        </tr>
    </div>
    <tr id="8-10">
        <th>08:00 - 10:00</th>

        <td></td>
        <td></td>
        <td title="No Class" class="Holiday"></td>
        <td></td>
        <td></td>
        </div>
    </tr>

    <tr id="10-12">
        <th>10:15 - 12:15</td>

        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        </div>
    </tr>

    <tr id="14-16">
        <th>14:15 - 16:15</td>

        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>

        </div>
    </tr>

    <tr id="16-18">
        <th>16:30 - 18:30</td>

        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>

        </div>
    </tr>

</table>

</body>
</html>
