using System;
using System.Collections.Generic;
using System.Web; 
using Npgsql;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
public class Methods
{

    public string chkusernamepwd(string username, string pwd)
    {
        string result = "";
        try
        {
            string d = ConfigurationManager.AppSettings["DSNPG"];
            NpgsqlConnection con = new NpgsqlConnection(ConfigurationManager.AppSettings["DSNPG"]);
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(("select pwd, role, userid from avls_user_table where upper(username) =\'"
                            + (username.ToUpper() + "\'")), con);
            DataSet ds = new DataSet();
            da.Fill(ds);
            int i;
            if ((ds.Tables[0].Rows.Count > 0))
            {
                for (i = 0; (i
                            <= (ds.Tables[0].Rows.Count - 1)); i++)
                {
                    if ((ds.Tables[0].Rows[i]["pwd"].ToString ().ToUpper() == pwd.ToUpper()))
                    {
                        con.Dispose();
                        da.Dispose();
                        return ds.Tables[0].Rows[i]["role"].ToString ();
                    }
                    else
                    {
                        con.Dispose();
                        da.Dispose();
                       result= "Invalid Password";
                    }

                }

            }
            else
            {
                con.Dispose();
                da.Dispose();
                result= "Invalid Username";
            }

        }
        catch (Exception ex)
        {
        }

        return result;

    }

    public string CALL_RETURNVALUE(string SQLSTMT)
    {
        string ret="";
        try
        {
            NpgsqlConnection call_return_con;
            call_return_con = new NpgsqlConnection(ConfigurationManager.AppSettings["DSNPG"]);
            call_return_con.Open();
            NpgsqlCommand myretsqlcmd = new NpgsqlCommand(SQLSTMT, call_return_con);
            myretsqlcmd.CommandType = CommandType.Text;
           
            ret = myretsqlcmd.ExecuteScalar().ToString ();
           
        }
        catch (Exception ex)
        {
        }
        return ret;
    }

    public int modificatios(string SQLSTMT)
    {
        int result = 0;
        try
        {
            NpgsqlConnection call_return_con;
            call_return_con = new NpgsqlConnection(ConfigurationManager.AppSettings["DSNPG"]);
            call_return_con.Open();
            NpgsqlCommand myretsqlcmd = new NpgsqlCommand(SQLSTMT, call_return_con);
            myretsqlcmd.CommandType = CommandType.Text;
           result= myretsqlcmd.ExecuteNonQuery();
           return result;
        }
        catch (Exception ex)
        {
        }
        return result;
    }

    public DataSet fillcombos_fun(string MyTableName, string MyFieldName, string myWhereCondition, int MyWherePresent)
    {
        DataSet mycombods = new DataSet();
        try
        {
            //  Dim conopen As Integer = 0
            NpgsqlCommand myretsqlcmd = new NpgsqlCommand();
            NpgsqlConnection call_return_con = new NpgsqlConnection();
          
            NpgsqlDataAdapter mycomboadapter = new NpgsqlDataAdapter();
            call_return_con = new NpgsqlConnection(ConfigurationManager.AppSettings["DSNPG"]);
            if ((MyWherePresent == 1))
            {
                mycomboadapter = new NpgsqlDataAdapter(("select "
                                + (MyFieldName + (" from "
                                + (MyTableName + (" where " + myWhereCondition))))), call_return_con);
            }
            else if ((MyWherePresent == 2))
            {
                mycomboadapter = new NpgsqlDataAdapter(("select "
                                + (MyFieldName + (" from "
                                + (MyTableName + (" order by " + myWhereCondition))))), call_return_con);
            }
            else
            {
                mycomboadapter = new NpgsqlDataAdapter(("select "
                                + (MyFieldName + (" from " + MyTableName))), call_return_con);
            }

            mycombods = new DataSet();
            mycomboadapter.Fill(mycombods, MyTableName);
         
            mycomboadapter.Dispose();
            
            //  If conopen = 1 Then
            call_return_con.Close();
            // call_return_con = Nothing
            //  End If
            
        }
        catch (Exception ex)
        {
        }
        return mycombods;
    }

   public  DataSet CALL_PROC_SP(string SQLSTMT)
    {
        SqlDataAdapter da = new SqlDataAdapter();
        string cls_mysqlstatement;
        cls_mysqlstatement = SQLSTMT;
        SqlConnection sql_connection = new SqlConnection("Server=192.168.1.73;Database=samb;User ID=gussbee28;Password=$mango#17;MultipleActiveResultSets=True;");
        SqlCommand sql_command; 
        sql_command = new SqlCommand(SQLSTMT, sql_connection);
        DataSet ds = new DataSet();
        da.Fill(ds); 
        //  cls_con = Nothing
        sql_command.Dispose();
        return ds;
        //  End Try
    }

   public  Npgsql.NpgsqlDataReader CALL_PROC_DR(string SQLSTMT)
    {
        NpgsqlCommand cmd;
        NpgsqlConnection cls_con = new NpgsqlConnection(ConfigurationManager.AppSettings["DSNPG"]);
        cls_con.Open();
        cmd = new NpgsqlCommand(SQLSTMT, cls_con);
        NpgsqlDataReader dr;
        dr = cmd.ExecuteReader();
        cls_con.Close();
        return dr;
        //  End Try
    }
}