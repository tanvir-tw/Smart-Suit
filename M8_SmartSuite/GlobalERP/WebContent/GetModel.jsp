<%@ include file="conn.jsp"%>
<%@page import="java.io.*" import="java.sql.*"%>
<%@page import="java.text.*"%>
<%@page import="java.util.*"%>
<%!
 Connection con1;
%>
<%
try 
{
  System.out.println(">>>>\nIn GetModel.jsp");
  Class.forName(DB_Driver);
  con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
  Statement stmt1=con1.createStatement();
  Statement stmt2=con1.createStatement();
  ResultSet rs1=null,rs2=null;
  int itemcode=0;
  String sql1="",part="",desc="",tableName1="",sql2="";
  boolean flag=false,flag1=false;
  String tableName="",buffer="";
  String today=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
  String groupName=request.getParameter("groupName");
  int groupCode=Integer.parseInt(request.getParameter("groupCode"));
  int makeCode=Integer.parseInt(request.getParameter("makeCode"));
  String makeName=request.getParameter("makeName");
  String model_name=request.getParameter("model");
  String partno=request.getParameter("partno");
  String description=request.getParameter("description");
  String action=request.getParameter("action");
  System.out.println(">>>>>>>>action:"+action);
  int i=1,Mcode=0;
  String str1="",Model=null;  
  if(action.contains("check"))
  {
     if(groupCode<5)
	 {
		System.out.println("\n >>>>>>>>>In If ");
		tableName=session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5)+"makemaster";
		System.out.println(">>>>>>>:tableName:"+tableName);
	    sql1="SELECT MakeCode from "+tableName.toLowerCase()+" where MakeName='"+makeName+"'";
		System.out.println(">>>>>>>sql1:"+sql1);
		rs1=stmt1.executeQuery(sql1);
		if(rs1.next())
		{
			Mcode=rs1.getInt("MakeCode");
		}
		System.out.println(">>>>>>>Mcode:"+Mcode);
		tableName1=session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5)+"im_make"+Mcode;
		System.out.println(">>>>>>>:tableName1:"+tableName1);
		sql2="SELECT Model,Partno,Description from "+tableName1.toLowerCase()+" ";
		System.out.println(">>>>>>>:sql2:"+sql2);
		rs2=stmt2.executeQuery(sql2);
		while(rs2.next())
		{
			//System.out.println("\n >>>>>>>>>In While ");
			flag=true;
		    Model= rs2.getString(1);
	    	part=rs2.getString(2);
	    	desc=rs2.getString(3);
		    i++;
		    if(Model.contains(model_name) && part.contains(partno) && desc.contains(description))
			{
		        System.out.println("Model,Part,Description Name Already Exist in GroupName 1 to 4");
		    	flag1=true;
		    	break;
		    }
	    }
		if(flag==true)
	    {
		   if(flag1==true)
		   {
		   	  System.out.println("Model,Part,Description Already Exist in GroupName 1 to 4");
	          //response.sendRedirect("alertGoTo.jsp?msg=Model,Part,Description Already Exist1 &goto=MakeMODEL.jsp");
              buffer="#Yes";
		   }
		   else
		   {
		      /*System.out.println("Insert Query");
		      String Sinsert="INSERT INTO "+tableName1.toLowerCase()+"(Model,Partno,Description,LandedPrice,EnteredBy,EnteredonDate)values('"+model_name+"','"+partno+"','"+description+"','0','"+session.getAttribute("EmpName").toString()+"','"+today+"')";
		      stmt2.executeUpdate(Sinsert);
		      System.out.println(">>>>>>>>:"+Sinsert);
	          response.sendRedirect("alertGoTo.jsp?msg=Model,Part,Description Saved Successfully &goto=MakeMODEL.jsp");
                          */
              buffer="#No";
		   }
		}
		out.println(buffer);
	 }
	else
	{
		//System.out.println("\n >>>>>>>>>In Else ");
		tableName=session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+groupCode;
		System.out.println("Table Name========"+tableName);
		sql1="SELECT Model,Partno,Description from "+tableName.toLowerCase()+" ";
		
	    rs1=stmt1.executeQuery(sql1);
	    System.out.println(sql1);
	    //System.out.println(rs1);
	    while(rs1.next())
	    {
	    	System.out.println("\n>>>>>>>>>>>In While");
	    	flag=true;
	    	Model= rs1.getString(1);
	    	part=rs1.getString(2);
	    	desc=rs1.getString(3);
		    i++;
		    if(Model.contains(model_name) && part.contains(partno) && desc.contains(description))
			   {
			        System.out.println("Model Name Already Exist in GroupName <5"+tableName);
			    	flag1=true;
			    	break;
			   }
			   else
			   {
			    	  flag1=false;
			   }
		}
		if(flag==true)
		{
		   if(flag1==true)
		   {
			  //System.out.println("Model Name Already Exist in GroupName >5"+tableName);
	          ///response.sendRedirect("alertGoTo.jsp?msg=Model,Part,Description Already Exist!&goto=MakeMODEL.jsp");
			   buffer="#Yes";
		   }
		  else
		  {	  
			  System.out.println("Insert Query"); 
			  String Sinsert="INSERT INTO "+tableName+"(Model,Partno,Description,LandedPrice,EnteredBy,EnteredonDate,MakeName)values('"+model_name+"','"+partno+"','"+description+"','0','"+session.getAttribute("EmpName").toString()+"','"+today+"','"+makeName+"')";
			  stmt2.executeUpdate(Sinsert);
			  System.out.println(Sinsert);
	          response.sendRedirect("alertGoTo.jsp?msg=Model,Part,Description Saved Successfully.&goto=MakeMODEL.jsp");
           buffer="#No";
		  }
	    }
		out.println(buffer);
	}
}
else
{
	 if(groupCode<5)
	 {
		tableName=session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5)+"makemaster";
		System.out.println(">>>>>>>:tableName:"+tableName);
	    sql1="SELECT MakeCode from "+tableName.toLowerCase()+" where MakeName='"+makeName+"'";
		System.out.println(">>>>>>>sql1:"+sql1);
		rs1=stmt1.executeQuery(sql1);
		if(rs1.next())
		{
			Mcode=rs1.getInt("MakeCode");
		}
		tableName1=session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5)+"im_make"+Mcode;
		System.out.println(">>>>>>>:tableName1:"+tableName1);
		sql2="SELECT Max(ItemCode) from "+tableName1.toLowerCase()+" ";
		System.out.println(">>>>>>>:sql2:"+sql2);
		rs2=stmt2.executeQuery(sql2);
		if(rs2.next())
		{
			itemcode=rs2.getInt(1)+1;	
		}
		else
		{
			itemcode=1;
		}		
		String Sinsert="INSERT INTO "+tableName1.toLowerCase()+"(ItemCode,Model,Partno,OldPartno,Description,LandedPrice,PriceDate ,SupplierCode,CostFactor,SellingPrice,OEMPrices,InOurStock,EnteredBy,EnteredonDate)"+
					   "values('"+itemcode+"','"+model_name+"','"+partno+"','-','"+description+"','0','"+today+"','0','0.00','0.00','0','0','"+session.getAttribute("EmpName").toString()+"','"+today+"')";
		stmt2.executeUpdate(Sinsert);
		System.out.println(">>>>>>>>1111111111:"+Sinsert);
	   response.sendRedirect("alertGoTo.jsp?msg=Model,Part,Description Saved Successfully &goto=MakeMODEL.jsp");
        buffer="Yes";
		out.println(buffer);
	 }
	else
	{
		System.out.println("\n >>>>>>>>>In Else ");
		tableName=session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+groupCode;
		
		//tableName=session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5)+"makemaster";
		
		System.out.println(tableName);
		sql2="SELECT Max(ItemCode) from "+tableName.toLowerCase()+" ";
		System.out.println(">>>>>>>:sql2:"+sql2);
		rs2=stmt2.executeQuery(sql2);
		if(rs2.next())
		{
			itemcode=rs2.getInt(1)+1;	
		}
		else
		{
			itemcode=1;
		}
		String Sinsert="INSERT INTO "+tableName.toLowerCase()+"(ItemCode,Model,Partno,Description,LandedPrice,EnteredBy,EnteredonDate, MakeName)values('"+itemcode+"','"+model_name+"','"+partno+"','"+description+"','0','"+session.getAttribute("EmpName").toString()+"','"+today+"','"+makeName+"')";
		stmt2.executeUpdate(Sinsert);
		System.out.println(">>>>>>>>22222222222:"+Sinsert);	
		buffer="#Yes";
		out.println(buffer);
	}
}
  String com=(String)session.getAttribute("CompanyMasterID");
  System.out.println("Com -----00000000-------"+com);
  Statement st=con1.createStatement();
  String sqlItems="Insert into "+com+"searchitems(groupcode ,GroupName,makecode ,makename ,makedettable ,ItemCode ,Model ,PartNo ,Description ,Price ,pricedate)"+
     	  " Values('"+groupCode+"','"+groupName+"','"+makeCode+"','"+makeName+"','"+tableName+"','"+itemcode+"','"+model_name+"','"+partno+"','"+description+"','0','0000-00-00')  ";
  System.out.println("insert SearchItems table qry---- "+sqlItems);
  boolean b= st.execute(sqlItems);
  if(b){
	  System.out.println("inserted into t_searchItems");
  }
con1.close();
} catch(Exception e) {  
	System.out.print(e);
    response.sendRedirect("MakeMODEL.jsp");
}
finally
{
	//response.sendRedirect("alertGoTo.jsp?msg=Incident saved successfully  &goto=MakeMODEL.jsp");
}
%>