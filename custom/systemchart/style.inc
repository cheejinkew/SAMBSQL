<style>
	body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-color: <%=bgcolor%>;
	}
	.table-title{visibility:hidden;}
	.lagenda
	{
		height:80px;
		width:200px;
		border: 1px solid darkgray;
		padding: 2px 2px 2px 2px;
		background:white;
		color:black;
	}
	.mainbox{position:absolute;top:0px;left:0px;width:100%;height:600px;background:lightblue;}
	.childbox{position:absolute;top:0px;width:210px;height:100%;background:transparent;}
	.titlebox{float:top;width:100%;height:30px;margin-bottom:3px;padding:3px 5px 3px 5px;font: bold 900 10px verdana;color:black;text-align:center;}
	.lineDIV{float:top;width:100%;margin-top:2px;margin-left:5px;}	
	.textbox{height:12px;width:90%;font: bold 500 11px verdana;float:left;padding-left:3px;}
	.separator_1{width:100%}
	.separator_2{width:100%}
	.Hline{position:absolute;z-index:4;height:2px;background:#000000;}
	.Vline{position:absolute;z-index:4;width:3px;background:#000000;}
	.HlineG{position:absolute;z-index:4;height:2px;background:#10a010;}
	.VlineG{position:absolute;z-index:4;width:3px;background:#10a010;}
	.HlineP{position:absolute;z-index:4;height:2px;background:#0000ee;}
	.VlineP{position:absolute;z-index:4;width:3px;background:#0000ee;}
	
	.up{position:absolute;z-index:4;width:25px;height:25px;background-image:url(<%=imgpath%>up.png);background-repeat:no-repeat;}
	.down{position:absolute;z-index:4;width:25px;height:25px;background-image:url(<%=imgpath%>down.png);background-repeat:no-repeat;}
	.left{position:absolute;z-index:4;width:25px;height:25px;background-image:url(<%=imgpath%>left.png);background-repeat:no-repeat;}
	.right{position:absolute;z-index:4;width:25px;height:25px;background-image:url(<%=imgpath%>blackarrow.png);background-repeat:no-repeat;}
	.Hright{position:absolute;z-index:4;width:25px;height:25px;background-image:url(<%=imgpath%>blackarrow.png);background-repeat:repeat-x;}
	.rightG{position:absolute;z-index:4;width:25px;height:25px;background-image:url(<%=imgpath%>greenarrow.png);background-repeat:no-repeat;}
	.HrightG{position:absolute;z-index:4;width:25px;height:25px;background-image:url(<%=imgpath%>greenarrow.png);background-repeat:repeat-x;}
	.rightP{position:absolute;z-index:4;width:25px;height:25px;background-image:url(<%=imgpath%>bluearrow.png);background-repeat:no-repeat;}
	.HrightP{position:absolute;z-index:4;width:25px;height:25px;background-image:url(<%=imgpath%>bluearrow.png);background-repeat:repeat-x;}
	
	a{text-decoration:none;color:black;}

</style>