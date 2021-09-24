//*******************************************************************************************  
//Enabled and Disabled Text Box According to their relevant checkbox
//*******************************************************************************************  

  function DisabledText(strField)
  {
    if (strField =="chkCenterNo")
    {
      document.forms[0].txtCenterNo.value="";
      document.forms[0].txtCenterNo.disabled  = !document.forms[0].txtCenterNo.disabled;
    }
    else if (strField =="chkNewPass")
    {
      document.forms[0].txtNewPass.value="";
      document.forms[0].txtNewPass.disabled  = !document.forms[0].txtNewPass.disabled;
    }
    else if (strField =="chkDateTime")
    {
      document.forms[0].txtDateTime.value="";
      document.forms[0].txtHr.value="";
      document.forms[0].txtMin.value="";
      document.forms[0].txtSec.value="";
    
      document.forms[0].txtHr.disabled  = !document.forms[0].txtHr.disabled;
      document.forms[0].txtMin.disabled  = !document.forms[0].txtMin.disabled;
      document.forms[0].txtSec.disabled  = !document.forms[0].txtSec.disabled;
      
      if(!document.forms[0].chkDateTime.checked)
      {
        document.getElementById("calendar").style.visibility= "hidden";
      }
      else
      {
        document.getElementById("calendar").style.visibility= "visible";
      }
    }
    else if (strField =="chkHH")
    {
      document.forms[0].txtHH.value="";
      document.forms[0].txtHH.disabled  = !document.forms[0].txtHH.disabled;
    }
    else if (strField =="chkH")
    {
      document.forms[0].txtH.value="";
      document.forms[0].txtH.disabled  = !document.forms[0].txtH.disabled;
    }
    else if (strField =="chkL")
    {
      document.forms[0].txtL.value="";
      document.forms[0].txtL.disabled  = !document.forms[0].txtL.disabled;
    }
    else if (strField =="chkLL")
    {
      document.forms[0].txtLL.value="";
      document.forms[0].txtLL.disabled  = !document.forms[0].txtLL.disabled;
    }
    else if (strField =="ddLog")
    {

      if (document.forms[0].ddLog.value == "0")
      {
        document.forms[0].chkLog12am.checked  = false;
        document.forms[0].chkLog8am.checked  = false;
        document.forms[0].chkLog345pm.checked  = false;
 
        document.forms[0].chkLog12am.disabled = true;
        document.forms[0].chkLog8am.disabled = true;
        document.forms[0].chkLog345pm.disabled = true;
      }
      else
      {
        document.forms[0].chkLog12am.disabled = false;
        document.forms[0].chkLog8am.disabled = false;
        document.forms[0].chkLog345pm.disabled = false;
      }
    }
  }


//*******************************************************************************************  
//Check input validation before submittion
//*******************************************************************************************  

  function gotoSubmit()
  {
    if (document.forms[0].ddSite.value=="0,0")
    {
      document.forms[0].txtError.value = "Please Select Site !";
      document.forms[0].txtErrorColor.value = "red";
    }

    if (document.forms[0].txtError.value =="" && document.forms[0].ddMode.value=="0")
    {
      document.forms[0].txtError.value = "Please Select Mode !";
      document.forms[0].txtErrorColor.value = "red";
    }

    if (document.forms[0].txtError.value =="" && document.forms[0].txtPassword.value=="")
    {
      document.forms[0].txtError.value = "Please Enter Password !";
      document.forms[0].txtErrorColor.value = "red";
    }

    if (document.forms[0].txtError.value =="" && document.forms[0].txtPassword.value != strDBPwd)
    {
      //alert(strDBPwd + "; " + document.forms[0].txtPassword.value)
      document.forms[0].txtError.value = "Invalid Password. Try again !";
      document.forms[0].txtErrorColor.value = "red";
    }

    if (document.forms[0].txtError.value =="" && !document.forms[0].txtCenterNo.disabled)
    {
      if (document.forms[0].txtCenterNo.value == "")
      {
      document.forms[0].txtError.value = "Please Enter Center No !";
      document.forms[0].txtErrorColor.value = "red";
      }
    }

    if (document.forms[0].txtError.value =="" && !document.forms[0].txtNewPass.disabled)
    {
      if (document.forms[0].txtNewPass.value == "")
      {
      document.forms[0].txtError.value = "Please Enter New Password !";
      document.forms[0].txtErrorColor.value = "red";
      }
    }
 
    if (document.forms[0].txtError.value =="" && document.forms[0].chkDateTime.checked)
    {
      if (document.forms[0].txtDateTime.value == "")
      {
      document.forms[0].txtError.value = "Please Select a Date !";
      document.forms[0].txtErrorColor.value = "red";
      }
      else if (document.forms[0].txtHr.value == "")
      {
      document.forms[0].txtError.value = "Please Enter Hour !";
      document.forms[0].txtErrorColor.value = "red";
      }
      else if (document.forms[0].txtMin.value == "")
      {
      document.forms[0].txtError.value = "Please Enter Minute !";
      document.forms[0].txtErrorColor.value = "red";
      }
      else if (document.forms[0].txtSec.value == "")
      {
      document.forms[0].txtError.value = "Please Enter Second !";
      document.forms[0].txtErrorColor.value = "red";
      }
      if (document.forms[0].txtHr.value > 23)
      {
      document.forms[0].txtError.value = "Please Enter Hour Correctly !";
      document.forms[0].txtErrorColor.value = "red";      
      }else if (document.forms[0].txtMin.value > 59)
      {
      document.forms[0].txtError.value = "Please Enter Minute Correctly !";
      document.forms[0].txtErrorColor.value = "red";      
      }else if (document.forms[0].txtSec.value > 59)
      {
      document.forms[0].txtError.value = "Please Enter Second Correctly !";
      document.forms[0].txtErrorColor.value = "red";      
      }
    }
 
    if (document.forms[0].txtError.value =="" && !document.forms[0].txtHH.disabled)
    {
      if (document.forms[0].txtHH.value == "")
      {
      document.forms[0].txtError.value = "Please Enter HH for Threshold !";
      document.forms[0].txtErrorColor.value = "red";
      }
    }

    if (document.forms[0].txtError.value =="" && !document.forms[0].txtH.disabled)
    {
      if (document.forms[0].txtH.value == "")
      {
      document.forms[0].txtError.value = "Please Enter H for Threshold !";
      document.forms[0].txtErrorColor.value = "red";
      }
    }

    if (document.forms[0].txtError.value =="" && !document.forms[0].txtL.disabled)
    {
      if (document.forms[0].txtL.value == "")
      {
      document.forms[0].txtError.value = "Please Enter L for Threshold !";
      document.forms[0].txtErrorColor.value = "red";
      }
    }

    if (document.forms[0].txtError.value =="" && !document.forms[0].txtLL.disabled)
    {
      if (document.forms[0].txtLL.value == "")
      {
      document.forms[0].txtError.value = "Please Enter LL for Threshold !";
      document.forms[0].txtErrorColor.value = "red";
      }
    }

    if (document.forms[0].txtError.value =="" && !document.forms[0].chkCenterNo.checked && 
       !document.forms[0].chkNewPass.checked && !document.forms[0].chkDateTime.checked &&
       !document.forms[0].chkHH.checked && !document.forms[0].chkH.checked &&
       !document.forms[0].chkL.checked && !document.forms[0].chkLL.checked &&
        document.forms[0].ddLog.value == "0")
    {
      document.forms[0].txtError.value = "Please Select At Least ONE SETTING !";
      document.forms[0].txtErrorColor.value = "red";
    }

    if (document.forms[0].txtError.value =="" && document.forms[0].ddLog.value != "0")
    {
      if (!document.forms[0].chkLog12am.checked && !document.forms[0].chkLog8am.checked && !document.forms[0].chkLog345pm.checked)
      {
        document.forms[0].txtError.value = "Please Select Time Frame for Re-Poll Log Data !";
        document.forms[0].txtErrorColor.value = "red";
      }
    }
    

    if (document.forms[0].txtError.value =="")
    {
      document.forms[0].action="HelperPages/AddUnitConfig.aspx";
      document.forms[0].submit();
    }
    else
    {
      document.forms[0].submit();
    }
  }

//*******************************************************************************************  
//Get password for comparison
//*******************************************************************************************  

  function setSelectedSite(strSiteVersionID)
  {
     document.forms[0].chkHH.checked = false;
     document.forms[0].txtHH.value="";
     
     document.forms[0].chkH.checked = false;
     document.forms[0].txtH.value="";
     
     document.forms[0].chkL.checked = false;
     document.forms[0].txtL.value="";
     
     document.forms[0].chkLL.checked = false;
     document.forms[0].txtLL.value="";
     
     document.forms[0].ddLog.value ="0";
    
     document.forms[0].txtSiteVersionID.value= strSiteVersionID;
     document.forms[0].submit();
  }



