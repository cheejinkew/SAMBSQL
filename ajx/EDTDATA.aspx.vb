Imports System.Data
Imports System.Data.SqlClient
Imports Newtonsoft.Json

Partial Class ajx_EDTDATA
    Inherits System.Web.UI.Page
    Public Shared strSiteID As String = ""
    Public Shared getRule As Boolean = False

    Private Cmd As New SqlCommand()
    Private Con As New SqlConnection()
    Private dr As SqlDataReader
    Private Query As String = ""
    Public Sub getData()
        Con = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("SAMBconnection"))
        Dim jsonData As ArrayList = New ArrayList
        Dim level As ArrayList = New ArrayList
        Dim Site As Data = New data
        'Try
        '    Dim strData As String = ""
        '    Dim intCount As Integer = 0
        '    Dim intPosition As Integer = 1
        '    Dim strsitename As String = ""
        '    Dim strValue As String = ""
        '    Dim strPosition As String = ""
        '    Dim strTimeStamp As String = "-"
        '    Dim strLastTimeStamp As String = "-"


        '    Query = "select est.siteid ,position ,dtimestamp,value ,sevent ,st.sitename  from telemetry_equip_status_table_m6 est left outer join telemetry_site_list_table st on est.siteid =st.siteid  WHERE est.siteid = '" & strSiteID & "' AND position >= '2' ORDER BY position ASC"

        '    Cmd = New SqlCommand(Query, Con)

        '    Con.Open()
        '    dr = Cmd.ExecuteReader()

        '    While dr.Read()
        '        intCount = intCount + 1
        '        intPosition = intPosition + 1
        '        strsitename = dr("sitename")
        '        If (IsDBNull(dr("value"))) Then
        '            strValue = "-"
        '        ElseIf (dr("value").ToString().IndexOf(".") > -1) Then
        '            strValue = Convert.ToDouble(dr("value")).ToString("0.00")
        '        Else
        '            strValue = dr("value").ToString()
        '        End If

        '        If IsDBNull(dr.GetOrdinal("position")) Then
        '            strPosition = "-"
        '        Else
        '            strPosition = dr("position").ToString()
        '        End If

        '        While intPosition.ToString() <> strPosition
        '            intCount = intCount + 1
        '            intPosition = intPosition + 1
        '            strData = strData & "-|"
        '        End While

        '        strData = strData + strValue + "|"
        '        If IsDBNull(dr.GetOrdinal("dtimestamp")) Then
        '            strTimeStamp = "-"
        '        Else
        '            strTimeStamp = dr("dtimestamp").ToString()
        '        End If

        '        If strTimeStamp <> "-" Then
        '            If strLastTimeStamp <> "-" AndAlso Convert.ToDateTime(strTimeStamp) > Convert.ToDateTime(strLastTimeStamp) Then
        '                strLastTimeStamp = strTimeStamp
        '            ElseIf strLastTimeStamp = "-" Then
        '                strLastTimeStamp = strTimeStamp
        '            End If
        '        End If
        '    End While

        '    Dim strRule As String = ""
        '    If getRule Then
        '        Dim strHH As String = "-"
        '        Dim strH As String = "-"
        '        Dim strL As String = "-"
        '        Dim strLL As String = "-"

        '        Dim strAlarmType As String = ""
        '        Dim strMultiplier As String = ""
        '        Dim strMinMax As String()

        '        Query = "SELECT * FROM telemetry_rule_list_table WHERE siteid='" & strSiteID & "' ORDER BY alarmtype"
        '        Cmd = New SqlCommand(Query, Con)
        '        dr = Cmd.ExecuteReader()

        '        While dr.Read()

        '            If IsDBNull(dr.GetOrdinal("alarmtype")) Then
        '                strAlarmType = ""
        '            Else
        '                strAlarmType = dr("alarmtype").ToString()
        '            End If
        '            If IsDBNull(dr.GetOrdinal("multiplier")) Then
        '                strMultiplier = ""
        '            Else
        '                strMultiplier = dr("multiplier").ToString()
        '            End If

        '            strMinMax = strMultiplier.Split(";"c)

        '            If strMinMax.Length > 2 Then
        '                If strMinMax(0).ToUpper() = "RANGE" Then
        '                    Select Case strAlarmType
        '                        Case "HH"
        '                            If True Then
        '                                strHH = strMinMax(1)
        '                            End If
        '                            Exit Select

        '                        Case "H"
        '                            If True Then
        '                                strH = strMinMax(1)
        '                            End If
        '                            Exit Select

        '                        Case "L"
        '                            If True Then
        '                                strL = strMinMax(2)
        '                            End If
        '                            Exit Select

        '                        Case "LL"
        '                            If True Then
        '                                strLL = strMinMax(2)
        '                            End If
        '                            Exit Select
        '                    End Select
        '                End If
        '            End If
        '        End While

        '        'String strLastValue = "0";

        '        'Query = "SELECT TOP 1 * FROM telemetry_rule_list_table WHERE siteid='" + strSiteID + "' ORDER BY alarmtype";
        '        'Cmd = new SqlCommand(Query, Con);
        '        'dr = Cmd.ExecuteReader();

        '        strRule = "|" & strHH & "|" & strH & "|" & strL & "|" & strLL
        '    End If
        '    If strLastTimeStamp = "-" Then
        '        strData = "Data No Available"
        '    Else
        '        strData = Convert.ToDateTime(strLastTimeStamp).ToString("dd/MM/yyyy hh:mm:ss tt") & "|" & intCount & "|" & strData & strSiteID & strRule & "|" & strsitename
        '    End If
        '    Response.Write(strData)
        'Catch ex As Exception
        '    Response.Write(ex.ToString())
        'Finally
        '    Cmd.Dispose()
        '    Con.Close()
        'End Try
        Dim restring As String = ""
        Try
            Dim strTmpSiteID As String = ""
            Dim strSiteID As String = ""
            Dim strValue As String = ""
            Dim strCounter As String = ""
            Dim strdayCounter As String = ""
            Dim dtTimeStamp As String = DateTime.Now.ToString
            Dim dtTempDateTime As String = ""
            Query = "SELECT sl.siteid, ISNULL(es.value, 0) AS value, ISNULL(es.position, 0) AS position, es.dtimestamp AS  dtimestamp,counter,counter,isnull((counter- dbo.[fn_getDayStartCounter](sl.siteid)),0) as daycount FROM telemetry_site_list_table sl LEFT OUTER JOIN telemetry_equip_status_table_m6 es ON es.siteid = sl.siteid WHERE sitetype = 'FLOWRATE' AND position=2 ORDER BY sl.siteid, position"
            Cmd = New SqlCommand(Query, Con)
            Con.Open()
            dr = Cmd.ExecuteReader()

            While dr.Read()
                strSiteID = IIf(IsDBNull(dr("siteid")), "", dr("siteid").ToString())
                strValue = IIf(IsDBNull(dr("value")), "", Convert.ToDouble(dr("value")).ToString("0.00"))
                dtTempDateTime = IIf(IsDBNull(dr("dtimestamp")), "", dr("dtimestamp").ToString())
                strCounter = IIf(IsDBNull(dr("counter")), "", Convert.ToDouble(dr("counter")).ToString("0.00"))
                strdayCounter = IIf(IsDBNull(dr("daycount")), "", Convert.ToDouble(dr("daycount")).ToString("0.00"))

                strTmpSiteID = IIf(IsDBNull(dr("siteid")), "", dr("siteid").ToString())
                'TODO: Warning!!!, inline IF is not supported ? 
                Site = New Data()
                Site.SiteID = strTmpSiteID
                Site.flowrate = strValue
                Site.acumulater = strCounter
                If strdayCounter >= 0 Then
                        Site.daycounter = strdayCounter
                    Else
                        Site.daycounter = 0
                    End If

                    If (Math.Round(Convert.ToDateTime(dtTimeStamp).Subtract(Convert.ToDateTime(dtTempDateTime)).TotalHours, 0) > 24) Then
                        Site.Delay = "1"
                    Else
                        Site.Delay = "0"
                    End If
                jsonData.Add(Site)
            End While
            jsonData.Add(Site)
            restring = JsonConvert.SerializeObject(jsonData)
        Catch ex As Exception
            Throw New HttpException(ex.ToString)
        Finally
            Cmd.Dispose()
            Con.Close()
        End Try
        Response.Write(restring)
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Request.QueryString("ID") Is Nothing Then
            strSiteID = ""
        Else
            strSiteID = Request.QueryString("ID")
        End If
        If Request.QueryString("Rule") Is Nothing Then
            getRule = False
        Else
            getRule = True
        End If
        getData()
    End Sub
    Public Class data
        Public SiteID As String
        Public Delay As String
        Public flowrate As Double
        Public daycounter As Double
        Public acumulater As Double
    End Class
End Class
