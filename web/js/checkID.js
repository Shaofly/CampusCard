
	function validate_form()
	{
		var txt=document.getElementById("bID");
		if(txt.value==null||txt.value=="")
		{
			alert("请填写编号！");
			txt.focus();
			return false;
		}
		else {return true;}
	}

