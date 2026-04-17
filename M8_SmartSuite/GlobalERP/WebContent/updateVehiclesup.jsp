<%@page import="java.util.Date"%>
<%@include file="conn.jsp"%>


<%
	Connection con=null, congps=null ;
	DecimalFormat twoDForm = new DecimalFormat("#.##");
	Statement sterp=null,sterp1=null,sterp2=null,sterp3=null,stupdate=null;
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
	

	
%>

<%
	try
	{	
		System.out.println("IN UPDATE PAGE  ");
		Class.forName(DB_Driver);
		con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		//Class.forName(DB_Driver).newInstance();
		//Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
		congps = DriverManager.getConnection("jdbc:mysql://"+host1+"/db_gps",user1,pass1);
		sterp=con.createStatement();
		sterp1=con.createStatement();
		sterp2=con.createStatement();
		sterp3=con.createStatement();
		stupdate = congps.createStatement();
		
		int currentmonthcount=0,currentyearcount=0,ppreviousmonth=0, ppreviousyear=0;
		String currentyear="";
		
		
		String currentmonth="select MONTH('"+todaysDate+"')";
		System.out.println(currentmonth);
		ResultSet rsMonth=sterp3.executeQuery(currentmonth);
		rsMonth.next();
		currentmonthcount=rsMonth.getInt(1);
		
		currentyear="select YEAR('"+todaysDate+"')";
		System.out.println(currentyear);
		ResultSet rsYear=sterp2.executeQuery(currentyear);
		rsYear.next();
		currentyearcount=rsYear.getInt(1);
			
		//if(currentmonthcount==1)
		//{
		//	currentyearcount=currentyearcount-1;
		//	currentmonthcount=12;
		//}
		
		System.out.println(currentmonthcount+"  "+currentyearcount );
			
		
		
		String vehno=request.getParameter("vehregno");
		System.out.println("veh reg no is"+vehno);
		String transporter=request.getParameter("transporter");
		System.out.println("^^^^transporter before conversion is^^^^^"+transporter);
		transporter = transporter.replace("^","&");
		System.out.println("^^^^transporter after conversion is^^^^^"+transporter);
		String group=request.getParameter("group");
		System.out.println("^^^^group before conversion is^^^^^"+group);
		group = group.replace("^","&");
		System.out.println("^^^^group after conversion is^^^^^"+group);
		String strvehiclecode = request.getParameter("vehiclecode");
		System.out.println("%%%%%Vehicle Code in str is%%%%%"+strvehiclecode);
		int vehiclecode = Integer.parseInt(strvehiclecode);
		System.out.println("%%%%%Vehicle Code in int is%%%%%"+vehiclecode);
		String month=request.getParameter("month");
		String year=request.getParameter("year");
		String status=request.getParameter("status");
		int vehid=0; 
				
		/*String sqlNew="CREATE TABLE IF NOT EXISTS `"+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+"` ( "
			         +" Select * from "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+currentyearcount+"_"+currentmonthcount+""
			         +" )";
		
		sterp.executeUpdate(sqlNew);
		System.out.println(sqlNew);*/
					
		String sqlVid="select MAX(Vehid) from "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+"";
		ResultSet rsvid=sterp2.executeQuery(sqlVid);
		System.out.println(sqlVid);
		
		rsvid.next();
		vehid=rsvid.getInt(1);
		vehid++;
			
		String sqlData="select * from "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+" where Groupname='"+group+"' Order By Vehid Desc Limit 1";
		ResultSet rsData=sterp1.executeQuery(sqlData);
		System.out.println(sqlData);
		
		rsData.next();
		String erpcode=rsData.getString("ERPCode");
		String erpname=rsData.getString("ERPCustname");
		String grpcd=rsData.getString("GroupCode");
		String billtransporter=rsData.getString("BillTransporter");
		String sla=rsData.getString("SLAPer");
		String rate=rsData.getString("Rate");
		String billtype=rsData.getString("BillType");
		String cperson=rsData.getString("CPerson");
		String st=rsData.getString("ST");
		String sc=rsData.getString("SC");
		String jrm=rsData.getString("jrm");
		System.out.println("JRM is"+jrm);
		String jrmdate=rsData.getString("FirstJRMDate");
		System.out.println("jrmdate is"+jrmdate);
		String insert="Insert into "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+" (Vehid,VehRegno,Transporter,ERPCode,ERPCustName,GroupCode,GroupName,BillTransporter,SLAPer,Rate,BillType,CPerson,ST,SC,jrm,FirstJRMDate) "+
					  "Values('"+vehid+"','"+vehno+"','"+transporter+"','"+erpcode+"','"+erpname+"','"+grpcd+"','"+group+"','"+billtransporter+"','"+sla+"','"+rate+"','"+billtype+"','"+cperson+"','0','0','0','"+jrmdate+"')";
		System.out.println(insert);
		
		sterp.executeUpdate(insert);
		
		System.out.println(insert);
		
		String update = "UPDATE db_gps.t_vehicledetails set updatedinerp = 'Yes' where VehicleCode='"+vehiclecode+"'";
						
		stupdate.executeUpdate(update);
		
		System.out.println(update);
		
		
		//response.sendRedirect("alertGoTo.jsp?msg=Vehicle Added Successfully.&goto=VehicleAdditionNew.jsp");
		out.println("Yes");
		con.close();
	}
	catch(Exception e)
	{
		//response.sendRedirect("alertGoTo.jsp?msg=Error In Adding Vehicle, Please Try Again.&goto=VehicleAdditionNew.jsp");
		e.printStackTrace();
		out.println("No");
	}
%>	