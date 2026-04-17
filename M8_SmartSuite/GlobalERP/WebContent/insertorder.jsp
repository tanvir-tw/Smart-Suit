<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>
<%@page import="java.util.concurrent.CopyOnWriteArrayList"%>

<script>

function Redirect11()
{
	
	//alert('Contract Updated  ','','success');
		  var sono=document.getElementById("sono").value;
		 // alert(value1);
var value2=document.getElementById("SON").value;
//alert(value2);
var value3=document.getElementById("SOD").value;
//alert(value3);
var value4=document.getElementById("SOD1").value;

var companyname=document.getElementById("companyname").value;

 window.location.href="printSalesOrder.jsp?salesOrder="+sono+"&SON="+value2+"&SOD="+value3+"&companyname="+companyname+"&SOD1="+value4;
 
	    
	
}


</script>


<%
	Connection con=null ;
	DecimalFormat twoDForm = new DecimalFormat("#.##");
	Statement st=null,st1=null,st2=null,st3=null;
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
		
		int i=0;
		int a=0;
		String salesorderno="",custsalesorderno="";
		String salesorderdate="",salesordertime="";
		String discount="",tax="";
		String group="",quantity1="",sellingprice="";
		String description="";
		
		String checkno=request.getParameter("checkedNumber");
		String customercode=request.getParameter("customercode");
		String salesquodate=request.getParameter("salesquodate");
		String contactperson=request.getParameter("contactperson");
		String SOD=request.getParameter("SOD");		
		String SON=request.getParameter("SON");
		String SOD1=request.getParameter("SOD1");
		String companyname=request.getParameter("companyname");

		System.out.println("Customer Purchase Order No.=>"+SON);
		System.out.println("Customer Purchase Order Date.=>"+SOD);
		System.out.println("Customer Purchase Order No.=>"+SOD1);
%>
					<input type="hidden" name="SON"  id="SON" value="<%=SON%>"></input>
					<input type="hidden" name="SOD"  id="SOD" value="<%=SOD%>"></input>
					<input type="hidden" name="SOD1"  id="SOD1" value="<%=SOD1%>"></input>
					<input type="hidden" name="companyname"  id="companyname" value="<%=companyname%>"></input>


<%
		String SODF=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(SOD));	

		System.out.println("Customer after Purchase Order Date.=>"+SODF);
		
		System.out.println("contactperson ->"+contactperson);
		CopyOnWriteArrayList<Character> arrlist = new CopyOnWriteArrayList<Character>();
		   contactperson = contactperson.trim();
		   String cperson1="";
		   if(contactperson.contains("'"))
		   {	  
			      System.out.println("contact person contains single quotes");
		          char[] cp = contactperson.toCharArray();
		          int cntr=0;
		          for(int eye=0; eye<cp.length; eye++)
		          {
			         if(cp[eye]=='\'')
			         {
				       cntr++;  
			         }
		           }	   
		          System.out.println("number of single quotes in string is"+cntr);
		          for(int ii=0; ii<cp.length; ii++)
		          {
			        arrlist.add(cp[ii]);	
		          }	   
		          	         
		          StringBuilder builder = new StringBuilder(arrlist.size());
		          
		          for(Character ch: arrlist)
		          {	 		        	 		        	  		        	  
		        	  if(ch=='\'') 		        		 
			             { 
			               	 builder.append('\'');			                	 			                	 
			             }			       		        	  
		        	  builder.append(ch);		        	  		        	 
		          }			      		   
		       cperson1 = builder.toString();
		       System.out.println("contact after conversion is"+cperson1);
		   }		   
		   else
		   {
			   cperson1 = contactperson;
			   System.out.println("contact person doesn't contain single quote");
		   }   
		
		
		String state=request.getParameter("state");
		String address=request.getParameter("address");
		String fax=request.getParameter("fax");
		String phone=request.getParameter("phone");
		String city=request.getParameter("city");
		String country=request.getParameter("country");
		String zip=request.getParameter("zip");
		String salesquorefno=request.getParameter("salesquorefno");
		String company=request.getParameter("companyname");
		String salesquono=request.getParameter("salesquono");
		String terms=request.getParameter("terms");
		String total=request.getParameter("total");
		System.out.print(total+"  !!!!!!!!!!");
		String amountinwords=request.getParameter("rupees");
		String addresscode=request.getParameter("addresscode");
		String twempname=request.getParameter("twempname");
		int number=Integer.parseInt(request.getParameter("checkedNumber").toString());
		//String gcode=request.getParameter("gcode");
		//System.out.println("GROUP CODE IS      "+gcode);
		group=request.getParameter("group"); 
		System.out.println("GRUOP ID +++++   "+group);
		
		String gname="select TheGroupCode from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster where TheGroupName='"+group+"'";
		ResultSet rsgrp=st.executeQuery(gname);
		rsgrp.next();
		String grpcd=rsgrp.getString("TheGroupcode");
		
		/*String sqlDet = "SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det WHERE SalesQuoNo='"+ salesquono + "' ";
		ResultSet rsDet = st1.executeQuery(sqlDet);
		rsDet.next();*/
					
		int sono=0;
		String sqlOrderno="SELECT MAX(SalesOrderNo) from "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det ";
		ResultSet rs=st3.executeQuery(sqlOrderno);
		rs.next();  
			sono=rs.getInt(1);
		sono++;
		
		
		String salesorderrefno="SO";
		String s="";
		java.text.DecimalFormat df = new java.text.DecimalFormat("000");
		String idDate =  new SimpleDateFormat("ddMMyy").format(new Date());
		
		String sqlInc="SELECT SalesorderRefNo  from "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det WHERE SalesorderRefNo like ('"+salesorderrefno+""+idDate+"%') "+
						" ORDER BY  SalesorderRefNo DESC limit 1";
		ResultSet rs0=st2.executeQuery(sqlInc);
		
		if(rs0.next())
			salesorderrefno=rs0.getString(1).substring(0,rs0.getString(1).length()-3)+df.format(Integer.parseInt(rs0.getString(1).substring(rs0.getString(1).length()-3, rs0.getString(1).length()))+1);
		else
			salesorderrefno+=idDate+"001";
		
		
		String sql="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det (SalesOrderNo ,DeliveryDate,SalesQuoNo,	CustSalesOrderNo,CustomerCode, "+ 
				
				"SalesOrderDate, SalesOrderTime, SOTermsAndConditions,Total, "+
				
				"DiscountPercent,TotalinWords, TheGroup,InvoiceGenerated, "+
				
				"CurrType,CurrValue,TWEmpName,SOCancelled,SOCancelledOnDate,"+ 	
				
				"RevofSOrderNo,	NoofRevisions,ReasonForCancellingSO,Grandtotal,AddressCode ,"+
				
				"CompanyName,ContactPerson,	Address,city,Zip,State,country,"+ 	
				
				"Phone,Fax,	SalesorderRefNo,RevofSOrderRefNo,OrderType,OrderPrinted, CustPurON,CustPurDT)"+
				
				"VALUES('"+sono+"','"+SOD1+"','"+salesquono+"','-','"+customercode+"',"+
						
				"'"+todaysDate+"','"+todaysTime+"','"+terms+"','"+total+"',"+
				
				"'0.00','"+amountinwords+"','"+grpcd+"','0' ,"+
				
				"'Rupees','1','"+twempname+"','0' ,"+
				
				"'0000-00-00','0','0','-' ,"+
				
				"'0.00','"+addresscode+"','"+companyname+"','"+cperson1+"' ,"+
				
				"'"+address+"','"+city+"','"+zip+"','"+state+"' ,"+
				
				"'"+country+"','"+phone+"','"+fax+"','"+salesorderrefno+"' ,"+
				
				"'0','OldTaxOrder','No','"+SON+"', '"+SODF+"')";
		
		
	st.executeUpdate(sql);	
		
		for(i=0;i<number;i++)
		{
			if(null!=request.getParameter("check"+i))
			{
					discount=request.getParameter("discountPercent"+i);
					tax=request.getParameter("STPercent"+i);
					quantity1=request.getParameter("quantity"+i);
					sellingprice=request.getParameter("sellingPrice"+i);
					description=request.getParameter("description"+i);
					String mcode=request.getParameter("mcode"+i);
					String icode=request.getParameter("icode"+i);
					int no=Integer.parseInt(request.getParameter("gcode"+i));
					String tableToBeAccessed="";
					if(no< 5)
					{
						tableToBeAccessed=session.getAttribute("CompanyMasterID").toString()+"tbl_"+group.substring(0,5).toLowerCase()+"im_make"+mcode+"";
						System.out.println(tableToBeAccessed);
					}else 
						tableToBeAccessed=session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+grpcd;
					
					String sqlInsert="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items (SalesOrderNo,	TheGroup,Make,ItemCode,"+ 	
								"Quantity,SellingPrice,	DiscountPercent ,InvRaisedQty,TheTableToBeAccessed, "+
								"TheOptionNo,InsertOR,STPercent,ItemSrno,ItemDescription,TaxType)"+
								"VALUES('"+sono+"','"+no+"','"+mcode+"','"+icode+"','"+quantity1+"','"+sellingprice+"','"+discount+"','0','"+tableToBeAccessed+"','0','NULL','"+tax+"','"+checkno+"','"+description+"','NIL')";
				
				st1.executeUpdate(sqlInsert);	
			}
		}
		
		sql="UPDATE  "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det  set ThisIsSalesOrder='1'  where SalesQuoNo='"+salesquono+"' limit 1  ";
		st.executeUpdate(sql);
		
		//response.sendRedirect("alertGoTo.jsp?msg=Record Saved Successfully.&goto=home.jsp");
/* 		response.sendRedirect("alertGoTo.jsp?msg=Sales Order added successfully with Order No: "+salesorderrefno+" For Company: "+company+" .&goto=printSalesOrder.jsp?salesOrder="+sono+"&SON="+SON+"&SOD="+SOD+"&SOD1="+SOD1+"");
 */	
 %>
 					<input type="hidden" name="sono"  id="sono" value="<%=sono%>"></input>
 
 
 <%
		out.println("<script>  Redirect11();</script>");		

	
	}
	catch(Exception e)
	{
		System.out.println( "Exception ::"+e );
		e.printStackTrace();
		response.sendRedirect("alertGoTo.jsp?msg=!!!! ERROR Inserting Record.Please try again.&goto=javascript:history.back()");
	}
	finally
	{
		con.close();
	}
%>	