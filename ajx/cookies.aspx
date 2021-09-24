<%@ Page Language="VB" debug=true %>
<html>
<script language="VB" runat="server">
'dim _option = request.querystring("pilih")
Dim objCookie As HttpCookie 
	
'if _option = "mute" then
'	response.cookies("Alert")("alert_choice") = "NO"
'	Dim ExpiryDate as DateTime 
'	Dim CurrentDate as new DateTime() 

	'set to expire in 2010. 
'	ExpiryDate =new DateTime(2010, 12, 31) 
'	objCookie = new HttpCookie("LastVisit") 
'	objCookie.Value = CurrentDate.Now.ToString 
'	objCookie.Expires = ExpiryDate 
'	objCookie.Path = "/" 
	'Write cookie out 
'	Response.Cookies.Add(objCookie)
'end if

Sub ClearCookie 
	'Removes Cookie by setting Expires date to the past. 
	'Called when Remove Cookie Button is set 
	objCookie = Request.Cookies("LastVisit") 
	if not isNothing(objCookie) then 
		objCookie.Expires = new DateTime(2000, 1, 1) 
		response.AppendCookie(objCookie) 
	End if 
End Sub 

Sub Check_Cookie
'Get the cookie that saved the last visit 
objCookie = Request.Cookies("LastVisit") 

If Not(objCookie is Nothing) Then 
	if Trim(objCookie.Value) <> "" then 'if object is not nothing and value is not "" then person has been here before 
		lblCookie.Text = "Your last visit to this page was on " & objCookie.Value 
		
	Else 
		lblCookie.Text = "This is your first visit to this page." 
		
	End if 
Else 'If object is nothing, or value= "" then it's person's first visit 
	lblCookie.Text = "This is your first visit to this page." 	
End If 
End Sub

Sub Page_Load(sender As Object, e As EventArgs) 
	Check_Cookie
End Sub 

Sub btnCookieDetails_OnClick(sender As Object, e As EventArgs) 
'Get details of cookie. 
 objCookie = Request.Cookies("LastVisit") 
 If Not(objCookie is Nothing) Then 
    lblName.Text = "<B>Name</B>: " & objCookie.Name 
	lblValue.Text = "<B>Value</B>: " & objCookie.Value 
	lblHasKeys.Text = "<B>HasKeys</B>: " & objCookie.HasKeys.ToString() 
	lblSecure.Text = "<B>Secure</B>: " & objCookie.Secure.ToString() 
 Else 
	lblCookie.Text = "This is your first visit to this page." 
	lblName.Text = "(Cookie Not Set)" 
	lblValue.Text = "" 
    lblHasKeys.Text = "" 
    lblSecure.Text = "" 
 End If 
End Sub 

Sub btnClearCookie_OnClick(sender As Object, e As EventArgs) 
	'Refer to comments in ClearCookie function 
	ClearCookie 
End Sub 

Sub Set_Cookie
	Dim ExpiryDate as DateTime 
	Dim CurrentDate as new DateTime() 

	'set to expire in 2010. 
	ExpiryDate =DateAdd(DateInterval.Day, 1, now())'new DateTime(2010, 12, 31)
	objCookie = new HttpCookie("LastVisit") 
	objCookie.Value = CurrentDate.Now.ToString 
	objCookie.Expires = ExpiryDate 
	objCookie.Path = "/" 
	'Write cookie out 
	Response.Cookies.Add(objCookie)
End Sub

Sub btnSetCookie_OnClick(sender As Object, e As EventArgs) 
	Set_Cookie
End Sub
</script> 
<body onload="Page_Load" runat="server" /> 
<font face = "verdana,arial,helvetica" size="+1">

<b>Cookie Example</b></font><p> 
<asp:label id="lblCookie" runat="server" /><P></p> 

Click the Button below to see more details about this 
cookie:<p></p> 
<form action="cookie.aspx" method="post" runat="server"> 
<asp:Button id="btnSetCookie" text="Set Cookie" OnClick="btnSetCookie_OnClick" runat="server" /> 
<asp:Button id="btnCookieDetails" text="Get Cookie Details" OnClick="btnCookieDetails_OnClick" runat="server" /> 
<asp:Button id="btnClearCookie" text="Remove Cookie" OnClick="btnClearCookie_OnClick" runat="server" /><p></p> 
<asp:label id="lblName" runat="server" /><br> 
<asp:label id="lblValue" runat="server" /><br> 
<asp:label id="lblHasKeys" runat="server" /><br> 
<asp:label id="lblSecure" runat="server" /><br> <p> 
 
</form> 
</body> 
</html>
