
<%
String category=request.getParameter("category");
System.out.println("Category:"+category);
String buffer="<select name='mode' id='mode' style='width: 100px; height:20px;  "+
" border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif;   "+
" color: #000000; <option value='Select' >Select</option>>"; 
try
{
if(category.contains("journeyFare"))
{
	System.out.println("In Ajax If Function");
	

	 buffer+="<option value='Bus'>Bus</option>";
	 buffer+="<option value='Train'>Train</option>";
	 buffer+="<option value='Air'>Air</option>";
	 buffer+="</select>";
	 out.println(buffer);

}
if(category.contains("hotelExp"))
{
	System.out.println("In Ajax If Function");
	 buffer+="<option value='Lodging'>Lodging</option>";
	 buffer+="<option value='D.A'>D.A</option>";
	 buffer+="<option value='Entertainment'>Entertainment</option>";
	 buffer+="</select>";
	 out.println(buffer);

}
if(category.contains("conveyance")|| category.contains("stationary") || category.contains("miscellaneous"))
{
	System.out.println("In Ajax If Function");
	String buffer1="<input type='text' name='mode' id='mode' style='width: 75px' value='-'/>";
	out.println(buffer1);
}
}
catch(Exception e)
{
	System.out.print(e);
	out.print("<select style='width: 100px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif;"+ 
	     " color: #000000; '>");
}

%>