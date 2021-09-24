<style>
a {text-decoration: none;}
a:link { text-decoration: none;}
a:visited { text-decoration: none;}
a:hover { text-decoration: underline;}
h1{font-size:16px;font-family:verdana}
sub{font-size:10px;font-family:verdana}
span{font-size:12px;font-family:verdana}
.bodytxt
{
  font-weight: normal;
  font-size: 11px;
  color: #333333;
  line-height: normal;
  font-family: Verdana, Arial, Helvetica, sans-serif;
  }
.FormDropdown
{
  font-family: Verdana, Arial, Helvetica, sans-serif;
  font-size: 12px;
  color:#5F7AFC;
  width: 40px;
  border-width: 1px;
  border-style: solid;
  border-color: #CBD6E4;
 }
.inputStyle
{
  border-width: 1px;
  border-style: solid;
  border-color: #5F7AFC;
  text-align:center;
  font-family: Verdana;
  font-size: 10pt;
  color: #3952F9;
  height: 20px;
}
	.td_label{font-family: Verdana, Arial, Helvetica, sans-serif;font-size:10px;color:#5F7AFC;font-weight:bold;text-align:right}
	div#preload{font-family: Verdana, Arial, Helvetica, sans-serif;font-size:10px;color:#5F7AFC;font-weight:bold}
	div#trends {position:absolute;width:1010px;height:560px;top:40px;left:5px;background-color:white;z-index:1;border-top: 1px solid #CBD6E4;text-align:left;visibility:visible;overflow:auto;}
	div#below {position:absolute;width:700px;height:100px;top:370px;left:250px;background-color:white;z-index:1;border-width:1px;border-style:solid;border-color:#5F7AFC;text-align:center}
	div#footnote{font-family: Verdana, Arial, Helvetica, sans-serif;font-size:8px;color:#CBD6E4;text-align:right}
    div#back{position:absolute;z-index:2;width:31px;height:31px;background-image:url(http://www.g1.com.my/extension/images/back-butt.png);background-repeat:no-repeat;cursor:pointer;}
	.submission_box{position:absolute;top:11px;left:810px;cursor:pointer}
	.saveexcel_box{position:absolute;top:11px;left:870px;cursor:pointer}
	.print_box{position:absolute;top:11px;left:950px;cursor:pointer}
	.report_select {position:absolute;top:10px;left:530px;}
	.report_select .title {position:absolute;top:2px;left:15px;font-family: Verdana, Arial, Helvetica, sans-serif;font-size:10px;color:#5F7AFC;font-weight:bold;text-align:right;}
	.report_select .left_arrow {position:absolute;top:6px;left:54px;cursor:pointer;}
	.report_select .right_arrow {position:absolute;top:6px;left:245px;cursor:pointer;}
.report_select .box
{
  position:absolute;
  top:0px;
  left:65px;
  border-width: 1px;
  border-style: solid;
  border-color: #5F7AFC;
  text-align:center;
  font-family: Verdana;
  font-size: 10pt;
  font-weight: bold;
  color: #3952F9;
  width:170px;
  height: 18px;
  }
.date_select {position:absolute;top:10px;left:320px;}
.date_select .title {position:absolute;width:85px;top:2px;left:0px;font-family: Verdana, Arial, Helvetica, sans-serif;font-size:10px;color:#5F7AFC;font-weight:bold;text-align:right;}
.date_select .cal {position:absolute;top:2px;left:195px;cursor:pointer;}
.date_select .box
{
  position:absolute;
  top:0px;
  left:90px;
  border-width: 1px;
  border-style: solid;
  border-color: #5F7AFC;
  text-align:center;
  font-family: Verdana;
  font-size: 10pt;
  font-weight: bold;
  color: #3952F9;
  width:100px;
  height: 18px;
  }
.dist_select {position:absolute;top:10px;left:220px;}
.dist_select .title {position:absolute;width:85px;top:2px;left:50px;font-family: Verdana, Arial, Helvetica, sans-serif;font-size:10px;color:#5F7AFC;font-weight:bold;text-align:right;}
.dist_select .Dropdown
{
  position:absolute;
  top:0px;
  left:140px;
  border-width: 0px;
  border-style: solid;
  border-color: #5F7AFC;
  text-align:center;
  font-family: Verdana;
  font-size: 8pt;
  font-weight: bold;
  color: #3952F9;
  width:130px;
  height: 18px;
  }
/* ============== Report Table Styling Starts Here ============== */
div#tbl-container {
width: 99%;
height: 81%;
overflow:scroll;
scrollbar-color:#336699;
}
table {
table-layout:fixed;
border-collapse:collapse;
background-color: White;
}
div#tbl-container table th {}
thead th, thead th.locked{
font-size: 11px;
font-weight: bold;
text-align: center;
color: white;
position:relative;
cursor: default; 
}	
thead th {
top: expression(document.getElementById("tbl-container").scrollTop-2); /* IE5+ only */
z-index: 20;
}
thead th.locked {z-index: 30;}
td.locked,  th.locked
{
padding: 1px 1px 1px 1px;
font-size: 11px;
border:1px solid #336699;
background-color: White;
left: expression(parentNode.parentNode.parentNode.parentNode.scrollLeft); /* IE5+ only */
position: relative;
z-index: 10;
}
/*these styles have nothing to do with the locked column*/
body.report{
margin-top:10px;
background-color: white;
color: black;
font-family: Verdana, Arial, Helvetica, sans-serif;
}
th{
  padding-left:3px;
  padding-right:3px;
  border-width: 1px;
  border-style: solid;
  border-color: #5373A2;
  font-family:verdana;
  font-size:13px;
  }
 .tdc{
  padding:3px;
  border-width: 1px;
  border-style: solid;
  border-color: #5373A2;
  font-family:verdana;
  font-size:11px;
  }
 .tdo{
  padding:3px;
  font-family:verdana;
  font-size:11px;
  }
 .tbl_1{
  border-spacing: 2px;
  border-collapse: collapse;
  background-color: white;
  }
.td_head
{
padding: 1px 1px 1px 5px;
font-size: 11px;
border:1px solid #336699;
font-weight: bold;
text-align:left;
color:black;
}
.td_data 
{
padding: 1px 1px 1px 1px;
font-size: 11px;
border:1px solid #336699;
}
.td_column_title
{
padding: 1px 1px 1px 1px;
font-size: 11px;
border:1px solid #336699;
font-weight: bold;
text-align:center;
color:black;
}
button {
width: 150px; 
font-weight: bold;
color: navy;
margin-bottom: 5px;
}
div.infobox {
position:absolute; 
top:110px; 
left:470px; 
right:5px; 
border: double 4px #6633ff;
padding:8px; 
font-size:12px; 
font-family:Arial, sans-serif; 
text-align:justify; 
text-justify:newspaper; 
background-color:white;
}
blockquote	{
font-family: Tahoma, Verdana, sans-serif;
font-size: 85%;
border: double 4px #6633ff;
padding: 8px 20px;
margin: 3% auto auto 0;
background-color: white;
width: 418px;
}
.sig{
color:#6633ff;
font-style: italic;
letter-spacing: 2px;
}
/* ============== Report Table Styling Ends Here ============== */
</style>