<%@ Page Language="VB" Debug="false" %>

<%@ Import Namespace="ADODB" %>
<%
    Dim objConn
    Dim sqlRs
    Dim strConn
    Dim Tmconn = "DSN=g1;UID=tmp;PWD=tmp;"
    Dim district = "Melaka"
    Dim sitetype = Request("Type")
  
    Dim strSiteName
    Dim siteid
    Dim sqlRs1
    
%>
<!--#include file="report_head.aspx"-->
<html>
<head>
    <title>Summary Page</title>
    <style type="text/css">/* Show only to IE PC \*/
* html .boxhead h2 {height: 1%;} /* For IE 5 PC */
 
.sidebox {
	margin: 0 auto; /* center for now */
	width:450px; /* ems so it will grow */
	background: url(images/sbbody-r.gif) no-repeat bottom right;
	font-size: 100%;
}
.boxhead {
	background: url(images/sbhead-r.gif) no-repeat top right;
	margin: 0;
	padding: 0;
	text-align: center;
}
.boxhead h2 {
	background: url(images/sbhead-l.gif) no-repeat top left;
	margin: 0;
	padding: 22px 30px 5px;
	color: white; 
	font-weight: bold; 
	font-size: 1.2em; 
	line-height: 1em;
	text-shadow: rgba(0,0,0,.4) 0px 2px 5px; /* Safari-only, but cool */
}
.boxbody {
	background: url(images/sbbody-l.gif) no-repeat bottom left;
	margin: 0;
	padding: 5px 5px 31px;
}
.tablehead {

}

.inputStyle
{
  border-width: 1px;
  border-style: solid;
  border-color: #5F7AFC;
  font-family: Verdana;
  font-size: 10pt;
  color: #3952F9;
  height: 20px
}
.td_label{font-family: Verdana, Arial, Helvetica, sans-serif;font-size:12px;color:#5F7AFC;font-weight:bold;text-align:right}
</style>
</head>
<body>
    <div>
        <%--<table width="200" border="0">
            <tr>
                <td class="td_label">
                    District : Besut
                </td>
            </tr>
        </table>--%>
        <br />
        <center>
            <table style="font-family: Verdana; font-size: 11px;" cellpadding="0" cellspacing="0"
                border="0">
                <tr>
                    <td>
                        <div class="sidebox">
                            <div class="boxhead">
                                <h2>
                                    Sites Summary<br />
                                </h2>
                            </div>
                            <div class="boxbody">
                                <table border="1" cellpadding="3" align="center" style="border: solid 1 black; font-family: Verdana;
                                    font-size: 11px;">
                                    <tr style="background-color: #4682b4; border: solid 1 black; color: #FFFFFF; height: 30px;">
                                        <th>
                                            Site Name</th>
                                        <th>
                                            Sequence</th>
                                        <th>
                                            Value</th>
                                    </tr>
                                    <%
                                        
                                        Dim hshData As New Hashtable()
                                        hshData.Add(8511, "ANGKASA NURI")
                                        hshData.Add(8620, "BANDAR BARU SG UDANG")
                                        hshData.Add(8619, "MITC INDUSTRI 2")
                                        hshData.Add(8621, "TAMAN INDAH")
                                        hshData.Add(8643, "TAMAN KRUBONG PERDANA")
                                        hshData.Add(8512, "TAMAN TANJUNG MINYAK UTAMA")
                                        hshData.Add(8546, "TMN PERTAM JAYA")
                                        hshData.Add(8663, "TMN DESA IDAMAN")
                                        
                                        Dim Enumerator As IDictionaryEnumerator = hshData.GetEnumerator()
                                        While (Enumerator.MoveNext())
                                            
                                    %>
                                    <tr>
                                        <td>
                                            <%=Enumerator.Value.ToString()%>
                                        </td>
                                        <td>
                                            <%=GetLastSequence(Tmconn, Enumerator.Key.ToString(), 2)%>
                                        </td>
                                        <td>
                                            <a style="text-decoration: none;" href="Summary.aspx?sitetype=RESERVOIR&district=<%=district%>&siteid=<%=Enumerator.Key.ToString() %>&sitename=<%=Enumerator.Value.ToString()%>&position=2&equipname=Flow Meter"
                                                title="Trending">
                                                <%=Get_Current_Value(Tmconn, Enumerator.Key.ToString(), 2, 2)%>
                                                m^3/h</a>
                                        </td>
                                    </tr>
                                    <%End While%>
                                </table>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </center>
    </div>
</body>
</html>
