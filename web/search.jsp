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
        function makeList(array, root){
            if(typeof root === 'undefined'){
                root = $('#list-container');
            }
            var ul = $("<ul></ul>");
            root.append(ul);
            for (var i = 0; i < array.length; i++) {
                var li = $("<li></li>");
                ul.append(li);
                var pre = $("<pre>" + JSON.stringify(array[i], null, 2) + "</pre>");
                li.append(pre);
                /*a.click(function() {
                    window.location.href = "http://localhost:28080/Client_war_exploded/etudiant.jsp&id=" + array[i].id;
                });

                if(typeof array[i].subMenu !== 'undefined'){
                    makeList(array[i].subMenu, li);
                }*/
            }
        }

        function search(token) {
            var searched_login = $('#login').val();
            $.ajax({
                type: 'POST',
                url: 'http://localhost:28080/Edt_jee_war_exploded/etudiants/search',
                dataType: 'json',
                data: JSON.stringify({login: searched_login}),
                headers:{'Authorization':'Bearer ' + token,
                    'Content-Type':'application/json;charset=utf8'} ,
                crossDomain: true,
                success: function (data, textStatus, xhr) {
                    console.log(xhr.status);
                    console.log(data);
                    console.log(data.length);
                    $('#list-container').html("");
                    makeList(data);
                },
                error: function (xhr, textStatus, errorThrown) {
                    if (xhr.status === 401) {
                        alert("Token not valid anymore. You will be redirected to login page.");
                        window.href.location("http://localhost:28080/Edt_jee_war_exploded/login.jsp")
                    }
                    console.log(xhr.status);
                    console.log(textStatus);
                    console.log(errorThrown);
                }
            });
        }

        $(document).ready(function() {
            var token = Cookies.get('token');
            console.log("Token : " + token);
            $("#search").click(function(e) {
                search(token);
            });

            $("#login").keypress(function(e) {
                if (e.which === 13) {
                    search(token);
                }
            });

        });
    </script>
</head>
<body>
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
