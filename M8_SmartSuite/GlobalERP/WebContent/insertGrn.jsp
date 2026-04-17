<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
   <%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
   <%@ page import="org.apache.commons.fileupload.*"%>
   <%@ page import="java.util.List" %>
    <%@ page import="java.util.Iterator" %>
   <%@ page import="java.io.File" %>
   <%@ page import="java.io.*" %>
   <%@ page import="java.util.ArrayList"%>
   <%@ page import = "java.io.FileNotFoundException"%>
  	<%@ page import = "java.io.FileOutputStream"%>
  	<%@ page import = " java.io.IOException"%>
  	<%@ page import="javax.activation.*" %>

<%
	DecimalFormat twoDForm = new DecimalFormat("#.##");
	Statement st=null,st1=null,st2=null,st3=null,st4=null;
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
	String tdydate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	
	Date today = new Date();
	Calendar cal = Calendar.getInstance();
	cal.add(Calendar.DAY_OF_MONTH, +4);
	Date fourdayslaterAsDate = cal.getTime();
	String fourdayslaterDate=new SimpleDateFormat("yyyy-MM-dd").format(fourdayslaterAsDate);
	System.out.println("$$$$$$$$$$$$$$$$$$$$$$$           %%%%%%%%%%%%   "+fourdayslaterDate);
%>

<%
	
try{	
	System.out.println("in try");

	//System.out.println("chk     ."+request.getParameter("checkedNumber").toString()+".");
	Class.forName(DB_Driver);
	Connection con= DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
	st=con.createStatement();
	st1=con.createStatement();
	st2=con.createStatement();
	st3=con.createStatement();
	st4=con.createStatement();
	
	Date d=new Date();
	
	Format df1= new SimpleDateFormat("yyyy-MM-dd");
	String dtoday=df1.format(d);
	
	String pin="",son="",invval="",gross="",policy="",courier="",docketno="",spd="",materialdet="";
	String specifications="",warranty="",materialname="",expdate="";
	String assval="",formFileLg="";
	String checkedNumber="";
    String Twrefno="",Make="",Model="",Description="";
			
	String grnno="",grndate="",pono="",supcode="",shipdate="",carrier="",dtdate="",twempname="",proinv="",suporder="";
	String totalinv="",grossweight="",openpolicy="",TotalAssessableValue="",replaceFile="";
	int i=0,j=0;
	
	twempname=session.getAttribute("EmpName").toString();		
			
	String CompId=session.getAttribute("CompanyMasterID").toString();	
	System.out.println("CompId.."+CompId);		

			
    String InsertDateTime=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
    
	System.out.println("InsertDateTime.."+InsertDateTime);		
			
	String fileName="";
	  fileName=request.getParameter("formFileLg");
	  System.out.println("Excel file Name=== "+fileName);
 		
	  System.out.println("");	
		int newgrn=0;
		String sqlGrn="SElect MAX(GRNno) from "+session.getAttribute("CompanyMasterID").toString()+"purchasegrn ";
		ResultSet rsGrn=st.executeQuery(sqlGrn);
		if(rsGrn.next()){
			newgrn=rsGrn.getInt(1)+1;
		}	
			
			
		int saveflag=0,filecount = 0,filecount1 = 0,count1 = 0;
		String fname="",fname1="",fname2="";
		String savefilestring="",itemName="";
		File savedFile;
		File savedFile1;
		String[] filepath =new String[3];
		String[] filename =new String[3];
		String[] filepath1 =new String[3];
		String[] filename1 =new String[3];
	  	int age=0,finalage=0;
		ArrayList<String> qtylist = new ArrayList<String>();


				boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		
		if (!isMultipart)
		{
			System.out.println("\n\nin multipart..");
		} 
		else
		{
			System.out.println("\n\n in else with  multipart how are you..");
			FileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			List items = null;
			try 
			{
				items = upload.parseRequest(request);
			}
			catch (FileUploadException e)
			{
				e.printStackTrace();
			}
		
			Iterator itr = items.iterator();

			while (itr.hasNext()) 
			{
				FileItem item = (FileItem) itr.next();
				if(item.isFormField()) 
				{
					String name = item.getFieldName();
					//System.out.print("\n name==>"+name);
					String value = item.getString();
					 /* Featch information from Employee */
					 if (name.equals("pono")) {
					pono= value;
					System.out.println("\n pono ======*"
									+ pono);
				}
					 if(name.contains("quantity")){
							qtylist.add(value);
						}
						
						if (name.equals("suppliercode")) {
							supcode =  value;
							System.out.println("\n suppliercode ============*"
											+ supcode);
						}
						if (name.equals("shipdate")) {
							shipdate =  value;
							System.out.println("shipdate ============*"
											+ shipdate);
						}
						if (name.equals("carrier")) {
							carrier =  value;
							System.out.println("carrier ============*"
											+ carrier);
						}
						if (name.equals("dtdate")) {
							dtdate =  value;
							System.out.println("dtdate ============*"
											+ dtdate);
						}
						if (name.equals("checkedNumber")) {
							checkedNumber =  value;
							System.out.println("checkedNumber ============*"
											+ checkedNumber);
						}
						if (name.equals("pin")) {
							pin =  value;
							System.out.println("pin ============*"
											+ pin);
						}
						if (name.equals("son")) {
							son =  value;
							System.out.println("son ============*"
											+ son);
						}
						if (name.equals("invval")) {
							invval =  value;
							System.out.println("invval ============*"
											+ invval);
						}
						if (name.equals("gross")) {
							gross =  value;
							System.out.println("gross ============*"
											+ gross);
						}
						if (name.equals("policy")) {
							policy =  value;
							System.out.println("policy ============*"
											+ policy);
						}
						if (name.equals("assval")) {
							assval =  value;
							System.out.println("assval ============*"
											+ assval);
						}
						if (name.equals("courier")) {
							courier =  value;
							System.out.println("courier ============*"
											+ courier);
						}
						if (name.equals("docketno")) {
							docketno =  value;
							System.out.println("docketno ============*"
											+ docketno);
						}
						if (name.equals("spd")) {
							spd =  value;
							System.out.println("spd ============*"
											+ spd);
						}
						if (name.equals("materialdet")) {
							materialdet =  value;
							System.out.println("materialdet ============*"
											+ materialdet);
						
						}
						if (name.equals("specifications")) {
							specifications =  value;
							System.out.println("specifications ============*"
											+ specifications);
						}
						if (name.equals("warranty")) {
							warranty =  value;
							System.out.println("warranty ============*"
											+ warranty);
						}
						if (name.equals("materialname")) {
							materialname =  value;
							System.out.println("materialname ============*"
											+ materialname);
						}
						if (name.equals("expdate")) {
							expdate =  value;
							System.out.println("expdate ============*"
											+ expdate);
						
						}
						if (name.equals("formFileLg")) {
							formFileLg =  value;
							System.out.println("formFileLg ============*"
											+ formFileLg);
						
						}
						
				
		        }
		
		else 
		{	
				
			try 
			{

					itemName = item.getName();
					System.out.print("\n\nitemName22<<<<<<<<==>"+itemName);
					String replaceFileName=itemName.replaceAll("","");  //replace itemname with driver id
					if(itemName.equalsIgnoreCase(""))
					{
					}
					else
					{
						try
						{
					
							System.out.println("Inside try block where file upload..........");
							//savedFile = new File("/home/s_dhole/test/"+InsertDateTime+"_"+itemName);

							/* savedFile = new File("/usr/share/tomcat6/webapps/images1/savedimages/"+InsertDateTime+"_"+itemName); */
							 System.out.println("Item(File Name) name== "+itemName);
							replaceFile=pono+"_"+newgrn+"_"+InsertDateTime+itemName.replaceAll(itemName.substring(0,itemName.lastIndexOf(".")),formFileLg);  //Replace ItemName with Driver ID
							 
							 
							 System.out.println("Replace file name == "+replaceFile);
									
                    if(CompId.equals("100000")){
                    	
						//savedFile = new File("/home/twtech/Nishant/Documents/"+replaceFile);

						savedFile = new File("/usr/share/tomcat/webapps/TransworldDocs/ERPDocs/100000/GRNDocs/"+replaceFile);

                    }
    				
                    else  if(CompId.equals("100005")){
                    	
						savedFile = new File("/usr/share/tomcat/webapps/TransworldDocs/ERPDocs/100005/GRNDocs/"+replaceFile);

                    }
                    else if(CompId.equals("100010")){
                    	
						savedFile = new File("/usr/share/tomcat/webapps/TransworldDocs/ERPDocs/100010/GRNDocs/"+replaceFile);

                    }
                    else if(CompId.equals("100015")){
                   	
						savedFile = new File("/usr/share/tomcat/webapps/TransworldDocs/ERPDocs/100015/GRNDocs/"+replaceFile);

                   }
                    else if(CompId.equals("100025")){
                      	
						savedFile = new File("/usr/share/tomcat/webapps/TransworldDocs/ERPDocs/100025/GRNDocs/"+replaceFile);

                  }
                    else if(CompId.equals("100030")){
                     	
						savedFile = new File("/usr/share/tomcat/webapps/TransworldDocs/ERPDocs/100030/GRNDocs/"+replaceFile);

                 }
                    else if(CompId.equals("100035")){
                     	
						savedFile = new File("/usr/share/tomcat/webapps/TransworldDocs/ERPDocs/100035/GRNDocs/"+replaceFile);

                 }
                    else  if(CompId.equals("100037")){
                     	
						savedFile = new File("/usr/share/tomcat/webapps/TransworldDocs/ERPDocs/100037/GRNDocs/"+replaceFile);

                 }
                    else  if(CompId.equals("100037")){
                    	
						savedFile = new File("/usr/share/tomcat/webapps/TransworldDocs/ERPDocs/100037/GRNDocs/"+replaceFile);

                }
                    else  if(CompId.equals("100039")){
                    	
						savedFile = new File("/usr/share/tomcat/webapps/TransworldDocs/ERPDocs/100039/GRNDocs/"+replaceFile);

                }
                    else   if(CompId.equals("100041")){
                    	
						savedFile = new File("/usr/share/tomcat/webapps/TransworldDocs/ERPDocs/100041/GRNDocs/"+replaceFile);

                }
                    else   if(CompId.equals("100043")){
                    	
						savedFile = new File("/usr/share/tomcat/webapps/TransworldDocs/ERPDocs/100043/GRNDocs/"+replaceFile);

                }
                    else                    
                    {
                    	
						savedFile = new File("/usr/share/tomcat/webapps/TransworldDocs/ERPDocs/100046/GRNDocs/"+replaceFile);

                     }
							

							
							System.out.print("\n\n savedFile==>"+savedFile);
							item.write(savedFile);
							filepath[filecount]=""+savedFile;
								
							filename[filecount]=replaceFile;
							filecount++;
							if(saveflag==1)
							{
								 savefilestring=""+savedFile;
								 saveflag++;
							}
							else
								savefilestring=savefilestring+","+savedFile;
								 //out.print("successfully saved the file");
								//File file = new File(savedFile);
								String screenshot=savedFile.getAbsolutePath();
							System.out.println("\n\nscreenshot--->>>"+screenshot);
							
							/*  Code for save file 1  */
							saveflag=0;
									
							
							
							/*----------- End */

					}
					catch(Exception e)
					{
						e.printStackTrace();
					}
				}
						
					}
							
				 catch (Exception e) {
	  					e.printStackTrace();
	  				}
					}  /* else part end */
		}  /* While end */
			
	}		/* Main else part end */
			
			
		System.out.println("After excel file-->");

			
	 grndate=dtoday;
	 System.out.println("grndate-->"+grndate);


	
			 shipdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(shipdate));
			 
			 System.out.println("shipdate-->"+shipdate);

				dtdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(dtdate));
				
				 System.out.println("dtdate-->"+dtdate);

				expdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(expdate));
				 System.out.println("expdate-->"+expdate);

			 			 
	System.out.println("OLD Grnno-->"+grnno);
	System.out.println("New Grnno-->"+newgrn);
	System.out.println("GRNDate-->"+grndate);
	System.out.println("PONO-->"+pono);
	System.out.println("suppliercode-->"+supcode);		 
	System.out.println("shipdate-->"+shipdate);
	System.out.println("carrier-->"+carrier);
	System.out.println("DtDate-->"+dtdate);
	System.out.println("twempname-->"+twempname);
	System.out.println("proinv-->"+pin);
	System.out.println("suporder-->"+son);
	System.out.println("totalinv-->"+invval);
	System.out.println("grossweight-->"+gross);
	System.out.println("openpolicy-->"+policy);
	System.out.println("TotalAssessableValue-->"+assval);
	System.out.println("courier-->"+courier);
	System.out.println("docketno-->"+docketno);
	System.out.println("spd-->"+spd);
	System.out.println("materialdet-->"+materialdet);
	System.out.println("specifications-->"+specifications);
	System.out.println("warranty-->"+warranty);
	System.out.println("materialname-->"+materialname);
	System.out.println("expdate-->"+expdate);
	
	
	
	String sqlInsert="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"purchasegrn (GRNno ,GRNDate,PONo ,SupplierCode ,ShipmentDate ,Carrier ,DtBonded ,"+
					 "TWEmpName ,ProformaInvoiceNo ,SupOrderNo ,TotalInvoiceValue ,GrossWeight ,OpenPolicyNo ,TotalAssessableValue,CourierName,DocketNo,SenderPersonDetails,MaterialDetails,MaterialName,Specifications,Warranty,Exp_date,fileLink )"+
			
					 "VALUES ('"+newgrn+"','"+grndate+"','"+pono+"','"+supcode+"','"+shipdate+"','"+carrier+"','"+ dtdate+"','"+twempname+"','"+pin+"','"+son+"','"+invval+"','"+gross+"','"+policy+"','"+assval+"','"+courier+"','"+docketno+"','"+spd+"','"+materialdet+"','"+materialname+"','"+specifications+"','"+warranty+"','"+expdate+"','"+replaceFile+"')";			
	
	System.out.println(sqlInsert);	
	st2.executeUpdate(sqlInsert);  
	
	//for(i=0;i<number;i++)
	{
	System.out.println("In for loop");	 		
		//String grnno=request.getParameter("description"+i);
			String sql1="select TheGroup,Make,ItemCode,Quantity,TheTableToBeAccessed from "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder_items where pono='"+pono+"' order by itemcode";
			ResultSet rs1=st4.executeQuery(sql1);	
			while(rs1.next()){
				String thegroup=rs1.getString("TheGroup");
				String make=rs1.getString("Make");
				String itemcode=rs1.getString("ItemCode");
				String ordered=rs1.getString("Quantity");
				String TheTableToBeAccessed=rs1.getString("TheTableToBeAccessed");
			
				
		grnno=request.getParameter("grnnumber");
		// String quantity=request.getParameter("quantity"+i);
		 String quantity=qtylist.get(i);
		 System.out.println("Old GRN-->"+grnno);
		 System.out.println("Quantity-->"+quantity);
		
		 if(quantity=="" ||quantity==" "){
			 quantity="0";
		 }
		 
		//String sql="insert into t_purchasegrn_items (GRNno,TheGroup,Make,ItemCode,OrderedQuantity,ReceivedQuantity,TheTableToBeAccessed) select '"+newgrn+"',TheGroup,Make,ItemCode,Quantity,"+quantity+",TheTableToBeAccessed from t_purchaseorder_items where pono='"+pono+"'";
		String sql="insert into "+session.getAttribute("CompanyMasterID").toString()+"purchasegrn_items (GRNno,TheGroup,Make,ItemCode,OrderedQuantity,ReceivedQuantity,TheTableToBeAccessed) values ('"+newgrn+"','"+thegroup+"','"+make+"','"+itemcode+"','"+ordered+"','"+quantity+"','"+TheTableToBeAccessed+"')";
		System.out.println("Insert In GRN Items-->"+sql);
	
	
		st3.executeUpdate(sql);
		%>
		<input type="hidden" id ="quantity <%=i %>" name="quantity<%=i %>" value="<%= quantity%>" /> 
		<%	
		i++;
		 
			}
} 
		
	
	/* String balance="";
	String sqlBal="Select Balance from t_suppaymentsettleddetails where SupplierCode='"+supcode+"' Order By Balance Desc limit 1";
	ResultSet rsBal=st3.executeQuery(sqlBal);
	if(rsBal.next())
	{	
	balance=rsBal.getString(1);
	}
	else 
	{
		 balance="0";
	}	
	String sqlSupPyament="Insert Into t_suppaymentsettleddetails (SupplierCode ,InvoiceNo ,InvoiceValue ,InvoiceDate ,PaymentDetails ,AmountPaid ,Balance ,CurrType ,PaymentDate ,PaymentDoneTillNow ,TWEmpName)"+
						 " VALUES ('"+supcode+"','"+pinvoiceno+"','"+grandtotal+"','"+tdydate+"','-','0.00','"+balance+"','Domestic Inv in Rupees','-','0.00','"+session.getAttribute("EmpName")+"')";
	System.out.println(">>>>>>>>>    "+sqlSupPyament);
	st.executeUpdate(sqlSupPyament);
	
	
	*/

	//response.sendRedirect("alertGoTo.jsp?msg=New GRN with GRN No :"+newgrn+" Is Added Successfully In System.&goto=showDetailGrn.jsp?newgrn='"+newgrn+"'");

	response.sendRedirect("purchaseGRN report.jsp");
	/* 
	RequestDispatcher rd=request.getRequestDispatcher("purchaseGRN report.jsp");
	rd.forward(request,response); */
	//System.out.println("In Insert page after forward");
	 
	}
	catch(Exception e)
	{
	System.out.println( "Exception in INSERT QUOTATION ::"+e );
	e.printStackTrace();
	//response.sendRedirect("alertGoTo.jsp?msg=!!!! ERROR Inserting Record.Please try again.&goto=javascript:history.back()");
	}
	
%>