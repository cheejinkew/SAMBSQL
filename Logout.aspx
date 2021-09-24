<%@ Page Language="VB" Debug="true" %>
<script language="VB" runat="server">
Public strExtensionsToDelete = "gif"
Public strFolder = Server.MapPath("Temp")
Public objFSO = createobject("Scripting.FileSystemObject")
' ************************************************************
Function RecursiveDeleteByExtension(byval strDirectory,strExtensionsToDelete)
	dim objFolder, objSubFolder, objFile
	dim strExt	
	
	objFolder = objFSO.GetFolder(strDirectory)
	for each objFile in objFolder.Files
		for each strExt in SPLIT(UCASE(strExtensionsToDelete),",")
			if RIGHT(UCASE(objFile.Path),LEN(strExt)+1) = "." & strExt then
				'wscript.echo "Deleting:" & objFile.Path
				objFile.Delete
				exit for
			end if
		next
	next   
End Function
</script>
<%
	session("login") = ""
	RecursiveDeleteByExtension(strFolder,strExtensionsToDelete)	
	Response.Write("Clearing the temps!")	
%>
<script language="javascript">
  history.go(-history.length);
  //window.location="http://www.g1.com.my";
  //window.location="login.aspx";
</script>
