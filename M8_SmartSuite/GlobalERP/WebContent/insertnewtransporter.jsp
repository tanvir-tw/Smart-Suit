<%@page import="com.ConnectionClass"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>

<%
	Connection con=null ;
	ConnectionClass connection = new ConnectionClass();
	Statement sterp=null;
%>

<%
	try
	{	
		System.out.println("In insert new transporter page");
		
		con = connection.getConnect("db_GlobalERP");
		sterp=con.createStatement();
		
		int currentmonthcount=0,currentyearcount=0,previousyear=0,previousmonth=0;
		String currentyear="", finalmonth="",fpreviousmonth="";			
		
		System.out.println(currentmonthcount+"  "+currentyearcount );
		if(currentmonthcount==1 || currentmonthcount==2 || currentmonthcount==3 || currentmonthcount==4 || currentmonthcount==5 || currentmonthcount==6 || currentmonthcount==7 || currentmonthcount==8 || currentmonthcount==9 )
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
			}
			else 
			{
				previousyear=currentyearcount;
				previousmonth=Integer.parseInt(finalmonth)-1;
			}
		
		if(previousmonth==1 || previousmonth==2 || previousmonth==3 || previousmonth==4 || previousmonth==5 || previousmonth==6 || previousmonth==7 || previousmonth==8 || previousmonth==9 )
			{
				fpreviousmonth="0"+Integer.toString(previousmonth);
			}
			else if(previousmonth==10 || previousmonth==11 || previousmonth==12)
			{
				fpreviousmonth=Integer.toString(previousmonth);
			}
		
		/******************************************************************************/
		
		String strvehiclecode = request.getParameter("vehiclecode");
		int vehiclecode = Integer.parseInt(strvehiclecode);
		String vehregno=request.getParameter("vehregno");
		String transporter=request.getParameter("transporter");
		int erpcode = Integer.parseInt(request.getParameter("erpcode"));
		String erpcustnm = request.getParameter("erpcustnm");
		int grpcd=Integer.parseInt(request.getParameter("grpcd"));
		String group = request.getParameter("group");
		String billtransporter = request.getParameter("billtransporter");
		int slaper = Integer.parseInt(request.getParameter("slaper"));
		int rate = Integer.parseInt(request.getParameter("rate"));
		String billtype = request.getParameter("billtype");
		String cp = request.getParameter("cp");
		if(cp.equalsIgnoreCase("Other"))//if cp != "Use ERP",then cperson name comes from cpname input box
		{
		  System.out.println(" in cp is Other");	
		  cp = request.getParameter("cpname");
		}
		System.out.println("cp is"+cp);
		Float stax = Float.parseFloat(request.getParameter("stax"));
		Float scharge = Float.parseFloat(request.getParameter("scharge"));
		
		String jrmverify="select instruction from db_gps.t_vehicledetails where vehiclecode="+vehiclecode;
		System.out.println("before executing jrmverify "+jrmverify);
		ResultSet rsdata1 = sterp.executeQuery(jrmverify);
		System.out.println("after executing jrmverify "+jrmverify);
		rsdata1.next();
		String instruction="";
		instruction=rsdata1.getString("instruction");
		int jrm=0;//just initialization
		if(instruction.equalsIgnoreCase("JRM"))
		{
			 jrm = 1;
		}	
		else
		{
			jrm = 0;
		}	
		
		
		String insert="Insert into "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+previousyear+"_"+fpreviousmonth+" (Vehid,VehRegno,Transporter,ERPCode,ERPCustName,GroupCode,GroupName,BillTransporter,SLAPer,Rate,BillType,CPerson,ST,SC,jrm) "+
					  "Values('"+vehiclecode+"','"+vehregno+"','"+transporter+"','"+erpcode+"','"+erpcustnm+"','"+grpcd+"','"+group+"','"+billtransporter+"','"+slaper+"','"+rate+"','"+billtype+"','"+cp+"','"+stax+"','"+scharge+"','"+jrm+"')";
		System.out.println(insert);
	//	sterp.executeUpdate(insert);
		
		String msg = "Vehicle Added Successfully!!";
		String gotopage = "VehicleAddition.jsp?CompanyName="+transporter;
		response.sendRedirect("alertGoTo.jsp?msg="+msg+"&goto="+gotopage);
	}
	catch(Exception e)
	{
		String msg = "Error In Adding Vehicle, Please Try Again!!";
		String gotopage = "VehicleAddition.jsp";
		e.printStackTrace();
		response.sendRedirect("alertGoTo.jsp?msg="+msg+"&goto="+gotopage);
	}
%>	