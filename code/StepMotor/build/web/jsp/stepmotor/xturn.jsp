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
                xturn ="<%=application.getAttribute("xturn")%>";
                document.datax.turn[xturn].checked=true;
               
            }
        </script>

        <%
            if (application.getAttribute("xturn") == null) {
                Integer xturn = new Integer("0");
                application.setAttribute("xturn", xturn);
            }

        %>

    </head>
    <body onload="init()">
        <form name="datax">

            
            <input type="radio" name="turn" value="s" onclick="changeTurn(document.datax.turn[0].value,'x')"/>

            启动
            <input type="radio" name="turn" value="e"

                   onclick="changeTurn(document.datax.turn[1].value,'x')"/>停止
            <br/><br/>
        </form>
    </body>
</html>
