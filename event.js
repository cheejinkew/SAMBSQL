// Customised for SATU's Event handler

function popup(url,width,height)
{
	eval("window.open('" + url + "','Reports', 'left=0,top=0,width=" + width + ",height=" + height + ",location=no,resizable=yes,menubar=0,toolbar=0,scrollbars=1');");
}

function getwinsize(para){
	var winW = 100, winH = 100;
	if (parseInt(navigator.appVersion)>3) {
	if (navigator.appName=="Netscape") {
	winW = window.innerWidth;
	winH = window.innerHeight;
	}
	if (navigator.appName.indexOf("Microsoft")!=-1) {
	winW = document.body.offsetWidth;
	winH = document.body.offsetHeight;
	}
	}

	if (parseInt(navigator.appVersion)>3) {
	if (navigator.appName=="Netscape") {
	winW = window.innerWidth;//-16;
	winH = window.innerHeight;//-16;
	}
	if (navigator.appName.indexOf("Microsoft")!=-1) {
	winW = document.body.offsetWidth;//-20;
	winH = document.body.offsetHeight;//-20;
	}
	}

	if (navigator.userAgent.indexOf("Opera")>=0)
	{
	winW = document.body.offsetWidth;
	winH = document.body.offsetHeight;
	}
	
	if (para=='height'){
		return winH;
	}else{
		return winW;
	}
}