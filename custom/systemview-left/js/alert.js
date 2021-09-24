// SATU BETA 0.5
// add node fix

var alert_xmlHttpfeed;
var alert_arr_data;
var alert_first_fecth = true;
var alert_running = false;

function show_alert()
{
if (alert_first_fecth){
	sv_element('adisplay_title','loading alert...');
	sv_element('adisplay_lines','');
}

var url="ajx/xmlalert.aspx?xUHyk=" + Math.random()
alert_xmlHttpfeed=GetXmlHttpObject(ChangingState_1)
alert_xmlHttpfeed.open("GET", url , true)
alert_xmlHttpfeed.send(null)

	if (alert_running){
		setTimeout('show_alert()', 30000);
	}
}

function ChangingState_1() 
{
if (alert_xmlHttpfeed.readyState==4 || alert_xmlHttpfeed.readyState=="complete")
{
var total_feed = alert_xmlHttpfeed.responseXML.documentElement;
	alert_first_fecth = false;
	if (total_feed.hasChildNodes()){
		if (alert_running){
			alert_running = false;
		}
		alert_arr_data = total_feed.getElementsByTagName("site");		
		displaying(alert_arr_data.length - 1)
	}else{
		// Re-fetching data every given period if no list
		sv_element('adisplay_title','NO ALERT');
		alert_running = true;
		setTimeout('show_alert()', 30000);
	}
} 
}

function displaying(m){
	sv_element('adisplay_title','ALERT:');	
		if (navigator.userAgent.indexOf("Opera")>=0)
		{				
			document.getElementById('adisplay_lines').innerHTML= alert_arr_data[m].getAttribute("district") + " : "  + alert_arr_data[m].getAttribute("id") + " - " + alert_arr_data[m].textContent + " : " + alert_arr_data[m].getAttribute("event") + "&nbsp;&nbsp;(&nbsp;" + alert_arr_data[m].getAttribute("timestamp") + "&nbsp;)";
		}
		else if (navigator.userAgent.indexOf("MSIE")>=0)
		{ 
			document.getElementById('adisplay_lines').innerHTML= alert_arr_data[m].getAttribute("district") + " : "  + alert_arr_data[m].getAttribute("id") + " - " + alert_arr_data[m].firstChild.text + " : " + alert_arr_data[m].getAttribute("event") + "&nbsp;&nbsp;(&nbsp;" + alert_arr_data[m].getAttribute("timestamp") + "&nbsp;)";
		} 
		else if (navigator.userAgent.indexOf("Mozilla")>=0)
		{
			document.getElementById('adisplay_lines').innerHTML= alert_arr_data[m].getAttribute("district") + " : "  + alert_arr_data[m].getAttribute("id") + " - " + alert_arr_data[m].textContent + " : " + alert_arr_data[m].getAttribute("event") + "&nbsp;&nbsp;(&nbsp;" + alert_arr_data[m].getAttribute("timestamp") + "&nbsp;)";
		}
	if (m <= 0){
		setTimeout('show_alert()', 5000);
		return 0;
	}else{
		m = m - 1;
		eval("setTimeout('displaying(" + m + ")', 4000);");
	}
}