<script runat="server">
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

function format_site_info(_obj,_name,_type)
	dim str = get_values(_obj,"name",_name,"textContent")
	if  str = "" then
		format_site_info = "N/A"
	else
		select case _type
			case 0 ' Unit Only
				format_site_info = get_values(_obj,"name",_name,"unit")
			case 1 ' Value & Unit
				format_site_info = str & " " & get_values(_obj,"name",_name,"unit")
			case else ' Value Only
				format_site_info = str
		end select
	end if
end function
</script>