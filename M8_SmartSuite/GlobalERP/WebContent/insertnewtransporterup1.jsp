<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>

<%
	Connection con=null ;
	DecimalFormat twoDForm = new DecimalFormat("#.##");
	Statement sterp=null,sterp1=null,sterp2=null,sterp3=null,stupdate=null;
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
	
	
%>

<%
	try
	{	
		System.out.println("In insert new transporter page");
		Class.forName(DB_Driver);
		con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		sterp=con.createStatement();
		//sterp1=con.createStatement();
		sterp2=con.createStatement();
		sterp3=con.createStatement();
		stupdate = con.createStatement();
		int currentmonthcount=0,currentyearcount=0,previousyear=0,previousmonth=0;
		String currentyear="", finalmonth="";			
		String currentmonth="select MONTH('"+todaysDate+"')";
		System.out.println("current month query "+currentmonth);
		ResultSet rsMonth=sterp3.executeQuery(currentmonth);
		rsMonth.next();
		currentmonthcount=rsMonth.getInt(1);	
		System.out.println("Current month is"+currentmonthcount);
		currentyear="select YEAR('"+todaysDate+"')";
		System.out.println("current year query"+currentyear);
		ResultSet rsYear=sterp2.executeQuery(currentyear);
		rsYear.next();
		currentyearcount=rsYear.getInt(1);
		System.out.println("Current year is"+currentyearcount);	
		//if(currentmonthcount==1)
		//{
		//	currentyearcount=currentyearcount-1;
		//	currentmonthcount=12;
		//}
		
		System.out.println(currentmonthcount+"  "+currentyearcount );
		if(currentmonthcount==1 || currentmonthcount==2 || currentmonthcount==3 || currentmonthcount==4 || currentmonthcount==5 || currentmonthcount==6 || currentmonthcount==7 || currentmonthcount==8 || currentmonthcount==9 )
			//if(currentmonthcount==1)
			{
				finalmonth="0"+Integer.toString(currentmonthcount);
			}
			else if(currentmonthcount==10 || currentmonthcount==11 || currentmonthcount==12)
			{
				finalmonth=Integer.toString(currentmonthcount);
			}	
		
		System.out.println("Final month is"+finalmonth);
		
		/******************************************************************************/
		
		if(currentmonthcount==1)
			{
				previousyear=currentyearcount-1;
				previousmonth=12;
			    
				//	currentmonthcount=12;
			}
			else 
			{
				previousyear=currentyearcount;
				System.out.println("abcd  "+finalmonth);
				previousmonth=Integer.parseInt(finalmonth)-1;
				System.out.println("abcd  "+previousmonth);
			}
		
		/******************************************************************************/
		
		String strvehiclecode = request.getParameter("vehiclecode");
		System.out.println("vehiclecode in str is"+strvehiclecode);
		int vehiclecode = Integer.parseInt(strvehiclecode);
		System.out.println("vehiclecode in int is"+vehiclecode);
		String vehregno=request.getParameter("vehregno");
		System.out.println("vehregno is"+vehregno);
		String transporter=request.getParameter("transporter");
		System.out.println("transporter is"+transporter);
		int erpcode = Integer.parseInt(request.getParameter("erpcode"));
		System.out.println("erpcode is"+erpcode);
		String erpcustnm = request.getParameter("erpcustnm");
		System.out.println("erpcustnm is"+erpcustnm);
		int grpcd=Integer.parseInt(request.getParameter("grpcd"));
		System.out.println("grpcd is"+grpcd);
		String group = request.getParameter("group");
		System.out.println("group is"+group);
		String billtransporter = request.getParameter("billtransporter");
		System.out.println("billtransporter is"+billtransporter);
		String status=request.getParameter("status");
		System.out.println("status is"+status);
		int slaper = Integer.parseInt(request.getParameter("slaper"));
		System.out.println("slaper is"+slaper);
		int rate = Integer.parseInt(request.getParameter("rate"));
		System.out.println("rate is"+rate);
		String billtype = request.getParameter("billtype");
		System.out.println("billtype is"+billtype);
		String cp = request.getParameter("cp");
		System.out.println("cp is"+cp);
		if(cp=="Other")//if cp != "Use ERP",then cperson name comes from cpname input box
		cp = request.getParameter("cpname");
		System.out.println("cp is"+cp);
		Float stax = Float.parseFloat(request.getParameter("stax"));
		System.out.println("stax is"+stax);
		Float scharge = Float.parseFloat(request.getParameter("scharge"));
		System.out.println("scharge is"+scharge);
		Float jrm = Float.parseFloat(request.getParameter("jrm"));
		System.out.println("jrm is"+jrm);
		String strfromdate = request.getParameter("fromdate");
		System.out.println("strfromdate is"+strfromdate);
		//SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		//Date fromdate = new SimpleDateFormat("yyyy-MM-dd").parse(strfromdate);
		//System.out.println("fromdate is"+fromdate);
		int vehid=0;
				
		/*String sqlNew="CREATE TABLE IF NOT EXISTS `"+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+"` ( "
			         +" Select * from "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+currentyearcount+"_"+currentmonthcount+""
			         +" )";
		
		sterp.executeUpdate(sqlNew);
		System.out.println(sqlNew);*/
		/**********************************************************************************************************/			
		//String sqlVid="select MAX(Vehid) from "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+previousyear+"_"+previousmonth+"";
		/*ResultSet rsvid=sterp2.executeQuery(sqlVid);*/
		//System.out.println(sqlVid);
		
		//rsvid.next();
		//vehid=rsvid.getInt(1);
		//vehid++;
		/********************************************************************************************************/	
				
		String insert="Insert into "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+previousyear+"_"+previousmonth+" (Vehid,VehRegno,Transporter,ERPCode,ERPCustName,GroupCode,GroupName,BillTransporter,SLAPer,Rate,BillType,CPerson,ST,SC,jrm,FirstJRMDate) "+
					  "Values('"+vehiclecode+"','"+vehregno+"','"+transporter+"','"+erpcode+"','"+erpcustnm+"','"+grpcd+"','"+group+"','"+billtransporter+"','"+slaper+"','"+rate+"','"+billtype+"','"+cp+"','"+stax+"','"+scharge+"','"+jrm+"','"+strfromdate+"')";
		System.out.println(insert);
		
		sterp.executeUpdate(insert);
		
		System.out.println(insert);
		
		/*******************************************************************************************************/
		
		//String update = "UPDATE db_gps.t_vehicledetails set updatedinerp = 'Yes' where VehicleCode='"+vehiclecode+"'";
		
		/*System.out.println(update);*/
		
		//stupdate.executeUpdate(update);
		
		/*System.out.println(update);*/
		/******************************************************************************************************/
		String msg = "Vehicle Added Successfully!!";
		String gotopage = "VehicleAdditionNewup1.jsp";
		response.sendRedirect("alertGoTo.jsp?msg="+msg+"&goto="+gotopage);
		
		//out.println("Yes");
		//con.close();
	}
	catch(Exception e)
	{
		String msg = "Error In Adding Vehicle, Please Try Again!!";
		String gotopage = "VehicleAdditionNewup1.jsp";
		response.sendRedirect("alertGoTo.jsp?msg="+msg+"&goto="+gotopage);
		//e.printStackTrace();
		//out.println("No");
	}
%>	