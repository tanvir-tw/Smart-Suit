<%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>
<%@ include file="header.jsp"%>

<jsp:useBean id="tally" class="com.tally.beans.TALLY" scope="page">
<style>
body {

            margin: 0px;
            padding: 0px;
            }
            
            #divheader
            {
            height:50;
            background:	White;
            }
            
            #header 
            {
            background: #2675a8;
            font:large;
            color:green;
            width: 100%;
            }
            
            #leftcolumn 
            {
            background:#0099CC;
            float: left;
            width: 35%;
            height: 400px;
            }
            
            #content 
            {
            border:medium;
            border-color:blue;
            background: ;
            float: left;
            width: 100%;
            height: 400px;
            overflow:scroll;
            }
            
            #myfooter 
            {
            background: #df781c;
            clear: both;
            width: 100%;
            }
}
</style>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Tally Conversion - Receipt Vouchers</title>
</head>
<body onload="changeScreenSize(100,100)">

<script type="text/javascript">
       var t = new ScrollableTable(document.getElementById('invoice'), 100);
</script>

<script language="JavaScript1.2">

function cancelbutton()
{
	document.getElementById("newentry").style.visibility="visible";
	document.getElementById("entry").style.visibility="hidden";
}

function okbutton()
{
	document.getElementById("newentry").style.visibility="visible";
	document.getElementById("entry").style.visibility="hidden";
}

function popUp(Address,companyName,SalesEnqNo)
{
    //alert("pop");
    window.open(Address+'?companyName='+companyName+'&SalesEnqNo='+SalesEnqNo,'jav','scrollbars=yes,menubar=yes,height=600,width=800,resizable=yes,toolbar=no,location=no,status=no');
}

function conformAll() {
    alert("CONFRM");
    alert(document.getElementByName(customername.options[1].value));/*
    while (ob.selectedIndex != -1) {
    if (ob.selectedIndex != 0)
    arSelected.push(ob.options[ob.selectedIndex].value);
    ob.options[ob.selectedIndex].selected = false;
    }*/
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

function getAccounts()
{
        document.getElementById("accountsList").style.visibility="visible";
		var accounts=document.epayment.accountName.value;
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
				document.getElementById("accountsList").innerHTML=reslt;
			} 
		}
		var queryString = "?accounts=" +accounts;
		ajaxRequest.open("GET", "AjaxGetAccounts.jsp" + queryString, true);
		ajaxRequest.send(null); 
	}

    function getAccountsDetails(i) 
    {
        //alert(document.getElementById("name"+i).value);
   		document.getElementById("accountsList").style.visibility="hidden";
 		document.epayment.accountName.value=document.getElementById("name"+i).value;
	}

    function getBankAccounts()
    {
            document.getElementById("bankaccountsList").style.visibility="visible";
    		var accounts=document.epayment.bankname.value;
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
     		document.epayment.bankname.value=document.getElementById("name"+i).value;
    	}

        function getVoucher(id,mf,action)
		{
		    //var accounts=document.payment.accountName.value;
		    
			var accounts=id;
			var modiflag = mf;
			var myaction = action;
       
			//alert(accounts+modiflag+myaction);
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
                    if (modiflag=="C" && action == "GET")
                    {
                        var mySplitResult = reslt.split("#");
						document.epayment.voucherno.value=mySplitResult[1];
						document.epayment.voucherdate.value=mySplitResult[2];
						document.epayment.accountName.value=mySplitResult[3];
						document.epayment.cheque_no.value=mySplitResult[4];
						document.epayment.chequedate.value=mySplitResult[5];
						document.epayment.amount.value=mySplitResult[6];
						document.epayment.purinvoiceno.value=mySplitResult[7];
						document.epayment.bankname.value=mySplitResult[3];
						document.epayment.paymentid.value=mySplitResult[9];
						document.getElementById("newentry").style.visibility="hidden";
						document.getElementById("entry").style.visibility="visible";
                    }
                    if (modiflag=="N" && action == "POST")
                    {
                        //alert(reslt);
						var mySplitResult = reslt.split("#");
						//alert(mySplitResult[7]);
						document.epayment.voucherno.value="";
						document.epayment.accountName.value="";
						document.epayment.cheque_no.value="";
						document.epayment.amount.value="";
						document.epayment.purinvoiceno.value="";
						document.epayment.bankname.value="";
						document.epayment.paymentid.value="";
                    	document.getElementById("newentry").style.visibility="visible";
						document.getElementById("entry").style.visibility="hidden";
						window.location.reload();
                    }
                    if (modiflag=="D" && action == "GET")
                    {
                        //alert(reslt);
						document.getElementById("newentry").style.visibility="visible";
						document.getElementById("entry").style.visibility="hidden";
						window.location.reload();
                    }
       			} 
			}
			
            if (modiflag=='N' && action == 'POST')
			{ 
    			var mysend_data = "zzz"+document.epayment.voucherno.value+'zzz'+document.epayment.accountName.value+"zzz"+document.epayment.cheque_no.value+"zzz"+document.epayment.amount.value+"zzz"+document.epayment.purinvoiceno.value+"zzz"+document.epayment.bankname.value+"zzz"+document.epayment.voucherdate.value+"zzz"+document.epayment.chequedate.value+"zzz"+document.epayment.paymentid.value;
                var queryString = "?id=" +accounts+"&modiflag="+modiflag+"&action="+myaction+"&mydata="+mysend_data;
            }
			else
			{
			    var queryString = "?id=" +accounts+"&modiflag="+modiflag+"&action="+myaction+"&mydata=''";
			}
		    if (modiflag=="N" && action=="GET")
		    {
			    document.getElementById("newentry").style.visibility="hidden";
				document.getElementById("entry").style.visibility="visible";
		    }
		  
            ajaxRequest.open("GET", "AjaxGetVoucher.jsp" + queryString, true);
			ajaxRequest.send(null);
		}

</script>

<form method="post" name="epayment" autocomplete="off">
      <%
      String CMID=session.getAttribute("CompanyMasterID").toString();
      String SID=session.getAttribute("TallySID").toString();
      String PID=session.getAttribute("TallyPID").toString();
            DecimalFormat df2 = new DecimalFormat( "0.00" );
            String voucherdate="",chequedate="",voucherdateCal="",chequedateCal="";
            Date today = new Date();
            Calendar cal = Calendar.getInstance();
			cal.setTime(today);
			cal.add(Calendar.DAY_OF_MONTH, -30);
			Date today30 = cal.getTime();
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

    <div id="entry" style="margin-left:25%; margin-top:7%; height:275;width:45%; border-style:outset; border-width:1; border-color: green;position:absolute; background-color: aqua; " >
      <div style="background-color:blue;height:25;width:100%; color:white; "> 
      <table style="color: white; align:center;width:100%"><tr style="color: white; text-align:center;"><td >Voucher Entry</td></tr></table>
       </div>
      <table >
      <tr>
      <td width="150" >Voucher No:</td>
      <td width="350"><input type="text" name="voucherno" id="voucherno" value="" size="10" /></td>
      </tr>
      <tr>
      <td width="150" >Payment Date:</td>
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
      </tr>
      <tr>
      <td>Paid to:</td>
      <td><input type="text" name="accountName" id="paid_to" value="<%=voucherdate%>"  size="50" onkeyup="getAccounts()" autocomplete="off" />
      
      <div id='accountsList' style="position:absolute; background-color: white;">
	<div style="height: 150px; width: 325px; overflow: auto; border:solid inset;"></div>
	</div>
	 <script>document.getElementById("accountsList").style.visibility="hidden";</script>
      </td>
      </tr>
      <tr>
      <td>Amount:</td>
      <td><input type="text" name="amount" id="amount" value=""  size="10"  style="text-align: right;"></td>
      </tr>
      <tr>
      <td>Cheque No:</td>
      <td><input type="text" name="cheque_no" id="cheque_no" value=""  size="10" /></td>
      </tr>
      <tr>
      <td>Cheque Date:</td>
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
			</script></td>
      </tr>
      <tr>
      <td>Bank Name:</td>
      
      <td>
      <input type="text" name="bankname" id="bank_name" value="" size="50"  onkeyup="getBankAccounts()" />
      <div id='bankaccountsList' style="position:absolute; background-color: white;">
	<div style="height: 150px; width: 325px; overflow: auto; border:solid inset;"></div>
	</div>
	 <script>document.getElementById("bankaccountsList").style.visibility="hidden";</script>
      
      </td>
      </tr>
      <tr>
      <td>Pur.Invoice No:</td>
      <td><input type="text" name="purinvoiceno" id="purinvoiceno" value=""  /></td>
      </tr>
      <tr>
      <td></td>
      <td>
      <input type="button" name="Ok" id="ok" value="Ok" style="width:80;" onclick="getVoucher('0','N','POST')" />
      <input type="button" name="Cancel" id="cancel" value="Cancel" onclick="cancelbutton()" style="width:80;" />
      </td>
      </tr>
    
      </table>
     </div>
       <div id="data">
      <div id="divheader">
      <table width="100%">
      <tr>
      <td colspan="3" align="center">[Cheques for Approval]</td>
      </tr>
      <tr>
      <td width="20%" align="left"><a href="#" onclick="checkAll()">Check All</a> / <a href="#" onclick="unCheckAll()">Uncheck All</a>
      </td>
      <td align="left">
      <div id="newentry" style="width:100%;">
    
     <a href="#" style="font-weight: bold; color: black; " onclick="getVoucher('0','N','GET')">
     <img src="new.JPG" width="25px" height="22px" style="border-style: none"></img>
     </a> 
      New Entry
     </div>
     </td>
      <td > 
      <a href="tally_paydata.jsp"  style="a:hover { color: #DA8525; }" >Select Payment Details from Tally Data&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
     </td>
      <td width="40%" align="right"> 
      <a href="supoutstanding.jsp"  style="a:hover { color: #DA8525; }" >Select Purchase Invoice&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
     </td>
     </tr>
     </table>
      </div>
      <script>document.getElementById("entry").style.visibility="hidden";</script>
      <div id="content">
     <table class="sortable">
     <tr>
     <th><div></div></th>
     <th><div>
     </div></th>
             <th><div></div></th>
            <th><div>VoucherNo</div></th>
            <th><div align="left">Payment-Date</div></th>
            <th width="400"><div align="left">Pay to</div></th>
            <th><div align="left">Cheque No</div></th>
            <th><div align="left">Cheque Date</div></th>
            <th><div align="right">Amount</div></th>
            <th><div align="left">Pur.Invoice No</div></th>
        </tr>
     <%
    
        try
        {
        	tally.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD, SID,PID,CMID);
        	Connection conn = null;
        	Statement st = null;
        	
        	String todaydate="";
	        todaydate=new SimpleDateFormat("dd-MM-yyyy").format(new java.util.Date());
	        conn = tally.ReturnConnection();
        	st = conn.createStatement();
        	String sql="select * from "+session.getAttribute("CompanyMasterID").toString()+"epayments";
        	ResultSet rs=st.executeQuery(sql);
        	while(rs.next())
        	{
        		String mPayment_date =new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("payment_date")));
    			String mCheque_date =new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("cheque_date")));
    			
            %>
            <tr>
            <td><div><input type="checkbox"  name="checkbox1" value="<%=rs.getString("Voucherno")%>" >
            <input type="hidden"  name="paymentid" value="<%=rs.getString("payment_id")%>" >
            </div>
            </td>
            <td>
            <a href="#" style="font-weight: bold; color: black; " onclick="getVoucher(<%=rs.getString("payment_id")%>,'D','GET');">
            <img src="delete.JPG" width="20px" height="18px" style="border-style: none"></img>
            </a></td>
            <td>
            <a href="#" style="font-weight: bold; color: black; " onclick="getVoucher(<%=rs.getString("payment_id")%>,'C','GET');">
            <img src="edit.JPG" width="20px" height="18px" style="border-style: none"></img>
            </a></td>
            <td width=75><div align="left"><%=rs.getString("VoucherNo") %></div></td>
            <td><div align="left"><%=mPayment_date%></div></td>
            <td width="400"><div align="left"><%=rs.getString("paid_to")%></div></td>
            <td><div align="left"><%=rs.getString("cheque_no")%></div></td>
            <td><div align="left"><%=mCheque_date%></div></td>
            <%
            double mamount=0.00;
            mamount =Double.parseDouble(rs.getString("amount"));
     
            %>
            <td><div align="right"><%=df2.format(mamount)%></div></td>
            <td><div align="left"><%=rs.getString("purinvoiceno")%></div></td>
            </tr>
        <%
            }
        }
        catch (Exception e)
        {
        e.printStackTrace();
        }
        %>
     </table>
     </div>
     </div>
     
     
	 <br>
	 <br><br><br><br><br><br>
	 <div id="footer">
	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
           	by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
	</div>
	</form>
	</body>
</html>
</jsp:useBean>