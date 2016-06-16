<HTML>
	<HEAD>
		<TITLE>???????????????</TITLE>
		<META NAME="Generator" CONTENT="EditPlus">
		<META NAME="Author" CONTENT="">
		<META NAME="Keywords" CONTENT="">
		<META NAME="Description" CONTENT="">
		<script language="javascript">
	var objContainsDiv;
	var objTrackBar;
	var objTrackPath;
	var objScaleDiv;
	var scaleNumber = 100;
	var scaleLenth; // ????
	var vLeft;
	var vaildLength; // ???????????
	function contentLoad() {window.history.forward(1);
		objContainsDiv = trackDiv;// ??
		objTrackBar = createTrack();
		objTrackBar = objContainsDiv.appendChild(objTrackBar);

		objTrackPath = trackDegree;
		objTrackBar.onmousedown = trackBarBeforeMove;
		objTrackBar.onmouseup = trackBeforeMouseup;
		objTrackPath.onclick = setPos;

		vaildLength = parseInt(objContainsDiv.offsetWidth)
				- parseInt(objTrackBar.offsetWidth) - 2;
		scaleLenth = Math.round(parseInt(objContainsDiv.offsetWidth)
				/ scaleNumber);

		// ???????
<!--		for ( var i = 0; i < scaleNumber - 1; i++) {-->
<!--			objScaleDiv = this.document-->
<!--					.createElement("<div style='position:absolute;left:50;top:13;font-size:4pt;font-weight:lighter;color:#999999;width:3:'/>");-->
<!--			objScaleDiv = objContainsDiv.appendChild(objScaleDiv);-->
<!--			with (objScaleDiv) {-->
<!--				style.left = scaleLenth * (i + 1);-->
<!--				innerText = "|";-->
<!--			}-->
<!--		}-->
	}

	function createTrack() { // ?????
		var objBarContainsDiv;
		objBarContainsDiv = this.document
				.createElement("<div style='position:absolute;left:0;top:0;height:16;width:11;z-index:2;'/>");

		// ??????
		var objBarTop = this.document
				.createElement("<div style='position:absolute;left:0;top:0;height:10;width:11;font-size:1px;border-top:solid 1px #999999;border-right:solid 1px #666666;border-left:solid 1px #cccccc;z-index:2;background:#cccccc;'>");
		objBarTop = objBarContainsDiv.appendChild(objBarTop);
		var objPointDiv;
		var iScale = 0;
		for ( var i = 0; i < 6; i++) { // ???????????????
			objPointDiv = this.document
					.createElement("<div style='position:absolute;background:red;font-size:1px;z-index:2;border-right:solid 1px #990000;'>");
			iScale = i + 1;
			with (objPointDiv) {
				style.left = iScale;
				style.top = parseInt(objBarTop.style.pixelHeight)
						+ (iScale - 1);
				if ((parseInt(objBarTop.style.pixelWidth) - 2 * iScale) < 0) {
					break;
				}
				style.width = parseInt(objBarTop.style.pixelWidth) - 2 * iScale;
			}
			objPointDiv = objBarContainsDiv.appendChild(objPointDiv);
		}

		return objBarContainsDiv;

	}

	function setPos() { // ??????????????

		trackBeforeMove();
		trackLevel.innerText = Math.round(parseInt(objTrackBar.style.left)
				* 100 / vaildLength)
				+ "%";// ?????
	}

	function trackBarBeforeMove() { // ?????????
		vLeft = window.event.x - objTrackBar.style.pixelLeft;
		objTrackBar.style.background = "#dddddd";// ??
		objTrackBar.setCapture(); // ??
		objTrackBar.attachEvent("onmousemove", trackBeforeMove); // ????????
	}

	function trackBeforeMove() {// ?????

		var leftPoint;
		var pointDividLength;
		var vMousePositionX;
		if ((event.x - objContainsDiv.offsetLeft - 8) > vaildLength
				|| event.x < objContainsDiv.offsetLeft)
			return;

		vMousePositionX = parseInt(event.x) - objContainsDiv.offsetLeft;
		leftPoint = Math.floor(vMousePositionX / scaleLenth);// ????????
		pointDividLength = leftPoint * scaleLenth + scaleLenth / 2;
		window.status = "leftPoint:" + leftPoint + " [vMousePositionX:"
				+ vMousePositionX + " pointDividLength:" + pointDividLength
				+ "]";
		if (vMousePositionX < pointDividLength) { // ??????
			objTrackBar.style.left = leftPoint * scaleLenth;
		}
		if (vMousePositionX > pointDividLength) { // ??????
			objTrackBar.style.left = (leftPoint + 1) * scaleLenth;
		}

		if (parseInt(objTrackBar.style.left) > vaildLength) {// ??????
			objTrackBar.style.left = vaildLength;
		}

		if (parseInt(objTrackBar.style.left) < 0) { // ??????
			objTrackBar.style.left = 0;
		}

		trackLevel.innerText = Math.round(parseInt(objTrackBar.style.left)
				* 100 / vaildLength)
				+ "%";
	}

	function trackBeforeMouseup() { // ?????????
		if (parseInt(trackLevel.innerText.replace("%", "")) > 100) {
			objTrackBar.style.left = vaildLength;
			trackLevel.innerText = "100%"; // ????????100
		} else if (parseInt(trackLevel.innerText.replace("%", "")) < 0) {
			objTrackBar.style.left = 0;
			trackLevel.innerText = "0%"; // ????????0
		}
		document.write(vLeft);
		objTrackBar.detachEvent("onmousemove", trackBeforeMove);// ??????
		objTrackBar.style.background = "#cccccc"; // ?????
		objTrackBar.releaseCapture(); // ????
	}
</script>
	</HEAD>
	<BODY onload="contentLoad()">
		<div id="trackDiv"
			style="position: absolute; left: 10; top: 50; border: solid 0px #cccccc; width: 700; height: 23; background: #dddddd;">
			<hr id="trackDegree" size="1" color="#cccccc"
				style="position: absolute; top: 16; height: 3; border: groove 1px #eeeeee; background: #666666; z-index: 1;">
		</div>
		<span id="trackLevel"
			style="position: absolute; left: 10; top: 30; width: 50; font-size: 9pt; color: red;">0%
		</span>
	</BODY>
</HTML>
