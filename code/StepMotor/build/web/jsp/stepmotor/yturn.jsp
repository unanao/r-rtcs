<!--
To change this template, choose Tools | Templates
and open the template in the editor.
-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title>???????????????</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript">

            function changeTurn(turn,which){
                window.self.location="../../turnControl?which="+which+"&turn="+turn;
            }
            function init(){
                 yturn ="<%=application.getAttribute("yturn")%>";
                document.datay.turn[yturn].checked=true;
            }
        </script>

        <%
            if (application.getAttribute("yturn") == null) {
                Integer yturn = new Integer("0");
                application.setAttribute("yturn", yturn);
            }
           
        %>

    </head>
    <body onload="init()">
        <form name="datay">

            
            <input type="radio" name="turn" value="s" onclick="changeTurn(document.datay.turn[0].value,'y')"/>

            启动
            <input type="radio" name="turn" value="e"

                   onclick="changeTurn(document.datay.turn[1].value,'y')"/>停止
           
        </form>
    </body>
</html>
