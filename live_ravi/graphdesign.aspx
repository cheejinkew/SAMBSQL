<%@ Page Language="VB" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Public objConn2 = New ADODB.Connection(), arr1 As New ArrayList, arr2 As New ArrayList
     Public sqlRs2 = New ADODB.Recordset(), arr As New ArrayList
    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim strConn
        Dim s, s1, i, u
        Dim sqlRs, st, uid1
        strConn = ConfigurationSettings.AppSettings("DSNPG")
        Dim objConn = New ADODB.Connection()
        sqlRs = New ADODB.Recordset()
        objConn.open(strConn)
        uid1 = Request.QueryString("StrUserID")
       
        st = "select control_district from telemetry_user_table where userid=" & uid1
        sqlRs.Open(st, objConn)
        If Not sqlRs.eof Then
            Do Until sqlRs.EOF
                s = sqlRs("control_district").value
                sqlRs.MoveNext()
            Loop
            s1 = "All," & s
            Dim split1 = s1.Split(",")
            Dim spit
            For i = 0 To split1.length - 1
                spit = split1(i)
                arr.Add(spit)
            Next
        End If
        sqlRs.close()
        Dim l As Integer
        Dim st1 As String, t As String
        For l = 0 To arr.Count - 1
            t = arr.Item(l)
            If t = "All" Then
            Else
                st1 = "select sitedistrict from telemetry_site_list_table where sitedistrict='" & t & "'"
                ' st1 = "select * from telemetry_site_list_table where sitedistrict='" & t & "'"
                sqlRs2.Open(st1, objConn)
                Dim k As String
                If Not sqlRs2.eof Then
                    k = sqlRs2("sitedistrict").value
                    arr1.Add(k)
                Else
                    arr2.Add(t)
                End If
                sqlRs2.close()
            End If
        Next
       
        For i = 0 To arr2.Count - 1
            arr.Remove(arr2(i))
        Next
        dropdist.Items.Clear()
        distlist.Items.Clear()
        For i = 0 To arr.Count - 1
            dropdist.Items.Add(arr(i))
            distlist.Items.Add(arr(i))
            Me.DropDownList1.Items.Add(arr(i))
        Next
       
        
    End Sub

    'Protected Sub dropdist_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
     
    '    Response.Write("hi")
     
    '    'Dim st, i
    '    'Dim objConn = New ADODB.Connection()
    '    'listsites.Items.Clear()
    '    'st = "select sitename from telemetry_site_list_table where sitedistrict='" & dropdist.SelectedItem.value & "'"
    '    'sqlRs2.Open(st, objConn)
    '    'If Not sqlRs2.eof Then
    '    '    i = sqlRs2("sitename")
    '    '    Response.Write(i)
    '    '    listsites.Items.Add(i)
    '    'End If
    'End Sub

    
    Public Sub distlist_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Response.Write("hi")
        
        Dim st, i, k
        Dim objConn = New ADODB.Connection()
        listsites.Items.Clear()
        k = distlist.SelectedItem.Text
        Response.Write(k)
        st = "select sitename from telemetry_site_list_table where sitedistrict='" & k & "'"
        sqlRs2.Open(st, objConn)
        If Not sqlRs2.eof Then
            i = sqlRs2("sitename")
            Response.Write(i)
            listsites.Items.Add(i)
        End If
    End Sub

    Public Sub DropDownList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Response.Write("hi")
        Dim st, i, k
        Dim objConn = New ADODB.Connection()
        listsites.Items.Clear()
        k = dropdist.SelectedItem.Text
        Response.Write(k)
        st = "select sitename from telemetry_site_list_table where sitedistrict='" & DropDownList1.SelectedItem.Text & "'"
        sqlRs2.Open(st, objConn)
        If Not sqlRs2.eof Then
            i = sqlRs2("sitename")
            Response.Write(i)
            listsites.Items.Add(i)
        End If
    End Sub
    'Private Sub dropdodist()
    '    Response.Write("hi")
    '    Dim st, i, k
    '    Dim objConn = New ADODB.Connection()
    '    listsites.Items.Clear()
    '    k = dropdist.SelectedItem.Text
    '    Response.Write(k)
    '    st = "select sitename from telemetry_site_list_table where sitedistrict='" & DropDownList1.SelectedItem.Text & "'"
    '    sqlRs2.Open(st, objConn)
    '    If Not sqlRs2.eof Then
    '        i = sqlRs2("sitename")
    '        Response.Write(i)
    '        listsites.Items.Add(i)
    '    End If
        
    'End Sub
        
    </script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
<script language="javascript" type="text/javascript">


//function Select1_onclick() {
// Response.Write("hi")
//        Dim st, i, k
//        Dim objConn = New ADODB.Connection()
//        listsites.Items.Clear()
//        k = dropdist.SelectedItem.Text
//        Response.Write(k)
//        st = "select sitename from telemetry_site_list_table where sitedistrict='" & DropDownList1.SelectedItem.Text & "'"
//        sqlRs2.Open(st, objConn)
//        If Not sqlRs2.eof Then
//            i = sqlRs2("sitename")
//            Response.Write(i)
//            listsites.Items.Add(i)
//        End If
//}


</script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:DropDownList ID="dropdist" runat="server" Style="z-index: 100;
            left: 178px; position: absolute; top: 91px" Width="148px" OnSelectedIndexChanged="dropdist_SelectedIndexChanged">
        </asp:DropDownList>
        <select id="Select1" style="z-index: 105; left: 4px; width: 158px; position: absolute;
            top: 9px" onclick="return Select1_onclick()">
            <option selected="selected"></option>
        </select>
        <asp:DropDownList ID="distlist" runat="server" Style="z-index: 102; left: 172px;
            position: absolute; top: 259px" Width="182px" OnSelectedIndexChanged="distlist_SelectedIndexChanged">
        </asp:DropDownList>
        &nbsp;&nbsp;
        <asp:ListBox ID="listsites" runat="server" Style="z-index: 103; left: 11px; position: absolute;
            top: 209px" Height="311px" Width="158px"></asp:ListBox>
        <asp:DropDownList ID="DropDownList1" runat="server" OnSelectedIndexChanged="call dropdodist()"
            Style="z-index: 104; left: 177px; position: absolute; top: 450px" Width="126px">
        </asp:DropDownList>
    
    </div>
    </form>
</body>
</html>
