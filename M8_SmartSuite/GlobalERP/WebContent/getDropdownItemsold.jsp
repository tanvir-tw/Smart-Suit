
<%@ include file="conn.jsp" %>

<%!
Connection con1;
%>

<% 
try {

Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
Statement stmt1=con1.createStatement();
ResultSet rs1=null;
String sql1="";
boolean flag=false;
String tableName="";

/*String[] globalModel;
String newModel="";
if(request.getParameter("Model")!=null)
{
 globalModel=request.getParameter("Model").split("::");	
 newModel=globalModel[0];

}*/

if(request.getParameter("group")!=null)
{
	System.out.println("in group!=null");
	String[] group=request.getParameter("group").split("::");
	
	System.out.println("/////////    "+group);
	
	int groupCode=Integer.parseInt(group[0]);
	String groupName=group[1];
	
	 String buffer="<select name='makeList' id='makeList' style='width: 150px; height:20px;  "+
	 " border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif;   "+
	 " color: #000000; ' onchange='OnChangeGetDetails(this,\"make\");'><option value='0::"+groupCode+"::"+groupName+"::0' >Select</option>"; 
	 int i=1;
	    
	if(groupCode<5)
	{
		System.out.println("in groupcode<5");
		tableName=session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5)+"makemaster";
		 sql1="SELECT MakeCode,MakeName from "+tableName.toLowerCase()+" group by MakeName";
		   rs1=stmt1.executeQuery(sql1);
		   while(rs1.next())
		   {
		      flag=true;
		      buffer+="<option value='"+rs1.getString(2)+"::"+groupCode+"::"+groupName+"::"+rs1.getString(1)+"'>"+rs1.getString(2)+"</option>";
		        i++;
		   } 
	}
	else
	{
		System.out.println("in groupcode is not <5");
		tableName=session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+groupCode;
		 sql1="SELECT distinct(MakeName) from "+tableName.toLowerCase()+" group by MakeName";
		   System.out.println(sql1);
		   rs1=stmt1.executeQuery(sql1);
		   while(rs1.next())
		   {
		      flag=true;
		      buffer+="<option value='"+rs1.getString(1)+"::"+groupCode+"::"+groupName+"::0"+"'>"+rs1.getString(1)+"</option>";
		        i++;
		   } 
	}
	
	   buffer+="</select>";
	out.println(buffer);
	System.out.println("Group buffer value is " +buffer);

}





else if(request.getParameter("make")!=null)
{
	System.out.println("in make!=null");
	String[] make=request.getParameter("make").split("::");
	
	System.out.println("/////////    "+make);
	
	String makeName=make[0];
	int groupCode=Integer.parseInt(make[1]);
	String groupName=make[2];
	String makeCode=make[3];

	if(groupCode<5)
	{
		tableName=session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5)+"im_make"+makeCode;
		 sql1="SELECT distinct(Model) from "+tableName.toLowerCase()+" group by Model";
	}
	else
	{
		tableName=session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+groupCode;
		 sql1="SELECT distinct(Model) from "+tableName.toLowerCase()+" group by Model";
	}
	
	 String buffer="<select name='modelList' id='modelList' style='width: 150px; height:20px;  "+
	 " border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif;   "+
	 " color: #000000; ' onchange='OnChangeGetDetails(this,\"model\");'><option value='0::"+tableName+"' >Select</option>"; 
	 int i=1;
	   System.out.println(sql1);
	   rs1=stmt1.executeQuery(sql1);
	   while(rs1.next())
	   {
	      flag=true;
	      buffer+="<option value='"+rs1.getString(1)+"::"+tableName+"' >"+rs1.getString(1)+"</option>";
	        i++;
	   } 
	   buffer+="</select>";
	out.println(buffer);
}

else if(request.getParameter("model")!=null)
{
	System.out.println("in model!=null");
	String[] model=request.getParameter("model").split("::");
	System.out.println("/////////    "+model);
	
	String modelName=model[0];
	tableName=model[1]; 
	
	
	String buffer="<select name='DescriptionList' id='DescriptionList' style='width: 300px;; height:20px;  "+
	 " border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif;   "+
	 " color: #000000; ' onchange='OnChangeGetDetails(this,\"description\");'><option value='0::"+tableName+"::0' >Select</option>"; 
	 int i=1;
	   sql1="SELECT Description  from "+tableName.toLowerCase()+" WHERE Model='"+modelName+"'  GROUP BY Description  ";
	   System.out.println(sql1);
	   rs1=stmt1.executeQuery(sql1);
	   while(rs1.next())
	   {
	      flag=true;
	      buffer+="<option value='"+rs1.getString(1)+"::"+tableName+"' >"+rs1.getString(1)+"</option>";
	        i++;
	   } 
	   buffer+="</select>##";
	   
	   buffer+="<select name='partNoList' id='partNoList' style='width: 200px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif;"+ 
	     " color: #000000; ' onchange='OnChangeGetDetails(this,\"partNo\");'>"+
		" <option value='0' >Select</option>";
		
		  sql1="SELECT partNo  from "+tableName.toLowerCase()+" WHERE Model='"+modelName+"' GROUP BY partNo  ";
		  System.out.println("IN MODEL    >>>    "+sql1);
		   rs1=stmt1.executeQuery(sql1);
		   while(rs1.next())
		    {
			     System.out.println("Partno is"+rs1.getString(1));
				 buffer+="<option value='"+rs1.getString(1)+"::"+tableName+"'  >"+rs1.getString(1)+"</option>";
			}
		
		buffer+="</select>";
		
	out.println(buffer);
}

else if(request.getParameter("partNo")!=null && request.getParameter("global")!=null)
{
	System.out.println("in partno!=null and global!=null");
	String[] partnoDate=request.getParameter("partNo").split("::");
	System.out.println("$$$$$   "+partnoDate);
	
	String partNumber=partnoDate[0];
	System.out.println("$$$$$   "+partNumber);
	
	tableName=partnoDate[1];
	System.out.println(" ????? "+tableName);

 	String[] model=request.getParameter("global").split("::");
	// String newmodel=model;
	System.out.println("<><><><><><><><><><><><><><><><<><><><><><><><><><><   "+model);
	
String b=model[0];
	System.out.println("?  "+b);
	
	
	//String newmodel=model.substring(0,model.indexOf("::"));
	//System.out.println("********************************* "+newmodel);
	
	/*	
	String abc="select Model from "+tableName.toLowerCase()+" where Partno='"+partNumber+"' and group by Model" ;
	System.out.println(""+abc);
	ResultSet rsModel=stmt1.executeQuery(abc);
	rsModel.next();
	String Md=rsModel.getString("Model");*/
	
	String buffer="<select name='DescriptionList' id='DescriptionList' style='width: 300px; height:20px;  "+
	 " border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif;   "+
	 " color: #000000; ' onchange='OnChangeGetDetails(this,\"description\");'><option value='-::"+tableName+"::0' >Select</option>"; 
	 int i=1;
	   sql1="SELECT Description  from "+tableName.toLowerCase()+" WHERE partNo='"+partNumber+"'  and Model='"+b+"'";
	   System.out.println("????????      "+sql1);
	   rs1=stmt1.executeQuery(sql1);
	   while(rs1.next())
	   {
	      flag=true;
	      buffer+="<option value='"+rs1.getString(1)+"::"+tableName+"' >"+rs1.getString(1)+"</option>";
	        i++;
	   } 
	   buffer+="</select>";
	out.println(buffer);
	
}
	
else if(request.getParameter("description")!=null && request.getParameter("newglobal")!=null)
{
	System.out.println("in description!=null and newglobal!=null");
	System.out.println("^^^^^^^^^^^^^^^^^^^^^^6  "+request.getParameter("description"));
		
	String[] details=request.getParameter("description").split("::");
	System.out.println(request.getParameter("description"));
	String description=details[0];
	tableName=details[1];
	
	String[] model=request.getParameter("newglobal").split("::");
	// String newmodel=model;
	System.out.println("<><><><><><><><><><><><><><><><<><><><><><><><><><><   "+model);
	
	String b=model[0];
	System.out.println("@@@@@   "+b);

	String respectivePartNumber=" ";
	
	String buffer="<select name='partNoList' id='partNoList' style='width: 200px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif;"+ 
    " color: #000000;' onchange='OnChangeGetDetails(this,\"partNo\");'>"+
	" ";
		
	  sql1="SELECT partNo  from "+tableName.toLowerCase()+" where description='"+description.replace("^^","+")+"'";
	  System.out.println(sql1);
	   rs1=stmt1.executeQuery(sql1);
	   String isSelected=" ";
	   while(rs1.next())
	    {
			 isSelected="selected='selected'";
			 buffer+="<option value='"+rs1.getString(1)+"::"+tableName+"' "+isSelected+" >"+rs1.getString(1)+"</option>";
		}
	
	buffer+="</select>";
	out.println(buffer);
}

} catch(Exception e) {  
	System.out.print(e);
	out.print("<select style='width: 150px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif;"+ 
	     " color: #000000; '>");
	
}
finally
{
	con1.close();
}
%>