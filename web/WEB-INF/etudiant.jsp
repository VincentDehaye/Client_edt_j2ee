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
            $.ajax({
                type: 'GET',
                url: 'http://localhost:' + port + '/Edt_jee_war_exploded/etudiants/' + id,
                dataType: 'json',
                headers:{'Authorization':'Bearer ' + token} ,
                crossDomain: true,
                success: function (data, textStatus, xhr) {
                    Etu = JSON.stringify(data,null,2);
                    $("#pre1").text(Etu);
                    $("body").prepend("<img src='https://demeter.utc.fr/portal/pls/portal30/portal30." +
                        "get_photo_utilisateur?username=" + data.login + "'/>");
                    //getEtuPhoto(data.login);
                },
                error: function (xhr, textStatus, errorThrown) {
                    if (xhr.status === 401) {
                        alert("Token not valid anymore. You will be redirected to login page.");
                        window.location.href = ("http://localhost:" + port + "/Client_war_exploded/login.jsp")
                    }
                    console.log(xhr.status);
                    console.log(textStatus);
                    console.log(errorThrown);
                }
            });
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
            $.ajax({
                type: 'GET',
                url: 'http://localhost:' + port + '/Edt_jee_war_exploded/edt/' + id,
                dataType: 'json',
                headers:{'Authorization':'Bearer ' + token} ,
                crossDomain: true,
                success: function (data, textStatus, xhr) {
                    Edt = JSON.stringify(data, null, 2);
                    $("#pre2").text(Edt);
                },
                error: function (xhr, textStatus, errorThrown) {
                    if (xhr.status === 401) {
                        alert("Token not valid anymore. You will be redirected to login page.");
                        window.location.href = ("http://localhost:" + port + "/Client_war_exploded/login.jsp")
                    }
                    console.log(xhr.status);
                    console.log(textStatus);
                    console.log(errorThrown);
                }
            });
        }

        $(document).ready(function () {
            var id = $('#getEtuId').val();
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
