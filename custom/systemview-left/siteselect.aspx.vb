Imports System.Data
Imports System.Collections
Imports ADODB
Partial Class siteselect
    Inherits System.Web.UI.Page
    '====================================================================================================================================================================
	Dim sitename() As String = {"Loji Merlimau","Loji Air Bukit Sebukor","Loji Asahan","Loji Bertam","Loji Gadek","Loji DAF"}
	' Loji Merlimau	
	Dim site_0() As String = {"8571", "8510", "8508", "8509", "8574", "8572", "8546", "8570", "8577", "8573"}
	' Loji Air Bukit Sebukor	
	Dim site_1() As String = {"8617", "8580", "8581", "8517", "TANGKI TAMAN LIMBONGAN PERMAI", "8584", "8583", "KOLAM AIR BUKIT SENJUANG"}
	' Loji Asahan	
	Dim site_2() As String = {"8514", "8575", "8576", "8507", "8506", "8522", "8578"}
	' Loji Bertam
    Dim site_3() As String = {"TANGKI TMN PAYA RUMPUT INDAH", "8540", "8582", "8585", "8566", "8515", "KOLAM BKT BERUANG", "8527", "8528", "8562", _
							  "KOLAM INDUSTRI LONDANG", "TANGKI TMN TG BIDARA INDAH", "8554", "8611", "8530", "8560", "TMN KESIDANG", "8616", "8615", "8512", "TANGKI TMN ANGKASANURI", "8550", "8543", "8542", "8545", _
							  "8590", "TANGKI TMN GAMILAN", "POWERTECK", "8559", "TANGKI TG DAHAN", "8551"}	
	' Loji Gadek
    Dim site_4() As String = {"8526", "8588", "TANGKI R/AWAM PULAU SEBANG", "TANGKI TMN DIMENSI", "TANGKI TMN SEBANG GEMILANG", "8592", "KOLAM INDUSTRI RUMBIA", "8529", "8557", "8563", "8614", "8591", "8586", "KAUSAR", "BKT BUSUK", "8555", "8587","8613", "TANGKI SOLOK MENGGONG", "8558", "TANGKI TMN KEBAYA", "8556", "TANGKI BANDAR BARU MASJID TANAH", "8547"}	
	' Loji DAF
    Dim site_5() As String = {"8501", "8537", "8544", "8541", "8519", "8518", _
							  "8525", "8610", "8524", "8503", "8531", "8532", "8523", "8536", "8561", "8549", "8548", _
							  "8502", "8505", "8504", "8589", "KOLAM TIARA", "8535", "8538", "8516", "8547", "8520", "8553", "8552", _ 
							  "8579","TANGKI TMN JUS PERMAI","8546", "8533", "8564", "8534", "SOLOK JENUANG"}
	'====================================================================================================================================================================
	function get_values(_obj,_att,_name,_data)
		dim i
		for i = 0 to _obj.length - 1
			if _obj(i).getAttribute(_att) = _name then
				if _data="textContent" then
					get_values = _obj(i).text
				else
					if _obj(i).getAttribute(_data)="" then
						get_values = ""
					else
						get_values = _obj(i).getAttribute(_data)
					end if
				end if
			end if
		next
	end function
	
	function summary_relocate(_obj,id)
		dim url
		if get_values(_obj,"id",id,"id") = "" then
			summary_relocate = "javascript:alert('Not Installed!');"
		else
			url = "../../Summary.aspx?siteid=" & id & "&sitename=" & get_values(_obj,"id",id,"textContent") & "&district=" & get_values(_obj,"id",id,"district") & "&sitetype=" & get_values(_obj,"id",id,"type")
			summary_relocate = url
		end if
	end function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
'========== bulid the XML url ===========
		dim x,y
		dim k = Split(Request.ServerVariables("PATH_INFO"), "/")
		dim kk
		dim random_number=int(rnd*9)+1
		for x=0 to k.length - 2
			select case x
				case 0
					kk = "/" & k(x)
				case k.length - 2
					kk = kk & k(x) & "/"
				case else
					kk = kk & k(x) & "/"
			end select
		next x
		kk = "http://" & Request.ServerVariables("SERVER_NAME") & kk & "feeds.aspx?sid=" & random_number
'=====================================
Response.Buffer = False
Dim xml,el,em
	xml = Server.CreateObject("Microsoft.XMLDOM")
	xml.async = False	
	xml.load (kk)	
If not xml.parseError.errorCode <> 0 Then
	if (xml.documentElement.hasChildNodes()) then
		el = xml.getElementsByTagName("site")
		'em = xml.getElementsByTagName("event")
		dim rekod = xml.getElementsByTagName("site_status")(0).getAttribute("recordcount")
'======================================= Building rule list for general use
		' for i = 0 to em.length - 1
			' if i = em.length - 1 then
				' arr_rule = arr_rule & em(i).getAttribute("ruleid")
			' else
				' arr_rule = arr_rule & em(i).getAttribute("ruleid") & "|"
			' end if
		' next		
'===================================== TEST START
        If Page.IsPostBack = False Then

            Dim cont1 As Integer = 0
            Dim cont2 As Integer = 0
			dim kira As Integer = 1
			for x=0 to sitename.length - 1
				kira = kira + 1
				TreeView1.Nodes.Add(New TreeNode(sitename(x), sitename(x)))
				cont1 += cont2
				TreeView1.Nodes(TreeView1.Nodes.Count - 1).NavigateUrl = "javascript:TreeView_ToggleNode(TreeView1_Data," & cont1 & ",TreeView1n" & cont1 & ",' ',TreeView1n" & cont1 & "Nodes)"
				select case x
					case 0
						for y=0 to site_0.length - 1
							Dim tn As TreeNode = New TreeNode(get_values(el,"id",site_0(y),"textContent"), site_0(y))
							'tn.NavigateUrl = "javascript:parent.showList('" & dist & "','" & str5("sitetype").value & "');"
							'http://www.g1.com.my/TelemetryMgmt_Selangor/Summary.aspx?siteid=0301&sitename=BUKIT+MAXWELL&district=Kuala+Lumpur&sitetype=RESERVOIR
							tn.Target = "main"
							tn.NavigateUrl = summary_relocate(el,site_0(y))
							TreeView1.Nodes(TreeView1.Nodes.Count - 1).ChildNodes.Add(tn)
							cont2 = (TreeView1.Nodes(TreeView1.Nodes.Count - 1).ChildNodes.Count) + 1
						next y
					case 1
						for y=0 to site_1.length - 1
							Dim tn As TreeNode = New TreeNode(get_values(el,"id",site_1(y),"textContent"), site_1(y))
							tn.Target = "main"
							tn.NavigateUrl = summary_relocate(el,site_1(y))
							TreeView1.Nodes(TreeView1.Nodes.Count - 1).ChildNodes.Add(tn)
							cont2 = (TreeView1.Nodes(TreeView1.Nodes.Count - 1).ChildNodes.Count) + 1
						next y					
					case 2
						for y=0 to site_2.length - 1
							Dim tn As TreeNode = New TreeNode(get_values(el,"id",site_2(y),"textContent"), site_2(y))
							tn.Target = "main"
							tn.NavigateUrl = summary_relocate(el,site_2(y))
							TreeView1.Nodes(TreeView1.Nodes.Count - 1).ChildNodes.Add(tn)
							cont2 = (TreeView1.Nodes(TreeView1.Nodes.Count - 1).ChildNodes.Count) + 1
						next y
					case 3
						for y=0 to site_3.length - 1
							Dim tn As TreeNode = New TreeNode(get_values(el,"id",site_3(y),"textContent"), site_3(y))
							tn.Target = "main"
							tn.NavigateUrl = summary_relocate(el,site_3(y))
							TreeView1.Nodes(TreeView1.Nodes.Count - 1).ChildNodes.Add(tn)
							cont2 = (TreeView1.Nodes(TreeView1.Nodes.Count - 1).ChildNodes.Count) + 1
						next y
					case 4
						for y=0 to site_4.length - 1
							Dim tn As TreeNode = New TreeNode(get_values(el,"id",site_4(y),"textContent"), site_4(y))
							tn.Target = "main"
							tn.NavigateUrl = summary_relocate(el,site_4(y))
							TreeView1.Nodes(TreeView1.Nodes.Count - 1).ChildNodes.Add(tn)
							cont2 = (TreeView1.Nodes(TreeView1.Nodes.Count - 1).ChildNodes.Count) + 1
						next y
					case 5
						for y=0 to site_5.length - 1
							Dim tn As TreeNode = New TreeNode(get_values(el,"id",site_5(y),"textContent"), site_5(y))
							tn.Target = "main"
							tn.NavigateUrl = summary_relocate(el,site_5(y))
							TreeView1.Nodes(TreeView1.Nodes.Count - 1).ChildNodes.Add(tn)
							cont2 = (TreeView1.Nodes(TreeView1.Nodes.Count - 1).ChildNodes.Count) + 1
						next y
				end select
			next x
        End If
'===================================== TEST END
	end if
else
	response.write("XML Errors!")
End If
	REM 'm_Tree.collapsePath(m_TreePath);
	REM 'm_Tree.expandPath(m_TreePath);
    End Sub
End Class