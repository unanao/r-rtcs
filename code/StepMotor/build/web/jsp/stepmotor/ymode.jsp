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
                ymode ="<%=application.getAttribute("ymode")%>";
                document.datay.mode[ymode].checked=true;
            }
        </script>

        <%

        if(application.getAttribute("ymode")==null){
	Integer ymode = new Integer("0");
	application.setAttribute("ymode",ymode);
        }
          %>

    </head>
    <body onload="init()">
        <form name="datay">

            <input type="radio" name="mode" value="0"

                   onclick="changeMode(document.datay.mode[0].value,'y')"/>

            模式1
            <input type="radio" name="mode" value="1"

                   onclick="changeMode(document.datay.mode[1].value,'y')"/>模式2
            <input type="radio" name="mode" value="2"

                   onclick="changeMode(document.datay.mode[2].value,'y')"/>模式3
            <br/>
            <input type="radio" name="mode" value="3"

                   onclick="changeMode(document.datay.mode[3].value,'y')"/>模式4
            <input type="radio" name="mode" value="4"

                   onclick="changeMode(document.datay.mode[4].value,'y')"/>模式5
            <input type="radio" name="mode" value="5"

                   onclick="changeMode(document.datay.mode[5].value,'y')"/>模式6
            
        </form>
    </body>
</html>
