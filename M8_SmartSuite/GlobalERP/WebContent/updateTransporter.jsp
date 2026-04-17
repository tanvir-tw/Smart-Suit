<%@page import="java.sql.*"%>
<%@page import="java.text.*"%>
<%@page import="java.util.Date"%>
 <%@page import="com.ConnectionClass"%> 
<%
int currentmonthcount=0,currentyearcount=0;
int previousmonth=0;
int previousyear=0;
String finalmonth="",previousmonthStr="";
Connection con=null ;
 
 try
  {	
	
	DecimalFormat twoDForm = new DecimalFormat("#.##");
	Statement sterp=null,sterp1=null,sterp2=null,sterp3=null;
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());

	ConnectionClass connection= new ConnectionClass();
	con = connection.getConnect("db_GlobalERP");
	
		sterp=con.createStatement();
		sterp1=con.createStatement();
		sterp2=con.createStatement();
		sterp3=con.createStatement();
		String currentmonth="select MONTH('"+todaysDate+"')";
		ResultSet rsMonth=sterp1.executeQuery(currentmonth);
		rsMonth.next();
		currentmonthcount=rsMonth.getInt(1);
		if(currentmonthcount==1 || currentmonthcount==2 || currentmonthcount==3 || currentmonthcount==4 || currentmonthcount==5 || currentmonthcount==6 || currentmonthcount==7 || currentmonthcount==8 || currentmonthcount==9 )
			{
				finalmonth="0"+Integer.toString(currentmonthcount);
			}
			else if(currentmonthcount==10 || currentmonthcount==11 || currentmonthcount==12)
			{
				finalmonth=Integer.toString(currentmonthcount);
			}		
				
			String currentyear="select YEAR('"+todaysDate+"')";
			ResultSet rsYear=sterp2.executeQuery(currentyear);
			rsYear.next();
			currentyearcount=rsYear.getInt(1);
			if(currentmonthcount==1)
			{
				previousyear=currentyearcount-1;
				previousmonth=12;
				previousmonthStr=""+previousmonth;			 
			}
			else 
			{
				previousyear=currentyearcount;
				System.out.println("abcd  "+finalmonth);
				previousmonth=Integer.parseInt(finalmonth)-1;
				if(previousmonth==1 || previousmonth==2 || previousmonth==3 || previousmonth==4 || previousmonth==5 || previousmonth==6 || previousmonth==7 || previousmonth==8 || previousmonth==9 )
				{
					previousmonthStr="0"+previousmonth;
				}
				else
				{
					previousmonthStr=""+previousmonth;
				}				
				previousmonth=Integer.parseInt(previousmonthStr)  ;
			}
	    if(request.getParameter("id")=="1" || request.getParameter("id").equals("1"))	
	    {
		String vehno=request.getParameter("vehregno");
		String transporter=request.getParameter("transporter");
		transporter = transporter.replace("^","&");
		String group=request.getParameter("group");
		group = group.replace("^","&");
		String status=request.getParameter("status");
		String insert="Update "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+previousyear+"_"+previousmonthStr+" set BillTransporter='"+status+"'  where VehRegno='"+vehno+"' and Transporter='"+transporter+"' and GroupName='"+group+"'";
		System.out.println(insert);
		sterp.executeUpdate(insert);
		
		
		String insert1="Update "+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+previousyear+"_"+previousmonthStr+" set BillTransporter='"+status+"'  where REPLACE(VehRegno,' ','')='"+vehno.replaceAll(" ","")+"' and Transporter='"+transporter+"'";
		System.out.println(insert1);
		sterp1.executeUpdate(insert1);
		
		out.println("Yes");
		}
	    else if(request.getParameter("id")=="2" || request.getParameter("id").equals("2"))	
	    {
		System.out.println("INn");
		String sla=request.getParameter("sla");
		String rate=request.getParameter("rate");
		String st=request.getParameter("st");
		String sc=request.getParameter("sc");
		String transp=request.getParameter("transporter");
		String insert="Update "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+previousyear+"_"+previousmonthStr+" set SLAPer='"+sla+"',Rate='"+rate+"',ST='"+st+"',SC='"+sc+"' where GroupName='"+transp+"' ";
		sterp.executeUpdate(insert);
		response.sendRedirect("alertGoTo.jsp?msg=Information Updated Successfully.&goto=transporterData.jsp");
		}
	}
	catch(Exception e)
	{
		response.sendRedirect("alertGoTo.jsp?msg=Error In Updating Information, Please Try Again.&goto=transporterData.jsp");
	}
%>	