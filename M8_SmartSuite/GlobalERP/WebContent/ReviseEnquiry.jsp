<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>
		
<%		
	Connection con=null ;
	DecimalFormat twoDForm = new DecimalFormat("#.##");
	Statement st=null,st1=null,st2=null,st3=null;
	Date today = new Date();
	    
	String enqDate=new SimpleDateFormat("dd-MMM-yyyy").format(today);
	String enqTime=new SimpleDateFormat("HH:mm:ss").format(today);
		
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
	int i=0;
	int salesEnqNo=0;
%>       
	    
<%      
    try 
	{	
		Class.forName(DB_Driver);
		con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
		st3=con.createStatement();
		
	    String salesrefno=request.getParameter("salesenqrefno");
	    System.out.println("&************7&&&&&&&&&&&&&             "+salesrefno);
		int count=Integer.parseInt(request.getParameter("count").toString());
		String customercode=request.getParameter("customercode");
		String enqdate=request.getParameter("enqdate");
		
		String dueDate=request.getParameter("expirydate");
		System.out.println("DUE DATE    "+dueDate);
		String refno=request.getParameter("refno");
		String remark=request.getParameter("custremark");
		String addresscode=request.getParameter("addresscode");
		String company=request.getParameter("company");
		String contact=request.getParameter("contactperson");
		String address=request.getParameter("address");
		String city=request.getParameter("city");
		String zip=request.getParameter("zip");
		String state=request.getParameter("state");
		String country=request.getParameter("country");
		String phone=request.getParameter("phone");
		String fax=request.getParameter("fax");
		String salesenqrefno="";
	 	
		System.out.println("NONO   NON O    "+address);
		java.text.DecimalFormat df = new java.text.DecimalFormat("000");
		String seRefNo="SE";
	 	
		String date =  new SimpleDateFormat("ddMMyy").format(new Date());
		String sql1="SELECT SalesEnqRefNo,SalesEnqNo  from "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det  where SalesEnqRefNo like ('"+seRefNo+""+date+"%') ORDER BY SalesEnqRefNo DESC LIMIT 1";
		ResultSet rs=st1.executeQuery(sql1);
		if(rs.next())
			  seRefNo=rs.getString(1).substring(0,rs.getString(1).length()-3)+df.format(Integer.parseInt(rs.getString(1).substring(rs.getString(1).length()-3, rs.getString(1).length()))+1);
		else
			  seRefNo+=date+"001";
	 			
		String sqlMax="SELECT max(SalesEnqNo)  from "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det ";
		ResultSet rsMax=st2.executeQuery(sqlMax);
		if(rsMax.next())
		salesEnqNo=rsMax.getInt(1)+1;
		System.out.println("ENQ NO ****    &&&&&    "+salesEnqNo);
		
		String sqlUpdate="Update "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det set SalesEnqClosed =1 where SalesEnqRefNo='"+salesrefno+"'";
		System.out.println(sqlUpdate);	
		st.executeUpdate(sqlUpdate);
		
		String sqlInsert=" Insert into "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det (SalesEnqNo ,SalesEnqDate ,SalesEnqTime ,SalesEnqDueDate ,CustomerCode ,CustRefNo,"+
						 " CustRemarks ,SalesEnqType ,TWEmpName ,SalesEnqClosed ,ReasonForClosing ,AddressCode ,CompanyName ,ContactPerson, "+	
						 " Address ,city ,Zip ,State ,country ,Phone ,Fax ,SalesEnqRefNo) "+
						 " Values ('"+salesEnqNo+"','"+enqdate+"',"+
						 "	'"+enqTime+"','"+dueDate+"','"+customercode+"','"+refno+"','"+remark+"','0','"+session.getAttribute("EmpName")+"','0',"+
						 " '-','"+addresscode+"','"+company+"','"+contact+"','"+address+"','"+city+"','"+zip+"','"+state+"','"+country+"','"+phone+"','"+fax+"','"+seRefNo+"')";
		System.out.println(sqlInsert);
		st1.executeUpdate(sqlInsert);
		
		for(i=0;i<count;i++)
		{
		
		String group=request.getParameter("groupname"+i);
		System.out.println("GROUP    >>>"+group);
		String groupcode1=request.getParameter("groupcode"+i);
		System.out.println(" CODE   >>>>    "+groupcode1);
		String makecode1=request.getParameter("makecode"+i);
		System.out.println(" MCODE   >>>>    "+makecode1);
		String itemcode1=request.getParameter("itemcode"+i);
		System.out.println(" ITEMCODE   >>>>    "+itemcode1);
		
		String quantity1=request.getParameter("quantity"+i);
		System.out.println(quantity1);
		String desc=request.getParameter("description"+i);
		System.out.println(desc);
		String sellingprice=request.getParameter("sellingPrice"+i);
		String amount=request.getParameter("amount"+i);
		
		String tableToBeAccessed="";
		int no=0;
		if(no< 5)
		{
			tableToBeAccessed=session.getAttribute("CompanyMasterID").toString()+"tbl_"+group.substring(0,5).toLowerCase()+"im_make"+makecode1+"";
		}
		else 
			tableToBeAccessed=""+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+groupcode1;
		
		String sqlIn="Insert into "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items (SalesEnqNo ,TheGroup ,Make ,ItemCode ,Quantity ,PriceQuoted ,TheTableToBeAccessed ,TheOptionNo ,InsertOR ,Description)"+
					" Values('"+salesEnqNo+"','"+groupcode1+"','"+makecode1+"','"+itemcode1+"','"+quantity1+"','0','"+tableToBeAccessed+"','0','-','"+desc+"')";
		System.out.println(sqlIn);
		st2.executeUpdate(sqlIn);
		
		
		}
		
		response.sendRedirect("alertGoTo.jsp?msg=Sales Enq Revised successfully &goto=salesEnqReport.jsp?id=Revise");
			
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