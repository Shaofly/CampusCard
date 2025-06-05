		//取值
		function validate_form(thisform)
		{
			with (thisform)
			{
				if (validate_required(bookID,"请填写图书编号！")==false)
					{bookID.focus();return false;}
				if (validate_number(bookID,"图书编号必需是1-3位数字！")==false)
					{bookID.focus();return false;}
				
				if (validate_required(bookName,"请填写图书名！")==false)
					{bookName.focus();return false;}
				
				if (validate_required(bTime,"请填写日期！")==false)
					{bTime.focus();return false;}
				if (validate_date(bTime,"日期格式不对！")==false)
					{bTime.focus();return false;}
				
				if (validate_required(bAuthor,"请填写作者！")==false)
					{bAuthor.focus();return false;}
				
				if (validate_required(bPrice,"请填写价格！")==false)
					{bPrice.focus();return false;}
				if (validate_realnumber(bPrice,"价格格式不对！")==false)
					{bPrice.focus();return false;}

				if (validate_required(bPPrice,"请填写促销价格！")==false)
					{bPPrice.focus();return false;}
				if (validate_realnumber(bPPrice,"促销价格格式不对！")==false)
					{bPPrice.focus();return false;}

				if (validate_required(bStock,"请填写图书库存！")==false)
					{bStock.focus();return false;}
				if (validate_number(bStock,"图书库存必需是1-3位整数！")==false)
					{bStock.focus();return false;}
				
				//if(check("两次输入的密码不同！")==false)
				//	{password1.focus();return false;}
			}
		}
		function validate_length(field, limit,alerttxt) 
		{
			with (field) {
	        	if (length > limit) {
	        		alert(alerttxt);
	        		return false;
	        	}
	        	else {return true;}
			}
		}
		function validate_number(field, alerttxt) 
		{//  
			with (field) {
	        	if (!(/^(0|[1-9]\d{0,2})$/.test(value))) {//
	         		alert(alerttxt);
	        		return false;
	        		
	        	}
	        	else {return true;}
			}
		}
		function validate_realnumber(field,alerttxt)
		{
			with (field)
			{
				if(!(/^(0|[1-9]\d{0,2})(\.\d{1,2})?$/.test(value)))
				{
					alert(alerttxt);
	        		return false;
				}
				else{return true;}
			}
		}
		function validate_date(field,alerttxt)
		{
			with (field)
			{
				if(!(/^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)$/.test(value)))
				{
					alert(alerttxt);
	        		return false;
				}
				else{return true;}
			}
		}
		// 校验字段非空函数
		function validate_required(field,alerttxt)
		{
			with (field)
				{
				  if (value==null||value=="")
				    {
					  alert(alerttxt);
					  return false;
				     }
				  else {return true;}
				}
		}
		//校验两次密码不同
		function check(alerttxt)
		{ 
		   with(document.all){
		   if(password1.value!=password2.value)
		   {
		     alert(alerttxt);
			 password1.value = "";
		     password2.value = "";
			 return false;
		   }else
		   {return true;}
		   }
		}
