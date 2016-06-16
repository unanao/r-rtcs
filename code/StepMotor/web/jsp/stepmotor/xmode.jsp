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
                var start=new Date().getTime()
                window.self.location="../../modeControl?which="+which+"&mode="+mode;
                var end=new Date().getTime();
                alert(end-start+"ms");
            }
            function init(){
                xmode ="<%=application.getAttribute("xmode")%>";
               
                document.datax.mode[xmode].checked=true;
            }
        </script>

        <%


        if(application.getAttribute("xmode")==null){
	Integer xmode = new Integer("0");
	application.setAttribute("xmode",xmode);
        }
        %>

    </head>
    <body onload="init()">
        <form name="datax">

            <input type="radio" name="mode" value="0"

                   onclick="changeMode(document.datax.mode[0].value,'x')"/>

            模式1
            <input type="radio" name="mode" value="1"

                   onclick="changeMode(document.datax.mode[1].value,'x')"/>模式2
            <input type="radio" name="mode" value="2"

                   onclick="changeMode(document.datax.mode[2].value,'x')"/>模式3
            <br/>
            <input type="radio" name="mode" value="3"

                   onclick="changeMode(document.datax.mode[3].value,'x')"/>模式4
            <input type="radio" name="mode" value="4"

                   onclick="changeMode(document.datax.mode[4].value,'x')"/>模式5
            <input type="radio" name="mode" value="5"

                   onclick="changeMode(document.datax.mode[5].value,'x')"/>模式6
            
        </form>
    </body>
</html>
