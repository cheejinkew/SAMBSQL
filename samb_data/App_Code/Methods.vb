Imports Microsoft.VisualBasic
Imports Npgsql
Imports System.Data
Imports System.Configuration


Public Class Methods
    Public Function chkusernamepwd(ByVal username As String, ByVal pwd As String) As String
        Try

            Dim d As String = ConfigurationManager.AppSettings("DSNPG")
            Dim con As New NpgsqlConnection(ConfigurationManager.AppSettings("DSNPG"))
            Dim da As New NpgsqlDataAdapter("select pwd, role, userid from avls_user_table where upper(username) ='" & UCase(username) & "'", con)

            Dim ds As New DataSet

            da.Fill(ds)
            Dim i As Integer
            If ds.Tables(0).Rows.Count > 0 Then
                For i = 0 To ds.Tables(0).Rows.Count - 1
                    If UCase(ds.Tables(0).Rows(i).Item("pwd")) = UCase(pwd) Then
                        con.Dispose()
                        da.Dispose()
                        Return ds.Tables(0).Rows(i).Item("role")
                    Else
                        con.Dispose()
                        da.Dispose()
                        Return "Invalid Password"

                    End If
                Next
            Else
                con.Dispose()
                da.Dispose()
                Return "Invalid Username"
            End If


        Catch ex As Exception

        End Try

    End Function
    Function CALL_RETURNVALUE(ByVal SQLSTMT As String) As String
        Try

            Dim call_return_con As NpgsqlConnection
            call_return_con = New NpgsqlConnection(ConfigurationManager.AppSettings("DSNPG"))
            call_return_con.Open()
            Dim myretsqlcmd As New NpgsqlCommand(SQLSTMT, call_return_con)
            myretsqlcmd.CommandType = CommandType.Text
            Dim ret As String
            ret = myretsqlcmd.ExecuteScalar
            Return ret

        Catch ex As Exception

        End Try


    End Function
    Function modificatios(ByVal SQLSTMT As String) As Integer

        Try




            Dim call_return_con As NpgsqlConnection

            call_return_con = New NpgsqlConnection(ConfigurationManager.AppSettings("DSNPG"))
            call_return_con.Open()
            Dim myretsqlcmd As New NpgsqlCommand(SQLSTMT, call_return_con)
            myretsqlcmd.CommandType = CommandType.Text
            myretsqlcmd.ExecuteNonQuery()

            Return 1
        Catch ex As Exception

        End Try


    End Function
    Public Function fillcombos_fun(ByVal MyTableName As String, ByVal MyFieldName As String, ByVal myWhereCondition As String, ByVal MyWherePresent As Integer) As DataSet
        Try


            ' Dim conopen As Integer = 0
            Dim myretsqlcmd As New NpgsqlCommand
            Dim call_return_con As New NpgsqlConnection
            Dim mycombods As New DataSet
            Dim mycomboadapter As New NpgsqlDataAdapter
            call_return_con = New NpgsqlConnection(ConfigurationManager.AppSettings("DSNPG"))

            If MyWherePresent = 1 Then
                mycomboadapter = New NpgsqlDataAdapter("select " & MyFieldName & " from " & MyTableName & " where " & myWhereCondition, call_return_con)
            ElseIf MyWherePresent = 2 Then
                mycomboadapter = New NpgsqlDataAdapter("select " & MyFieldName & " from " & MyTableName & " order by " & myWhereCondition, call_return_con)
            Else
                mycomboadapter = New NpgsqlDataAdapter("select " & MyFieldName & " from " & MyTableName, call_return_con)
            End If
            mycombods = New DataSet
            mycomboadapter.Fill(mycombods, MyTableName)

            fillcombos_fun = mycombods
            mycomboadapter.Dispose()
            mycombods.Dispose()
            ' If conopen = 1 Then
            call_return_con.Close()
            'call_return_con = Nothing
            ' End If
            Return fillcombos_fun
        Catch ex As Exception

        End Try
    End Function
    Function CALL_PROC_SP(ByVal SQLSTMT As String) As DataSet

        Dim cls_myda As NpgsqlDataAdapter
        Dim cls_mysqlstatement As String
        cls_mysqlstatement = SQLSTMT

        Dim cls_con As NpgsqlConnection = New NpgsqlConnection(ConfigurationManager.AppSettings("DSNPG"))
        cls_myda = New NpgsqlDataAdapter(SQLSTMT, cls_con)
        Dim ds As New DataSet
        cls_myda.Fill(ds)
        cls_con.Close()
        ' cls_con = Nothing
        cls_myda.Dispose()

        Return ds
       ' End Try
    End Function
    Function CALL_PROC_DR(ByVal SQLSTMT As String) As Npgsql.NpgsqlDataReader
        Dim cmd As NpgsqlCommand
        Dim cls_con As NpgsqlConnection = New NpgsqlConnection(ConfigurationManager.AppSettings("DSNPG"))
        cls_con.Open()
        cmd = New NpgsqlCommand(SQLSTMT, cls_con)
        Dim dr As NpgsqlDataReader
        dr = cmd.ExecuteReader
        cls_con.Close()
        Return dr
        ' End Try
    End Function

End Class
