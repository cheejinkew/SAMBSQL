using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;


public class ruleList
{  
    public static string[] getEvent(string unitID, double value)
    {
        String sql_query = string.Empty;
        SqlConnection sql_connection = new SqlConnection("Server=203.223.159.168;Database=samb;User ID=gussbee28;Password=$mango#17;MultipleActiveResultSets=True;");
        SqlCommand sql_command;
        SqlDataReader sql_reader;

        string[] alarmType = new string[2];
        double[] alarmTypeValue = new double[5];
        double[] alarmTypeValue2 = new double[5];
        string[] ruleID = new string[5];
        string theRuleID = string.Empty;
        int a = 0;

        sql_query = "SELECT multiplier, ruleid FROM telemetry_rule_list_table where unitid = '" + unitID + "'";
        sql_command = new SqlCommand(sql_query, sql_connection);
        sql_connection.Open();
        sql_reader = sql_command.ExecuteReader();

        while (sql_reader.Read())
        {
            string[] tempMultiplier = sql_reader["multiplier"].ToString().Split(';');
            alarmTypeValue2[a] = double.Parse(tempMultiplier[2]);
            alarmTypeValue[a] = double.Parse(tempMultiplier[1]);
            ruleID[a] = sql_reader["ruleid"].ToString();
            a++;
        }
        sql_command.Dispose();
        sql_connection.Close();
        Array.Sort(alarmTypeValue2);
        Array.Sort(alarmTypeValue);
        if (value >= alarmTypeValue[4] && value <= alarmTypeValue2[4])
        {
            alarmType[0] = "HH";
            theRuleID = ruleID[1];
        }
        else if (value >= alarmTypeValue[3] && value < alarmTypeValue[4])
        {
            alarmType[0] = "H";
            theRuleID = ruleID[0];
        }
        else if (value >= alarmTypeValue[2] && value < alarmTypeValue[3])
        {
            alarmType[0] = "NN";
            theRuleID = ruleID[4];
        }
        else if (value >= alarmTypeValue[1] && value < alarmTypeValue[2])
        {
            alarmType[0] = "L";
            theRuleID = ruleID[2];
        }
        else if (value >= 0 && value <= alarmTypeValue[1])
        {
            alarmType[0] = "LL";
            theRuleID = ruleID[3];
        }
        else
        {
            if (value > alarmTypeValue2[4])
            {
                alarmType[0] = "Value exceed maximum";
                theRuleID = ruleID[1];
            }
            else
            {
                alarmType[0] = "Value below minimum";
                theRuleID = ruleID[3];
            }
        }
        alarmType[1] = theRuleID;
        return alarmType;
    }

}
