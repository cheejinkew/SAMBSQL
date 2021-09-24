<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>
<%@ Import Namespace ="System.Data.sqlClient" %>
<%@ import Namespace ="System.Web.UI" %>

<%	
	dim objConn
   	dim rsRecords
   	dim strConn
	
    strConn = ConfigurationSettings.AppSettings("DSNPG")
   	objConn =  new ADODB.Connection()
   	rsRecords = new ADODB.Recordset()
   	objConn.open(strConn)
	
	dim siteid as string
	dim sitename as string
	dim district as string
	
	dim unitid as string
	dim simno as string
	dim password as string
	dim pollmethod as string
	dim sitetype as string
    Dim userid As String
    Dim haddress As String
    Dim browser As String
	siteid = request.Form("siteid")
	sitename = request.form("sitename")
	district = request.Form("district")
	password = request.form("password")
	pollmethod = request.Form("pollmethod")
    haddress = Request.UserHostAddress
    browser = Request.Browser.Browser & " " & Request.Browser.Version
    userid = Session("userid")
	rsRecords.Open("select unitid, sitetype from telemetry_site_list_table where siteid='" & siteid & "'",objConn)
   	if rsRecords.EOF = false then
		unitid = rsrecords.fields("unitid").value
		sitetype = rsrecords.fields("sitetype").value
	else
		rsrecords.close
		rsrecords = nothing
		objconn = nothing
		exit sub
	end if
	rsrecords.close
	rsRecords.Open("select simno from unit_list where unitid='" & unitid & "'",objConn)
	if rsrecords.eof = false then
        simno = rsRecords.fields("simno").value
        Label1.Text = simno
	else
		rsrecords.close
		rsrecords = nothing
		objconn = nothing
		exit sub
	end if
	dim tmpenddate as date
    tmpenddate = DateAdd("d", 1, Now)
    
    Dim Str As String = System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB")
    
    Dim ObjConnSql As New SqlConnection(Str)
    
    ObjConnSql.Open()
    
    'Response.Write("Insert Into sms_outbox_Table (destination, startdate, enddate, priority, message, network, assign, insertdate, kn_source_id) Values ('" & simno & "', '" & Now & "', '" & tmpenddate & "', '0', '(CGUS;20)', 'None', 'FALSE', '" & Now & "', '000')")
    Dim chkcmd As New SqlCommand("SELECT top 1 startdate FROM  sms_outbox_history_table where destination ='" & simno & "' order by startdate desc", ObjConnSql)
    Dim dr As SqlDataReader
    dr = chkcmd.ExecuteReader()
    Dim min As Integer
    If (dr.Read()) Then
        min = DateDiff(DateInterval.Minute, Convert.ToDateTime(dr("startdate")), DateTime.Now)
        If (min > 20) Then
            Dim myComm As New SqlCommand("Insert Into sms_outbox_table (destination, startdate, enddate, priority, smessage, network, assign, insertdate, kn_source_id) Values ('" & simno & "', '" & Now & "', '" & tmpenddate & "', '0', '(CGUS;20)', 'None', '0', '" & Now & "', '000')", ObjConnSql)
            myComm.ExecuteNonQuery()
    
            Dim mycomm1 As New SqlCommand("insert into dbo.telemetry_users_log_table (userid,logintime,hostaddress,browser,action) values ('" & userid & "','" & DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss") & "','" & haddress & "','" & browser & "','" & siteid & "Polling')", ObjConnSql)
            mycomm1.ExecuteNonQuery()
        Else
            Dim mycomm1 As New SqlCommand("insert into dbo.telemetry_users_log_table (userid,logintime,hostaddress,browser,action) values ('" & userid & "','" & DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss") & "','" & haddress & "','" & browser & "','" & siteid & " Trying to Poll')", ObjConnSql)
            mycomm1.ExecuteNonQuery()
        End If
    Else
        Dim myComm As New SqlCommand("Insert Into sms_outbox_table (destination, startdate, enddate, priority, smessage, network, assign, insertdate, kn_source_id) Values ('" & simno & "', '" & Now & "', '" & tmpenddate & "', '0', '(CGUS;20)', 'None', '0', '" & Now & "', '000')", ObjConnSql)
        myComm.ExecuteNonQuery()
    
        Dim mycomm1 As New SqlCommand("insert into dbo.telemetry_users_log_table (userid,logintime,hostaddress,browser,action) values ('" & userid & "','" & DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss") & "','" & haddress & "','" & browser & "','" & siteid & "Polling')", ObjConnSql)
        mycomm1.ExecuteNonQuery()
    End If
    
   
   
  
    %>

<script language="javascript">
window.location="Summary.aspx?siteid=<%=siteid%>&sitename=<%=sitename%>&district=<%=district%>&sitetype=<%=sitetype%>&message=Request+has+been+submitted+successfully+!";
</script>

<form id="form1" runat="server">
<asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
</form>
