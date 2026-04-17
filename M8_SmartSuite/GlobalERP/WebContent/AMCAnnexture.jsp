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
    </head>
<body style="background-color:azure;" onload="calculate()">  
<%

Connection conn = null;
Statement st1=null,st2=null;
ResultSet rs123=null;
try {

	conn = connection.getConnect("db_GlobalERP");    
	st1=conn.createStatement();
	st2=conn.createStatement();
} catch (Exception e) {
    e.printStackTrace();
} 

String tablename="" ,invoiceno="";
String Amcfromdate="",Amctodate="";
String Owner=request.getParameter("owner");
tablename=request.getParameter("tablename");
System.out.println("Tabelname  From Birt------------------>"+tablename);
invoiceno=request.getParameter("Invoiceno");
%>
<%
try{
%>
<%
if(tablename==null){
	
	System.out.println("Tabelname  From Birt-------------Inside----->");
	tablename="db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"VehASCSummaryDetails";
	String insertdata="select * from "+tablename+" where InvoiceRefNo='"+invoiceno+"' and ownername='"+Owner+"' limit 1";
	System.out.println("Select Query Inside Submit -------------->"+insertdata);
	 rs123=st.executeQuery(insertdata);
	 rs123.next();

	 Amcfromdate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs123.getString("Amcfromdate")));
	 Amctodate=rs123.getString("Amctodate");
	System.out.println("Select Query Inside Submit -------------->"+insertdata);
}
else

Amcfromdate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(Amcfromdate));
Amctodate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(Amctodate));
int i =1;
%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">ASC Summary For <%=Owner%> From <%=Amcfromdate %> To <%=Amctodate %></h5>
	<input type="hidden" id="owner" name="owner" value=<%=Owner %> />
	<input type="hidden" id="tablename" name="tablename" value=<%=tablename %> />
    </div>
</div>
<br>
	<%
	tablename=request.getParameter("tablename");
	if(tablename==null)
	{
		System.out.println("Inside If");
		tablename="db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"VehASCSummaryDetails";
	%>
	<div class="container" style="width: 70%">
	<table id="example" class="display" style="width:100%;">        
       <thead>
            <tr>
	            <th class="col-width-4">SrNo.</th>
	            <th>ItemCode</th>
	            <th>ItemDescription</th>
	            <th>Vehicle</th>
	            <th>Days</th>
	            <th>RatePerDay</th>
	            <th>Amount</th>     
            </tr>
       </thead>

            <tbody>
            <%

            int totalVehicle = 0;
            int totalDays = 0;
            double totalAmount = 0.0;
            String ItemCode ="",ItemDescription="",Vehicle="",Days="",RatePerDay="",Amount="";
            String query ="select ItemDescription,ItemCode,count(vehiclenumber) as Vehicle,sum(days) as Days,SellingPrice, sum(amount) as Amount from "+tablename+" where ownername='"+Owner+"' and invoicerefno='"+invoiceno+"' and InvoiceStatus!='Deleted' group by itemdescription";
           System.out.println("query in if contion"+query);
           ResultSet rs1 = st2.executeQuery(query);
           while(rs1.next()){
        
        	   ItemCode = rs1.getString("ItemCode");
        	   ItemDescription = rs1.getString("ItemDescription");
        	   Vehicle = rs1.getString("Vehicle");
        	   Days = rs1.getString("Days");
        	   RatePerDay = rs1.getString("SellingPrice");
        	   Amount = rs1.getString("Amount");
        	   
               totalVehicle += Integer.parseInt(Vehicle);
               totalDays += Integer.parseInt(Days);
               totalAmount += Double.parseDouble(Amount);
        	   
            %>
            
            <tr>
            	<td class="text-center"><%=i%></td>
		        <td class="text-center"><%=ItemCode%></td>
		        <td class="text-left"><%=ItemDescription%></td>
		        <td class="text-center"><%=Vehicle%></td>
		        <td class="text-center"><%=Days%></td>
            	<td class="text-center"><%=RatePerDay%></td>
            	<td class="text-center"><%=String.format("%.2f", Double.parseDouble(Amount))%></td>
            </tr>
            
            
             <%i++;} %>
             
             
            </tbody>
            <tfoot>
            <tr style="font-weight:bold; background-color:#f0f8ff;">
	             <td class="text-right"></td>
	             <td class="text-right"></td>
			    <td class="text-right">Total :</td>
			    <td class="text-center"><%=totalVehicle%></td>
			    <td class="text-center"><%=totalDays%></td>
			    <td class="text-center"></td>
			    <td class="text-center"><%=String.format("%.2f", totalAmount)%></td>
			</tr>
            
            </tfoot>
      </table>
      </div>
	<%
	}
	
	%>

</div>
<%
}
catch(Exception e)
{
	e.printStackTrace();
}
%>
<script>
function calculate()
{
	var junkVal=document.getElementById('grandTotal').value;
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
    document.getElementById("rupees").innerHTML=finalWord;
}
</script>
  <script type="text/javascript">
   $(document).ready(function () {
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-4"l><"col-sm-12 col-md-5"f><"col-sm-12 col-md-3 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
	       displayLength: 10,
	        scrollY: 330,
	        scrollX: true, 
	        colReorder: true,
	        scrollCollapse: true,
	        pagingType: 'full_numbers',  //alternative pagination
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
	                         title : 'ASC Summary Report',
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
							 title : 'ASC Summary Report',
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
                             title : 'ASC Summary Report',
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
                             title : 'ASC Summary Report',
		                        
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title : 'ASC Summary Report',
							},
 
					],
				},
           ], 
       
       });

   });
   
</script>
  <%@ include file="footer.jsp" %>
</body>
</html>