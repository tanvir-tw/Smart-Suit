<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
<link href="css/ERP.css" rel="stylesheet" type="text/css"></link>
<style type="text/css">@import url(jscalendar-1.0/calendar-blue.css);</style>
<%@ page import = "java.io.FileNotFoundException"%>
<%@ page import = "java.io.FileOutputStream"%>
<%@ page import = " java.io.IOException"%>
<%@ page import="javax.activation.*" %>
<script type="text/javascript" language="javascript" src="calendar/prototype-1.js"></script>
<script type="text/javascript" language="javascript" src="calendar/prototype-base-extensions.js"></script>
<script type="text/javascript" language="javascript" src="calendar/prototype-date-extensions.js"></script>
<script type="text/javascript" language="javascript" src="calendar/behaviour.js"></script> 
<script type="text/javascript" language="javascript" src="calendar/datepicker.js"></script> 
<link rel="stylesheet" href="calendar/datepicker.css">
<script type="text/javascript" language="javascript" src="calendar/behaviors.js"></script> 

<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">  

<body onkeypress="hideList(event);" onclick="hideOnClick();">
<script>

function formValidation1()
{
	alert("Hi");
}
function formValidation()
{
	//alert("Hi");
	
	var itemdesc=document.getElementById("itemdesc").value;
	alert("itemdesc :- "+itemdesc);
	
	if(itemdesc=="" ){
		alert("Please Enter Value For Item Specification");
		return false;
	}
	var make=document.getElementById("make").value;
	alert("make :- "+make);
	
	var invalid=/^[a-zA-Z  .]+$/;
	var oth=make.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	if(make=="" || oth==""){
		alert("Please Enter Value For Make");
		return false;
	}
	if(!invalid.test(make)){
		alert("Please Enter Character Value For Make");
	     return false;
	 }	
	
	var partno=document.getElementById("partno").value;
	alert("partno :- "+partno);
	
	//var invalid=/^[a-zA-Z  .]+$/;
	var oth=make.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	if(partno=="" || oth==""){
		alert("Please Enter Value For PartNo");
		return false;
	}
	/* if(!invalid.test(partno)){
		alert("Please Enter Valid Value For PartNo");
	     return false;
	 } */
	
	
	var quantity=document.getElementById("quantity").value;
	alert("quantity :- "+quantity);
	
	if(quantity=="" ){
		alert("Please Enter Numeric Value");
		return false;
	}
	
	var invalid=/^[0-9]+$/; 
	if(!(quantity ==0))
		{
			 if(isNaN(quantity))
				{
				 alert("Please Enter Numeric Value");
					//document.getElementById("noofunits1").style.display="";
					return false;
				}	
			 if(!invalid.test(quantity)){
				 alert("Please Enter Numeric Value");
			        //document.getElementById("noofunits2").style.display="";
			                return false;
			            }
				
				
		    }
	
	var unit=document.getElementById("unit").value;
	alert("unit :- "+unit);
	
	if(unit=="Select" ){
		alert("Please select value for Unit Of Measure");
		return false;
	}
	
	var instructions=document.getElementById("instructions").value;
	alert("instructions:- "+instructions);
	
	var dept=document.getElementById("dept").value;
	alert("dept:- "+dept);
	if(dept=="Select" ){
		alert("Please select value for Department");
		return false;
	}
	
	var project=document.getElementById("project").value;
	alert("project "+project);
	
	if(project=="Select" ){
		alert("Please select value for Project");
		return false;
	}
	
	var costcenter=document.getElementById("costcenter").value;
	alert("costcenter "+costcenter);
	
	if(costcenter=="Select" ){
		alert("Please select value for CostCenter");
		return false;
	}
	
	
	var deliverydate=document.getElementById("contractdate").value;
	alert("deliverydate "+deliverydate);
	
	
		//alert("Hi");
		var chkf="";
		var chkt="";
		var objFromDate = document.getElementById("contractdate").value;
		var fdate=objFromDate.split("-");
		if(fdate[1]=="Jan")
		{
			chkf="01";
		}
		if(fdate[1]=="Feb")
		{
			chkf="02";
		}
		if(fdate[1]=="Mar")
		{
			chkf="03";
		}
		if(fdate[1]=="Apr")
		{
			chkf="04";
		}
		if(fdate[1]=="May")
		{
			chkf="05";
		}
		if(fdate[1]=="Jun")
		{
			chkf="06";
		}
		if(fdate[1]=="Jul")
		{
			chkf="07";
		}
		if(fdate[1]=="Aug")
		{
			chkf="08";
		}
		if(fdate[1]=="Sep")
		{
			chkf="09";
		}
		if(fdate[1]=="Oct")
		{
			chkf="10";
		}
		if(fdate[1]=="Nov")
		{
			chkf="11";
		}
		if(fdate[1]=="Dec")
		{
			chkf="12";
		}
		var objFromDate1=""+fdate[2]+"-"+chkf+"-"+fdate[0]+"";
		
		
	    var objToDate = document.getElementById("today").value;
	    alert("Today :-"+objToDate);
	    
	    var tdate=objToDate.split("-");
	    
	    if(tdate[1]=="Jan")
		{
	    	chkt="01";
		}
		if(tdate[1]=="Feb")
		{
			chkt="02";
		}
		if(tdate[1]=="Mar")
		{
			chkt="03";
		}
		if(tdate[1]=="Apr")
		{
			chkt="04";
		}
		if(tdate[1]=="May")
		{
			chkt="05";
		}
		if(tdate[1]=="Jun")
		{
			chkt="06";
		}
		if(tdate[1]=="Jul")
		{
			chkt="07";
		}
		if(tdate[1]=="Aug")
		{
			chkt="08";
		}
		if(tdate[1]=="Sep")
		{
			chkt="09";
		}
		if(tdate[1]=="Oct")
		{
			chkt="10";
		}
		if(tdate[1]=="Nov")
		{
			chkt="11";
		}
		if(tdate[1]=="Dec")
		{
			chkt="12";
		}
	    var objToDate1=""+tdate[2]+"-"+chkt+"-"+tdate[0]+"";
	   // alert("Entry from date > "+objFromDate1+" Todate > "+objToDate1);
	     
	    var date1 = new Date(objFromDate1);//delivery date
	    var date2 = new Date(objToDate1);//today
	    
	    alert("from > "+date1+" Todate > "+date2);
	    
	    
	    
	     
	        if(date1 <  date2)
	        {
	        	
	         
	         alert("Delivery Date Should be greater or equals to To Date");
	            return false; 
	        }	

		
	        
	
	
	
	
	
	
	var vendor=document.getElementById("vendor").value;
	alert("vendor "+vendor);
	
	if(vendor=="")
		{
		alert("Please Enter Value For Vendor");
		return false;
		
		}
	var invalid=/^[a-zA-Z  .]+$/;
	var oth=vendor.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	if(vendor=="" || oth==""){
		alert("Please Enter Value For Vendor");
		return false;
	}
	if(!invalid.test(vendor)){
		alert("Please Enter Character Value For Vendor");
	     return false;
	 }	
	
	var vendoraddress=document.getElementById("vendoraddress").value;
	alert("vendoraddress "+vendoraddress);
	
	
	if(vendoraddress=="" ){
		alert("Please Enter Value For Vendor Address");
		return false;
	}
	
	
	var vendormobile=document.getElementById("vendormobile").value;
	alert("vendormobile "+vendormobile);
	
	if(vendormobile=="")
	{
	alert("Please Enter Value For Vendor Contact");
	return false;
	
	}
	var invalid=/^[0-9]+$/; 
	if(!(vendormobile ==0))
		{
			 if(isNaN(vendormobile))
				{
				 alert("Please Enter Numeric Value");
					//document.getElementById("noofunits1").style.display="";
					return false;
				}	
			 if(!invalid.test(vendormobile)){
				 alert("Please Enter Numeric Value");
			        //document.getElementById("noofunits2").style.display="";
			                return false;
			            }
				
				
		    }
	
	var vendoremail=document.getElementById("vendoremail").value;
	alert("vendoremail "+vendoremail);
	
	 
	var text= /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,15})+$/;

	if(vendoremail=="")
		{
		alert("Please Enter EmailID");
		//document.getElementById("email3").style.display="";
		return false;
		}

	if(!text.test(vendoremail))
		{
		alert("Please Enter valid EmailID");
		//document.getElementById("email2").style.display="";
		return false;
		
		}
	
	
	
        
        
}
		

function Redirect()
{	
	
	//var a=document.getElementById("rupees").value;
	//alert(a);
	
	alert("Data Inserted  Successfully ");
	
    window.location="PurchaseIndentReport.jsp";
    
    
}

function Redirect1()
{
	alert("ERROR While Data Inserting ..........!!");
    window.location="PurchaseIndentEntryForm.jsp";
	
}
		
</script>
<%@ include file="header.jsp"%>
<%!
Connection con1;
%>
<% 
		Class.forName(DB_Driver);
		con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		%>
		
		<%



Statement stdynamicdrop = null;
String datenew1="",datenew2="",datenew3="",datenew4="";
datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());

datenew3=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
System.out.println("DAte :- "+datenew3);

datenew2=datenew1;
datenew4=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
%>
<input type="hidden" name="today" id="today" value="<%=datenew4 %>"  />
<%
//centnon1.getConnection();
// con1=centconn.ReturnConnection();
//stdynamicdrop=con1.createStatement();

Statement st = null, st1 = null, st3 = null, st4 = null,st5 = null,st6 = null,st2 = null,st7=null,st8=null;

String selectedName;
String FollowUpType = "";String company="";
st = con1.createStatement();
st1 = con1.createStatement();
st2 = con1.createStatement();
st3 = con1.createStatement();
st4 = con1.createStatement();
st5 = con1.createStatement();
st6 = con1.createStatement();
st7 = con1.createStatement();
st8 = con1.createStatement();


try{
	
String itemdesc=request.getParameter("itemdesc");
String make=request.getParameter("make");
String partno=request.getParameter("partno");
String quantity=request.getParameter("quantity");
String unit=request.getParameter("unit");
String instructions=request.getParameter("instructions");
if(instructions=="" || instructions==" " || instructions==null)
{
	instructions="-";
}
String project=request.getParameter("project");
String costcenter=request.getParameter("costcenter");
String contractdate=request.getParameter("contractdate");

contractdate = new SimpleDateFormat("yyyy-MM-dd")
.format(new SimpleDateFormat("dd-MMM-yyyy")
		.parse(contractdate));

String vendor=request.getParameter("vendor");
String vendoraddress=request.getParameter("vendoraddress");
String vendormobile=request.getParameter("vendormobile");
String vendoremail=request.getParameter("vendoremail");
String dept=request.getParameter("dept");
String cost=request.getParameter("cost");
System.out.println("itemdesc"+itemdesc);
System.out.println("make"+make);
System.out.println("part no "+partno);
System.out.println("quantity "+quantity);
System.out.println("unit"+unit);
System.out.println("instr"+instructions);
System.out.println("Project "+project);
System.out.println("costcenter "+costcenter);
System.out.println("contractdate"+contractdate);
System.out.println("Vendor"+vendor);
System.out.println("vendor"+vendoraddress);
System.out.println("vendor"+vendormobile);
System.out.println("vendor"+vendoremail);
System.out.println("dept"+dept);
System.out.println("cost"+cost);


String insert="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"PurchaseIndentRequestData (RequestDate,ItemSpecification,Make,PartNo,Quantity,UnitOfMeasure,SpecialInstructions,Department,Project,CostCenter,DeliveryDate,SuggestedVendor,SuggestedVendorAddress,SuggestedVendorContact,SuggestedVendorEmail,EntryBy,Rate) values ('"+datenew3+"','"+itemdesc+"','"+make+"','"+partno+"','"+quantity+"','"+unit+"','"+instructions+"','"+dept+"','"+project+"','"+costcenter+"','"+contractdate+"','"+vendor+"','"+vendoraddress+"','"+vendormobile+"','"+vendoremail+"','"+session.getAttribute("EmpName").toString()+"','"+cost+"')";
System.out.println("Insert Query :- "+insert);
st.executeUpdate(insert);


String insert1="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"PurchaseIndentDataHistory (RequestDate,ItemSpecification,Make,PartNo,Quantity,UnitOfMeasure,SpecialInstructions,Department,Project,CostCenter,DeliveryDate,SuggestedVendor,SuggestedVendorAddress,SuggestedVendorContact,SuggestedVendorEmail,EntryBy,Rate) values ('"+datenew3+"','"+itemdesc+"','"+make+"','"+partno+"','"+quantity+"','"+unit+"','"+instructions+"','"+dept+"','"+project+"','"+costcenter+"','"+contractdate+"','"+vendor+"','"+vendoraddress+"','"+vendormobile+"','"+vendoremail+"','"+session.getAttribute("EmpName").toString()+"','"+cost+"')";
System.out.println("Insert Query :- "+insert1);
st1.executeUpdate(insert1);


// All pending mail alert code 




DateFormat df = new SimpleDateFormat("dd-MMM-yyyy HH:mm");
java.util.Date date = new java.util.Date();		
String data ="";
String CurrentDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
.format(new java.util.Date());
String SystemName="",Website="",Logo1="",Logo2="",Signature="",fromLabel="",replyToMailid="",Disclaimer="";
String companyMaster=session.getAttribute("CompanyMasterID").toString();
String Status="Pending";
String ReportName="Purchase Request ";
String displayedReportNo="629";

String tomailid=session.getAttribute("EmpEmail").toString();
String EmpCode=session.getAttribute("EmpCode").toString();
String HODId="select * from db_leaveapplication.t_leaveadmin where EmpID='"+EmpCode+"'";
ResultSet rsHODId=st7.executeQuery(HODId);
rsHODId.next();
String HodMail="select * from db_GlobalERP.UserMaster where EmpCode='"+rsHODId.getString("ReportingtoHod")+"' ";
ResultSet rsHodMail=st8.executeQuery(HodMail);
String tohod="";
String EmpName="";
if(rsHodMail.next())
{
	tohod=rsHodMail.getString("email");
	EmpName=rsHodMail.getString("EmpName");
}
System.out.println("to mail Id:- "+tomailid);
System.out.println("to HOD mail Id:- "+tohod);

String toid=tohod , tocc=tomailid;

String subject = "New Purchase Request On "+ df.format(date)+" .";
	System.out
			.println("===11111111111111111111111111===");
	
			data="<tr></tr><tr><td><table align=left  cellpadding=0 cellspacing=0 border=0><tr><td align=left><font size=3 face=arial><b> Purchase Requisition Request Details : </b></font></br></td></tr></table></td></tr>"+
					"<tr><td><table align=left  cellpadding=0 cellspacing=0 border=1 style=^border-collapse: collapse^>"+
			"<tr bgcolor=^#ADDFFF^>"+
					"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b> SrNo  </b></font></td>"+
					"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b> ItemDesc  </b></font></td>"+
		/* "<td align=center style=^width: 3%;^><font size=^2^ face=^arial^><b> PurQuoNo </b></font></td>"+ */
		"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b> Quantity  </b></font></td>"+
		
				"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b> Rate </b></font></td>"+
						"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b> Unit Of Measure </b></font></td>"+
						"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b> Dept  </b></font></td>"+
		"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b> Project </b></font></td>"+
		
		"<td align=center style=^width: 3%;^><font size=^2^ face=^arial^><b> Cost Center  </b></font></td>"+
				"<td align=center style=^width: 3%;^><font size=^2^ face=^arial^><b> SpecialInstructions  </b></font></td>"+
		"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b> Delivery Date </b></font></td>"+
				"<td align=center style=^width: 3%;^><font size=^2^ face=^arial^><b> Status </b></font></td>"+
		"<td align=center style=^width: 3%;^><font size=^2^ face=^arial^><b> Entry By</b></font></td>";

		int z=0;
					z++;		
				
		
data= data +"<tr><td align=right><font size=^2^ face=^arial^>"+ z +"</font></td>"+
"<td align=right><font size=^2^ face=^arial^>"+itemdesc+"</font></td>"+
/* "<td align=right><font size=^2^ face=^arial^>"+pqno+"</font></td>"+ */
			
						"<td align=right><font size=^2^ face=^arial^>"+quantity+"</font></td>"+
								"<td align=right><font size=^2^ face=^arial^>"+cost+"</font></td>"+
								"<td align=left><font size=^2^ face=^arial^>"+unit+"</font></td>"+
								
						"<td align=left><font size=^2^ face=^arial^>"+dept+"</font></td>"+
						
		"<td align=right><font size=^2^ face=^arial^>"+project+"</font></td>"+
		"<td align=left><font size=^2^ face=^arial^>"+costcenter+"</font></td>"+
				"<td align=left><font size=^2^ face=^arial^>"+instructions+"</font></td>"+
				"<td align=right><font size=^2^ face=^arial^>"+new SimpleDateFormat("dd-MMM-yyyy")
		.format(new SimpleDateFormat(
				"yyyy-MM-dd")
				.parse(contractdate))+"</font></td>"+
				
				"<td align=left><font size=^2^ face=^arial^>"+Status+"</font></td>"+
		"<td align=left><font size=^2^ face=^arial^>"+session.getAttribute("EmpName").toString()+"</font></td>";
		
		
		
									
				
				data= data + "</table></tr><br/><br/><br/><br/><br/><br/><br/><br/>";

				data= data + "<tr><td align = left><table align= left><br></br><tr><td><font size=^3^ face=^Arial^></font></td></tr> <tr>  <td><font size=^3^ face=^Arial^></font></td> </tr>";
				data= data + "</tr></body></html>";

	System.out
			.println("in DDDDDDDDDDDDDDDDAta====="
					+ data);
	
	try
	{
		
		String getEmailDetails="select * from db_gps.t_EmailReportSettings	where System='ERP"+companyMaster+"'";
		ResultSet rs100=st5.executeQuery(getEmailDetails);
		
		while(rs100.next())
		{
			 SystemName=rs100.getString("System");
			 Website=rs100.getString("Website");
			 Logo1=rs100.getString("Logo1");
			 Logo2=rs100.getString("Logo2");
			 Signature=rs100.getString("Signature");
			 fromLabel=rs100.getString("fromLabel");
			 replyToMailid=rs100.getString("replyToMailid");
			 Disclaimer=rs100.getString("Disclaimer");
			
		}
		
	}catch(Exception e)
	{
		System.out.println("Exception "+e.getMessage());
	}
			
	
	String html ="<html><head><style type=text/css>table.mytable{font:13px arial,sans-serif;border-collapse: collapse; border: 1px solid #839E99;background: #f1f8ee;}</style> </head>"+
				"<body><table    border=^18^  bordercolor=^#E6E6FA^ align=^center^ width=^60%^><tr align=^center^><td align=^left^ style=^border: 0px;^ width=^100%^>"+
				"<table  style=^margin-left: 1em;margin-right: 1em;width: 100%;height: 100%;^><tr><td width=^100%^><table width = ^97%^ ><tr><td><a href= target=^_blank^>"+
				"<img src="+Logo1+" style=^height: 80px; width: 300px;^ id=^logo^ alt=^Logo^ /></a></td><td  align = ^right^ >"+
				"<img src="+Logo2+"  style=^height: 80px; width: 300px;^ /></td></tr></table> <font style=^color: #D8D8D8^>"+
				"________________________________________________________________________________________________________________________________________________</font><br><div width = ^100%^><font size = ^2^ face = ^Arial^>"+
				" <u><a href=http://"+Website+"></u>"+Website+"</a>"+ df.format(new Date())+"<br>"+"\n "+ReportName+": "+displayedReportNo+"</font><table>"+
				"<tr><td align=left><font size=2 face=arial> Dear "+EmpName+",</font></br></td></tr><tr><td align=left><font size=2 face=arial> Please Approve Below New Purchase Request. </font></br></td></tr>";
    
    html = html + data;
    html = html + "</table><table align= left><br></br><tr><td><font size=^2^ face=^Arial^>Thanks and Regards</font></td></tr><tr><td><font size=^2^ face=^Arial^>"+Signature+"</font></td></tr><tr><td><font size=^2^ face=^Arial^>Phone: +91-20-41214444  +91-9762007124 +91-9762007125</font></td></tr><tr>  <td><font size=^2^ face=^Arial^> "+Disclaimer+"</font></td> </tr></table></td></tr></table></div></td></tr></table></td></tr></body></html>";
	
String 	q2 = "insert into t_allpendingmailtableERP(MailName,Description,MailBody,subjectline,Toid,Tocc,EntryDateTime,MailStatus,SenderName,FileName,AttachFilePath) values ('Purchase Requisition Details','Purchase Requisition Request','"
			+ html
			+ "','"
			+ subject
			+ "','"
			+ toid
			+ "','"
			+ tocc
			+ "','"
			+ CurrentDate + "','Pending','Transworld','','')";

System.out.println("q2All_PendingMail>>>> :" + q2);
st6.executeUpdate(q2);
System.out.println("inserted in all pending mail >>> 1234");




out.println("<script>  Redirect();</script>");

}
catch(Exception e)
{
	out.println("<script>  Redirect1();</script>");
	e.printStackTrace();
}
%>
 
 

</jsp:useBean>

<%-- <%@include file="footer_new.jsp"%> --%>

<%@ include file="footer_new.jsp"%>