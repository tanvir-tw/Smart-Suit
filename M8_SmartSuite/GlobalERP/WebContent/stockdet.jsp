<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%>
 <jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
 
	<script type="text/javascript">

function hideOptions()
{
	document.getElementById("options").style.display="none";
	document.itemSearch.submit.style.visibility="hidden";
	document.itemSearch.item.value="";
}

function showItemDetails(item)
{
	document.itemSearch.item.value=item.replace("~","&");
	//window.location="?item="+item;
	document.getElementById("itemDescription").style.visibility="hidden";
}
	
function getItems()
{
	//alert(" 88888888888888888888888888  ");
		var item=document.itemSearch.item.value;

		var ajaxRequest;  // The variable that makes Ajax possible!

		try{
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
				document.getElementById("itemDescription").innerHTML=reslt;
			} 
		}
		
		var queryString = "?item=" +item;
		ajaxRequest.open("GET", "AjaxGetItems.jsp" + queryString, true);
		ajaxRequest.send(null); 

		document.getElementById("itemDescription").style.visibility="visible";
	
}
	 



</script>

<%
String supp="?";
	if(request.getParameter("searchBy")!=null)
		if(request.getParameter("searchBy").equalsIgnoreCase("Supplier"))
		supp=request.getParameter("supplier");
%>
<body onload="showVisitingCard('<%=supp %>')">
	 
<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
%>
<%
	java.text.DecimalFormat df = new java.text.DecimalFormat("0.00");
	
		Connection conn = null;
			Statement st = null, st1 = null;
			Statement st2 = null;
			String groupname="",makename="",model="",partno="";
			int groupcode=0,makecode=0,itemcode=0;
			String FollowUpType = "",tabletobeaccessed="";String sqldata="";
%>
<%
		String fromDateCal = "", toDateCal = "",sql="";
			fromDateCal = toDateCal = new SimpleDateFormat("dd-MMM-yyyy")
					.format(new java.util.Date());
			
			if(request.getParameter("fromdate")!=null)
			{
				fromDateCal=request.getParameter("fromdate");
				toDateCal=request.getParameter("todate");
				
			}
			try {
				conn = erp.ReturnConnection();
				st = conn.createStatement();
				st1 = conn.createStatement();
				st2 = conn.createStatement();
			} catch (Exception e) {
				e.printStackTrace();
			}
 
%>
<div style="font-size: 1.8em; text-align: center; " ><a> Stock Details</a></div>
<br>
<form name='itemSearch' action="" method="get">

<table  border="0" align="center">
		<tr>
			<td style="width: 330px;"><b>	Search Item:</b>
	<input type="text" name="item" id="search-text" style="width:230px;" autocomplete="off"  value=""  onkeyup="if (event.keyCode == 27){document.getElementById('itemDescription').style.display = 'none';} else { getItems(); }" /> 
	 &nbsp;&nbsp;&nbsp;<br>
	 <div style="position: absolute;"  >
	 <table><tr><td>
	 	
	 </td></tr>
	 <tr><td>
	 <div id='itemDescription'>
	 </div>
	 </td></tr>
	 </table>
	 </div>
     </td>
 	<td><input type="submit" name="submit" id="submit" style="border: outset;"
				value="GO"></input></td>
	  </tr> 
</table>
</form>
<br>
<%
try
{
	
if(null!=request.getQueryString())
{	
%>

<div align="center" style="font-size: 1.5em; margin-top: 0.5em; margin-bottom: 0.3em; height: 3px; background-color: #339CCB">
</div>
<div align="center" style="font-size: 1.5em; ">
	<a>Details of : <%=request.getParameter("item") %></a> 
</div>
	<br>
<form name="itemupdate" action="insertstock.jsp" method="post">	
<table class="sortable">
<tr>
<th>Group</th>
<th>Make</th>
<th>Description</th>
<th>Stock</th>
<th>Entered By</th>
<th>Entered On</th>
</tr>
<%

	String sqlItems="select * from "+session.getAttribute("CompanyMasterID").toString()+"searchitems where Description = '"+request.getParameter("item").replace("~","&")+"'";
	System.out.println(sqlItems);
	ResultSet rsitem=st1.executeQuery(sqlItems);
	if(rsitem.next())
	{
		groupcode=rsitem.getInt("groupcode");
		groupname=rsitem.getString("GroupName");
		makecode=rsitem.getInt("makecode");
		makename=rsitem.getString("makename");
		itemcode=rsitem.getInt("ItemCode");
		
		if(groupcode<5)
		{
			
		tabletobeaccessed=groupname.substring(0,5);	
		System.out.println(">> >>>  >?????  "+tabletobeaccessed);
		sqldata="select * from "+session.getAttribute("CompanyMasterID").toString()+"tbl_"+tabletobeaccessed.toLowerCase()+"im_make"+makecode+" where Description ='"+request.getParameter("item")+"' and ItemCode='"+itemcode+"'";
	
		}
		else 
			sqldata="select * from "+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+groupcode+" where Description ='"+request.getParameter("item")+"' and ItemCode='"+itemcode+"'";
			
		System.out.println("////////  //////   "+sqldata);
		ResultSet rsdata=st2.executeQuery(sqldata);
		if(rsdata.next())
		{
			System.out.println("<>><><><><><><><><><   "+rsdata.getString("Description"));
%>
<tr>
<td><div align="left"><input type="hidden" name="group" id="group" value="<%=groupname %>"/><%=groupname %></div></td>
<td><div align="left"><input type="hidden" name="make" id="make" value="<%=makename %>"/><%=makename %></div></td>
<td><div align="left"><input type="hidden" name="description" id="description" value="<%=rsdata.getString("Description") %>"/><%=rsdata.getString("Description")%></div></td>
<td><div align="right"><input type="text" id="stock" name="stock" style="width:70px;padding: 4px 5px 2px 5px;
			border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
			color: #000000; " value="<%=rsdata.getString("InOurStock")%>" /></div></td>
<td><%=rsdata.getString("EnteredBy")%></td>
<td><%=rsdata.getString("EnteredonDate")%></td>
</tr>
<input type="hidden" name="itemcode" id="itemcode" value="<%=itemcode %>"/>
<input type="hidden" name="makecode" id="makecode" value="<%=makecode %>"/>
<input type="hidden" name="groupcode" id="groupcode" value="<%=groupcode %>"/>
<input type="hidden" name="model" id="model" value="<%=rsdata.getString("Model") %>"/>
<input type="hidden" name="partno" id="partno" value="<%=rsdata.getString("Partno")%>"/>
<%			

			
		}
		
%>
 </table></form>
 <br>
 <div align="center"><input type="submit" name="Update" value="UPDATE" style="border: outset; background-color: #C6DEFF;width: 150px;"/></div>
<%	
	}

	else
	{
		%>
		
		<table class="sortable">
		<tr>
		<td colspan="5">NO DATA</td>
		</tr>
		
		</table>
		</br>
		
<!-- </form> -->
<%
	
	}
}
}
catch(Exception e)
{
	
}
finally
{
	conn.close();
}
%>
<!-- <br><br><br><br><br><br> -->
<!-- <br><br><br><br><br><br> -->
<!-- 	 	<br><br><br><br> -->
<!-- 	<div id="footer"> -->
<!-- 	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009 -->
<!-- 	by Transworld  Technologies Ltd. All Rights Reserved.</a></p> -->
<!-- 	</div> -->
	<!-- end #footer -->
	</body>
	</html>
</jsp:useBean>
<%@include file="footer_new.jsp"%>