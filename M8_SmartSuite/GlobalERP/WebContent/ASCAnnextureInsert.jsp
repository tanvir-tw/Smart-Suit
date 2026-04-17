<%@ page language="java" import="java.sql.*" import="java.util.*" import="java.text.*" errorPage=""
    pageEncoding="ISO-8859-1"%>
    <%@ include file="header.jsp" %>
   <jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>ASC Summary</title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script src="js/sorttable.js" type="text/javascript"></script>
<script >


function calculate()
{
	
	var junkVal=document.getElementById('grandTotal').value;
	alert(junkVal);
    junkVal=Math.floor(junkVal);
    var obStr=new String(junkVal);
     numReversed=obStr.split("");
    actnumber=numReversed.reverse();

   if(Number(junkVal) >=0){
    }
    else{
    alert('wrong Number cannot be converted');
    return false;
    }
    if(Number(junkVal)==0){
        document.getElementById('container').innerHTML=obStr+''+'Rupees Zero Only';
        return false;
    }
    if(actnumber.length>9){
        alert('Oops!!!! the Number is too big to covertes');
        return false;
    }
 
    var iWords=["Zero", " One", " Two", " Three", " Four", " Five", " Six", " Seven", " Eight", " Nine"];
    var ePlace=['Ten', ' Eleven', ' Twelve', ' Thirteen', ' Fourteen', ' Fifteen', ' Sixteen', ' Seventeen', ' Eighteen', ' Nineteen'];
    var tensPlace=['dummy', ' Ten', ' Twenty', ' Thirty', ' Forty', ' Fifty', ' Sixty', ' Seventy', ' Eighty', ' Ninety' ];
 
    var iWordsLength=numReversed.length;
    var totalWords="";
    var inWords=new Array();
    var finalWord="";
    j=0;
	for(i=0; i<iWordsLength; i++){
    switch(i)
        {
        case 0:
        if(actnumber[i]==0 || actnumber[i+1]==1 ) {
                inWords[j]='';
            }
            else {
                inWords[j]=iWords[actnumber[i]];
            }
            inWords[j]=inWords[j]+' Only';
        break;
        case 1:
            tens_complication();
            break;
        case 2:
       if(actnumber[i]==0) {
           inWords[j]='';
        }
        else if(actnumber[i-1]!=0 && actnumber[i-2]!=0) {
                inWords[j]=iWords[actnumber[i]]+' Hundred and';
        }
            else {
            inWords[j]=iWords[actnumber[i]]+' Hundred';
            }
       break;
        case 3:
            if(actnumber[i]==0 || actnumber[i+1]==1) {
                inWords[j]='';
            }
            else {
            inWords[j]=iWords[actnumber[i]];
            }
            if(actnumber[i+1] != 0 || actnumber[i] > 0){
            inWords[j]=inWords[j]+" Thousand";
        }
            break;
        case 4:
            tens_complication();
        break;
        case 5:
            if(actnumber[i]==0 || actnumber[i+1]==1) {
            inWords[j]='';
            }
        else {
            inWords[j]=iWords[actnumber[i]];
        }
            if(actnumber[i+1] != 0 || actnumber[i] > 0){
                inWords[j]=inWords[j]+" Lacs";
       }
            break;
        case 6:
            tens_complication();
            break;
        case 7:
            if(actnumber[i]==0 || actnumber[i+1]==1 ){
                inWords[j]='';
            }
            else {
                inWords[j]=iWords[actnumber[i]];
            }
            inWords[j]=inWords[j]+" Crore";
            break;
        case 8:
            tens_complication();
        break;
        default:
            break;
    }
        j++;
}

	function tens_complication() {
        if(actnumber[i]==0) {
            inWords[j]='';
        }
        else if(actnumber[i]==1) {
        inWords[j]=ePlace[actnumber[i-1]];
        }
        else {
       inWords[j]=tensPlace[actnumber[i]];
        }
	}
inWords.reverse();
for(i=0; i<inWords.length; i++) {
    finalWord+=inWords[i];
}
alert(finalWord);
   // document.getElementById('rupees').value=finalWord;
    document.getElementById("rupees").innerHTML=finalWord;
}



function Redirect()
{	
	
	//var a=document.getElementById("rupees").value;
	//alert(a);
	alert("Summary Records Saved Successfully ");
    window.location="ASCPendingInvoiceReport.jsp";
	
}

function Redirect1()
{
	alert("Summary Records Not Saved ..........!!");
    window.location="ASCSummaryReport.jsp";
	
}
function Redirect2()
{
	var status=document.getElementById('invoicestatus').value;
	
	if(status=="Invoiced")
		{
		       alert("ASC Summary Status Is "+status+" Please Make Status As Deleted ");
		       
		       
		}
	else
		{
		alert("ASC Summary Status Is "+status);
		
		}
	
	
	
    window.location="ASCPendingInvoiceReport.jsp";
	
}
</script>


<body onload="calculate()">

<%!
Connection conn=null;
%>

<%
//////////



//conn=erp.ReturnConnection();
//Statement st=conn.createStatement();
//Statement st1=conn.createStatement();

Connection conn = null, conn1=null;
Statement sterp = null, sterp1 = null, sterp2=null, sterp3=null, sterp4=null, sterp5=null, stqr=null, stsql1=null,stsql2=null;
ResultSet rs = null;
//String DB_NAME="jdbc:mysql://103.8.126.138:3306/db_gps";
//String DB_NAME="jdbc:mysql:// twdb.fleetview.in/db_gps";
String DB_NAME123="jdbc:mysql://"+host1+"/db_gps";
//String DB_NAME1="jdbc:mysql://103.8.126.138:3306/twsql_twalldata";
//String DB_NAME1="jdbc:mysql://"+host1+"/twsql_twalldata";
String DB_NAME11234="jdbc:mysql://"+host1+"/db_GlobalERP";
String DB_USERNAME1=user1;
String DB_PASSWORD1=pass1;
Class.forName("com.mysql.cj.jdbc.Driver");
//conn=DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
conn1=DriverManager.getConnection(DB_NAME11234,DB_USERNAME1,DB_PASSWORD1);
sterp = conn1.createStatement();
sterp1 = conn1.createStatement();
sterp2 = conn1.createStatement();
sterp3 = conn1.createStatement();
sterp4 = conn1.createStatement();
sterp5 = conn1.createStatement();
stsql1= conn1.createStatement();
stsql2= conn1.createStatement();

Statement st=conn1.createStatement();
Statement st1=conn1.createStatement();
String tablename="";
String Owner="",status="";
String ASCFromDate="",ASCToDate="",OwnerName="",toDate1="";
String EntryBy="";
String VehicleCount=request.getParameter("VehicleCount");
String DaysCount=request.getParameter("DaysCount");
double Grandtotal=0.00;
double total=0.00;
NumberFormat nf = new DecimalFormat("#0.00");
%>
<form name="generateInvoice" method="get" action="ASCPendingInvoiceReport.jsp" >
<%

tablename=request.getParameter("tablename");
Owner=request.getParameter("owner");
toDate1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());

EntryBy=session.getAttribute("EmpName").toString();
System.out.println("Owner------"+Owner+"--------Table------------"+tablename);


String Total=request.getParameter("Total");

System.out.println("----------Total From Birt report------"+Total);

 total=Double.parseDouble(request.getParameter("Total").toString());


//total=Math.round(total);

System.out.println("----------Total  After Parse into double------"+total);

Grandtotal = total + (total * 15 / 100);

Grandtotal=Math.round(Grandtotal);
System.out.println("----------Total  After Service Tax Apply ------"+Grandtotal);

%>
<!-- <form name="" method="get" action=""> -->

<input type="hidden" id="grandTotal" name="grandTotal" value=<%=Grandtotal %> />

 <!--  <textarea readonly="readonly" name="rupees" id="rupees"   style="width: 230px; border: none; display : none;" ></textarea> -->
 <table><tr>
 <td valign="top">
		<!-- <b>Total In Words :</b></td> -->
 <td>
 
		<textarea readonly="readonly" name="rupees" id="rupees"   style="width: 230px; border: none; display:none;" ></textarea>
		</td></tr></table>
  



<%




String Query="select * from "+tablename+" where ownername='"+Owner+"' and itemcode is not null";
ResultSet rs123=stsql1.executeQuery(Query);

if(rs123.next())
{
	ASCFromDate=rs123.getString("Amcfromdate");
	ASCToDate=rs123.getString("Amctodate");
	OwnerName=rs123.getString("Ownername");
}

try
{
	
	
	try{
		
		
		
		String BeforeInsert="Select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ASCSummaryDetails where OwnerName='"+OwnerName+"' and Amcfromdate='"+ASCFromDate+"' and Amctodate='"+ASCToDate+"' and (InvoiceStatus='Pending' or InvoiceStatus='Invoiced') ";
		
		ResultSet rs12=st.executeQuery(BeforeInsert);
		
		System.out.println("Before Insert Summary-------->"+BeforeInsert);
		
		
		if(rs12.next())
		{
			
			status=rs12.getString("invoicestatus");
			
			%>
			
			<input type="hidden" id="invoicestatus" name="invoicestatus" value=<%=status %> />
			<%
			out.println("<script>  Redirect2();</script>");
		}
				
		else{
	
String InsertQuery="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ASCSummaryDetails (Ownername,Amcfromdate,Amctodate,EnrtyDate,EntryBy,ComputedTotal,GrandTotal) values('"+OwnerName+"','"+ASCFromDate+"','"+ASCToDate+"','"+toDate1+"','"+EntryBy+"','"+total+"','"+Grandtotal+"')";
st.executeUpdate(InsertQuery);



System.out.println("--------Insert Query------------"+InsertQuery);

String MasterInsert="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"VehASCSummaryDetails select * from "+tablename+" where itemcode is not null" ; // we need to use itemcode is not null
st1.executeUpdate(MasterInsert);

System.out.println("--------Master Insert Query------------"+MasterInsert);


String ShortAnnexure="select ItemDescription,ItemCode,count(vehiclenumber) as Vehicle,sum(days) as Days,SellingPrice,sum(amount)  as Amount  from "+tablename+" where ownername='"+Owner+"' and itemcode is not null group by itemdescription ";

ResultSet rs23=st.executeQuery(ShortAnnexure);

String ItemDescription="",ItemCode="",Vehicle="",SellingPrice="",Amount="",Days="";

System.out.println("Short Summary Annexure Data---->"+ShortAnnexure);
total=Double.parseDouble(request.getParameter("Total").toString());

System.out.println("--------VehicleCount------"+VehicleCount+"------DaysCount---------"+DaysCount+"-----AmountTotal-----"+total);


while(rs23.next())
{
	ItemDescription=rs23.getString("ItemDescription");
	ItemCode=rs23.getString("ItemCode");
	Vehicle=rs23.getString("Vehicle");
	Days=rs23.getString("Days");
	SellingPrice=rs23.getString("SellingPrice");
	Amount=rs23.getString("Amount");
	
	
	
	
	String InsertShort="insert into db_GlobalERP.ASCAnnexureMaster(InvoiceType,OwnerName,invoiceno,ASCBillFrom,ASCBillTo,ItemCode,ItemDescription,Vehicle,VehicleDays,SellingPrice,VehicleCount,DaysCount,TotalAmount,insertDate,EntryBy,Amount) values('ASCShortSummary','"+Owner+"','-','"+ASCFromDate+"','"+ASCToDate+"','"+ItemCode+"','"+ItemDescription+"','"+Vehicle+"','"+Days+"','"+SellingPrice+"','"+VehicleCount+"','"+DaysCount+"','"+nf.format(total)+"','"+toDate1+"','"+EntryBy+"','"+Amount+"')";
	
	st1.executeUpdate(InsertShort);
	
	
	System.out.println("Short Summary Annexure Insert Data---->"+InsertShort);
	
	
}


String DeleteTemp="delete from "+tablename+" " ;
st1.executeUpdate(DeleteTemp);

System.out.println("--------Temp Delete Query------------"+DeleteTemp);


out.println("<script>  Redirect();</script>");
		}
		
		String DeleteTemp="delete from "+tablename+" " ;
		st1.executeUpdate(DeleteTemp);

		System.out.println("--------Temp Delete Query------------"+DeleteTemp);
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}	

//  response.sendRedirect("alertGoTo.jsp?msg=Summary Saved Successfully In System &goto=ASCPendingInvoice.jsp");
}
catch(Exception e)
{
	e.printStackTrace();
	out.println("<script>  Redirect1();</script>");
}
%>
</form>
</body>
</html>
</jsp:useBean>