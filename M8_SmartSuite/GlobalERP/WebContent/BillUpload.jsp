<%@ page language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage="" %>

<html>
 <head>
 <title>Transworld Upload page</title>
 </head>
 <style type="text/css">@import url(jscalendar-1.0/calendar-win2k-1.css);</style>
	<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>
	<script type="text/javascript" src="js/ajax-dynamic-content.js"></script>
	<script type="text/javascript" src="js/ajax.js"></script>
	<script type="text/javascript" src="js/ajax-tooltip.js"></script>	
	<script src="sorttable.js" type="text/javascript"></script>
<script LANGUAGE="JavaScript" type="text/javascript">
var dispAtchFile=null;
//var dispDelFile=null;
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function MultiSelector( list_target, max ){

	
	
	var fileList=null;
	this.list_target = list_target;
	this.count = 0;
	this.id = 0;
	if( max ){
		this.max = max;
	} else {
		this.max = -1;
	};
	this.addElement = function( element ){
		if( element.tagName == 'INPUT' && element.type == 'file' ){

			element.name = 'file_' + this.id++;
			element.multi_selector = this;
			element.onchange = function(){
				var new_element = document.createElement( 'input' );
				new_element.type = 'file';
				this.parentNode.insertBefore( new_element, this );
				this.multi_selector.addElement( new_element );
				this.multi_selector.addListRow( this );
				this.style.position = 'absolute';
				this.style.left = '-1000px';
				
				
				
			};
			if( this.max != -1 && this.count >= this.max ){
				element.disabled = true;
			};

			// File element counter
			this.count++;
			// Most recent element
			this.current_element = element;
			
		} else {
			// This can only be applied to file input elements!
			alert( 'Error: not a file input element' );
		};

	};

	/**
	 * Add a new row to the list of files
	 */
	this.addListRow = function( element ){

		// Row div
		var new_row = document.createElement( 'div' );

		// Delete button
		var new_row_button = document.createElement( 'input' );
		new_row_button.type = 'button';
		new_row_button.value = 'Delete';

		// References
		new_row.element = element;

		//**cal 2 add atched files*****************************************
		if(dispAtchFile==null || dispAtchFile=="")
		{
			dispAtchFile=new_row.element.value;
			alert("add files===="+dispAtchFile);

		}
		else
		{
			//alert("add files===="+dispAtchFile);
			dispAtchFile=dispAtchFile+","+new_row.element.value;
		}
		testIt(dispAtchFile);
	//	document.getElementById("fileName").value=dispAtchFile;
		//******************************************************************

		// Delete function
		new_row_button.onclick= function(){

			// Remove element from form
			this.parentNode.element.parentNode.removeChild( this.parentNode.element );

			// Remove this row from the list
			this.parentNode.parentNode.removeChild( this.parentNode );

			//***cal 2 remove deltd files***************************************
			var dispDelFile=null;
			if(dispDelFile==null)
			{
				dispDelFile=this.parentNode.element.value;
			}
			else
			{
				dispDelFile=dispDelFile+","+this.parentNode.element.value;
			}
			
			//-----------------------------------------------------------------
			removeFileList(dispAtchFile,dispDelFile);
			//-----------------------------------------------------------------	
			
			//******************************************************************
			

			// Decrement counter
			this.parentNode.element.multi_selector.count--;

			// Re-enable input element (if it's disabled)
			this.parentNode.element.multi_selector.current_element.disabled = false;
				
			// Appease Safari
			//    without it Safari wants to reload the browser window
			//    which nixes your already queued uploads
			return false;
		};

		// Set row value
		new_row.innerHTML = element.value;
		if(fileList==null)
		{
			fileList=new_row.innerHTML;
		}
		else
		{
			fileList=fileList+","+new_row.innerHTML;
		}
		
//		getFileList(fileList);//Ajx fun
		
		// Add button
		new_row.appendChild( new_row_button );
		//alert(fileList);
			
		// Add it to the list
		this.list_target.appendChild( new_row );
		
		
	};

	

	
//	response.sendRedirect("fileData.jsp?fileList="+fileList);
};

function removeFileList(AddName,DelName)
{
	//alert(employeeList+"==="+delEmployee);
	var ajaxRequest;  // The variable that makes Ajax possible!
	try
	{
		// Opera 8.0+, Firefox, Safari
		ajaxRequest = new XMLHttpRequest();
	}  
	catch (e)
	{
		// Internet Explorer Browsers
		try
		{
			ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
		} 
		catch (e)
		{
			try
			{
				ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
			} 
			catch (e)
			{
				// Something went wrong
				alert("Your browser broke!");
				return false;
			}
		}
	}

	ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
		{
			var reslt=ajaxRequest.responseText;
	        testIt(reslt);
		} 
		
	}
	ajaxRequest.open("GET","fileDataDeleteBk.jsp?AddName="+AddName+"&DelName="+DelName,true);
	ajaxRequest.send(null);
}
function testIt(p1)
{
	dispAtchFile=p1.replace(/\s+/g,'');
	//alert("in testIt=====<>"+dispAtchFile);
	document.getElementById("fileName").value=dispAtchFile;
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function validate()
{
	var val1 = document.getElementById("fileName").value.replace(/\s+/g,'');
	if(val1=="")
	{
		alert("Please Select File For Upload");
		return false;
	}
	return true;
}
</script>
 <body>
 <table align="center" border="0">
 <tr><td>
 	<table>
	 <tr><td>
					 <table align="center" border="0">
					 <%
					 String resendMsg=request.getParameter("resendMsg");
					 if(!(resendMsg==null))
					 {
					 %>
					 <tr><td align="center"><b><%=resendMsg%></b></td></tr>
					 <%}
					 else
					 { %>
					 <tr><td align="center"><b><font size="4" color="#151B54">Multiple file Upload</font></b></td></tr>
					 <%}%>
					 </table>
	 </td></tr>
	 <tr><td>
					 <form action="BillNext.jsp" method="post" enctype="multipart/form-data" name="form1" id="form1">
					 
					   <center>
					   <table  border="0">
					       
					       <tr><td align="center">
					       <input type="file" name="MyFile" id="MyFile"/>
							
							<input type="hidden" name="fileName" id="fileName" value=""></input>
					       
					       </td></tr>
					       
					       <tr><td align="center">
					       <input  type="submit" id="submitButton1" value="Upload" onclick="return validate();">
					       </td></tr>
					       
					    </table>
					        </center>
					 </form>
	 </td></tr>
 </table>
 </td>
 <td>
 <table bgcolor="#E0DDFE" border="1" cellpadding="0" cellspacing="0">
		<tr><td align="center"><b>List Of Documents</b></td></tr>
		<tr bgcolor="white"><td align="center"><div id="files_list"></div></td></tr>
</table>
</td>
</tr>
</table>

</body>
<script type="text/javascript">
var multi_selector = new MultiSelector( document.getElementById('files_list'), 1);
multi_selector.addElement( document.getElementById('MyFile'));
//alert(valId);
</script>
 </html>
 