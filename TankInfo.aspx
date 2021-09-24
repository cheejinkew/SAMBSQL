<%@ Page Language="VB" %>

<script runat="server">
    Sub Page_Load(ByVal Source As Object, ByVal E As EventArgs)
       
        Dim objConn
        Dim sqlrs
        Dim strConn As String = ConfigurationSettings.AppSettings("DSNPG")
        Dim siteid = Request.QueryString("siteid")
        
        objConn = New ADODB.Connection()
        sqlrs = New ADODB.Recordset()
        
        Dim datetime As Date
    
        objConn.open(strConn)
       
        'sqlrs.Open("select siteid,sequence,value from telemetry_log_table where siteid='" & siteid & "' and sequence=(select max(sequence) as lastdate from telemetry_log_table where siteid='" & siteid & "')", objConn)
        sqlrs.Open("select siteid,dtimestamp,value from telemetry_equip_status_table  where siteid='" & siteid & "' and position='2'", objConn)
        
        If (Not sqlrs.EOF) Then
            
            If IsDBNull(sqlrs(0).value) Then
                Response.Write("null")
                
            Else
                datetime = Date.Parse(sqlrs(1).value)
               
                'Response.Write("SiteID : " & sqlrs(0).value & "<br/>")
                Response.Write("Date   : " & datetime.Date & "<br/>")
                Response.Write("Time   : " & datetime.ToShortTimeString() & "<br/>")
                Response.Write("Level  : <b id=""level"">" & Math.Round(sqlrs(2).value, 2) & "</b><br/>")
                'Response.Write("<embed src=""chart.svg"" width=""20px"" height=""78px"" style=""position: absolute;left: 130px;top:22px;""></embed>")
                'Response.Write("<embed src=""tankinfo.svg"" type=""image/svg+xml"" width=""22px"" height=""100px""></embed>")
            End If
        Else
            Response.Write("<b>No Data</b>")
        End If
        
        
            
    End Sub
</script>

