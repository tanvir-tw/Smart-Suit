<%@ page language="java" import="java.sql.*" import="java.util.*"  contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
<%@ page import = "java.io.FileNotFoundException"%>
<%@ page import = "java.io.FileOutputStream"%>
<%@ page import = " java.io.IOException"%>
<%@ page import="javax.activation.*" %>
<%@page import="com.ConnectionClass"%> 

	<%
	//fetch connection 
		
	Connection conn = null;
	Statement st1 = null;
	
	String Sesrole2=session.getAttribute("role").toString();
	
	String issue_id="",Description="", TargetDate ="", Department = "", Concern = "", TaskType = "", ClosureDate = "", Status = "",
						OverdueDays = "",CustomerName="",UserId="",HOD="",FirstDay="",LastDay="",FirstDayNew="",LastDayNew="";
	String ComplaintID="",CustomerType="",IssueRaisedBy="",Priority="",SystemName="",ActionPoint="",OpenIssue="",TargetClosureDate="";
	String TargetDateNew="",ClosureDateNew="",TargetClosureDateNew="";
	String dept="",ename="",issuestatus="",chbk="",fd="",td="";

		try {
			ConnectionClass connection= new ConnectionClass();
			st1 = conn.createStatement();
			
			issue_id=request.getParameter("editissueid");
			ComplaintID=request.getParameter("complaintid");			
			CustomerType=request.getParameter("editcustomer");	
			IssueRaisedBy=request.getParameter("editissueraisedby");
			Priority=request.getParameter("editpriority");
			SystemName=request.getParameter("editsystem");
			ActionPoint=request.getParameter("editactionpoint");
			OpenIssue=request.getParameter("editreportname");
			TargetClosureDate=request.getParameter("edittargetclosedate");
		    System.out.println("TargetClosureDate  =="+TargetClosureDate);
		    TargetClosureDateNew = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MM-yyyy").parse(TargetClosureDate));
		    System.out.println("TargetClosureDateNew  =="+TargetClosureDateNew);
			Description=request.getParameter("editdescription");
			CustomerName=request.getParameter("editcustomername");
			TargetDate = request.getParameter("targetclosedate1");			
			System.out.println("Target date=="+TargetDate);
			Department = request.getParameter("editDepartment");
			Concern = request.getParameter("editconcernperson");
			TaskType = request.getParameter("tasktype");			
			FirstDay = request.getParameter("firstday");     		
			FirstDayNew = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(FirstDay));
			System.out.println("FirstDayNew=="+FirstDayNew);

			LastDay = request.getParameter("lastday");
			LastDayNew = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(LastDay));
						
			ClosureDate = request.getParameter("targetclosedate2");
			
			if (ClosureDate==null || ClosureDate=="-" || ClosureDate.equals("-") || ClosureDate.contains(" ") || ClosureDate.equals(" ") || ClosureDate.isEmpty() ){
				System.out.println("in if==");

				ClosureDate="-";		
			}else{
				System.out.println("in else==");

				 ClosureDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MM-yyyy").parse(ClosureDate));

			}

			Status = request.getParameter("editstatus");
			System.out.println("Status=="+Status);
			
			TargetDateNew=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MM-yyyy").parse(TargetDate));
			System.out.println("TargetDateNew :- "+TargetDateNew);
			
			dept = request.getParameter("dept");
			ename = request.getParameter("ename");
			issuestatus = request.getParameter("issuestatus");
			chbk = request.getParameter("chbk");
			fd = request.getParameter("fd");
			td = request.getParameter("td");
	
			System.out.println("fd :"+fd+"  td "+td+"   deptnew "+dept+"  empnamenew "+ename+" issuestatusnew "+issuestatus+" checkall "+chbk);
		
		 	//New code added to link issue with task system
			String id="select * from db_GlobalERP.UserMaster where EmpName='"+Concern+"'";		
			System.out.println("Sql Query for userid == "+id);
			 
			ResultSet rs=st1.executeQuery(id);
				
			if(rs.next()){
				UserId=rs.getString("dotprojectid");
				HOD=rs.getString("HodReport");
			}		

		} catch (Exception e) {
			out.print("Exception-->" + e);
		}
		response.sendRedirect("TaskAllocation.jsp?userId="+UserId+"&fromdate="+FirstDayNew+"&todate="+LastDayNew+"&Dept="+Department+"&User="+Concern+"&Status=Assigned&Description="+Description+"&issue_id="+issue_id+"&ComplaintID="+ComplaintID+"&CustomerType="+CustomerType+"&IssueRaisedBy="+IssueRaisedBy+"&Priority="+Priority+"&SystemName="+SystemName+"&ActionPoint="+ActionPoint+"&OpenIssue="+OpenIssue+"&TargetClosureDate="+TargetDateNew+"&TargetDate="+TargetDateNew+"&TaskType="+TaskType+"&ClosureDate="+ClosureDate+"&IssueStatus="+Status+"&companyName1="+dept+"&EmpName="+ename+"&from_date1="+fd+"&to_date1="+td+"&issuestatus="+issuestatus+"&extAll="+chbk+" ");
	%>