// JScript File
var ns4=document.layers
var ie4=document.all
var ns6=document.getElementById&&!document.all

//drag drop function for NS 4////
/////////////////////////////////

var dragswitch=0
var nsx
var nsy
var nstemp

function drag_dropns(name){
if (!ns4)
return
temp=eval(name)
temp.captureEvents(Event.MOUSEDOWN | Event.MOUSEUP)
temp.onmousedown=gons
temp.onmousemove=dragns
temp.onmouseup=stopns
}

function gons(e){
temp.captureEvents(Event.MOUSEMOVE)
nsx=e.x
nsy=e.y
}
function dragns(e){
if (dragswitch==1){
temp.moveBy(e.x-nsx,e.y-nsy)
return false
}
}

function stopns(){
temp.releaseEvents(Event.MOUSEMOVE)
}

//drag drop function for ie4+ and NS6////
/////////////////////////////////


function drag_drop(e){
if (ie4&&dragapproved){
crossobj.style.left=tempx+event.clientX-offsetx
crossobj.style.top=tempy+event.clientY-offsety
return false
}
else if (ns6&&dragapproved){
crossobj.style.left=tempx+e.clientX-offsetx+"px"
crossobj.style.top=tempy+e.clientY-offsety+"px"
return false
}
}

function initializedrag(e){
crossobj=ns6? document.getElementById("mydiv") : document.all.mydiv
var firedobj=ns6? e.target : event.srcElement
var topelement=ns6? "html" : document.compatMode && document.compatMode!="BackCompat"? "documentElement" : "body"
while (firedobj.tagName!=topelement.toUpperCase() && firedobj.id!="dragbar"){
firedobj=ns6? firedobj.parentNode : firedobj.parentElement
}

if (firedobj.id=="dragbar"){
offsetx=ie4? event.clientX : e.clientX
offsety=ie4? event.clientY : e.clientY

tempx=parseInt(crossobj.style.left)
tempy=parseInt(crossobj.style.top)

dragapproved=true
document.onmousemove=drag_drop
}
}
document.onmouseup=new Function("dragapproved=false")
//Drag drop ends here


document.onclick=check; 
function check(e){ 
var target = (e && e.target) || (event && event.srcElement); 
var obj = document.getElementById('mydiv'); 
//var frm=document.getElementById('frmSrc');
//var imgl=document.getElementById('divWait');
if (checkParent(target))
{
obj.style.display='none';
//imgl.innerHTML ='<img border="0" src="../images/loading.gif"><b>Loading...</b>';
//frm.src="";
}
//Showdiv()
} 

function checkParent(t){ 
while(t.parentNode){ 

if(t==document.getElementById('mydiv'))
{ 
return false 
} 
t=t.parentNode 
} 
return true 
} 
//function stopload()
//{
//document.getElementById('divWait').innerHTML ="<b></b>";
//}
//function startload()
//{

//document.getElementById('divWait').innerHTML ='<img border="0" src="../images/loading.gif"><b>Loading...</b>';
//}
function closediv()
{
document.getElementById('mydiv').style.display='none';
//document.getElementById('divWait').innerHTML ='<img border="0" src="../images/loading.gif"><b>Loading...</b>';
//document.getElementById('frmSrc').src="";
}
function Showdiv()
{

document.getElementById('mydiv').style.display='block';
//document.getElementById('divWait').innerHTML ='<img border="0" src="../images/loading.gif"><b>Loading...</b>';
//document.getElementById('frmSrc').src="";
}

//function ShowGraph(sid,sname,dist,stype,ename,pos)
//{

//document.getElementById('divWait').innerHTML ='<img border="0" src="../images/loading.gif"><b>Loading...</b>';
//document.getElementById('mydiv').style.display='block';
//document.getElementById('frmSrc').src="CascadeTSelection.aspx?siteid=" + sid + "&sitename=" + sname + "&district=" + dist + "&sitetype=" + stype + "&equipname=" + ename + "&position=" + pos + "";
//}
