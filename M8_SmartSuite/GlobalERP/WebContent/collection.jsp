 <%@page import="java.util.Date"%>
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
<body style="background-color:azure;">   

      <%
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd"); 
      		java.util.Date d1 = null;
      		java.util.Date d2 = null;
            DecimalFormat df2 = new DecimalFormat( "0.00" );
            String voucherdate="",chequedate="",voucherdateCal="",chequedateCal="";
            Date today = new Date();
            Calendar cal = Calendar.getInstance();
			cal.setTime(today);
			cal.add(Calendar.DAY_OF_MONTH, -30);
			Date today30 = cal.getTime();
			String exportFileName="collection.xls";
			String todaysDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
	
			voucherdateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
			chequedateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
			if (!(null == request.getParameter("voucherdate"))) 
			{
				voucherdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("voucherdate")));
    			voucherdateCal=request.getParameter("voucherdate");
			}
			if (!(null == request.getParameter("chequedate")))
			{
    			chequedate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("chequedate")));
    			chequedateCal=request.getParameter("chequedate");
			}
			
	  %>

<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Payment Collections</h5>
    </div>
</div>
	  

     
 <form method="post" name="ereceipt" autocomplete="off">
     
     
     
      <!--  <div id="entry" style="margin-left:7%; margin-top:0%; height:500;width:86%; eborder:thin solid; border-color: blue;position:absolute;
        background-color: #E1F3F3; border-radius: 12px 12px 12px 12px;" > -->
        
        <div id="entry" 
     style="
       position:fixed; top:7%; left:50%; transform:translateX(-50%); width:75%;
       height:auto;
       background:#E1F3F3; z-index:9999;border-radius:12px;padding:10px; ">
        
     
      <div style="background-color:#2678B7;height:27;width:100%; color:white; font-size:small;border:thin solid; border-color: blue; border-radius: 12px 12px 0px 0px;"> 
     <!--  <div style="position:absolute;height: 395px; width:1; margin-left:47%; margin-top:3%;border:thin solid; border-color:blue; "></div> -->
      <table style="color: white; align:center;width:100%">
      <tr style="color: white; text-align:center;">
      <td width="100%"><strong>Voucher Entry</strong></td>
      <td align="right"><input type="button" name="cancel" id="cancel" value="X"  onclick="cancelbtn()" style="width:20; color:red;" />
      </td>
      </tr>
      </table>
       </div>
      <table style="font-size:small;width:100%">
      <tr>
	  <td style="margin-top:0%;"><strong>Payment Mode<font face="Arial" size="2" color="red">*</font>:</strong></td>
      <td>
      <select id="paymentmode" onchange="checksuspense()">
  			<option value="Cheque">Cheque</option>
  			<option value="Cash">Cash</option>
  			<option value="Credit Note">Credit Note</option>
  			<option value="Debit Note">Debit Note</option>
  			<option value="Demand Draft">Demand Draft</option>
  			<option value="NEFT">NEFT</option>
  			<option value="Suspense">Suspense</option>
  			<option value="BAD DEBT">Trf to BAD DEBT</option>
  	  </select>
	 
     </td>
      <td>
      <strong>Available Balance:</strong><input type="text" name="availBal" id="availBal" value="" readonly="readonly" size="10"  style="text-align: right;">
       <input type="radio" name="invoice" id="invoice" value="invoice" onchange="showInvoiceTable()"><strong>Show Invoices</strong>
	  
     </td>

      </tr>
      <tr>
      <td width="100" ><strong>Payment Date<font face="Arial" size="2" color="red">*</font>:</strong></td>
      <td>
      <input type="text" id="voucherdate"
						name="voucherdate" value="<%=voucherdateCal %>" size="15" readonly
						style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
					
			<script type="text/javascript">
			  Calendar.setup(
			    {
			      inputField  : "voucherdate",         // ID of the input field
			      ifFormat    : "%d-%b-%Y",     // the date format
			      button      : "voucherdate"       // ID of the button
			    }
			  );
			</script></td>
			<td colspan="2"> <div id="invoiceTable" style="display:none; position:absolute;margin-left:17%; overflow:auto; height: 350px; width:25%; font-size:small; ">
			 <table> <tr><td>.</td></tr>
			 <tr><td><b>GETTING DATA...</b></td></tr>
			 </table>
	 </div>
	 <div id="invoiceTable_e" style="display:none; position:absolute; overflow:auto; height: 350px; width:16%; font-size:small; ">
			 <table> <tr><td>.</td></tr>
			 <tr><td><b>GETTING DATA...</b></td></tr>
			 </table>
	 </div></td>
			
	  </tr>
      <tr>
      <td><strong>Received from<font face="Arial" size="2" color="red">*</font>:</strong></td>
      <td colspan="3"><input type="text" name="customerName" id="received_from" value=""  size="45" onkeyup="getCustomer()" autocomplete="off" 
          onmouseout="javascript:hide_tooltip()" onblur="receive();"/>
<input type="hidden" name="custcode" id="custcode" value=""/>          
          <br><label id="lblNameMsg1" style="display: none;"><font face="Arial" size="2" color="red">Please Enter CompanyName</font></label></br>
      <div id='customerList' style="position:absolute; background-color: white;">
	<div style="height: 150px; width: 315px; overflow: auto; border:solid inset;"></div>
	</div>
	 <script>document.getElementById("customerList").style.visibility="hidden";</script>
      </td>
	  <td></td>
      </tr>
      <tr>
      <td><strong>Amount Received <font face="Arial" size="2" color="red"> *</font>:</strong></td>
      <td><input type="text" name="amount" id="amount" value=""  onblur="resetPaymentAmount();" size="10"  style="text-align: right;">
      
      <select name="e_tds" id="e_tds">
             <option value="TDS">TDS</option>
	     	 <option value="Short">Short</option>
	     	 <option value="Other">Other</option>
      		</select>
      		<strong>Ded.</strong>
            <input type="text" name="e_tdsamount" id="e_tdsamount" value="0"  size="10"  style="text-align: right;">
            <br><label id="lblNameMsg2" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Received Amount In Numeric Format</font></label></br>
      </td>
      
      
      <td>
      <input type="hidden" id="tableHTML" name="tableHTML" value="" />  
	<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 
      </td>
      </tr>
       <tr>
      <td><strong>Cheque No <font face="Arial" size="2" color="red" > *</font>:</strong></td>
      <td><input type="text" name="cheque_no" id="cheque_no" value=""  size="10" onblur="ch();"/>
      <label id="lblNameMsg3" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Cheque Number</font></label>
      </td>
       
      <td></td>
    </tr>
    <tr>
    <td width="100"><strong>Cheque Date <font face="Arial" size="2" color="red"> *</font>:</strong></td>
      <td><input type="text" id="chequedate"
						name="chequedate" value="<%=chequedateCal %>" size="15" readonly
						style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
					
			<script type="text/javascript">
			  Calendar.setup(
			    {
			      inputField  : "chequedate",         // ID of the input field
			      ifFormat    : "%d-%b-%Y",     // the date format
			      button      : "chequedate"       // ID of the button
			    }
			  );
			</script>
			
	</td>
	<td></td>
	<td></td>
    </tr>
    <tr>
    <td><strong>Bank Name:</strong></td>
    <td colspan="3">
    <input type="text" name="bankname" id="bankname" value="" size="45"  onkeyup="" />
    <div id='bankaccountsList' style="position:absolute; background-color: white;">
	<div style="height: 150px; width: 325px; overflow: auto; border:solid inset;"></div>
	</div>
	<script>document.getElementById("bankaccountsList").style.visibility="hidden";</script>
    </td>
	</tr>
    <tr>
    <td><strong>Branch Name:</strong></td>
    <td><input type="text" name="branchname" id="branchname" value=""  /></td>
    <td></td>
    <td></td>
    </tr>
    <tr>
    <td width="100"><strong>City:</strong></td>
    <td><input type="text" name="city" id="city" value=""  /></td>
    <td></td>
    <td></td>
    </tr>
    <tr valign="top">
    <td ><strong>Remarks <font face="Arial" size="2" color="red"> *</font>:</strong></td>
	  <td>	  
	  <textarea id="e_remarks" name="e_remarks" rows="3" cols="25"  onblur="remark();"></textarea>
	  <br><label id="lblNameMsg4" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Remarks</font></label></br>
	   </td>
	   
      </tr>
   
    <tr>
    <td width="100"><strong>Tally Ref No:</strong></td>
    <td><input type="hidden" name="voucherno" id="voucherno" size="10" value="" />
    <input type="text" name="e_tallyrefno" id="e_tallyrefno" value=""  /></td>
    <td></td>
    <td></td>
    </tr>
      
      <tr>
      <td></td>
      <td colspan="3" align="left">
       <input type="button" name="Ok" id="ok" value="Ok" onclick="return validate('add');" style="width:80;"/>
      <input type="button" name="Okc" id="okc" value="Ok" onclick="return validate('edit');" style="width:80;"/>
      <input type="button" name="Cancel" id="cancel" value="Cancel" onclick="cancelbutton()" style="width:80;" />
      </td>
      </tr>
      <tr>
      <td>
      <input type="hidden" name="invoiceno" id="invoiceno" value="0"  />
      <input type="hidden" name="EXCEL" id="EXCEL" value=""  />
      <input type="hidden" name="e_twempname" id="e_twempname" value=""  />
      <input type="hidden" name="e_auth_by" id="e_auth_by" value=""  />
      <input type="hidden" name="e_auth_on" id="e_auth_on" value=""  />
      <input type="hidden" name="e_insertdt" id="e_insertdt" value=""  />
      <input type="hidden" name="e_customercode" id="e_customercode" value=""  />
      <input type="hidden" name="e_moneyreceiptno" id="e_moneyreceiptno" value=""  />
      <input type="hidden" name="e_department" id="e_department" value="<%=session.getAttribute("department") %>"  />
      </td>
      </tr>
      </table>
     </div>
 
     
   <!--   ////////////////////////////////////////// -->
<div class="row col-12">

    <!-- Left: New Entry -->
<!--     <div class="col-md-3 d-flex align-items-center">
        <a href="#" style="font-weight: bold; color: black;" onclick="getReceipt('0','N','GET')">
            <img src="images/new.JPG" width="25px" height="22px" style="border-style:none">
        </a>
        <span style="margin-left:5px;">New Entry</span>
    </div>
     -->
    
    
 <div class="col-md-3 d-flex align-items-center"> 
    <div id="newentry" style="width:100%;"> <a href="#" style="font-weight: bold; color: black; " onclick="getReceipt('0','N','GET')"> 
    <img src="images/new.JPG" width="25px" height="22px" style="border-style: none"></img> </a>New Entry 
	</div>
</div>
    
    
    

    <!-- CENTER: Legend Items -->
    <div class="col-md-6 d-flex justify-content-center">

        <div class="d-flex align-items-center mx-3">
            <span style="background-color:#FDD5D8;width:20px;height:20px;display:inline-block;margin-right:6px;"></span>
            <span style="font-size:16px; color:blue;">Uncleared Cheques</span>
        </div>

        <div class="d-flex align-items-center mx-3">
            <span style="background-color:rgb(112, 219, 112);width:20px;height:20px;display:inline-block;margin-right:6px;"></span>
            <span style="font-size:16px; color:blue;">Suspense</span>
        </div>

    </div>

    <!-- Right: Collection Report -->
    <div class="col-md-3 text-end">
        <a href="collectionreport.jsp" style="font-weight:bold; text-decoration:none;">Collection Report</a>
    </div>

</div>

     
       <script>document.getElementById("entry").style.visibility="hidden";</script>
       
       <br>
       <table id="example" class="display" style="width:100%;">        
            <thead>
                <tr>     
            		<th>Delete</th>
                   	<th>Edit</th>
                   	<th>Payment Mode</th>
                   	<th>VoucherNo</th>
                   	<th>Receipt-Date</th>
                   	<th>Received From</th>
                   	<th>Branch</th>
                   	<th>Cheque No</th>
                   	<th>Cheque Date</th>
                   	<th>Amount</th>
                   	<th>Tally Ref No.</th>
                   	<th>User Name</th>
                   	<th>Entered On</th>
                   	<th>TDS/Short/Other</th>
                   	<th>Ded.Amount</th>
                   	<th>Remark</th>
               </tr>
               </thead>
               <tbody>
	    <%
        try
        {
        	 String TSID=session.getAttribute("TallySID").toString(), TPID=session.getAttribute("TallyPID").toString(), CMPID=session.getAttribute("CompanyMasterID").toString();

        	String todaydate="";
	        todaydate=new SimpleDateFormat("dd-MM-yyyy").format(new java.util.Date());            
        	String sql="select * from "+session.getAttribute("CompanyMasterID").toString()+"collection as a inner join "+session.getAttribute("CompanyMasterID").toString()+"customerdet as b on a.customercode=b.customercode where (tallyrefno = '' OR PaymentMode='Suspense') AND Status='Active' order by paymentdate";
        	
        	ResultSet rs=st.executeQuery(sql);
        	System.out.println("Query is"+sql);
        	String mtoday=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
        	String mColorCode="white";
        	while(rs.next())
        	{
        		String mPayment_date =new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("a.paymentdate")));
        		String mpaydate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("a.paymentdate")));
        		String mCheque_date =new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("a.chorddorcreditnotedate")));
    			String mEntered_on=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss ").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("a.inserdt")));
    			d1 = format.parse(mtoday);
    			d2 = format.parse(mpaydate);
    		    long diff = d1.getTime() - d2.getTime();
        		long diffDays = diff / (24 * 60 * 60 * 1000);
        		System.out.println(">>>"+rs.getString("a.tallyrefno")+"<<<");
        		if (diffDays > 2 && (rs.getString("a.tallyrefno").equals("")))
        		{
        			mColorCode="#FDD5D8";
        		}
        		else
        		{
        			mColorCode="white";
        		}
        		if((rs.getString("PaymentMode").equals("Suspense"))){
        			mColorCode="rgb(112, 219, 112)";
        		}
            %>
            <tr>
            <td class="text-center" style="background-color:<%=mColorCode%>;">
            <a href="#" style="font-weight: bold; color: black; " onclick="getReceipt(<%=rs.getString("a.moneyreceiptno")%>,'D','GET');">
            <img src="images/delete.JPG" width="20px" height="18px" style="border-style: none"></img>
            </a>
            <input type="hidden"  name="moneyreceiptno" value="<%=rs.getString("a.moneyreceiptno")%>" >
            </td>
            <td class="text-center" style="background-color:<%=mColorCode%>;">
            <a href="#" style="font-weight: bold; color: black; " onclick="getReceipt(<%=rs.getString("a.moneyreceiptno")%>,'C','GET');">
            <img src="images/edit.JPG" width="20px" height="18px" style="border-style: none"></img>
            </a></td>
            <td class="text-left" style="background-color:<%=mColorCode%>;" width=75><div align="left"><%=rs.getString("a.paymentmode") %></div></td>
            <td class="text-center" style="background-color:<%=mColorCode%>;" width=75><div align="left"><%=rs.getString("a.paymentvoucherno") %></div></td>
            <td class="text-right" style="background-color:<%=mColorCode%>;"><div align="left"><%=mPayment_date%></div></td>
            <td class="text-left" style="background-color:<%=mColorCode%>;" width="400"><div align="left"><%=rs.getString("b.companyname")%></div></td>
            <td class="text-left" style="background-color:<%=mColorCode%>;"><div align="left"><%=rs.getString("b.BranchName")%></div></td>
            <td class="text-center" style="background-color:<%=mColorCode%>;"><div align="left"><%=rs.getString("a.chorddorcreditnoteno")%></div></td>
            <td class="text-right" style="background-color:<%=mColorCode%>;"><div align="left"><%=mCheque_date%></div></td>
            <%
            double mamount=0.00;
            mamount =Double.parseDouble(rs.getString("a.amountpaid"));
            %> 
            <td class="text-center" style="background-color:<%=mColorCode%>;"><div align="right"><%=df2.format(mamount)%></div></td>
            
            <td class="text-center" style="background-color:<%=mColorCode%>;"><div align="left"><%=rs.getString("a.tallyrefno")%></div></td>
            <td class="text-left" style="background-color:<%=mColorCode%>;"><div align="left"><%=rs.getString("a.twempname")%></div></td>
            <td class="text-center" style="background-color:<%=mColorCode%>;"><div align="left"><%=mEntered_on%></div></td>
            <td class="text-left" style="background-color:<%=mColorCode%>;"><div align="left"><%=rs.getString("a.ded_type")%></div></td>
            <td class="text-center" style="background-color:<%=mColorCode%>;"><div align="left"><%=rs.getString("a.ded_amount")%></div></td>
            <td class="text-left" style="background-color:<%=mColorCode%>;">
    <div style="width:250px; white-space:normal; word-wrap:break-word; overflow-wrap:break-word;">
        <%=rs.getString("a.remarks")%>
    </div>
</td>
            </tr>
        <%
            }
        }
        catch (Exception e)
        {
        	e.printStackTrace();
        }
        %>
               
          </tbody>
     </table>
  </form> 
	<div id='tooltipper' style="position:absolute; width:300;"></div>
	</div>


<script type="text/javascript">
function checksuspense(){
	var mode=document.getElementById("paymentmode").value;
	if(mode=="Suspense"){
		document.getElementById("customerList").style.visibility="hidden";
		document.getElementById("received_from").style.visibility="hidden";	
	}else{
		document.getElementById("received_from").style.visibility="Visible";	
	}
}
var mmoneyreceiptno="";
function gotoExcel(elemId, frmFldId)  
{  
	var originalContents = document.body.innerHTML;
	var input = document.ereceipt.getElementsByTagName("a");
    var count = input.length;
    for(var i =0; i < count; i++)
    {
 		document.ereceipt.getElementsByTagName("a")[i].removeAttribute("href");
    }
    var obj = document.getElementById(elemId);  
    var oFld = document.getElementById(frmFldId); 
    oFld.value = obj.innerHTML;  
    document.ereceipt.action ="excel.jsp";
    document.forms["ereceipt"].submit();
    document.body.innerHTML = originalContents;
}
function hide_tooltip()
{
	document.getElementById("tooltipper").innerHTML="" ;
}

function show_tooltip(event,help_id)
{	
		var mhelp_id=help_id;
		var ajaxRequest;  // The variable that makes Ajax possible!
		try
		{
			// Opera 8.0+, Firefox, Safari
			ajaxRequest = new XMLHttpRequest();
		}  
		catch (e)
		{
			// Internet Explorer Browsers
			try
			{
				ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
			} 
			catch (e)
			{
				try
				{
					ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
				} 
				catch (e)
				{
					// Something went wrong
					alert("Your browser broke!");
					return false;
				}
			}
		}

		ajaxRequest.onreadystatechange = function()
		{
			if(ajaxRequest.readyState == 4)
			{
				var reslt=ajaxRequest.responseText;
	     		document.getElementById('tooltipper').style.display='block';
				document.getElementById("tooltipper").style.left=event.clientX+5
				document.getElementById("tooltipper").style.top=event.clientY+10
				//document.getElementById("tooltipper").style.width= 250;
				//document.getElementById("tooltipper").style.height =100;
				document.getElementById("tooltipper").innerHTML=reslt;
			} 
		}
		var queryString = "?help_id=" +mhelp_id;
		ajaxRequest.open("GET", "GetHelp.jsp" + queryString, true);
		ajaxRequest.send(null); 
}

var initialAmountAgainstInvoice=0;
var amountAgainstInvoice=0;

function showInvoiceTable()
{
	
	amountAgainstInvoice=document.ereceipt.amount.value;
	initialAmountAgainstInvoice=document.ereceipt.amount.value;
	document.ereceipt.availBal.value=amountAgainstInvoice;
	document.getElementById('invoiceTable').innerHTML='<table> <tr><td>.</td></tr><tr><td><b>GETTING DATA...</b></td></tr></table>';
		
		var customer=document.ereceipt.customerName.value;
		customer=customer.replace("&","ampers")
		//alert(customer);
		
	        var customercode=document.ereceipt.e_customercode.value;
		//alert("---------------------------"+customercode);

		var ajaxRequest;  // The variable that makes Ajax possible!

		try{
			// Opera 8.0+, Firefox, Safari
			ajaxRequest = new XMLHttpRequest();
		}  
		catch (e)
		{
			// Internet Explorer Browsers
			try
			{
				ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
			} 
			catch (e)
			{
				try
				{
					ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
				} 
				catch (e)
				{
					// Something went wrong
					alert("Your browser broke!");
					return false;
				}
			}
		}

		ajaxRequest.onreadystatechange = function()
		{
			if(ajaxRequest.readyState == 4)
			{
				var reslt=ajaxRequest.responseText;
				//alert("Invioce ---->"+reslt);
				document.getElementById("invoiceTable").innerHTML=reslt;
				//alert("Hello");
				document.getElementById('invoice').checked=false;
			} 
		}
		var queryString = "?company=" +customer+"&customercode="+customercode;
		//alert(queryString);
		ajaxRequest.open("GET", "GetInvoices.jsp" + queryString, true);
		ajaxRequest.send(null); 

		document.getElementById('invoiceTable').style.display='block';
}

function showInvoiceTable_e()
{
	
	amountAgainstInvoice=document.ereceipt.amount.value;
	initialAmountAgainstInvoice=document.ereceipt.amount.value;
	document.ereceipt.availBal.value=amountAgainstInvoice;
	document.getElementById('invoiceTable_e').innerHTML='<table> <tr><td>.</td></tr><tr><td><b>GETTING DATA...</b></td></tr></table>';
		
		var mmoneyreceiptno=document.ereceipt.e_moneyreceiptno.value;
		//alert(document.ereceipt.e_moneyreceiptno.value);
		
		var ajaxRequest;  // The variable that makes Ajax possible!

		try{
			// Opera 8.0+, Firefox, Safari
			ajaxRequest = new XMLHttpRequest();
		}  
		catch (e)
		{
			// Internet Explorer Browsers
			try
			{
				ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
			} 
			catch (e)
			{
				try
				{
					ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
				} 
				catch (e)
				{
					// Something went wrong
					alert("Your browser broke!");
					return false;
				}
			}
		}

		ajaxRequest.onreadystatechange = function()
		{
			if(ajaxRequest.readyState == 4)
			{
				var reslt=ajaxRequest.responseText;
				//alert("Invoce ---->"+reslt);
				document.getElementById("invoiceTable_e").innerHTML=reslt;
				
			} 
		}
		var queryString = "?myvoucherno=" +mmoneyreceiptno;
		
		//alert("VoucherEntry-->"+queryString);
		ajaxRequest.open("GET", "GetInvoices_e.jsp" + queryString, true);
		ajaxRequest.send(null); 
		
		document.getElementById('invoiceTable_e').style.display='block';
}

function tallyInvoice(i)
{
	 if(!(amountAgainstInvoice<=0) || document.getElementById('check'+i).checked==false)
		 {
		 var flag=0;
			 if(document.getElementById('check'+i).checked==false)
			 {
				 amountAgainstInvoice=initialAmountAgainstInvoice;
				
				 for(j=1;j<document.getElementById('checktotal').value;j++)
				 {
					 if(document.getElementById('check'+j).checked==true)
					 {
							if(parseFloat(document.getElementById('balance'+j).value)<parseFloat(amountAgainstInvoice))
							{
								document.getElementById('tdAmountAgainstInvoice'+j).innerHTML=document.getElementById('balance'+j).value;
								document.getElementById('amt'+j).value=parseFloat(document.getElementById('balance'+j).value);		
							}
							else
							{
							 	document.getElementById('tdAmountAgainstInvoice'+j).innerHTML=amountAgainstInvoice;
							 	document.getElementById('amt'+j).value=parseFloat(amountAgainstInvoice);
							}
						 amountAgainstInvoice=parseFloat(amountAgainstInvoice)-parseFloat(document.getElementById('balance'+j).value);
						 document.ereceipt.availBal.value=parseFloat(amountAgainstInvoice).toFixed(2);

						 if(document.ereceipt.availBal.value<0)
						 		document.ereceipt.availBal.value=0;
					 	flag=1;
					 }
				 } 
				document.getElementById('tr'+i).style.background='#E1F3F3';
				document.getElementById('tdAmountAgainstInvoice'+i).innerHTML='';
				document.getElementById('amt'+i).value=0;
				//alert(amountAgainstInvoice);
				if (flag==0)
				{
					amountAgainstInvoice=initialAmountAgainstInvoice;
					document.ereceipt.availBal.value=parseFloat(amountAgainstInvoice).toFixed(2);
				}
			 }
			 else
			 {
					if(parseFloat(document.getElementById('balance'+i).value)<parseFloat(amountAgainstInvoice))
					{
						document.getElementById('tdAmountAgainstInvoice'+i).innerHTML=document.getElementById('balance'+i).value;
						document.getElementById('amt'+i).value=parseFloat(document.getElementById('balance'+i).value);		
					}
					else
					{
					 	document.getElementById('tdAmountAgainstInvoice'+i).innerHTML=amountAgainstInvoice;
					 	document.getElementById('amt'+i).value=parseFloat(amountAgainstInvoice);
					}
				 	document.getElementById('tr'+i).style.background='#C6DEFF';
				 	amountAgainstInvoice=parseFloat(amountAgainstInvoice)-parseFloat(document.getElementById('balance'+i).value);
				 	
				 	document.ereceipt.availBal.value=parseFloat(amountAgainstInvoice).toFixed(2);
				 	if(document.ereceipt.availBal.value<0)
				 		document.ereceipt.availBal.value=0;
			 }
	 	}
	 else 
	{
		 alert("Payable amount not available");
		 document.getElementById('check'+i).checked=false;
	}	
}
function receive()
{
	var from=document.getElementById("received_from").value;
	//alert(from);
	var mode=document.getElementById("paymentmode").value;
	
	
	
	if(from=="" || from==null && mode!=Suspense)
	{
		
		document.getElementById("lblNameMsg1").style.display="";
		return false;
		//alert("Enter Company Name");
		//return false;
	}
	else
		{
		document.getElementById("lblNameMsg1").style.display="none";
		return true;
		}
	
}
function ch()
{
	var cheque_no=document.getElementById("cheque_no").value;
	
	if(cheque_no=="" || cheque_no==null)
	{
		document.getElementById("lblNameMsg3").style.display="";
		return false;
		//alert("Enter Cheque No");
		//return false;
	}
	else
	{
	document.getElementById("lblNameMsg3").style.display="none";
	return true;
	}
	
}
function remark()
{

	var e_remarks=document.getElementById("e_remarks").value;
	
	if(e_remarks=="" || e_remarks==null)
	{
		document.getElementById("lblNameMsg4").style.display="";
		return false;
		//alert("Enter Remarks");
		//return false;
	}
	else
	{
	document.getElementById("lblNameMsg4").style.display="none";
	return true;
	}
}
function resetPaymentAmount()
{
	var amount=document.ereceipt.amount.value;
	var amount=document.getElementById("amount").value;
	
	if(amount=="" || amount==null)
	{
		document.getElementById("lblNameMsg2").style.display="";
		return false;
		//alert("Enter Amount");
		//return false;
	}
	else
		{
		document.getElementById("lblNameMsg2").style.display="none";
		return true;
		}
	var numericExpression = /^[0-9 .]+$/;
	if(!(amount.match(numericExpression))) 
	{
		  	//alert("Payment value has to be Numeric");
		  	document.getElementById("lblNameMsg2").style.display="";
	  		document.ereceipt.amount.value=document.ereceipt.amount.value.substring(0, document.receipt.amount.value.length-1);
			return false;
	} 
	for(j=1;j<document.getElementById('checktotal').value;j++)
	{
		 if(document.getElementById('check'+j).checked==true)
		 {
				 document.getElementById('check'+j).checked=false;
				 document.getElementById('tr'+j).style.background='white';
				 document.getElementById('tdAmountAgainstInvoice'+j).innerHTML='';
				 document.getElementById('amt'+j).value=0;
			 }
		 } 
		 initialAmountAgainstInvoice=amount;
	  	 amountAgainstInvoice=initialAmountAgainstInvoice;
		 document.receipt.availBal.value=parseFloat(amountAgainstInvoice);
}


function printokbutton()
{
	document.getElementById("printoption").style.visibility="hidden";
	document.ereceipt.action ="moneyreceipt.jsp?moneyreceiptno="+mmoneyreceiptno;//document.ereceipt.e_moneyreceiptno.value;
    document.forms["ereceipt"].submit();
}

function cancelbutton()
{
	document.ereceipt.voucherno.value="";
	document.ereceipt.customerName.value="";
	document.ereceipt.cheque_no.value="";
	document.ereceipt.amount.value="";
	document.ereceipt.invoiceno.value="";
	document.ereceipt.bankname.value="";
	document.ereceipt.branchname.value="";
	document.ereceipt.city.value="";
	document.ereceipt.e_remarks.value="";
	document.ereceipt.e_moneyreceiptno.value="";
	document.ereceipt.e_customercode.value="";
	document.ereceipt.e_tallyrefno.value="";
	document.ereceipt.e_auth_by.value="";
	document.ereceipt.e_auth_on.value="";
	document.ereceipt.e_insertdt.value="";
	document.ereceipt.e_twempname.value="";
	document.ereceipt.e_tds.value="";
	document.ereceipt.e_tdsamount.value="";
	document.getElementById("newentry").style.visibility="visible";
	document.getElementById("okc").style.visibility="hidden";
	document.getElementById("ok").style.visibility="hidden";
	document.getElementById("entry").style.visibility="hidden";
	 document.getElementById("e_tallyrefno").style.visibility="hidden";
	 document.getElementById("invoiceno").style.visibility="hidden";
	 document.getElementById("voucherno").style.visibility="hidden";
	// window.location.reload();
}
function cancelbtn()
{
	document.ereceipt.voucherno.value="";
	document.ereceipt.customerName.value="";
	document.ereceipt.cheque_no.value="";
	document.ereceipt.amount.value="";
	document.ereceipt.invoiceno.value="";
	document.ereceipt.bankname.value="";
	document.ereceipt.branchname.value="";
	document.ereceipt.city.value="";
	document.ereceipt.e_remarks.value="";
	document.ereceipt.e_moneyreceiptno.value="";
	document.ereceipt.e_customercode.value="";
	document.ereceipt.e_tallyrefno.value="";
	document.ereceipt.e_auth_by.value="";
	document.ereceipt.e_auth_on.value="";
	document.ereceipt.e_insertdt.value="";
	document.ereceipt.e_twempname.value="";
	document.ereceipt.e_tds.value="";
	document.ereceipt.e_tdsamount.value="";
	document.getElementById("newentry").style.visibility="visible";
	document.getElementById("okc").style.visibility="hidden";
	document.getElementById("ok").style.visibility="hidden";
	document.getElementById("entry").style.visibility="hidden";
	 document.getElementById("e_tallyrefno").style.visibility="hidden";
	 document.getElementById("invoiceno").style.visibility="hidden";
	 document.getElementById("voucherno").style.visibility="hidden";
	 document.getElementById("invoiceTable").style.visibility="hidden";
	 window.location.reload();
}
function cancelbutton()
{
	document.ereceipt.voucherno.value="";
	document.ereceipt.customerName.value="";
	document.ereceipt.cheque_no.value="";
	document.ereceipt.amount.value="";
	document.ereceipt.invoiceno.value="";
	document.ereceipt.bankname.value="";
	document.ereceipt.branchname.value="";
	document.ereceipt.city.value="";
	document.ereceipt.e_remarks.value="";
	document.ereceipt.e_moneyreceiptno.value="";
	document.ereceipt.e_customercode.value="";
	document.ereceipt.e_tallyrefno.value="";
	document.ereceipt.e_auth_by.value="";
	document.ereceipt.e_auth_on.value="";
	document.ereceipt.e_insertdt.value="";
	document.ereceipt.e_twempname.value="";
	document.ereceipt.e_tds.value="";
	document.ereceipt.e_tdsamount.value="";
}
function show_hide()
{
	if (document.ereceipt.all_pending.value="All Entries")
	{
		document.ereceipt.all_pending.value="Pending Entries";
	}
	else
	{
		document.ereceipt.all_pending.value="All Entries";
	}
	
}

function okbutton()
{
	document.getElementById("newentry").style.visibility="visible";
	document.getElementById("entry").style.visibility="hidden";
	document.getElementById("okc").style.visibility="hidden";
	document.getElementById("ok").style.visibility="hidden";
	 document.getElementById("e_tallyrefno").style.visibility="hidden";
	 document.getElementById("invoiceno").style.visibility="hidden";
	 document.getElementById("voucherno").style.visibility="hidden";
	
}

function popUp(Address,companyName,SalesEnqNo)
{
    //alert("pop");
    window.open(Address+'?companyName='+companyName+'&SalesEnqNo='+SalesEnqNo,'jav','scrollbars=yes,menubar=yes,height=600,width=800,resizable=yes,toolbar=no,location=no,status=no');
}

function conformAll() {
    alert("CONFRM");
    alert(document.getElementByName(customername.options[1].value));
}
</script>

<script type="text/javascript" src="scrollabletable.js"></script>

<SCRIPT LANGUAGE="JavaScript">

function checkAll()
{
    var field=document.getElementsByName('checkbox1');
    var i;
    try
    {
         for (i = 0; i < field.length; i++)
         field[i].checked = true ;
    }
    catch(e)
    {
	    alert(e);
	}
}

function unCheckAll()
{
var field=document.getElementsByName('checkbox1');
var i;
try{
for (i = 0; i < field.length; i++)
field[i].checked = false ;
}catch(e){alert(e);}
}

function OnSubmitForm()
{
  if(document.pressed == 'submit')
  {
   document.payment.action ="epaymentupdate.jsp";
  }
  else
  if(document.pressed == 'Update')
  {
    document.payment.action ="update.html";
  }
  return true;
}

function changeScreenSize(w,h)
{
    window.resizeTo( w,h )
}

function getCustomer()
{
        document.getElementById("customerList").style.visibility="visible";
		var accounts=document.ereceipt.customerName.value;
		var ajaxRequest;  // The variable that makes Ajax possible!

		try
		{
			// Opera 8.0+, Firefox, Safari
			ajaxRequest = new XMLHttpRequest();
		}  
		catch (e)
		{
			// Internet Explorer Browsers
			try
			{
				ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
			} 
			catch (e)
			{
				try
				{
					ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
				} 
				catch (e)
				{
					// Something went wrong
					alert("Your browser broke!");
					return false;
				}
			}
		}

		// Create a function that will receive data sent from the server
		ajaxRequest.onreadystatechange = function()
		{
			if(ajaxRequest.readyState == 4)
			{
				var reslt=ajaxRequest.responseText;
				//alert(reslt);
				var mySplitResult = reslt.split("#");
				//alert(mySplitResult[15]);
				document.getElementById("customerList").innerHTML=reslt;
			} 
		}
		var queryString = "?company=" +accounts;
		//var queryString = "?company=" +accounts;
		ajaxRequest.open("GET", "AjaxGetCustomer.jsp" + queryString, true);
		ajaxRequest.send(null); 
	}

    function getAccountsDetails(i) 
    {
        //alert(document.getElementById("name"+i).value);
        var reslt=document.getElementById("name"+i).value;
        var mySplitResult = reslt.split("#");
      	alert("Customer - "+mySplitResult[0]+"\n Branch - "+mySplitResult[1]);
      	//alert(mySplitResult[1]);
      	//alert(mySplitResult[2]);
   		document.getElementById("customerList").style.visibility="hidden";
 		document.ereceipt.customerName.value=mySplitResult[0];
 		document.ereceipt.custcode.value=mySplitResult[2];
 		document.ereceipt.e_customercode.value=mySplitResult[2];

	}

    function getBankAccounts()
    {
            document.getElementById("bankaccountsList").style.visibility="visible";
    		var accounts=document.ereceipt.bankname.value;
    		var ajaxRequest;  // The variable that makes Ajax possible!

    		try
    		{
    			// Opera 8.0+, Firefox, Safari
    			ajaxRequest = new XMLHttpRequest();
    		}  
    		catch (e)
    		{
    			// Internet Explorer Browsers
    			try
    			{
    				ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
    			} 
    			catch (e)
    			{
    				try
    				{
    					ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
    				} 
    				catch (e)
    				{
    					// Something went wrong
    					alert("Your browser broke!");
    					return false;
    				}
    			}
    		}

    		// Create a function that will receive data sent from the server
    		ajaxRequest.onreadystatechange = function()
    		{
    			if(ajaxRequest.readyState == 4)
    			{
    				var reslt=ajaxRequest.responseText;
    				//alert(reslt);
    				//var mySplitResult = reslt.split("#");
    				//alert(mySplitResult[15]);
    				document.getElementById("bankaccountsList").innerHTML=reslt;
    			} 
    		}
    		var queryString = "?accounts=" +accounts;
    		ajaxRequest.open("GET", "AjaxGetBankAccounts.jsp" + queryString, true);
    		ajaxRequest.send(null); 
    	}

        function getbankAccountsDetails(i) 
        {
            //alert(document.getElementById("name"+i).value);
       		document.getElementById("bankaccountsList").style.visibility="hidden";
     		document.ereceipt.bankname.value=document.getElementById("name"+i).value;
    	}

        function getReceipt(id,mf,action)
        
        
        {
        	//alert("in get receipt");
        	//alert("mf"+mf);

            var ac="";
            if(mf=="D"){
                ac="delete !";
            }
            if(mf=="C"){
                ac="edit !";
            }
            //var accounts=document.payment.accountName.value;
            var r="";
            if(mf=="N"){
               
            }else{
                r = confirm("Are you sure you want to "+ac);
            }
           
            if (r == true || mf=="N") {
                var accounts=id;
                var modiflag = mf;
                var myaction = action;
               
                if (mf=="C" && id=="0")
                {
                    accounts = document.ereceipt.e_moneyreceiptno.value;
                }
                var ajaxRequest;  // The variable that makes Ajax possible!
                try
                {
                    // Opera 8.0+, Firefox, Safari
                    ajaxRequest = new XMLHttpRequest();
                } 
                catch (e)
                {
                    // Internet Explorer Browsers
                    try
                    {
                        ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
                    }
                    catch (e)
                    {
                        try
                        {
                            ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
                        }
                        catch (e)
                        {
                            // Something went wrong
                            alert("Your browser broke!");
                            return false;
                        }
                    }
                }

                // Create a function that will receive data sent from the server
                ajaxRequest.onreadystatechange = function()
                {
                    if(ajaxRequest.readyState == 4)
                    {
                        var reslt=ajaxRequest.responseText;
                        //alert("Received data"+reslt);
                        if (modiflag=="C" && action == "GET")
                        {
                            var mySplitResult = reslt.split("zz");
                            document.ereceipt.voucherno.value=mySplitResult[1];
                            document.ereceipt.voucherdate.value=mySplitResult[2];
                            document.ereceipt.customerName.value=mySplitResult[3];
                            document.ereceipt.cheque_no.value=mySplitResult[4];
                            document.ereceipt.chequedate.value=mySplitResult[5];
                            document.ereceipt.amount.value=mySplitResult[6];
                            document.ereceipt.invoiceno.value=mySplitResult[7];
                            document.ereceipt.bankname.value=mySplitResult[8];
                            document.ereceipt.branchname.value=mySplitResult[9];
                            document.ereceipt.city.value=mySplitResult[10];
                            document.getElementById('e_remarks').value=mySplitResult[11];
                            document.ereceipt.e_moneyreceiptno.value=mySplitResult[12];
                            document.ereceipt.e_customercode.value=mySplitResult[13];
                            document.getElementById('paymentmode').value=mySplitResult[14];
						if(mySplitResult[14]=="Suspense"){
							document.getElementById("received_from").style.visibility="hidden";
						}
                            document.ereceipt.e_tallyrefno.value=mySplitResult[15];
                            document.ereceipt.e_auth_by.value=mySplitResult[16];
                            document.ereceipt.e_auth_on.value=mySplitResult[17];
                            document.ereceipt.e_insertdt.value=mySplitResult[18];
                            document.ereceipt.e_twempname.value=mySplitResult[19];
                            document.ereceipt.e_tds.value=mySplitResult[20];
                            document.ereceipt.e_tdsamount.value=mySplitResult[21];
                            document.getElementById("newentry").style.visibility="hidden";
                            document.getElementById("entry").style.visibility="visible";
                            document.getElementById("ok").style.visibility="hidden";
                            document.getElementById("okc").style.visibility="visible";
                            mmoneyreceiptno=document.ereceipt.e_moneyreceiptno.value;
                           
                            showInvoiceTable_e();
                        }
                        if (modiflag=="N" && action == "POST")
                        {
                        	
                        	var from=document.getElementById("received_from").value;

				var mode=document.getElementById("paymentmode").value;
	
				if(from=="" || from==null && mode=="Suspense")
                        	{
                        		
                        		document.getElementById("lblNameMsg1").style.display="none";
                        		return true;
                        		
                        	}
				
                        	if(from=="" || from==null && mode!="Suspense")
                        	{
                        		
                        		document.getElementById("lblNameMsg1").style.display="";
                        		return false;
                        		
                        	}	
                        	var date=document.getElementById("voucherdate").value;
                        	if(date=="" || date==null)
                        	{
                        		
                        	}	
                        	var amount=document.getElementById("amount").value;
                        	
                        	if(amount=="" || amount==null)
                        	{
                        		document.getElementById("lblNameMsg2").style.display="";
                        		return false;
                        		
                        	}
                        	var numericExpression = /^[0-9 .]+$/;
                        	if(!(amount.match(numericExpression))) 
                        	{
                        		   	
                        		  	document.getElementById("lblNameMsg2").style.display="";
                            		document.ereceipt.amount.value=document.ereceipt.amount.value.substring(0, document.receipt.amount.value.length-1);
                        			return false;
                        	} 
                        	
							var cheque_no=document.getElementById("cheque_no").value;
                        	
                        	if(cheque_no=="" || cheque_no==null)
                        	{
                        		document.getElementById("lblNameMsg3").style.display="";
                        		return false;
                        	
                        	}
							var cheque_no=document.getElementById("chequedate").value;
                        	
                        	if(chequedate=="" || chequedate==null)
                        	{
                        		alert("Enter Cheque Date");
                        		return false;
                        	}
							var e_remarks=document.getElementById("e_remarks").value;
                        	
                        	if(e_remarks=="" || e_remarks==null)
                        	{
                        		document.getElementById("lblNameMsg4").style.display="";
                        		return false;
                        		//alert("Enter Remarks");
                        		//return false;
                        	}
                        	
                            var mySplitResult = reslt.split("#");
                            //alert(mySplitResult);
                            document.ereceipt.voucherno.value="";
                            document.ereceipt.customerName.value=mySplitResult[3];
                            document.ereceipt.cheque_no.value="";
                            document.ereceipt.amount.value="";
                            document.ereceipt.invoiceno.value="";
                            document.ereceipt.bankname.value="";
                            document.ereceipt.branchname.value="";
                            document.ereceipt.city.value="";
                            document.ereceipt.e_remarks.value="";
                            document.ereceipt.e_moneyreceiptno.value=mySplitResult[12];
                           
                            document.ereceipt.e_customercode.value="";
                            document.ereceipt.e_tallyrefno.value="";
                            document.ereceipt.e_auth_by.value="";
                            document.ereceipt.e_auth_on.value="";
                            document.ereceipt.e_insertdt.value="";
                            document.ereceipt.e_twempname.value="";
                            document.ereceipt.e_tds.value="";
                            document.ereceipt.e_tdsamount.value="";
                            var cust=document.ereceipt.customerName.value;
                            // var mcustomername=mySplitResult[3].replace("&","ampers");
                            var mcustomername=cust.replace("&","ampers");
                            
                            
                          // alert(document.ereceipt.customerName.value);
                           
                           
                           if(document.ereceipt.customerName.value==""){
                        	   return false;
                           }else{
                        	  // alert("Collectoninv");
                        	   var invoice="invoice";
                        	   var mcustcode=document.ereceipt.custcode.value;
                        	   //alert(document.ereceipt.custcode.value);
                        	   var checktotal="0";
                            document.ereceipt.action ="collectioninv.jsp?myvoucherno="+mySplitResult[12]+"&customerName="+mcustomername+"&customerCode="+mcustcode+"&invoice="+invoice+"&checktotal="+checktotal;//?moneyreceiptno="+mySplitResult[12];//+document.ereceipt.e_moneyreceiptno.value;
                            document.forms["ereceipt"].submit();
                            alert("Entry Updated......");
                            document.getElementById("newentry").style.visibility="visible";
                            document.getElementById("okc").style.visibility="hidden";
                            document.getElementById("ok").style.visibility="hidden";
                            document.getElementById("entry").style.visibility="hidden";
                             document.getElementById("e_tallyrefno").style.visibility="hidden";
                             document.getElementById("invoiceno").style.visibility="hidden";
                             document.getElementById("voucherno").style.visibility="hidden";
                           window.location.reload();
                            return true;
                           }
                        }
                        if (modiflag=="C" && action == "POST")
                        {
                            var mySplitResult = reslt.split("#");
                            document.ereceipt.voucherno.value="";
                            document.ereceipt.customerName.value="";
                            document.ereceipt.cheque_no.value="";
                            document.ereceipt.amount.value="";
                            document.ereceipt.invoiceno.value="";
                            document.ereceipt.bankname.value="";
                            document.ereceipt.branchname.value="";
                            document.ereceipt.city.value="";
                            document.ereceipt.e_remarks.value="";
                            document.ereceipt.e_moneyreceiptno.value="";
                            document.ereceipt.e_customercode.value="";
                            document.ereceipt.e_tallyrefno.value="";
                            document.ereceipt.e_auth_by.value="";
                            document.ereceipt.e_auth_on.value="";
                            document.ereceipt.e_insertdt.value="";
                            document.ereceipt.e_twempname.value="";
                            document.ereceipt.e_tds.value="";
                            document.ereceipt.e_tdsamount.value="";
                            document.getElementById("newentry").style.visibility="visible";
                            document.getElementById("okc").style.visibility="hidden";
                            document.getElementById("ok").style.visibility="hidden";
                            document.getElementById("entry").style.visibility="hidden";
                            if (document.ereceipt.e_department.value=="Accounts" || document.ereceipt.e_department.value=="All")
                            {
                                    document.getElementById("printoption").style.visibility="visible";
                            }       
                            window.location.reload();
                        }
                        if (modiflag=="D" && action == "GET")
                        {                    
                            //alert(reslt);
                            document.getElementById("newentry").style.visibility="visible";
                            document.getElementById("entry").style.visibility="hidden";
                            document.getElementById("ok").style.visibility="hidden";
                            document.getElementById("okc").style.visibility="hidden";
                             document.getElementById("e_tallyrefno").style.visibility="hidden";
                             document.getElementById("invoiceno").style.visibility="hidden";
                             document.getElementById("voucherno").style.visibility="hidden";
                             window.location.reload();
                        }
                       }
                }
                if (modiflag=='N' && action == 'POST')
                {
                   
                    var mPaymentmode = document.getElementById("paymentmode").value;
                    var mcustomername =document.ereceipt.customerName.value.replace("&","ampers");
                    var mcustcode=document.ereceipt.custcode.value;
                    var mysend_data = "zz"+document.ereceipt.voucherno.value+"zz"+document.ereceipt.voucherdate.value+"zz"+mcustomername+"zz"+document.ereceipt.cheque_no.value+"zz"+document.ereceipt.chequedate.value+"zz"+document.ereceipt.amount.value+"zz"+document.ereceipt.invoiceno.value+"zz"+document.ereceipt.bankname.value+"zz"+document.ereceipt.branchname.value+"zz"+document.ereceipt.city.value+"zz"+document.ereceipt.e_remarks.value+"zz"+document.ereceipt.e_moneyreceiptno.value+"zz"+document.ereceipt.e_customercode.value+"zz"+mPaymentmode+"zz"+document.ereceipt.e_tallyrefno.value+"zz"+document.ereceipt.e_auth_by.value+"zz"+document.ereceipt.e_auth_on.value+"zz"+document.ereceipt.e_insertdt.value+"zz"+document.ereceipt.e_twempname.value+"zz"+document.ereceipt.e_tds.value+"zz"+document.ereceipt.e_tdsamount.value+"zz"+mcustcode;
                    var queryString = "?id=" +accounts+"&modiflag="+modiflag+"&action="+myaction+"&mydata="+mysend_data;
                    //alert("N - POST------------>"+queryString);
                    document.getElementById("ok").style.visibility="visible";
                    document.getElementById("okc").style.visibility="hidden";
                   
                }
                if (modiflag=='C' && action == 'POST')
                {
                    var mPaymentmode = document.getElementById("paymentmode").value;
                    var mcustomername =document.ereceipt.customerName.value.replace("&","ampers");
                    var mcustcode=document.ereceipt.e_customercode.value;

                    var mysend_data = "zz"+document.ereceipt.voucherno.value+"zz"+document.ereceipt.voucherdate.value+"zz"+mcustomername+"zz"+document.ereceipt.cheque_no.value+"zz"+document.ereceipt.chequedate.value+"zz"+document.ereceipt.amount.value+"zz"+document.ereceipt.invoiceno.value+"zz"+document.ereceipt.bankname.value+"zz"+document.ereceipt.branchname.value+"zz"+document.ereceipt.city.value+"zz"+document.ereceipt.e_remarks.value+"zz"+document.ereceipt.e_moneyreceiptno.value+"zz"+document.ereceipt.e_customercode.value+"zz"+mPaymentmode+"zz"+document.ereceipt.e_tallyrefno.value+"zz"+document.ereceipt.e_auth_by.value+"zz"+document.ereceipt.e_auth_on.value+"zz"+document.ereceipt.e_insertdt.value+"zz"+document.ereceipt.e_twempname.value+"zz"+document.ereceipt.e_tds.value+"zz"+document.ereceipt.e_tdsamount.value+"zz"+mcustcode;
                    var queryString = "?id=" +accounts+"&modiflag="+modiflag+"&action="+myaction+"&mydata="+mysend_data;
                    document.getElementById("ok").style.visibility="visible";
                    document.getElementById("okc").style.visibility="hidden";
                   
                }
                if (modiflag=='D' && action == 'GET')
                {
                    var queryString = "?id=" +accounts+"&modiflag="+modiflag+"&action="+myaction+"&mydata=''";
                }
                if (modiflag=="N" && action=="GET")
                {
                    var queryString = "?id=" +accounts+"&modiflag="+modiflag+"&action="+myaction+"&mydata=''";
                    document.getElementById("newentry").style.visibility="hidden";
                    document.getElementById("entry").style.visibility="visible";
                    document.getElementById("ok").style.visibility="visible";
                    document.getElementById("okc").style.visibility="hidden";
                    if (document.ereceipt.e_department.value=="Accounts" || document.ereceipt.e_department.value=="All")
                    {
                          document.getElementById("e_tallyrefno").style.visibility="visible";
                          document.getElementById("invoiceno").style.visibility="visible";
                          document.getElementById("voucherno").style.visibility="visible";
                    }
                    else
                    {
                         document.getElementById("e_tallyrefno").style.visibility="hidden";
                         document.getElementById("invoiceno").style.visibility="hidden";
                         document.getElementById("voucherno").style.visibility="hidden";
                    }
                }
                if (modiflag=="C" && action=="GET")
                {
                    var queryString = "?id=" +accounts+"&modiflag="+modiflag+"&action="+myaction+"&mydata=''";
                    document.getElementById("newentry").style.visibility="hidden";
                    document.getElementById("entry").style.visibility="visible";
                    document.getElementById("ok").style.visibility="hidden";
                    document.getElementById("okc").style.visibility="visible";
                   
                    if (document.ereceipt.e_department.value=="Accounts" || document.ereceipt.e_department.value=="All")
                    {
                          document.getElementById("e_tallyrefno").style.visibility="visible";
                          document.getElementById("invoiceno").style.visibility="visible";
                          document.getElementById("voucherno").style.visibility="visible";
                    }
                    else
                    {
                         document.getElementById("e_tallyrefno").style.visibility="hidden";
                         document.getElementById("invoiceno").style.visibility="hidden";
                         document.getElementById("voucherno").style.visibility="hidden";
                    }
                }
               
                ajaxRequest.open("GET", "AjaxGetReceipt.jsp" + queryString, true);
                ajaxRequest.send(null);
               
            } else {
                //alert("Okey");
            }
           
           
           
        }
</script>
<script>

function validate(val){
	
	//alert("in validate: "+val);
	var from=document.getElementById("received_from").value;
	var mode=document.getElementById("paymentmode").value;

	
	if(from=="" || from==null && mode!=Suspense)
	{

		document.getElementById("lblNameMsg1").style.display="";
		return false;
		
	}
	else
		{
		document.getElementById("lblNameMsg1").style.display="none";
		}
	
	var amount=document.ereceipt.amount.value;
	//alert("amount"+amount);

	if(amount=="" || amount==null)
	{
		document.getElementById("lblNameMsg2").style.display="";
		return false;
		
	}
	else
		{
		document.getElementById("lblNameMsg2").style.display="none";
		}
	
	var numericExpression = /^[0-9 .]+$/;
	if(!(amount.match(numericExpression))) 
	{
		  	document.getElementById("lblNameMsg2").style.display="";
	  		document.ereceipt.amount.value=document.ereceipt.amount.value.substring(0, document.receipt.amount.value.length-1);
			return false;
	} 
		
		 var cheque_no=document.getElementById("cheque_no").value;
			
			if(cheque_no=="" || cheque_no==null)
			{
				document.getElementById("lblNameMsg3").style.display="";
				return false;
				
			}

	
			var e_remarks=document.getElementById("e_remarks").value;
			
			if(e_remarks=="" || e_remarks==null)
			{
				document.getElementById("lblNameMsg4").style.display="";
				return false;
				
			}	
			
			if(val=="add"){
				getReceipt('0','N','POST');
			}
			else{
				getReceipt('0','C','POST');
			}
}

</script>
  <script type="text/javascript">
   $(document).ready(function () {
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-4"f><"col-sm-12 col-md-2 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
	       displayLength: 10,
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
		                        title: 'Collection Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
		                        title: 'Collection Report '+$("#data").val()+' to ' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
		                        title: 'Collection Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
		                        title: 'Collection Report '+$("#data").val()+' to ' +$("#data1").val(),
		                        
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title: 'Collection Report '+$("#data").val()+' to ' +$("#data1").val(),
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