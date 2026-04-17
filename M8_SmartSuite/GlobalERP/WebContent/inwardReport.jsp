 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
 <%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
<%@ include file="headernew.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>GlobalERP</title>
    
<style>
.popup {
	background-color: #98AFC7;
	position: absolute;
	visibility: hidden; . popupnew { background-color : #98AFC7;
	position: absolute;
	visibility: visible; . popupx { background-color : #98AFC7;
	position: absolute;
	visibility: hidden;
}
</style>

</head>
<body style="background-color:azure;">
<%
Connection conn = null;
Statement st1=null,st2=null,st3=null;
String datex1="",datex2="",bt="",data1="",data2="",dt="",dt1="",dttime="",dt1time="";
String user="",pass="";
String checkstatus="",updatedatetime="";
String monthFirstDate ="",todaysDate="",empname1="";
try {

	conn = connection.getConnect("db_leaveapplication");    
	st1 = conn.createStatement();
    st2 = conn.createStatement();
    st3 = conn.createStatement();

} catch (Exception e) {
    e.printStackTrace();
} 
empname1=session.getAttribute("user").toString();
monthFirstDate = session.getAttribute("onemonthback").toString();  
todaysDate = session.getAttribute("today").toString(); 

String sqlUP="select * from t_leaveadmin where UName='"+empname1+"'";
System.out.println("sqlUP: "+sqlUP);
ResultSet rs=st1.executeQuery(sqlUP);
	if(rs.next())
	{
		user=rs.getString("UName");
		pass=rs.getString("pass");
	}
	

		bt=request.getParameter("button");
			
			if (bt== null || bt.equals("null")) {		
				datex1 = monthFirstDate;
				datex2 = todaysDate;
			} else {	
				datex1 = request.getParameter("data");
				datex2 = request.getParameter("data1");
			}

		 dt = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));
		 dt1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex2));	
	
	
%>
	
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Inward Report <% if(request.getParameter("status")!=null){ %> <b><font size="3"
						color="blue">[<%=request.getParameter("status")  %>Files
							Report]
					</font></b> <%} %></h5>
    </div>
</div>	
	
<form name="customdetail" id="customdetail" method="post" Onsubmit="return datevalidate()">
<input type="hidden" name="empname" id="empname" value="<%=empname1%>" />
		    <!-- <div class="row col-12"> -->
		  
		    <div class="d-flex justify-content-center gap-2 mt-3" id="auto" style="width:100%">
             <div class="col-md-2">
				  <label for="dropdown"><b>Status</b></label>
						<div class="input-group input-group-merge">
			               <select class="form-select" id="status" name="status">
			               <option selected="selected" value="All">All</option>
			               <option value="Checked">Checked</option>
							<option value="Unchecked">Unchecked</option>
							<option value="Forwarded">Forwarded</option>
			               </select>
						<script>
                            const mySel = document.getElementById("status");

                            // On page load
                             const savedValue = localStorage.getItem("selValue");
                             if (isBtNull) {
                             mySel.value = "Select"; // Default to "Select" if btn is null
                             } else if (savedValue) {
                              mySel.value = savedValue; // Restore saved value
                               }

                             // Add change event listener
                              mySel.addEventListener("change", function () {
                              localStorage.setItem("selValue", this.value); // Save selected value
                               });
                             </script>			
		                </div>
			</div>	
			
			<div class="col-md-2">
				  <label for="dropdown"><b>Type</b></label>
						<div class="input-group input-group-merge">
			               <select class="form-select" id="rd" name="rd">
			               	<option selected="selected" value="all">All</option>
			               	<option value="bill">Bill</option>
							<option value="doc">Document</option>
			               </select>
						<script>
                            const mySel = document.getElementById("rd");

                            // On page load
                             const savedValue = localStorage.getItem("selValue");
                             if (isBtNull) {
                             mySel.value = "Select"; // Default to "Select" if btn is null
                             } else if (savedValue) {
                              mySel.value = savedValue; // Restore saved value
                               }

                             // Add change event listener
                              mySel.addEventListener("change", function () {
                              localStorage.setItem("selValue", this.value); // Save selected value
                               });
                             </script>			
		                </div>
			</div>		
				<div class="col-md-1" style="width: 30px;">
    <label class="form-label fw-bold d-block">All</label>
    <div class="form-check">
        <input class="form-check-input" type="checkbox" name="extAll" id="extAll" value="1" onclick="allSelected(this.value);">
    </div>
    </div>		            
			<div class="col-md-2" id="frmdt">
				<label for="from"><b>From</b></label>
					<div class="input-group input-group-merge" >
					<input type="text" name="data" id="data"  class="form-control" value="<%=datex1%>"> 
					<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
				</div>
			</div>
			<div class="col-md-2" id="todt">
				<label for="to"><b>To</b></label>
				<div class="input-group input-group-merge" >	
					<input type="text" id="data1" name="data1"  class="form-control" value="<%=datex2%>"/> 
				<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
 				</div>
		    </div>
		    <div class="col-md-2" id="saerchbox">
                <label for="input"><b>Search Here</b></label>
                <input class="form-control form-control-sm" type="text" id="searchTxt" name="searchTxt">
			 </div>
		    	
			<div class="col-md-1 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit" onclick="return validate();">
			</div>
		
		</div>
</form> 
<script type="text/javascript">
        Calendar.setup(
	       {
	    	   inputField  : "data",         // ID of the input field
			   ifFormat    : "%d-%b-%Y",     // the date format
			   button      : "trigger"       // ID of the button
	        } );
        
        Calendar.setup(
     	       {
     	    	   inputField  : "data1",         // ID of the input field
     			   ifFormat    : "%d-%b-%Y",     // the date format
     			   button      : "trigger"       // ID of the button
     	        } );
</script>		
	<%			
	System.out.println("========="+user+"======================="+pass+"============="+empname1+"========");
		if(!(null==datex1)&&!(null==datex2))
		{
		try 
		{
			%>

	<input type="hidden" name="pswd" id="pswd" value="<%=pass%>"></input>
	<form name="inwrdreport" method="post" action="sendIntimation.jsp" Onsubmit="return validate()">
	 <br>
	<table id="example" class="display" style="width:100%;">        
       <thead>
            <tr>
            		<th class="col-width-4">SrNo.</th>
					<th >Inward Date</th>
					<th>Ref.No.</th>
					<th>Category</th>
					<th>Subject</th>
					<th>In/Out</th>
					<th>Files</th>
					<th>UpdatedDate-Time</th>
					<th>Status</th>
				</tr>
			</thead>
			<%String rsbt="";
			try
			{
				rsbt=request.getParameter("rdbtn");
			}
			catch(Exception e)
			{
				System.out.println(e);
			}
			  %>
			<%
			int i = 1;
			String frm="", sub="", partyRef="", iwdate="",cat="",loc="",fname="",fileLink="",refNo="",stat="",dept="",toemp="",remark="";
			String blno="-",blamt="-",bldate="-",blduedate="-",rRemark="-",fromparty="",UpdatedDateTime;
			String empNameString="",enteredby = ""; 
			
			DateFormat df1=new SimpleDateFormat("yyyy-MM-dd");
			DateFormat df2=new SimpleDateFormat("dd-MMM-yyyy");				
			
			String entBy ="";	
			String cmpString ="";
			String statusdrp="";
			String drpDwn="";
			String searchKey="";
			String selctAllChbx="";
			
			statusdrp=request.getParameter("status");
			System.out.println("STATUS VALUE IS   "+statusdrp);
			try
			{
				entBy=session.getAttribute("user").toString();
				cmpString =session.getAttribute("user").toString();
				selctAllChbx=request.getParameter("extAll");
				drpDwn=request.getParameter("rd");
				
				searchKey=request.getParameter("searchTxt");
			
				if(selctAllChbx.equals("yes")){}
			}
			catch(Exception e)
			{
				selctAllChbx="No";
				System.out.println(e);
			}
			
			String sqlData="";
				
			try
			{	
				if(selctAllChbx.equals("yes"))
				{
					
					if(statusdrp.equals("All"))
					{
					System.out.println("IN YES and CHECKED  "+statusdrp);
						sqlData="select * from t_inwarddetails where  (Enteredby like '"+session.getAttribute("empname")+"' or ToEmploy like '%"+session.getAttribute("empname")+"%') and (FileName like '%"+searchKey+"%' or Category like '%"+searchKey+"%' or BillNo like '%"+searchKey+"%' or senderRemark like '%"+searchKey+"%' Or Subject like '%"+searchKey+"%' Or InwardDate like '%"+searchKey+"%' Or ManualRef like '%"+searchKey+"%' Or FromParty like '%"+searchKey+"%' Or Dept like '%"+searchKey+"%' Or Keywords like '%"+searchKey+"%' Or BillDate like '%"+searchKey+"%' Or  BillDueDate like '%"+searchKey+"%' Or ToEmploy like '%"+searchKey+"%' Or ToEmailID like '%"+searchKey+"%')  order by InwardDate asc";
					}
					
					else if(statusdrp.equals("Checked"))
					{
					System.out.println("IN YES and CHECKED  "+statusdrp);
						sqlData="select * from t_inwarddetails where  (Enteredby like '"+session.getAttribute("empname")+"' or ToEmploy like '%"+session.getAttribute("empname")+"%') and (FileName like '%"+searchKey+"%' or Category like '%"+searchKey+"%' or BillNo like '%"+searchKey+"%' or senderRemark like '%"+searchKey+"%' Or Subject like '%"+searchKey+"%' Or InwardDate like '%"+searchKey+"%' Or ManualRef like '%"+searchKey+"%' Or FromParty like '%"+searchKey+"%' Or Dept like '%"+searchKey+"%' Or Keywords like '%"+searchKey+"%' Or BillDate like '%"+searchKey+"%' Or  BillDueDate like '%"+searchKey+"%' Or ToEmploy like '%"+searchKey+"%' Or ToEmailID like '%"+searchKey+"%') and CheckStatus='Checked' order by InwardDate asc";
					}
					else if(statusdrp.equals("Unchecked"))
					{
						System.out.println("IN YES and UNCHECKED  "+statusdrp);
						sqlData="select * from t_inwarddetails where CheckStatus ='Unchecked' and (Enteredby like '"+session.getAttribute("empname")+"' or ToEmploy like '%"+session.getAttribute("empname")+"%') and (FileName like '%"+searchKey+"%' or Category like '%"+searchKey+"%' or BillNo like '%"+searchKey+"%' or senderRemark like '%"+searchKey+"%' Or Subject like '%"+searchKey+"%' Or InwardDate like '%"+searchKey+"%' Or ManualRef like '%"+searchKey+"%' Or FromParty like '%"+searchKey+"%' Or Dept like '%"+searchKey+"%' Or Keywords like '%"+searchKey+"%' Or BillDate like '%"+searchKey+"%' Or  BillDueDate like '%"+searchKey+"%' Or ToEmploy like '%"+searchKey+"%' Or ToEmailID like '%"+searchKey+"%')  order by InwardDate asc";
					}
					else if(statusdrp.equals("Forwarded"))
					{
						System.out.println("IN YES and FORWARDED "+statusdrp);
						sqlData="select * from t_inwarddetails where CheckStatus='Forwarded' and (Enteredby like '"+session.getAttribute("empname")+"' or ToEmploy like '%"+session.getAttribute("empname")+"%') and (FileName like '%"+searchKey+"%' or Category like '%"+searchKey+"%' or BillNo like '%"+searchKey+"%' or senderRemark like '%"+searchKey+"%' Or Subject like '%"+searchKey+"%' Or InwardDate like '%"+searchKey+"%' Or ManualRef like '%"+searchKey+"%' Or FromParty like '%"+searchKey+"%' Or Dept like '%"+searchKey+"%' Or Keywords like '%"+searchKey+"%' Or BillDate like '%"+searchKey+"%' Or  BillDueDate like '%"+searchKey+"%' Or ToEmploy like '%"+searchKey+"%' Or ToEmailID like '%"+searchKey+"%')  order by InwardDate asc";
					}
					
				}
				else
				{
					System.out.println("IN NO NO NO  ");
					if(drpDwn.equals("doc"))
					{
						if(statusdrp.equals("All"))
						{
							System.out.println("IN DOC AND CHECKED  "+statusdrp);		
							sqlData="select * from t_inwarddetails where  (InwardDate>='"+dt+"' and InwardDate<='"+dt1+"') and BillAmt='0.00' and (Enteredby like '"+session.getAttribute("user")+"' or ToEmploy like '%"+session.getAttribute("user")+"%') and (FileName like '%"+searchKey+"%' Or InwardDate like '%"+searchKey+"%' Or ManualRef like '%"+searchKey+"%' Or FromParty like '%"+searchKey+"%' Or Dept like '%"+searchKey+"%' Or Keywords like '%"+searchKey+"%' Or BillDate like '%"+searchKey+"%' Or  BillDueDate like '%"+searchKey+"%' Or ToEmploy like '%"+searchKey+"%' Or ToEmailID like '%"+searchKey+"%') order by InwardDate asc";
						}
						else if(statusdrp.equals("Checked"))
						{
							System.out.println("IN DOC AND CHECKED  "+statusdrp);		
							sqlData="select * from t_inwarddetails where CheckStatus='Checked' and (InwardDate>='"+dt+"' and InwardDate<='"+dt1+"') and BillAmt='0.00' and (Enteredby like '"+session.getAttribute("user")+"' or ToEmploy like '%"+session.getAttribute("user")+"%') and (FileName like '%"+searchKey+"%' Or InwardDate like '%"+searchKey+"%' Or ManualRef like '%"+searchKey+"%' Or FromParty like '%"+searchKey+"%' Or Dept like '%"+searchKey+"%' Or Keywords like '%"+searchKey+"%' Or BillDate like '%"+searchKey+"%' Or  BillDueDate like '%"+searchKey+"%' Or ToEmploy like '%"+searchKey+"%' Or ToEmailID like '%"+searchKey+"%') order by InwardDate asc";
						}
						else if(statusdrp.equals("Unchecked"))
						{
							System.out.println("IN DOC AND UNCHECKED  "+statusdrp);
							sqlData="select * from t_inwarddetails where CheckStatus='Unchecked' and (InwardDate>='"+dt+"' and InwardDate<='"+dt1+"') and BillAmt='0.00' and (Enteredby like '"+session.getAttribute("user")+"' or ToEmploy like '%"+session.getAttribute("user")+"%') and (FileName like '%"+searchKey+"%' Or InwardDate like '%"+searchKey+"%' Or ManualRef like '%"+searchKey+"%' Or FromParty like '%"+searchKey+"%' Or Dept like '%"+searchKey+"%' Or Keywords like '%"+searchKey+"%' Or BillDate like '%"+searchKey+"%' Or  BillDueDate like '%"+searchKey+"%' Or ToEmploy like '%"+searchKey+"%' Or ToEmailID like '%"+searchKey+"%') order by InwardDate asc";
						}
						else if(statusdrp.equals("Forwarded"))
						{
							System.out.println("IN DOC AND FORWARDED  "+statusdrp);
							sqlData="select * from t_inwarddetails where CheckStatus='Forwarded' and (InwardDate>='"+dt+"' and InwardDate<='"+dt1+"') and BillAmt='0.00' and (Enteredby like '"+session.getAttribute("user")+"' or ToEmploy like '%"+session.getAttribute("user")+"%') and (FileName like '%"+searchKey+"%' Or InwardDate like '%"+searchKey+"%' Or ManualRef like '%"+searchKey+"%' Or FromParty like '%"+searchKey+"%' Or Dept like '%"+searchKey+"%' Or Keywords like '%"+searchKey+"%' Or BillDate like '%"+searchKey+"%' Or  BillDueDate like '%"+searchKey+"%' Or ToEmploy like '%"+searchKey+"%' Or ToEmailID like '%"+searchKey+"%') order by InwardDate asc";
						}
										
					}
					else if(drpDwn.equals("bill"))
					{
						if(statusdrp.equals("All"))
						{
							sqlData="select * from t_inwarddetails where (InwardDate>='"+dt+"' and InwardDate<='"+dt1+"') and BillAmt<>'0.00' and (Enteredby like '"+session.getAttribute("user")+"' or ToEmploy like '%"+session.getAttribute("user")+"%') and (FileName like '%"+searchKey+"%' Or InwardDate like '%"+searchKey+"%' Or Subject like '%"+searchKey+"%' or Category like '%"+searchKey+"%' Or InwardDate like '%"+searchKey+"%' Or ManualRef like '%"+searchKey+"%' Or FromParty like '%"+searchKey+"%' Or Dept like '%"+searchKey+"%' Or Keywords like '%"+searchKey+"%' Or BillDate like '%"+searchKey+"%' Or  BillDueDate like '%"+searchKey+"%' Or ToEmploy like '%"+searchKey+"%' Or ToEmailID like '%"+searchKey+"%') order by InwardDate asc";

						}

						else if(statusdrp.equals("Checked"))
						{
							sqlData="select * from t_inwarddetails where CheckStatus='Checked' and  (InwardDate>='"+dt+"' and InwardDate<='"+dt1+"') and BillAmt<>'0.00' and (Enteredby like '"+session.getAttribute("user")+"' or ToEmploy like '%"+session.getAttribute("user")+"%') and (FileName like '%"+searchKey+"%' Or InwardDate like '%"+searchKey+"%' Or Subject like '%"+searchKey+"%' or Category like '%"+searchKey+"%' Or InwardDate like '%"+searchKey+"%' Or ManualRef like '%"+searchKey+"%' Or FromParty like '%"+searchKey+"%' Or Dept like '%"+searchKey+"%' Or Keywords like '%"+searchKey+"%' Or BillDate like '%"+searchKey+"%' Or  BillDueDate like '%"+searchKey+"%' Or ToEmploy like '%"+searchKey+"%' Or ToEmailID like '%"+searchKey+"%') order by InwardDate asc";

						}
						else if(statusdrp.equals("Unchecked"))
						{
							sqlData="select * from t_inwarddetails where CheckStatus='Unchecked' and  (InwardDate>='"+dt+"' and InwardDate<='"+dt1+"') and BillAmt<>'0.00' and (Enteredby like '"+session.getAttribute("user")+"' or ToEmploy like '%"+session.getAttribute("user")+"%') and ( Subject like '%"+searchKey+"%' or Category like '%"+searchKey+"%' Or BillDate like '%"+searchKey+"%' Or  BillDueDate like '%"+searchKey+"%' Or ToEmploy like '%"+searchKey+"%' Or ToEmailID like '%"+searchKey+"%') order by InwardDate asc";

						}
						else if(statusdrp.equals("Forwarded"))
						{
							sqlData="select * from t_inwarddetails where CheckStatus='Forwarded' and  (InwardDate>='"+dt+"' and InwardDate<='"+dt1+"') and BillAmt<>'0.00' and (Enteredby like '"+session.getAttribute("user")+"' or ToEmploy like '%"+session.getAttribute("user")+"%') and (Subject like '%"+searchKey+"%' or Category like '%"+searchKey+"%' Or BillDate like '%"+searchKey+"%' Or  BillDueDate like '%"+searchKey+"%' Or ToEmploy like '%"+searchKey+"%' Or ToEmailID like '%"+searchKey+"%') order by InwardDate asc";

						}
						
					}
					else
					{
						if(statusdrp.equals("All"))
						{
							sqlData="select * from t_inwarddetails where  (InwardDate>='"+dt+"' and InwardDate<='"+dt1+"') and (Enteredby like '"+session.getAttribute("user")+"' or ToEmploy like '%"+session.getAttribute("user")+"%') and (FileName like '%"+searchKey+"%' or Category like '%"+searchKey+"%' or BillNo like '%"+searchKey+"%' or senderRemark like '%"+searchKey+"%' Or Subject like '%"+searchKey+"%' Or BillDate like '%"+searchKey+"%' Or  BillDueDate like '%"+searchKey+"%' Or ToEmploy like '%"+searchKey+"%' Or ToEmailID like '%"+searchKey+"%') order by InwardDate asc";
						}
						else if(statusdrp.equals("Checked"))
						{
							sqlData="select * from t_inwarddetails where CheckStatus='Checked' and (InwardDate>='"+dt+"' and InwardDate<='"+dt1+"') and (Enteredby like '"+session.getAttribute("user")+"' or ToEmploy like '%"+session.getAttribute("user")+"%') and (FileName like '%"+searchKey+"%' or Category like '%"+searchKey+"%' or BillNo like '%"+searchKey+"%' or senderRemark like '%"+searchKey+"%' Or Subject like '%"+searchKey+"%' Or BillDate like '%"+searchKey+"%' Or  BillDueDate like '%"+searchKey+"%' Or ToEmploy like '%"+searchKey+"%' Or ToEmailID like '%"+searchKey+"%') order by InwardDate asc";
						}
						else if(statusdrp.equals("Unchecked"))
						{
							sqlData="select * from t_inwarddetails where CheckStatus='Unchecked' and (InwardDate>='"+dt+"' and InwardDate<='"+dt1+"') and (Enteredby like '"+session.getAttribute("user")+"' or ToEmploy like '%"+session.getAttribute("user")+"%') and (FileName like '%"+searchKey+"%' or Category like '%"+searchKey+"%' or BillNo like '%"+searchKey+"%' or senderRemark like '%"+searchKey+"%' Or Subject like '%"+searchKey+"%' Or BillDate like '%"+searchKey+"%' Or  BillDueDate like '%"+searchKey+"%' Or ToEmploy like '%"+searchKey+"%' Or ToEmailID like '%"+searchKey+"%') order by InwardDate asc";
						}	
						else if(statusdrp.equals("Forwarded"))
						{
							sqlData="select * from t_inwarddetails where CheckStatus='Forwarded' and (InwardDate>='"+dt+"' and InwardDate<='"+dt1+"') and (Enteredby like '"+session.getAttribute("user")+"' or ToEmploy like '%"+session.getAttribute("empname")+"%') and (FileName like '%"+searchKey+"%' or Category like '%"+searchKey+"%' or BillNo like '%"+searchKey+"%' or senderRemark like '%"+searchKey+"%' Or Subject like '%"+searchKey+"%' Or BillDate like '%"+searchKey+"%' Or  BillDueDate like '%"+searchKey+"%' Or ToEmploy like '%"+searchKey+"%' Or ToEmailID like '%"+searchKey+"%') order by InwardDate asc";
						}	
					
					}				
				}
			}                
			catch(Exception e)
			{
				System.out.println(e);
				System.out.println("IN CATCH ");
				sqlData="select * from t_inwarddetails where (InwardDate>='"+dt+"' and InwardDate<='"+dt1+"')  and (Enteredby like '"+session.getAttribute("user")+"' or ToEmploy like '%"+session.getAttribute("user")+"%') order by InwardDate asc";
				System.out.println(sqlData);
					}
			System.out.println(sqlData);
			ResultSet rst=st3.executeQuery(sqlData);
			while(rst.next())
			{
				
				System.out.println(""+rst.getString("CheckStatus"));
				
				boolean f1=false;
				boolean f2=false;
				empNameString=rst.getString("ToEmailID");
				enteredby=rst.getString("Enteredby");
				fromparty=rst.getString("FromParty");
				
					String delims12 = "[,]";
    				String[] tokens1 = empNameString.split(delims12);
    				
				for (String t : tokens1)
				{
					System.out.println(t+"   11111   111   111111   "+cmpString);
						if(t.equals(cmpString))
						{
							f1=true;
						}
				}
				System.out.println(enteredby+"    333333333333    "+entBy);
				if(enteredby.equals(entBy))
				{
					f2=true;
				}
				
				if(f1==true || f2==true)
				{
				frm=rst.getString("FromParty");
				sub=rst.getString("Subject");
				partyRef=rst.getString("PartyRefNo");
				iwdate=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("InwardDate")+" "+rst.getString("InwardTime")));
				cat=rst.getString("Category");
				if(cat.equals("Bills"))
				{
					blno=rst.getString("BillNo");
					blamt=rst.getString("BillAmt");
					bldate=df2.format(df1.parse(rst.getString("BillDate")));
					blduedate=df2.format(df1.parse(rst.getString("BillDueDate")));
				}
				else
				{
					blno="-";
					blamt="-";
					bldate="-";
					blduedate="-";
				}
				loc=rst.getString("FileLocation");
				fname=rst.getString("FileName");
				refNo=rst.getString("InwardRefNo");
				fileLink="ftp://203.199.134.131/test004/"+fname;
				toemp=rst.getString("ToEmploy");
				remark=rst.getString("senderRemark");
				rRemark=rst.getString("receiverRemark");
			
				String abc= "";
				%>
			<tbody>
				<tr>
					<td class="text-center"><%= i%></td>
					<td class="text-right"><%= iwdate%></td>
					<td class="text-center"><a href="javascript:toggleDetails('<%=refNo %>','true','0','<%=i%>')" /><%= refNo%>
						<div align="right" class="popup" id="popup<%=i %>">

							<table width="50%" align="right" border=1 bgcolor="#C6DEFF"
								cellpadding="0" cellspacing="0" style="position: absolute;">
								<tr>
									<td><div align="center">
											<a href="Detailsofdoc.jsp?refno=<%=refNo %>" />View Details</a>
										</div></td>
								</tr>
								<tr>
									<td><div align="center">
											<a href="recvrsRemark.jsp?refno=<%=refNo %>" />Receiver's
											Report</a>
										</div></td>
								</tr>
								<!--  <tr><td><div align="center"><a href="addToFolder.jsp?refno=<%=refNo %>" />Add File To Folder</a></div></td></tr> -->
								<tr>
									<td><div align="center">
											<a href="" onclick="sendIntimation('<%= refNo%>')" />Foward</a>
										</div></td>
								</tr>
								<tr>
									<td><div align="center">
											<a href="" onclick="editInward('<%= refNo%>')" />Edit</a>
										</div></td>
								</tr>
								<tr>
									<td><div align="center">
											<a
												href="javascript:toggleDetails('<%= refNo%>','false','3','<%=i%>')" />close</a>
										</div></td>
								</tr>
							</table>
						</div></td>
						
						
					<td class="text-center"><%= cat%></td>
					<td class="text-center"><%= sub%></td>
					<%
				if(f1==true && f2==false)
				{
				%>
					<td class="text-center">In</td>
					<%
				}
				else if(f1==false && f2==true)
				{
				%>
					<td class="text-center">Out</td>
					<%
				}
				else if(f1==true && f2==true)
				{
				%>
					<td class="text-center">In & Out</td>
					<%
				}
				%>
					<td class="text-left">
						<% 
					String[] tok = fname.split(delims12);
				
					for (String t1 : tok)
					{										
					%> 
							<a href="http://twtech.in/TWDOC/<%=t1%>">
                          View File
                        </a>	
					 <%	
					
				}
				%> <%
				String Checkfile="Select * from t_uploadedFiles where FileName='"+tok[0]+"'";
				ResultSet rscheck=st.executeQuery(Checkfile);
				System.out.println("queryt  "+Checkfile);
				%>
					</td>
					<%
				System.out.println(":::::::::::::::::::::::::::::::::::::::");
				if(rscheck.next())
				{
					
					updatedatetime=rscheck.getString("UpdatedDateTime");
					System.out.println(" update date time  1111  "+updatedatetime);
				%>
					<td class="text-right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rscheck.getString("UpdatedDateTime"))) %></td>
					<%
				}
				else
				{	
				
				%>
					<td class="text-center">NA</td>
					<%
				}
				%>
					<% 
			String sqlstatus="select CheckStatus from t_inwarddetails WHERE InwardRefNo='"+refNo+"' ";
			ResultSet rsstatus=st.executeQuery(sqlstatus);
			System.out.println(sqlstatus);
			if(rsstatus.next())
			{
				checkstatus=rsstatus.getString(1);
				if(checkstatus.equalsIgnoreCase("Checked"))
					checkstatus="Checked";
				else
					checkstatus="Unchecked";
				
				System.out.println("CHECKED STATUS   "+checkstatus);
			%>
					<td class="text-left"><%= checkstatus%></td>
					<%
			}
			%>
				</tr>
			</tbody>
			<%
				}
				 i++;
			}
			%>
		</table>
		<input TYPE="hidden" id="rd" name="rd" VALUE="<%=refNo%>" />
		<input type="hidden" name="rdcnt" id="rdcnt" value="<%=i%>"></input> 
				
	</form>
	
<% 
	} 
	catch (Exception e) 
	{
		e.printStackTrace();
	} 
	
}
%>
</div>
  <script type="text/javascript">
   $(document).ready(function () {
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-4"f><"col-sm-12 col-md-2 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
	       displayLength: -1,
	        scrollY: 330,
	        scrollX: true, 
	        colReorder: true,
	        scrollCollapse: true,
	        pagingType: 'full_numbers',  //alternative pagination
	         fixedColumns: { 
	            left: 4      //To freeze two columns
	        }, 
	        stateSave: true,
	        lengthMenu: [[-1, 10, 25, 50], ["All", 10, 25, 50]], //Page Length(Pagination)	  
	         buttons : [
	        	 'colvis',
				{
					extend : 'collection',
					className: 'btn btn-outline-secondary  ',
					 text:'Export',
					 orientation: 'landscape',
                     pageSize: 'A4',
					buttons : [
							{
							 extend: 'excel',
	                         text: feather.icons['file'].toSvg({ class: 'font-small-4 me-50' }) + 'Excel',
	                         className: 'dropdown-item',  
		                        title: 'Inward Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
		                        title: 'Inward Report '+$("#data").val()+' to ' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
		                        title: 'Inward Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
		                        title: 'Inward Report '+$("#data").val()+' to ' +$("#data1").val(),
		                        
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title: 'Inward Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
 
					],
				},
           ], 
       
       });

   });
   
</script>
<script type="text/javascript">
function toggleDetails(refno,show,id,row) 
{
	var popupx = document.getElementById("popup"+row);
	if(show=="true") 
	{
		popupx.style.visibility = "visible";
		popupx.setfocus();
	} 
	else 
	{
		 if(id=="3")
		{
		}
		popupx.style.visibility = "hidden";
	}
}

function allSelected(allVal)
{
	if(document.customdetail.extAll.checked) 
	{
		document.getElementById("data").style.display='none';
    	document.getElementById("data1").style.display='none';
    	document.getElementById("frmdt").style.display='none';
    	document.getElementById("todt").style.display='none';
    	document.getElementById("auto").style.width='100%';
    	
    }
	else 
	{
		document.getElementById("auto").style.width='100%';
		document.getElementById("data").style.display="";
    	document.getElementById("data1").style.display="";
    	document.getElementById("frmdt").style.display="";
    	document.getElementById("todt").style.display="";
	}
}

function getFTPImage(t1,refNo,empname1)
{
	try
	{
		window.open('inwardLink.jsp?filename='+t1+'&iwno='+refNo+'&empName='+empname1+'','mywindow','width=700, height=500, toolbar=false, location=false, status=no, menubar=no, resizable=no, scrollbars=yes');
	}
	catch(e)
	{
		alert(e);
	}
} 

function showRecvrReport(refno) 
{
	testwindow=window.open('recvrsRemark.jsp?refno='+refno,'mywindow1','width=1000, height=400, toolbar=false, location=false, status=no, menubar=no, resizable=no, scrollbars=yes');
} 

function sendIntimation(refno)
{
	testwindow=window.open('intimationWindow.jsp?refno='+refno,'mywindow2','width=600, height=250, toolbar=false, location=false, status=no, menubar=no, resizable=no, scrollbars=no');
}

function datevalidate()
{
	var date1=document.getElementById("data").value;
	var date2=document.getElementById("data1").value;
  
	var dm1,dd1,dy1,dm2,dd2,dy2;
	dy1=date1.substring(0,4);
	dy2=date2.substring(0,4);
	dm1=date1.substring(5,7);
	dm2=date2.substring(5,7);
	dd1=date1.substring(8,10);
	dd2=date2.substring(8,10);
    var d2date=date2.substring(0,2);
    var d1date=date1.substring(0,2);
    var date=new Date();
	var month=date.getMonth()+1;
	var day=date.getDate();
	var year=date.getFullYear();
	return true;
}

function getEmp(deptName)
{
		var xmlhttp;
		if (window.XMLHttpRequest)
		  {
		  // code for IE7+, Firefox, Chrome, Opera, Safari
		  xmlhttp=new XMLHttpRequest();
		  }
		else if (window.ActiveXObject)
		  {
		  // code for IE6, IE5
		  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		  }
		else
		  {
		  alert("Your browser does not support XMLHTTP!");
		  }
		xmlhttp.onreadystatechange=function()
		{
		if(xmlhttp.readyState==4)
		  {
		  //alert(xmlhttp.responseText);
		  document.getElementById("to").innerHTML=xmlhttp.responseText;
		  }
		}
		xmlhttp.open("GET","getEmp.jsp?deptName="+deptName,true);
		xmlhttp.send(null);
}

function chkForParam()
{
	var p=document.getElementById("rdcnt").value;
	if(p=="" || p==null || p=="0")
	{
		alert("No document selected to send intimation");
		return false;
	}
	var p1=document.getElementById("rd").value;
	var p2=document.getElementById("dept").value;
	var p3=document.getElementById("to").value;
	if(p1=="" || p1==null)
	{
		alert("Please select the document to send intimation");
		return false;
	}
	if(p2=='Select' || p3=="")
	{
		alert("Please select the employee to whom intimation to be sent");
		return false;
	}
	return true;
}

function validate()
{
	var val1 = document.forms['inwrdreport'].elements['rdcnt'].value;
	var rdbtn;
	var i=0;
	for (i=0;i<=val1;i++)
	{
		//alert(i);
		{
			rdbtn= document.getElementById("rd").value;
		}
		if(document.inwrdreport.rd[1].checked==true)
		{
			rdbtn= document.getElementById("rd").value;
		}
		if(document.inwrdreport.rd[2].checked==true)
		{
			rdbtn= document.getElementById("rd").value;
		}
	}

	var val2=document.forms['inwrdreport'].elements['dept'].value;
	var val3=document.forms['inwrdreport'].elements['to'].value;
//	alert(rdbtn);
	//return rdbtn;
	return true;
}
</script>
<script type="text/javascript">
function editInward(reference)
{
	testwindow=window.open('editInwardedEntry.jsp?refno='+reference,'mywindow1','width=400, height=500, toolbar=false, location=false, status=no, menubar=no, resizable=no, scrollbars=yes');
}
</script>
 <%@ include file="footer.jsp" %>
</body>
</html>