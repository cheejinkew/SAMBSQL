
function gotoSearch(strForm, strURL)
{
   eval("document."+ strForm + ".txtStatus.value='Y'");
   eval("document."+ strForm + ".action=strURL");
   eval("document."+ strForm + ".submit()");
}

function checkCR(evt)
{

  var evt  = (evt) ? evt : ((event) ? event : null);
  var node = (evt.target) ? evt.target : ((evt.srcElement) ? evt.srcElement : null);
  //keyCode 13 is return key, keyCode 39 is single quote key
  if ((evt.keyCode == 13) && (node.type=="text")) {return false;}
  if ((evt.keyCode == 39) && (node.type=="text")) {alert("Single Quote is not allowed."); return false;}
 
 }


function getDelLenght(strForm)
{
  var strTolDel = 0;

  if (eval("document." + strForm + ".chkDelete && document." + strForm + ".chkDelete[0]"))
  {
    strTolDel = eval("document." + strForm + ".chkDelete.length");
  }
  else if (eval("document." + strForm + ".chkDelete"))
  {
    strTolDel = 1;
  }
  else
  {
    eval("document." + strForm + ".chkAllDelete.disabled=true");
  }
  return strTolDel;
}

function gotoCheckAll(strForm)
{
  var strTolDel = getDelLenght(strForm);
 
  if (strTolDel > 1)
  {
    if (eval("document." + strForm + ".chkAllDelete.checked"))
    {
      for(var intI = 0; intI < strTolDel; intI++)
      {
       eval("document." + strForm + ".chkDelete[intI].checked=true");
      }
    }
    else
    {
      for(var intI = 0; intI < strTolDel; intI++)
      {
       eval("document." + strForm + ".chkDelete[intI].checked=false");
      }
    }
  }
  else
  {
    if (eval("document." + strForm + ".chkAllDelete.checked"))
    {
    eval("document." + strForm + ".chkDelete.checked=true");
    }
    else
    {
    eval("document." + strForm + ".chkDelete.checked=false");
    }
  }
}


function gotoDelete(strForm, strURL)
{
  var blnSubmit = true;
  var strCheckDel=0;
  var strTolDel = getDelLenght(strForm);
  
  if(strTolDel > 1)
  {

    for(var intI = 0; intI < strTolDel; intI++)
    {
      if (eval("document." + strForm + ".chkDelete[intI].checked"))
      {
        strCheckDel=strCheckDel+ 1
      }
    }

    if (strCheckDel == 0)
    {
      alert ("No item to be deleted !");
      blnSubmit = false;
    }
  }
  else if (strTolDel == 1)
  {
     if(eval("!document." + strForm + ".chkDelete.checked"))
     {
      alert ("No item to be deleted !");
      blnSubmit = false;
     }
  }
  else
  {
    alert ("No item to be deleted !");
    blnSubmit = false;

  }
  if (blnSubmit)
  {
    eval("document." + strForm + ".action=strURL");
    eval("document." + strForm + ".submit()");
  }
}


function gotoUpdate(strForm, strField, strID)
{
  eval("document." + strForm + "." + strField + ".value=strID");
  eval("document." + strForm + ".submit()");
}


function moveRight(){
    var src = document.getElementById('cmbAvailable');
    var target = document.getElementById('cmbSelected');
    copyToList(src, target);
    }

function moveLeft(){
    var src = document.getElementById('cmbSelected');
    var target = document.getElementById('cmbAvailable');
    copyToList(src, target);
    }

function copyToList(from,to)
{
  var fromList = eval(from);
  //alert(fromList);
  var toList = eval(to);
  //alert(toList);
  
  if (toList.options.length > 0 && toList.options[0].value == 'temp')
  {
    toList.options.length = 0;
  }
  var sel = false;
  for (i=0;i<fromList.options.length;i++)
  {
    var current = fromList.options[i];
    if (current.selected)
    {
      sel = true;
      if (current.value == 'temp')
      {
        alert ('You cannot move this text!');
        return;
      }
      txt = current.text;
      val = current.value;
      toList.options[toList.length] = new Option(txt,val);
      fromList.options[i] = null;
      i--;
    }
  }
  if (!sel) alert ('You haven\'t selected any options!');
}


function IsInteger(value, field)
{
 
 var intExp = /[^0-9]/g; 
 if(!intExp.test(value))
 {}
 else
 {
 alert("Please Enter Intereger Value Only !");
 eval("document.forms[0]." + field + ".select()");
 }

}

function IsNumberDecimal(value, field)
{
 
 var intExp = /[^0-9.]/g; 
 if(!intExp.test(value))
 {}
 else
 {
 alert("Please Enter Numeric Value Only !");
 eval("document.forms[0]." + field + ".select()");
 }

}
