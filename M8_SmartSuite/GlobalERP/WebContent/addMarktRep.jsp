<%@ include file="conn.jsp"%>
<%@page import="java.util.Date"%>

<%
Connection con;
con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
%>
<%
int compressorvalue=0,digitalequpvalue=0,dgsetvalue=0,endoscopevalue=0,othergroupvalue=0;

String EMPName=session.getAttribute("EmpName").toString();

String todaysDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());


String repName=request.getParameter("repName");   
System.out.println(repName);
String city=request.getParameter("city");  
System.out.println(city);
String address=request.getParameter("address");
System.out.println(address);
String state=request.getParameter("state");
System.out.println(state);
String country=request.getParameter("country");  
System.out.println(country);
String email=request.getParameter("email"); 
System.out.println(email);
String phone=request.getParameter("phone"); 
System.out.println(phone);
String dept=request.getParameter("department");
System.out.println(dept);
String level=request.getParameter("userlevel");
String vtarget=request.getParameter("visittarget");
String caltarget=request.getParameter("calltarget");
String lettarget=request.getParameter("lettarget");
String SQtarget=request.getParameter("squotarget");
String NQuotarget=request.getParameter("nprostarget");
String password=request.getParameter("userpsd");
String username=request.getParameter("repuname");
String talevel=request.getParameter("talevel");
String comp=request.getParameter("company");
System.out.println(">>>>>>>>>>>>>>>>>>>>>            "+comp);
String compr=request.getParameter("compressor");
System.out.println("VALUE  VALOUE   "+compr);
if(compr!=null)
{
if(compr.equalsIgnoreCase("True"))
{
	compressorvalue=1;
}
else 
{
	compressorvalue=0;
}
}
System.out.println("COMPRESSOR           "+compressorvalue);

String digieqp=request.getParameter("digiequp");
System.out.println("VALUE  VALOUE   "+digieqp);

if(digieqp!=null)
{	
if(digieqp.equalsIgnoreCase("True"))
{
	digitalequpvalue=1;
}
else
{
	digitalequpvalue=0;
}
}
System.out.println("DIGITAL EQUIPMENTSn      "+digitalequpvalue);

String dgset=request.getParameter("dgset");
if(dgset!=null)
{	
if(dgset.equalsIgnoreCase("True"))
{
	dgsetvalue=1;
}
else 
{
	dgsetvalue=0;
	
}
}
System.out.println("DIGITALSET       "+dgsetvalue);

String endoscope=request.getParameter("endoscope");
System.out.println("VALUE  "+endoscope);
if(endoscope!=null)
{
if(endoscope.equalsIgnoreCase("True"))
{
	endoscopevalue=1;
}
else 
{
	endoscopevalue=0;
}
}
System.out.println("ENDOSCOPE      "+endoscopevalue);

String othergrp=request.getParameter("othergroup");
System.out.println(othergrp);
if(othergrp!=null)
{
if(othergrp.equalsIgnoreCase("True"))
{
	othergroupvalue=1;
}else
{
	othergroupvalue=0;
}
}
System.out.println("OTHERGROUP      "+othergroupvalue);
Statement st1=con.createStatement(); 
Statement st=con.createStatement();
Statement st2=con.createStatement();
Statement st3=con.createStatement();
Statement st4=con.createStatement();

String repcode="";
String sql="SELECT EmpCode from "+session.getAttribute("CompanyMasterID").toString()+"security where EmpName='"+repName+"' and email='"+email+"';";
ResultSet rs=st.executeQuery(sql);
rs.next();
repcode=rs.getString("EmpCode");
		//while(rs.next()){
System.out.println("EmpCode = "+repcode);
System.out.println("Select SQL qry = "+sql);

String Check="select * from "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster where MarketingRepName='"+repName+"' and MarketingRepCode='"+repcode+"' ";
ResultSet rscheck=st3.executeQuery(Check);
if(rscheck.next())
{
	
	String sqlUpdate="UPDATE "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster  SET MarketingRepAddress='"+address+"' ,MarketingRepCity='"+city+"',MarketingRepPhNo='"+phone+"',MarketingRepState='"+state+"' ,MarketingRepCountry='"+country+"',UserLevel='"+level+"',Compressor='"+compressorvalue+"',DigitalEquipment='"+digitalequpvalue+"' ,DGSet='"+dgsetvalue+"',Endoscope ='"+endoscopevalue+"',OtherGroups='"+othergroupvalue+"',VisitsTarget='"+vtarget+"',CallsTarget='"+caltarget+"',LettersTarget='"+lettarget+"',SQTarget='"+SQtarget+"',NewProspectTarget='"+NQuotarget+"'  where MarketingRepName='"+repName+"' and MarketingRepCode='"+repcode+"' ";
	System.out.println(sqlUpdate);
	st1.executeUpdate(sqlUpdate);
	
	
		String msg1 = "Data Updated For Marketing Representative :"+repName +" successfully  in system";
		
		response.sendRedirect("alertGoTo.jsp?msg="+msg1+"&goto=addNewMarketingRep.jsp?type=new");
	
}else{
String sqlInsert="";
	    
sqlInsert = " INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster(MarketingRepCode ,MarketingRepName ,MarketingRepAddress ,MarketingRepCity ,MarketingRepPhNo, "+
			" MarketingRepState ,MarketingRepCountry ,MarketingRepEMail ,MarketingRepPassword ,UserLevel ,Compressor ,DigitalEquipment ,DGSet ,"+	
			" Endoscope ,OtherGroups ,VisitsTarget ,CallsTarget ,LettersTarget ,SQTarget ,NewProspectTarget ,MailerToProspCustTarget , "+	
			" UserName ,Password ,Level,Dept ,VisitTarget ,SalesTarget,	MailerToProspectTarget ,NewProspCustTarget) VALUES "+
		    " ('"+repcode+"','"+repName+"','"+address+"','"+city+"','"+phone+"' ,"+
		    " '"+state+"','"+country+"','"+email+"','"+password+"','"+level+"','"+compressorvalue+"','"+digitalequpvalue+"','"+dgsetvalue+"' ,"+
		    " '"+endoscopevalue+"','"+othergroupvalue+"','"+vtarget+"','"+caltarget+"','"+lettarget+"','"+SQtarget+"','"+NQuotarget+"','0',"+
		   	" '"+username+"','"+password+"','"+level+"','"+dept+"','0','0','0','0' )";     

System.out.println(sqlInsert);

String Sendhistory="Insert into "+session.getAttribute("CompanyMasterID").toString()+"Adminhistory(AdminUserName,UserName,UpdatedDateTime,Action,ActiveStatus)values('"+EMPName+"','"+repName+"','"+todaysDateTime+"','Add','Yes')";
System.out.println("------------"+Sendhistory);
out.println("#Yes");

//st1.executeUpdate(sqlInsert);		              
				  
/*String insertSec="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"security(UserName ,Password ,UserLevel ,Dept ,Code ,EmpCode ,Level ,EmpName ,TALevel ,CompanyCode ,mobileno ,email)"+
				 " VALUES('"+username+"','"+password+"','"+level+"','"+dept+"','"+repcode+"','"+repcode+"','"+level+"','"+repName+"','"+talevel+"','"+comp+"','"+phone+"','"+email+"')	";
System.out.println(insertSec);
st2.executeUpdate(insertSec);		*/              
		
try{          
				
st2.executeUpdate(sqlInsert);
st3.executeUpdate(Sendhistory);
String existedDriver = "";
String msg = "";		
boolean flag=false;
	
flag=true;

msg = "Data insertion Failed . please try again";
				 /*sqlInsert = "update "+session.getAttribute("CompanyMasterID").toString()+"followup SET ()*/
if(flag){
msg = "New Marketing Representative :"+repName +" successfully added in system";
}
response.sendRedirect("alertGoTo.jsp?msg="+msg+"&goto=addNewMarketingRep.jsp?type=new");

}catch(Exception e){
out.println( "Exception ::"+e );
}	
}
%>
