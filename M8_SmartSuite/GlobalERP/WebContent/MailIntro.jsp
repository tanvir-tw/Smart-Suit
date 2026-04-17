<%@page import="java.util.Date"%>
<%@page language="java" import="java.sql.*"  import=" java.text.*" import=" java.util.*" errorPage="close.jsp" 
%>
<%@ include file="conn.jsp" %>
<!DOCTYPE html>

<%@page import="com.erp.beans.*"  %> 

<%-- <%@page import="com.erp.beans.EmailTemplate"%> --%>
<%@
page import="javax.*,java.awt.*,

 com.lowagie.text.Chunk,  
 com.lowagie.text.Document,  
 com.lowagie.text.DocumentException,  
com.lowagie.text.Font, 
com.lowagie.text.FontFactory,  
com.lowagie.text.HeaderFooter,  
com.lowagie.text.Image,  
com.lowagie.text.PageSize,  
com.lowagie.text.Paragraph,  
com.lowagie.text.Phrase,
 com.lowagie.text.pdf.BaseFont,  
 com.lowagie.text.pdf.PdfContentByte,  
 com.lowagie.text.pdf.PdfImportedPage,  
com.lowagie.text.pdf.PdfLayer,  
com.lowagie.text.pdf.PdfReader,  
com.lowagie.text.pdf.PdfStamper,  
com.lowagie.text.pdf.PdfString,  
com.lowagie.text.pdf.PdfWriter,  
java.io.FileOutputStream,
java.io.*,
java.util.*,
java.awt.*,
java.awt.geom.Rectangle2D,
com.lowagie.text.pdf.*,
com.lowagie.text.pdf.PdfPCellEvent,
com.lowagie.text.*,
com.lowagie.text.Image,
org.jfree.chart.ChartFactory,
org.jfree.chart.JFreeChart,
org.jfree.chart.plot.PlotOrientation,
org.jfree.data.DefaultCategoryDataset,
org.jfree.data.DefaultPieDataset,
org.jfree.chart.ChartFrame,
org.jfree.chart.renderer.BarRenderer,
org.jfree.chart.plot.CategoryPlot,
org.jfree.chart.plot.PiePlot3D"%>



<%@page import="com.lowagie.text.Rectangle"%><jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
 
	<script src="dropdown.js" type="text/javascript"></script>
	<script src="dynamic.js" type="text/javascript"></script>

	<head>
	<script type="text/javascript">
	function fun(){
		alert("Error");
	//	window.close();
	}
	function Redirect()
	{
		alert("Mail Records Saved Successfully");
	    window.location="home.jsp";
		
	}
	function Redirect1()
	{
		alert("Mail Records Not Saved Successfully");
		 var companyname=document.getElementById("companyname1234").value;
		 var customercode=document.getElementById("customercode1").value;
		 var contact=document.getElementById("contact1").value;
		 var companyEmail1=document.getElementById("companyEmail1").value;
		 var companyEmail2=document.getElementById("companyEmail2").value;
		 
		 // alert("Comapny---------name "+companyname);
		// alert("Comapny---------customercode "+customercode);
		// alert("Comapny---------contact "+contact);
		// alert("Comapny--------companyEmail1 "+companyEmail1);
		// alert("Comapny--------companyEmail2 "+companyEmail2);
		 
		
		var queryString = "?companyname="+companyname+"&customercode="+customercode+"&contact="+contact+"&companyEmail="+companyEmail1;
        //alert(queryString);
       // ajaxRequest.open("GET", "checkNoOfFollowUp.jsp" + queryString, true);
	    window.location="IntroMail.jsp"+ queryString;
		
	}
	</script>
	</head>
	<body>
	<%
erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	Connection conn = null;
	Connection conn1 = null;
	Statement st = null, st1 = null,st2=null,st3=null,st4=null,st5=null,stlbl=null;
String emailTo="";
String data="";
String ss="";
String ss2="",ss1="";
String CcMail="";
String mainMailTo="";
String mainMailCc="";
String companyname="",companyname1="",companyname2="";
String Doc1="",Doc2="",Doc3="";
String AttachFilePath1="",AttachFilePath2="",AttachFilePath3="";
String[] AttachFilePath= new String[100];
String DocumentName1="",DocumentPath="";
String Attachment123="";
String DocumentPath1="";
String attch="";
try {
	conn = erp.ReturnConnection();
	conn1=erp.ReturnConnection();
	st = conn.createStatement();
	st2 = conn.createStatement();
	st1 = conn.createStatement();
	st3 = conn.createStatement();
	st4 = conn.createStatement();
	st5 = conn.createStatement();
	stlbl = conn.createStatement();
	} catch (Exception e) {
		e.printStackTrace();
	}
try{

emailTo=request.getParameter("emailTo1").trim();
ss1=request.getParameter("email");
ss2=request.getParameter("emailTo");
CcMail=request.getParameter("emailTo2").trim();

String comid=session.getAttribute("CompanyMasterID").toString();
String Docs="select DocumentName,DocumentPath from db_GlobalERP.ERPIntroDocsMaster where CompanyId='"+comid+"'";
	ResultSet rs1=st5.executeQuery(Docs);
	while(rs1.next())
	{
		
		DocumentPath1=rs1.getString("DocumentPath");
		
		
	}	

if(emailTo==null){
	emailTo="";
}
System.out.println("EMAIL EXTRA   "+emailTo);
}catch(Exception e){System.out.println("No Extra Mail Ids");}
String pgname="";
String reportno="";

try{
// 	data=request.getParameter("data");
// 	data=data.replaceAll("\"", "^");
// 	data=data.replaceAll("_and_", "&");
// 	data=data.replaceAll("__per__", "%");
// 	data=data.replaceAll("_1_", "'");

		data=request.getParameter("data");
		data=data.replaceAll("__12__", "\"");
		data=data.replaceAll("_and_", "&");
		data=data.replaceAll("__per__", "%");
		data=data.replaceAll("_1_", "'");
		data=data.replaceAll("_1k_", "&#94;");
		data=data.replaceAll("_plus_", "&#43;");
		data=data.replaceAll("_ll_", "<");
		data=data.replaceAll("_rr_", ">");
		data=data.replaceAll("_123A_", "#");
		data=data.replaceAll("_rupee_", "&#x20B9;");
		data=data.replaceAll("(", "");
		data=data.replaceAll(")", "");
		data=data.replaceAll(" ", "");
		//data=data.replaceAll(" ", "&nbsp;");
		
		
		data="<br><br><font size=^2^ face=^Arial^>"+data+"</font>";







	pgname=request.getParameter("pagename");
	reportno=request.getParameter("reportnumber");
	System.out.println("Data   "+data+"--"+reportno+"--"+pgname);
	//out.println("Data   "+data+"--"+reportno+"--"+pgname+" end");
	//out.println("<br>2");
}
catch(Exception e)
{
	System.out.println("No Extra Mail Ids");
}

try{
	
	ResultSet rs_email1=null;
	Statement st_email1=conn.createStatement();
String mailname=(String)session.getAttribute("EmpName");
	//String Description="About Quotations";
	String MailBody=data;//"Dear Customer,<br>Thank you for your enquiry.<br> Please find attached quotation.<br>Waiting for your valuable order.Thank You";
	String comid=session.getAttribute("CompanyMasterID").toString();
			
	String sql_email1="select * from db_GlobalERP.CompanyMaster where  companymid='"+session.getAttribute("CompanyMasterID").toString()+"'";
	rs_email1=st_email1.executeQuery(sql_email1);
	
	while(rs_email1.next()){
		companyname2=rs_email1.getString("Companyname");
		
	} 		
		companyname2=companyname2.replaceAll("\n"," ");
	
	StringBuilder sb=new StringBuilder();
	StringBuilder sb1=new StringBuilder();
	/* String Docs="select DocumentName,DocumentPath from db_GlobalERP.ERPIntroDocsMaster where CompanyId='"+comid+"'";
	ResultSet rs1=st5.executeQuery(Docs);
	while(rs1.next())
	{
		DocumentName1=rs1.getString("DocumentName");
		DocumentPath=rs1.getString("DocumentPath");
		System.out.println("DocumentName1----------**************"+DocumentName1);
		sb.append(DocumentName1+",");
		System.out.println("DocumentName1----------**************"+sb.toString());
		//DocumentName2=rs1.getString(2);
		sb1.append(DocumentPath+",");
	}			System.out.println("DocumentName1----------"+DocumentName1);
	
	String DocumentName123[]=sb.toString().split(",");
    DocumentPath1=sb1.toString().split(","); */
	 DateFormat df = new SimpleDateFormat("dd-MMM-yyyy HH:mm");
	String dt_sub=df.format(new Date());
	System.out.println("dt_sub========"+dt_sub);
	companyname1=request.getParameter("companyname");
	
	companyname1=companyname1.replace("..","&");
	
	String subjectline=companyname2+"Profile to " +companyname1+" on "+dt_sub;
	//subjectline=subjectline.trim();
	//subjectline=subjectline.replaceAll(" ","");
	//subjectline=subjectline.replaceAll("(","");
	//subjectline=subjectline.replaceAll(")","");
	String PageName=companyname2+"Profile";
	
	/* String FileName1=DocumentName123[0];
	FileName1=FileName1.replaceAll(" ", "");
	System.out.println("FileName1----------"+FileName1);
	String FileName2=DocumentName123[1];
	FileName2=FileName2.replaceAll(" ", "");
	System.out.println("FileName2----------"+FileName2);
	 */
	//String Toid="k_rajput@transworld-compressor.com";
	String Toid=emailTo;
// 	if(emailTo!="" || emailTo!=null){
// 		Toid=Toid+","+emailTo;
// 	}
	
	String Tocc=CcMail;
	String msg="",FileName="";
	

	int cntr=Integer.parseInt(request.getParameter("cntr"));
	
	

String filepath=request.getParameter("id");

String filepathnew[]=filepath.split(",");
//out.println("\nCount----------"+cntr);



int k=0;

if(cntr==0)
{
	FileName="-";
	attch="-";
	//out.println("\nCount----------1");
	//out.println("\nCount-------FileName---1"+FileName);
	//out.println("\nCount--------attch--1"+attch);
}
else{
	
	FileName=filepath.substring(0, filepath.length()-1);
	String[] select=new String[cntr];
		 for(k=0;k<cntr;k++)
		{
			 out.println("\nCount----------2"+cntr);
			/* select[k]=request.getParameter("cb"+k);
			
			 System.out.println("select----------"+select[k]);
			 
			 System.out.println("\nCount----------"+k);
			
			
			FileName+=select[k]; */
			
			
	 
			 AttachFilePath[k]=""+DocumentPath1.toString()+""+comid+"/"+filepathnew[k];
			 attch+=AttachFilePath[k]+",";
			 
			 
			 //out.println("filname----------"+FileName);
			 //out.println("attach------filname----------"+select[k]);
			// out.println("attachfilepath----------"+AttachFilePath[k]);
		} 
		 
}	 


		  attch=attch.substring(0, attch.length()-1);
		 //out.println("filname----------"+FileName);
		 //out.println("attch----------"+attch);
	
	
	String date1="";
	String date2="";
	//String date3=new SimpleDateFormat("dd/MM/yyyy").format(new SimpleDateFormat(new Date().parse("")));
	String displayedReportNo="572";
	System.out.println("0.2");
	String ReportName=PageName;
	System.out.println("0.5");
	StringBuffer htmlstr=new StringBuffer(MailBody);
	System.out.println("1");
	
	//String FileName=FileName1+","+FileName2;
	//htmlstr=MailBody.
			/* String comid=(String)session.getAttribute("CompanyMasterID"); */
	String krn="w_tamboli@transworld-compressor.com,r_shah@transworld-compressor.com,";
	//boolean isSend=template.sendmail(htmlstr, krn, Tocc, subjectline,subjectline, date1, date2, displayedReportNo, ReportName, FileName, AttachFilePath,comid);
	ERPEmailTemplate template=new ERPEmailTemplate();
	/* boolean isSend=template.sendmail(htmlstr,krn,"",subjectline, subjectline,date1, date2, displayedReportNo, "","","",comid); */
	boolean isSend=template.sendmail(htmlstr,Toid,Tocc,subjectline,subjectline,date1, date2, displayedReportNo,ReportName,FileName,attch,comid,"","");
	System.out.println("2");
	
	String companyname123=request.getParameter("companyname");
	String customercode=request.getParameter("customercode");
	String contact=request.getParameter("firstContact");
	String companyEmail1=request.getParameter("emailTo1");
	String companyEmail2=request.getParameter("emailTo2");
	%>
	<input type="hidden" name="companyname1234"  id="companyname1234" value="<%=companyname123%>"></input>
<input type="hidden" name="customercode1"  id="customercode1" value="<%=customercode%>"></input>
<input type="hidden" name="contact1"  id="contact1" value="<%=contact%>"></input>
<input type="hidden" name="companyEmail1"  id="companyEmail1" value="<%=companyEmail1%>"></input>
<input type="hidden" name="companyEmail2"  id="companyEmail2" value="<%=companyEmail2%>"></input>
	<% 
	

	if(isSend)
	{
		out.println("<script>  Redirect();</script>");
		 msg="Mail Sent Successfully to "+Toid+"and"+Tocc+"====Attachments=====*********Doc1******"+Doc1+"---Doc2-------"+Doc2+"^^^^^^^^^^^^^"+AttachFilePath;
		 
		 
	}else{
		 out.println("<script>  Redirect1();</script>");
		 msg="Error While Sending Mail  please try again...!!!!";
		
	}
	System.out.println(msg);
	
	System.out.println("krn"+msg);
	System.out.println("*****************************");
			
	 //response.sendRedirect("home.jsp?msg="+msg);
}
catch(Exception e)
{
	e.printStackTrace();
}
	 %>	
	</body>
	</html>
</jsp:useBean>