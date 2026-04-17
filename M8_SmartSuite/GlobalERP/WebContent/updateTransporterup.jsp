<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>
<%
 try
  {	
	Connection con=null ;
	DecimalFormat twoDForm = new DecimalFormat("#.##");
	Statement sterp=null,sterp1=null,sterp2=null,sterp3=null;
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
%>
<%
	System.out.println("Insert");
        int currentmonthcount=0,currentyearcount=0;
        int previousmonth=0;
 		int previousyear=0;
        String finalmonth="";
		Class.forName(DB_Driver);
		con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		sterp=con.createStatement();
		sterp1=con.createStatement();
		sterp2=con.createStatement();
		sterp3=con.createStatement();
		System.out.println("id   "+request.getParameter("id"));
		String currentmonth="select MONTH('"+todaysDate+"')";
		System.out.println(currentmonth);
		ResultSet rsMonth=sterp1.executeQuery(currentmonth);
		rsMonth.next();
		currentmonthcount=rsMonth.getInt(1);
		System.out.println("current month "+currentmonthcount);
		if(currentmonthcount==1 || currentmonthcount==2 || currentmonthcount==3 || currentmonthcount==4 || currentmonthcount==5 || currentmonthcount==6 || currentmonthcount==7 || currentmonthcount==8 || currentmonthcount==9 )
			//if(currentmonthcount==1)
			{
				finalmonth="0"+Integer.toString(currentmonthcount);
			}
			else if(currentmonthcount==10 || currentmonthcount==11 || currentmonthcount==12)
			{
				finalmonth=Integer.toString(currentmonthcount);
			}		
				
			System.out.println("a    a "+finalmonth);
			String currentyear="select YEAR('"+todaysDate+"')";
			System.out.println(currentyear);
			ResultSet rsYear=sterp2.executeQuery(currentyear);
			rsYear.next();
			currentyearcount=rsYear.getInt(1);
			System.out.println(currentyearcount);
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
		//String sqlNew="CREATE TABLE IF NOT EXISTS "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+currentyearcount+"_"+finalmonth+" ( "
		//+" Select * from "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+previousyear+"_"+previousmonth+""
		//+" )";
		//System.out.println(sqlNew);
		//sterp.executeUpdate(sqlNew);
		//System.out.println(sqlNew);	
	    if(request.getParameter("id")=="1" || request.getParameter("id").equals("1"))	
	    {
		String vehno=request.getParameter("vehregno");
		String transporter=request.getParameter("transporter");
		System.out.println("Transporter before conversion is"+transporter);
		transporter = transporter.replace("^","&");
		System.out.println("Transporter after conversion is"+transporter);
		String group=request.getParameter("group");
		System.out.println("Group before conversion is"+group);
		group = group.replace("^","&");
		System.out.println("Group after conversion is"+group);
		String status=request.getParameter("status");
		String insert="Update "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+previousyear+"_"+previousmonth+" set BillTransporter='"+status+"'  where VehRegno='"+vehno+"' and Transporter='"+transporter+"' and GroupName='"+group+"'";
		sterp.executeUpdate(insert);
		System.out.println(insert);
		out.println("Yes");
		//response.sendRedirect("alertGoTo.jsp?msg=Information Updated Successfully.&goto=transporterDataNewup.jsp");
		}
	    else if(request.getParameter("id")=="2" || request.getParameter("id").equals("2"))	
	    {
		System.out.println("INn");
		String sla=request.getParameter("sla");
		String rate=request.getParameter("rate");
		System.out.println("Rate is"+rate);
		String st=request.getParameter("st");
		String sc=request.getParameter("sc");
		String transp=request.getParameter("transporter");
		System.out.println(sla+""+rate+""+st+""+sc);			
		 
		String insert="Update "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+previousyear+"_"+previousmonth+" set SLAPer='"+sla+"',Rate='"+rate+"',ST='"+st+"',SC='"+sc+"' where GroupName='"+transp+"' ";
		sterp.executeUpdate(insert);
		System.out.println(insert);
		response.sendRedirect("alertGoTo.jsp?msg=Information Updated Successfully.&goto=transporterDataNewup.jsp");
		}
	}
	catch(Exception e)
	{
		response.sendRedirect("alertGoTo.jsp?msg=Error In Updating Information, Please Try Again.&goto=transporterDataNewup.jsp");
		//e.printStackTrace();
	}
%>	