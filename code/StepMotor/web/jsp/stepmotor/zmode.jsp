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

            function changeMode(mode,which){
                window.self.location="../../modeControl?which="+which+"&mode="+mode;
            }
            
            function init(){
                zmode ="<%=application.getAttribute("zmode")%>";
                document.dataz.mode[zmode].checked=true;
            }
        </script>

        <%

        if(application.getAttribute("zmode")==null){
	Integer zmode = new Integer("0");
	application.setAttribute("zmode",zmode);
        }
        %>

    </head>
    <body onload="init()">
        <form name="dataz">

            <input type="radio" name="mode" value="0"

                   onclick="changeMode(document.dataz.mode[0].value,'z')"/>

            模式1
            <input type="radio" name="mode" value="1"

                   onclick="changeMode(document.dataz.mode[1].value,'z')"/>模式2
            <input type="radio" name="mode" value="2"

                   onclick="changeMode(document.dataz.mode[2].value,'z')"/>模式3
            <br/>
            <input type="radio" name="mode" value="3"

                   onclick="changeMode(document.dataz.mode[3].value,'z')"/>模式4
            <input type="radio" name="mode" value="4"

                   onclick="changeMode(document.dataz.mode[4].value,'z')"/>模式5
            <input type="radio" name="mode" value="5"

                   onclick="changeMode(document.dataz.mode[5].value,'z')"/>模式6
            
        </form>
    </body>
</html>
