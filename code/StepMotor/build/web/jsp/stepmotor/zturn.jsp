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
                zturn ="<%=application.getAttribute("zturn")%>";
                document.dataz.turn[zturn].checked=true;
            }
        </script>

        <%
            if (application.getAttribute("zturn") == null) {
                Integer zturn = new Integer("0");
                application.setAttribute("zturn", zturn);
            }
        %>

    </head>
    <body onload="init()">
        <form name="dataz">

            
            <input type="radio" name="turn" value="s" onclick="changeTurn(document.dataz.turn[0].value,'z')" />

            启动
            <input type="radio" name="turn" value="e"

                   onclick="changeTurn(document.dataz.turn[1].value,'z')"/>停止
            <br/><br/>
        </form>
    </body>
</html>
