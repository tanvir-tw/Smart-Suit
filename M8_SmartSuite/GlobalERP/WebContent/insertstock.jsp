<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>


<%
	Connection con=null ;
	DecimalFormat twoDForm = new DecimalFormat("#.##");
	Statement st=null,st1=null,st2=null,st3=null;
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
%>

<%
System.out.print("Insert");
	
	try{	
		Class.forName(DB_Driver);
		con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
		st3=con.createStatement();
		
		int grpcode=0;
		String groupname=request.getParameter("group");
		System.out.println("  "+groupname);
		String makename=request.getParameter("make");
		System.out.println("  "+makename);
		String itemcd=request.getParameter("itemcode");
		System.out.println("  "+itemcd);
		String stock=request.getParameter("stock");
		System.out.println("  "+stock);
		String mkcode=request.getParameter("makecode");
		System.out.println("  "+mkcode);
		grpcode=Integer.parseInt(request.getParameter("groupcode"));
		System.out.println("  "+grpcode);
		String desc=request.getParameter("description");
		String model=request.getParameter("model");
		System.out.println("  "+model);
		String partno=request.getParameter("partno");
		System.out.println("  "+partno);
		String table="";
		
		String tabletobeaccessed=groupname.substring(0,5);	
		if(grpcode<5)
			table=session.getAttribute("CompanyMasterID").toString()+"tbl_"+tabletobeaccessed.toLowerCase()+"im_make"+mkcode+"";
		else 
			table=""+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+grpcode+"";
		System.out.println("TABLE SIS       "+table);		
		
		String updatedata="Update "+table+" SET InOurStock='"+stock+"' where ItemCode ='"+itemcd+"'  and Description='"+desc+"' ";
		System.out.println("Update query;;  "+updatedata);
		st.executeUpdate(updatedata);	
	
		String insertdata="Insert into "+session.getAttribute("CompanyMasterID").toString()+"stockdetails(groupcode,GroupName,makecode,makename,ItemCode,Model,PartNo,Description,NewStock,EnteredBy,EnteredOn)"+
						  "Values ('"+grpcode+"','"+groupname+"','"+mkcode+"','"+makename+"','"+itemcd+"','"+model+"','"+partno+"','"+desc+"','"+stock+"','"+session.getAttribute("EmpName")+"','"+todaysDate+"')";
		System.out.println("INSERT "+insertdata);
		st1.executeUpdate(insertdata);
		
		response.sendRedirect("alertGoTo.jsp?msg=Stock is Updated for Item : "+desc+"&goto=stockdet.jsp");
		
		
		
		
	}
	catch(Exception e)
	{
		System.out.println( "Exception ::"+e );
		e.printStackTrace();
		response.sendRedirect("alertGoTo.jsp?msg=!!!! ERROR Inserting Record.Please try again. \n\n \n\n   "+e.toString().replace("'"," --")+"&goto=javascript:history.back()");
	}
	finally
	{
		con.close();
	}
%>	