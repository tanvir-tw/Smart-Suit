<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>

<%
	Connection con=null ;
	DecimalFormat twoDForm = new DecimalFormat("#.##");
	Statement st=null,st1=null,st2=null,st3=null,st4=null,st5=null;
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
%>

<%
try{	
		Class.forName(DB_Driver);
		con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
		st3=con.createStatement();
		st4=con.createStatement();
		st5=con.createStatement();
		
		 String Gname="",Gname_tab=""; 
		 String newmake="",newmodel="",newpartno="",newdescription="";
         Gname=request.getParameter("thegroup");
         System.out.println(">>>>>>>>>>>>>>>>.   "+Gname);
		
		 newmodel=request.getParameter("newmodel");
		 System.out.println(">>>>>>>>>>>>>>>>.   "+newmodel);
		 newpartno=request.getParameter("newpartno");
		 System.out.println(">>>>>>>>>>>>>>>>.   "+newpartno);
		 newdescription=request.getParameter("newdescription");
		 System.out.println(">>>>>>>>>>>>>>>>.   "+newdescription);
         String id=request.getParameter("id");
         System.out.println(">>>>>>>>>>>>>>>>.   "+id);
        
         
		 
	if(id.contains("group"))
	{
		
		
		String sqlGrpMasterNew="CREATE TABLE IF NOT EXISTS "+session.getAttribute("CompanyMasterID").toString()+"tbl_"+Gname.substring(0,5).toLowerCase()+"makemaster"+"( "+
			  "MakeCode int(11) NOT NULL auto_increment,"+
			  "MakeName varchar(150) default NULL,"+
			  "TheAlternativeMakeCode int(11) default NULL,"+
			  "IsDataValid tinyint(1) default '0',"+
			  "MajorAssemblyGroup int(11) default NULL,"+
			  "PRIMARY KEY  (MakeCode)"+
			  "	)";
		 st4.executeUpdate(sqlGrpMasterNew);	
		 System.out.println("INSERT NEW MAKE   masetrrrr "+sqlGrpMasterNew);
		
		
		
		
		
	         String sqlGroupMain="SELECT TheGroupName FROM  "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster where TheGroupName='"+Gname+"' limit 1";
	         System.out.println("\n\n QueryString"+sqlGroupMain);
	         ResultSet rsGroup2=st1.executeQuery(sqlGroupMain);
	      
	         if(rsGroup2.next())
	         {
	       	  System.out.println("*********");
	          Gname_tab=rsGroup2.getString("TheGroupName");
	          if(Gname_tab.equals(Gname)) 
	           	   System.out.println("......................................");
	         	   response.sendRedirect("alertGoTo.jsp?msg=The Group Name Already Exist!&goto=GroupMaster.jsp?id=group");
	          // out.println("Group "+Gname_tab+" already Exist!! ");
	          // n++;
	         }else
	         {
	         	  String sql1="insert into "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster (TheGroupName, Status)values('"+Gname+"','Active')";
	         	  st.executeUpdate(sql1);
	         	  System.out.println(sql1);
	         	  
	         	  String gcode="select TheGroupCode from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster where TheGroupName='"+Gname+"'";
	         	  ResultSet rscode=st2.executeQuery(gcode);	
	         	  rscode.next();
	         	  String code=rscode.getString("ThegroupCode");
	         	  
	         	  String createTable="CREATE TABLE IF NOT EXISTS "+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+code+" ( "+
	         		"ItemCode INT(11) NULL DEFAULT NULL,"+
	         		"Model VARCHAR(150) NULL DEFAULT NULL,"+
	         		"Partno VARCHAR(150) NULL DEFAULT NULL,"+
	         		"OldPartno VARCHAR(150) NULL DEFAULT NULL,"+
	         		"Description VARCHAR(255) NULL DEFAULT NULL,"+
	         		"LandedPrice FLOAT(10,2) NULL DEFAULT NULL,"+
	         		"PriceDate DATE NULL DEFAULT NULL,"+
	         		"SupplierCode INT(11) NULL DEFAULT NULL,"+
	         		"CostFactor FLOAT(4,2) NULL DEFAULT NULL,"+
	         		"SellingPrice FLOAT(10,2) NULL DEFAULT NULL,"+
	         		"IsDataValid TINYINT(1) NULL DEFAULT '0',"+
	         		"OEMPrices INT(11) NULL DEFAULT NULL,"+
	         		"InOurStock VARCHAR(25) NULL DEFAULT NULL,"+
	         		"EnteredBy VARCHAR(255) NULL DEFAULT NULL,"+
	         		"EnteredonDate DATE NULL DEFAULT NULL,"+
	         		"Specifications VARCHAR(150) NULL DEFAULT NULL,"+
	         		"MakeName VARCHAR(150) NULL DEFAULT NULL"+
	         		")";
	         	  
	         	  st2.executeUpdate(createTable);
	         	  System.out.println(">>>>>>>>>>>>   "+createTable);
	         	  
	         	  
	         	  String sqlItems="Insert into "+session.getAttribute("CompanyMasterID").toString()+"searchitems (groupcode ,GroupName,makecode ,makename ,makedettable ,ItemCode ,Model ,PartNo ,Description,pricedate)"+
	         	  " Values('"+code+"','"+Gname+"','0','-','-','0','-','-','-','0000-00-00')  ";
	         	  st.executeUpdate(sqlItems);
	         	  System.out.println(sqlItems);
	         	  
	         	  response.sendRedirect("alertGoTo.jsp?msg=NEW Group Name :"+Gname+"  Saved Successfully!&goto=GroupMaster.jsp?id=group");
	         }
			
	 }
		
     else if(id.contains("make"))
     {	
    	 	System.out.println("IN NEW MAKE>>>>   ");
    	 	int a=0;  String make=""; 	String getcode="", tblName=""; 	 
    	 	newmake=request.getParameter("newmake");
		 	System.out.println(">>>>>>>>>>>>>>>>.   "+newmake);
 			String grpstring=request.getParameter("group");
 			System.out.println(">>>>>>>>>>>>>>>>.   "+grpstring);
 			a=grpstring.indexOf("::");
 			System.out.println(a);
 			String grpcode=grpstring.substring(0,a);
 			System.out.println("GRP CODE  "+grpcode);
 			
 			String grname=grpstring.substring(a+2,grpstring.length());
 			System.out.println("GRP NAME ###   "+grname);
 			
 			int gcd=Integer.parseInt(grpcode);
 			System.out.println("NEW CODE IS   ***    "+gcd);
 			
 			if(gcd>5)
 			{
 				System.out.println(">>>  IN MAIN IF   ");
 	    	 	response.sendRedirect("alertGoTo.jsp?msg=You Can not Add Make for This Group!&goto=GroupMaster.jsp?id=make");	
 	 		}
 			
 			else
		 	{
		 			System.out.println(">>>  IN MAIN ELSE  ");
		 			String sqlGrpMaster="CREATE TABLE IF NOT EXISTS "+session.getAttribute("CompanyMasterID").toString()+"tbl_"+grname.substring(0,5).toLowerCase()+"makemaster"+"( "+
  	 			  "MakeCode int(11) NOT NULL auto_increment,"+
  	 			  "MakeName varchar(150) default NULL,"+
  	 			  "TheAlternativeMakeCode int(11) default NULL,"+
  	 			  "IsDataValid tinyint(1) default '0',"+
  	 			  "MajorAssemblyGroup int(11) default NULL,"+
  	 			  "PRIMARY KEY  (MakeCode)"+
  	 			  "	)";
  	 		 st4.executeUpdate(sqlGrpMaster);	
  	 		 System.out.println("INSERT NEW MAKE   masetrrrr "+sqlGrpMaster);
		 	    	 	
				 	String sql="Select MakeName from "+session.getAttribute("CompanyMasterID").toString()+"tbl_"+grname.substring(0,5).toLowerCase()+"makemaster where MakeName='"+newmake+"' ";   	 
		    	 	ResultSet rsmake=st.executeQuery(sql);
		    	 	System.out.println(">>>   "+sql);
		    
		    	 	if(gcd<5){
		    	 		tblName=session.getAttribute("CompanyMasterID").toString()+"tbl_"+grname.substring(0,5).toLowerCase()+"makemaster";
		    	 	}else
		    	 	{
		    	 		tblName=session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+gcd;
		    	 	}
		    	 	
		    	 	if(rsmake.next())
		    	 	{
		    	 		System.out.println(">>>  IN SECOND IF   ");
		        	 	
		    	 		 make=rsmake.getString("MakeName");
		    	 		if(make.equals(newmake))
		    	 		{
		    	 			System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&&&&&7  ");
		    	 		response.sendRedirect("alertGoTo.jsp?msg=The Make Name Already Exist!&goto=GroupMaster.jsp?id=make");	
		    	 		}
		    	 	}	
		    	 	else
		    	 	{
		    	 		System.out.println(">>>  IN SECOND ELSE  ");
		    	 		String sqlInsert="Insert into "+tblName+" (MakeName) Values ('"+newmake+"')";
		   				st1.executeUpdate(sqlInsert);
		    	 		System.out.println(">>  "+sqlInsert);
		    	 		
		    	 		String sqlGetCode="select MakeCode from "+session.getAttribute("CompanyMasterID").toString()+"tbl_"+grname.substring(0,5).toLowerCase()+"makemaster where MakeName='"+newmake+"' ";
		    	 		ResultSet rsgetcd=st3.executeQuery(sqlGetCode);
		    	 		System.out.println(">>  "+sqlGetCode);
		    	 		if(rsgetcd.next());
		    	 		getcode=rsgetcd.getString("MakeCode");
		    	 		System.out.println(">>  "+getcode);
		    	 		System.out.println("********************************* 8888888888 ");
		    	 		String sqlNewMake="CREATE TABLE IF NOT EXISTS "+session.getAttribute("CompanyMasterID").toString()+"tbl_"+grname.substring(0,5).toLowerCase()+"im_make"+getcode+"( "+
		    	 			  "ItemCode int(11) default NULL,"+
		    	 			  "Model varchar(150) default NULL,"+
		    	 			  "Partno varchar(150) default NULL,"+
		    	 			  "OldPartno varchar(150) default NULL,"+
		    	 			  "Description varchar(255) default NULL,"+
		    	 			  "LandedPrice float(10,2) default NULL,"+
		    	 			  "PriceDate date default NULL,"+
		    	 			  "SupplierCode int(11) default NULL,"+
		    	 			  "CostFactor float(4,2) default NULL,"+
		    	 			  "SellingPrice float(10,2) default NULL,"+
		    	 			  "IsDataValid tinyint(1) default '1',"+
		    	 			  "OEMPrices int(11) default NULL,"+
		    	 			  "InOurStock varchar(25) default NULL,"+
		    	 			  "EnteredBy varchar(255) default NULL,"+
		    	 			  "EnteredonDate date default NULL,"+
		    	 			  "ComprType varchar(250) default NULL,"+
		    	 			  "Service varchar(250) default NULL,"+
		    	 			  "Specifications longtext "+
		    	 			  "	)";
		    	 		 st2.executeUpdate(sqlNewMake);	
		    	 		 System.out.println("INSERT NEW MAKE  "+sqlNewMake);
		    	 		 
		    	 		 
		    	 		 
		    	 		/*String sqlItems="Insert into t_searchitems (groupcode ,GroupName,makecode ,makename ,makedettable ,ItemCode ,Model ,PartNo ,Description ,Price ,pricedate)"+
			         	  " Values();  "*/
			         	  
		    	 		 
		    	 		 
		    	 		 
		    	 		response.sendRedirect("alertGoTo.jsp?msg=NEW  MAKE WITH  NAME :"+newmake+" IS ADDED IN SYSTEM.&goto=GroupMaster.jsp?id=make");
		    	 	}
		        
		 	}//end of else 
     }
		
/*   
else if(id.contains("model"))
     {
        	 System.out.println("IN NEW MODEL  >>>>   ");
        	 
     }
		
     else if(id.contains("partno"))
     {
        	 System.out.println("IN NEW PAT NO   >>>>   ");
        	 
     }
		
     else if(id.contains("description"))
     {
        	 System.out.println("IN NEW DESCRIPTIOn  >>>>   ");
        	 
     }
		*/
		
}
catch(Exception e)
{
	System.out.println( "Exception ::"+e );
	e.printStackTrace();
	response.sendRedirect("alertGoTo.jsp?msg=!!!! ERROR Inserting Record.Please try again.&goto=javascript:history.back()");
}
finally
{
	//con.close();
}
%>			