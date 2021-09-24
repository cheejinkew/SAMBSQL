<style>

  a {text-decoration: none;}
  a:link { text-decoration: none;}
  a:visited { text-decoration: none;}
  a:hover { text-decoration: underline;}

  h1{font-size:16px;font-family:verdana}
  sub{font-size:10px;font-family:verdana}
  span{font-size:12px;font-family:verdana}
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
  padding:2px;
  border-width: 1px;
  border-style: solid;
  border-color: #5373A2;
  font-family:verdana;
  font-size:11px;
  }
  .tdimage
  {
  padding:3px;
  border-width: 0px;
  font-family:verdana;
  }

  .tdc_incoming{
  padding:3px;
  border-width: 1px;
  border-style: solid;
  border-color: #5373A2;
  background-color: #dcdcdc;
  color:#000000;
  font-family:verdana;
  font-size:11px;
  }

  .tdc_non{
  padding:3px;
  border-width: 1px;
  border-style: solid;
  border-color: #5373A2;
  background-color: #c0c0c0;
  color:#000000;
  font-family:verdana;
  font-size:11px;
  }

  .tdc_black{
  padding:3px;
  border-width: 1px;
  border-style: solid;
  border-color: #5373A2;
  background-color: #000000;
  color:#ffffff;
  font-family:verdana;
  font-size:11px;
  }

  .tdc_black_no{
  padding:3px;
  border-width: 1px;
  border-style: solid;
  border-color: #5373A2;
  background-color: #000000;
  color:gray;
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

  .bodytxt
  {
  font-weight: normal;
  font-size: 11px;
  color: #333333;
  line-height: normal;
  font-family: Verdana, Arial, Helvetica, sans-serif;
  }

  .centerstatus
  {
  text-align:center;
  padding:3px;
  font-family:verdana;
  font-size:11px;
  }

  .td_label{font-family: Verdana, Arial, Helvetica, sans-serif;font-size:10px;color:#5F7AFC;font-weight:bold;text-align:right}
  div#preload{font-family: Verdana, Arial, Helvetica, sans-serif;font-size:10px;color:#5F7AFC;font-weight:bold}
  div#trends {position:absolute;width:1010px;height:520px;top:40px;left:5px;background-color:white;z-index:1;border-width:1px;border-style:solid;border-color:#CBD6E4;text-align:left;visibility:visible;overflow:auto;}
  div#below {position:absolute;width:700px;height:100px;top:370px;left:250px;background-color:white;z-index:1;border-width:1px;border-style:solid;border-color:#5F7AFC;text-align:center}
  div#footnote{font-family: Verdana, Arial, Helvetica, sans-serif;font-size:11px;color:gray;text-align:left}
  div#live_logo{z-index:10;position:absolute;bottom:49px;right:40px;background:white;filter:alpha(opacity=55);-moz-opacity:.55;opacity:.55;}
  div#beta_logo{
  z-index:10;
  position:absolute;
  bottom:37px;
  right:150px;
  background:transparent;
  color:#696969;
  font-family:verdana,arial;
  font-size:12px;
  font-weight:bold;
  filter:alpha(opacity=55);-moz-opacity:.55;opacity:.55;
  }

  pre.leftmargin {margin-left: 1cm;font-family:verdana;}

  .FormDropdown2
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

  .submission_box{position:absolute;top:11px;left:850px;cursor:pointer}
  .saveexcel_box{position:absolute;top:11px;left:810px;cursor:pointer}
  .print_box{position:absolute;top:11px;left:900px;cursor:pointer}

  .report_select {position:absolute;top:10px;left:100px;}
  .report_select .title {position:absolute;top:2px;left:35px;font-family: Verdana, Arial, Helvetica, sans-serif;font-size:11px;color:#5F7AFC;font-weight:bold;text-align:right;}
  .report_select .left_arrow {position:absolute;top:4px;left:1px;cursor:pointer;visibility:hidden;}
  .report_select .right_arrow {position:absolute;top:4px;left:83px;cursor:pointer;visibility:hidden;}
  .report_select .box
  {
  position:absolute;
  top:0px;
  left:10px;
  border-width: 1px;
  border-style: solid;
  border-color: #5F7AFC;
  text-align:center;
  font-family: Verdana;
  font-size: 10pt;
  font-weight: bold;
  color: #3952F9;
  width:70px;
  height: 18px;
  visibility:hidden;
  }

  .district_select {position:absolute;top:10px;left:400px;}
  .district_select .title {position:absolute;top:2px;left:137px;font-family: Verdana, Arial, Helvetica, sans-serif;font-size:11px;color:#5F7AFC;font-weight:bold;text-align:left;}
  .district_select .left_arrow {position:absolute;top:4px;left:1px;cursor:pointer;}
  .district_select .right_arrow {position:absolute;top:4px;left:128px;cursor:pointer;}
  .district_select .box
  {
  position:absolute;
  top:0px;
  left:10px;
  border-width: 1px;
  border-style: solid;
  border-color: #5F7AFC;
  text-align:center;
  font-family: Verdana;
  font-size: 10pt;
  font-weight: bold;
  color: #3952F9;
  width:115px;
  height: 18px;
  }

  .date_select {position:absolute;top:10px;left:530px;}
  .date_select .title {position:absolute;width:85px;top:2px;left:0px;font-family: Verdana, Arial, Helvetica, sans-serif;font-size:10px;color:#5F7AFC;font-weight:bold;text-align:right;}
  .date_select .down_arrow {position:absolute;top:7px;left:223px;cursor:pointer;}
  .date_select .box1
  {
  position:absolute;
  top:-10px; /*0 */
  left:90px;
  border-width: 1px;
  border-style: solid;
  border-color: #5F7AFC;
  text-align:center;
  font-family: Verdana;
  font-size: 10pt;
  font-weight: bold;
  color: #3952F9;
  width:130px;
  height: 18px;
  visibility:hidden;
  }
  .date_select .box2
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
  width:130px;
  height: 18px;
  }

  #xloading {z-index:10;background: transparent; margin:1em;position:absolute;top:30px;left:0px;width:150px;filter:alpha(opacity=90);-moz-opacity:.90;opacity:.90;visibility:hidden}
  #xlogo {z-index:10;background: transparent; margin:1em;position:absolute;bottom:8px;right:8px;width:215px;filter:alpha(opacity=55);-moz-opacity:.55;opacity:.55;visibility:visible}
  .xtop, .xbottom {display:block; background:transparent; font-size:1px;}
  .xb1, .xb2, .xb3, .xb4 {display:block; overflow:hidden;}
  .xb1, .xb2, .xb3 {height:1px;}
  .xb2, .xb3, .xb4 {background:#fff; border-left:1px solid #CBD6E4; border-right:1px solid #CBD6E4;}
  .xb1 {margin:0 5px; background:#CBD6E4;}
  .xb2 {margin:0 3px; border-width:0 2px;}
  .xb3 {margin:0 2px;}
  .xb4 {height:2px; margin:0 1px;}
  .xboxcontent {display:block; background:#fff; border:0 solid #CBD6E4; border-width:0 1px;}

  BODY {
  SCROLLBAR-FACE-COLOR: #ffffff;
  SCROLLBAR-HIGHLIGHT-COLOR: #ffffff;
  SCROLLBAR-SHADOW-COLOR: #CBD6E4;
  SCROLLBAR-3DLIGHT-COLOR: #CBD6E4;
  SCROLLBAR-ARROW-COLOR: #CBD6E4;
  SCROLLBAR-TRACK-COLOR: #ffffff;
  SCROLLBAR-DARKSHADOW-COLOR: #ffffff;
  }
</style>