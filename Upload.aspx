<%@ Page Language="VB" Debug="true" %>

<%@ Import Namespace="ADODB" %>
<%@ Import Namespace="System.IO" %>
<html>
<head>
    <title>Uploading File</title>
    <script language="VB" runat="server">

        Dim savePath As String = "D:\wwwroot\SAMBSQL\images\UploadedImages\" '"D:\wwwroot\Telemetry\TelemetryMgmt_Melaka\images\UploadedImages\"
        Dim strSiteID As String
        Dim objConn
        Dim strConn
        Dim sqlSp
 

        'Sub Upload_Click(source As Object, e As EventArgs)
        Sub Upload_Click(source As Object, e As System.Web.UI.ImageClickEventArgs)
            strSiteID = Request.QueryString("test")
  
            If Not (uploadedFile.PostedFile Is Nothing) Then
                Try
                    Dim postedFile = uploadedFile.PostedFile
                    Dim filename As String = strSiteID & Path.GetFileName(postedFile.FileName)
                    Dim contentType As String = postedFile.ContentType
                    Dim contentLength As Integer = postedFile.ContentLength

                    postedFile.SaveAs(savePath & filename)
                    If filename <> strSiteID Then
                        message.Text = "File is Successfully Uploaded !"
                        '"postedFile.Filename & " Uploaded !" 
                        '"<br>content type: " & contentType & _
                        '"<br>content length: " & contentLength.ToString()
                        Call InsertFileName(filename, strSiteID)
                    Else
                        message.Text = "Failed Uploading File !"
                    End If
    
                Catch exc As Exception
                    message.Text = "Failed uploading file, Error - " & exc.ToString()
                End Try
            End If
        End Sub

        Sub InsertFileName(strFileName As String, strSiteID As String)
            strConn = ConfigurationSettings.AppSettings("DSNPG")
            objConn = New ADODB.Connection()

            objConn.open(strConn)
 
            sqlSp = "update telemetry_site_list_table set image_path='" & strFileName & "' where siteid='" & strSiteID & "'"
            'response.write(sqlSp)
            'response.end
   
            objConn.Execute(sqlSp)

            objConn.close()
            objConn = Nothing

        End Sub

    </script>
</head>
<body>
    <form enctype="multipart/form-data" runat="server">
    <table border="0" cellpadding="1" width="400" style="font-family: Verdana; font-size: 10px;
        color: white;">
        <tr>
            <td height="20" bgcolor="#97A9FF" align="center">
                <b>Select File To Upload</b>
            </td>
        </tr>
    </table>
    <table border="0" cellpadding="5" width="350" style="font-family: Verdana; font-size: 10px;
        color: #5373A2;">
        <tr>
            <td height="26" colspan="3">
                <p align="center">
                    <asp:Label ID="message" runat="server" Style="font-family: Verdana; font-size: 10px;
                        color: green; font-weight: bold;" />
            </td>
        </tr>
        <tr>
            <td width="150" height="25">
                <b><font size="1" face="Verdana" color="#5373A2">Select File</font></b>
            </td>
            <td width="20" height="25">
                <b><font color="#5373A2">:</font></b>
            </td>
            <td width="180" height="25">
                <font color="#0B3D62">
                    <input id="uploadedFile" type="file" runat="server" style="color: #0B3D62; font-size: 10pt;
                        font-family: Verdana; border: 1px solid #CBD6E4">
            </td>
        </tr>
        <tr>
            <td height="26" colspan="3">
                <p align="center">
                    <input type="image" id="upload" value="Upload" src="images/Upload.jpg" onserverclick="Upload_Click"
                        runat="server">
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
