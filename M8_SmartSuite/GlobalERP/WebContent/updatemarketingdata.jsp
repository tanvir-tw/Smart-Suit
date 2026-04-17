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
		
		String repname=request.getParameter("repName1");
		String email=request.getParameter("email");
		String address=request.getParameter("address");
		String city=request.getParameter("city");
		String dept=request.getParameter("department");
		String state=request.getParameter("state");
		String country=request.getParameter("country");
		String phone=request.getParameter("phone");
		String userlevel=request.getParameter("userlevel");
		String visittarget=request.getParameter("visittarget");
		String calltarget=request.getParameter("calltarget");
		String lettarget=request.getParameter("lettarget");
		String squotarget=request.getParameter("squotarget");
		String nprostarget=request.getParameter("nprostarget");
		String talevel=request.getParameter("talevel");
		String compressor=request.getParameter("compressor");
		String digiequp=request.getParameter("digiequp");
		String dgset=request.getParameter("dgset");
		String endoscope=request.getParameter("endoscope");
		String othergroup=request.getParameter("othergroup");
		
		System.out.println( repname);
		String sqlUpdate="";
		sqlUpdate="UPDATE "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster "+
				  " SET MarketingRepAddress='"+address+"' ,MarketingRepCity='"+city+"',MarketingRepPhNo='"+phone+"',MarketingRepState='"+state+"' ,MarketingRepCountry='"+country+"' ," +
				  " UserLevel='"+userlevel+"',Compressor='"+compressor+"',DigitalEquipment='"+digiequp+"' ,DGSet='"+dgset+"',Endoscope ='"+endoscope+"',OtherGroups='"+othergroup+"' ,	 "+
				  " VisitsTarget='"+visittarget+"',CallsTarget='"+calltarget+"',LettersTarget='"+lettarget+"',SQTarget='"+squotarget+"',NewProspectTarget='"+nprostarget+"' 	 "+
				  " where MarketingRepName='"+repname+"' ";
		System.out.println(sqlUpdate);
		st3.executeUpdate(sqlUpdate);
			
		response.sendRedirect("alertGoTo.jsp?msg=Details are successfully Updated.&goto=Marketingeditreport.jsp");
	
		
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