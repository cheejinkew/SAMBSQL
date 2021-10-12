Imports System.Data.SqlClient
Imports System.Data
Imports System.Collections.Generic
Imports System.Configuration

Partial Class reservoirAnalysis
	Inherits System.Web.UI.Page

	Public Query As String = ""

	Public strControlDistrict As String = ""

	Public arryControlDistrict As String()

	Public Shared dbMax As Double = 10

	Public Shared dbRestore As Double = 0

	Public elekw As Double = 0

	Public elekwtariff As Double = 0

	Public flowrate As Double = 0

	Public flowratetariff As Double = 0

	Public Shared dbValue As Double()

	Public Shared dtDate As String()

	Public strLastDate
	Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
		If Not IsPostBack() Then
			txtfromdate.Text = Date.Now.ToString("yyyy/MM/dd")
			txtEnddate.Text = Date.Now.ToString("yyyy/MM/dd")

			Dim conn As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB"))
			Dim cmd As SqlCommand
			Dim ds As New DataSet

			Try
				'Dim strQuery As String = "SELECT distinct(sitedistrict) as sitedistrict from telemetry_site_list_table ORDER BY sitedistrict "
				Dim strQuery As String = "SELECT distinct(sitedistrict) as sitedistrict from telemetry_site_list_table where sitedistrict not in (' ','Hidden','Dismantle','Testing') ORDER BY sitedistrict "
				cmd = New SqlCommand(strQuery, conn)
				conn.Open()
				Dim da As SqlDataAdapter
				da = New SqlDataAdapter(cmd)
				da.Fill(ds)
				ddldistrict.DataSource = ds.Tables(0)
				ddldistrict.DataValueField = "sitedistrict"
				ddldistrict.DataTextField = "sitedistrict"
				ddldistrict.DataBind()
				ddldistrict.Items.Insert(0, "Select Site District")
				'ddldistrict.Items.Insert(1, "ALL")
				'ddldistrict.SelectedValue = "ALL"
			Catch ex As Exception

			End Try
		End If
	End Sub

	Public Sub Fill_gvReports()
		Dim cmd As SqlCommand
		Dim dr As SqlDataReader
		Dim steps As String = "0"
		Dim position As Integer = 2
		Dim Con As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB"))
		Try
			Dim strBeginDate As String = Date.Parse(txtfromdate.Text).ToString("yyyy-MM-dd") & " " & ddBeginHour.SelectedValue & ":" & ddBeginMinute.SelectedValue & ":00"
			Dim strEndDate As String = Date.Parse(txtEnddate.Text).ToString("yyyy-MM-dd") & " " & ddendHour.SelectedValue & ":" & ddendMinute.SelectedValue & ":59"

			Dim dt As DataTable = New DataTable()
			dt.Columns.Add("no")
			dt.Columns.Add("siteid")
			dt.Columns.Add("sitename")
			dt.Columns.Add("datetime")
			dt.Columns.Add("average")
			dt.Columns.Add("max")
			dt.Columns.Add("min")
			dt.Columns.Add("median")

			Dim dtRow As DataRow
			Dim r As DataRow
			Dim totalSpan As TimeSpan = New TimeSpan()
			Dim total1 As Double = 0
			Dim total2 As Double = 0
			Dim total3 As Double = 0
			Dim sno As Integer = 1


			Dim str1 As String = "select siteid from telemetry_site_list_table where sitedistrict = '" & ddldistrict.SelectedValue & "'"
			Con.Open()
			Dim cmd1 As New SqlCommand(str1, Con)
			Dim reader1 As SqlDataReader = cmd1.ExecuteReader
			Dim checkSiteId As String = ""
			Dim checkSiteId2 As String = ""
			Dim aList As New List(Of String)
			Dim number As Integer = 1

			While (reader1.Read())
				aList.Add(reader1(0))
			End While


			For Each item As String In aList
				strLastDate = String.Format("{0:yyyy/MM/dd}", Date.Parse(strBeginDate))
				Do While strLastDate <= String.Format("{0:yyyy/MM/dd HH:mm:ss}", Date.Parse(strEndDate))
					'Dim ds As Data.Odbc.OdbcDataAdapter
					'Dim str1 As String = "SELECT dtimestamp,value FROM telemetry_log_table WHERE (siteid = '" & strSiteId & "') and dtimestamp between '" & strLastDate & ":00' and '" & strLastDate & ":59' and position='" & position & " ' group by dtimestamp,value order by dtimestamp"
					Dim str2 As String = "Select t.siteid,s.sitename,CAST(AVG(value) AS DECIMAL(10,2)) AS 'Average Level',max(value) As 'Max Level',min(value) As 'Min Level', ( SELECT((SELECT MAX(value) FROM(SELECT TOP 50 PERCENT value,dtimestamp FROM telemetry_log_table where siteid='" & item & "' And position in ('" & position & "', '0') and dtimestamp between '" & strLastDate & " 00:00:00' and '" & strLastDate & " 23:59:59' ORDER by value )AS BottomHalf)+(SELECT MIN(value) FROM(SELECT TOP 50 PERCENT value,dtimestamp FROM telemetry_log_table where siteid='" & item & "' And position in ('" & position & "', '0') and dtimestamp between '" & strLastDate & " 00:00:00' and '" & strLastDate & " 23:59:59' ORDER by value DESC) AS TopHalf)) / 2 )AS 'Median Level' From telemetry_log_table t LEFT join telemetry_site_list_table s on t.siteid = s.siteid Where t.siteid ='" & item & "' And position In ('" & position & "', '0') and dtimestamp between '" & strLastDate & " 00:00:00' and '" & strLastDate & " 23:59:59' group by t.siteid,s.sitename"

					'Dim cmd As New Data.Odbc.OdbcCommand(str, objConn)
					'dr = cmd.ExecuteReader()
					'While (dr.Read())
					Dim cmd2 As New SqlCommand(str2, Con)
					Dim reader As SqlDataReader = cmd2.ExecuteReader

					While (reader.Read())

						r = dt.NewRow()
						checkSiteId2 = reader(0)

						If (checkSiteId = reader(0)) Then
							r(0) = ""
							r(1) = ""
							r(2) = ""
						Else
							r(0) = number
							r(1) = reader(0)
							r(2) = reader(1)
						End If
						r(3) = strLastDate
						r(4) = reader(2)
						r(5) = reader(3)
						r(6) = reader(4)
						r(7) = reader(5)
						dt.Rows.Add(r)
					End While

					'number = number + 1
					checkSiteId = checkSiteId2
					strLastDate = String.Format("{0:yyyy/MM/dd}", Date.Parse(strLastDate).AddDays(1))
				Loop
				number = Number + 1
			Next
			Con.Close()

			If dt.Rows.Count = 0 Then
				r = dt.NewRow()
				r(0) = "--"
				r(1) = "--"
				r(2) = "--"
				r(3) = "--"
				r(4) = "--"
				r(5) = "--"
				r(6) = "--"
				r(7) = "--"

				dt.Rows.Add(r)
			End If

			Session.Remove("exceltable")
			Session("exceltable") = dt
			gvReport.DataSource = dt
			gvReport.DataBind()
			gvReport.FooterRow.Cells(4).Text = totalSpan.Duration().TotalHours.ToString("00") & ":" + totalSpan.Duration().Minutes.ToString("00") & ":" + totalSpan.Duration().Seconds.ToString("00")
			gvReport.FooterRow.Cells(7).Text = total1.ToString("0.00")


		Catch ex As Exception
			Response.Write("Fill_gvReports Error - " & ex.Message)
		Finally
			cmd.Dispose()
			Con.Close()
		End Try

	End Sub

	Protected Sub btnSubmit_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click
		Try
			Fill_gvReports()
		Catch ex As Exception

		End Try
	End Sub

End Class
