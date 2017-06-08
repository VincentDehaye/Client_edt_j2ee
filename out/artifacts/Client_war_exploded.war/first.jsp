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
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script type="text/javascript">

        $(document).ready(function () {

            $.ajax({
                type: 'GET',
                url: 'http://redrock.com:6606/api/values/get',

                dataType: "jsonp",

                crossDomain: true,
                success: function (msg) {

                    alert("success");

                },
                error: function (request, status, error) {

                    alert(error);
                }
            });
        });

    </script>
    <title>First</title>
</head>
<body>
Bonjour
Ceci est une page générée depuis une JSP
</body>
</html>
