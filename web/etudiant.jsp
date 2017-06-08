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
        var port = window.location.port;
        var Etu = [];
        var Edt = [];
        function getEtu(id) {
            $.ajax({
                type: 'GET',
                url: 'http://localhost:' + port + '/Edt_jee_war_exploded/etudiants/' + id,
                dataType: 'json',
                headers:{'Authorization':'Bearer ' + token} ,
                crossDomain: true,
                success: function (data, textStatus, xhr) {
                    console.log(xhr.status);
                    console.log(data);
                    Etu = JSON.parse(data);
                },
                error: function (xhr, textStatus, errorThrown) {
                    console.log(xhr.status);
                    console.log(textStatus);
                    console.log(errorThrown);
                }
            });
        }

        function getEdt(id) {
            $.ajax({
                type: 'GET',
                url: 'http://localhost:' + port + '/Edt_jee_war_exploded/edt/' + id,
                dataType: 'json',
                headers:{'Authorization':'Bearer ' + token} ,
                crossDomain: true,
                success: function (data, textStatus, xhr) {
                    console.log(xhr.status);
                    console.log(data);
                    Edt = JSON.parse(data);
                },
                error: function (xhr, textStatus, errorThrown) {
                    if (xhr.status === 401) {
                        alert("Token not valid anymore. You will be redirected to login page.");
                        window.href.location("http://localhost:" + port + "/Edt_jee_war_exploded/login.jsp")
                    }
                    console.log(xhr.status);
                    console.log(textStatus);
                    console.log(errorThrown);
                }
            });
        }


        $(document).ready(function () {
            var token = Cookies.get('token');
            console.log("Token : " + token);
            var id = $('#getEtuId').val();
            getEtu(id);
            getEdt(id);
            var Data = Etu.concat(Edt);
            $("pre").text(Data);
        });

    </script>
</head>
<body>
<input type="hidden" id="getEtuId" value="<%= request.getParameter("id") %>" />

<pre></pre>
</body>
</html>
