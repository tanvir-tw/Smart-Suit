<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="conn.jsp"%>

<%@page import="java.util.Date"%>
<%@page import="java.io.*"%>
<%@page import="java.text.*"%>
<%@page import="java.util.TimeZone"%><jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<style type="text/css">
    @import url(jscalendar-1.0/calendar-win2k-1.css);
    </style>
	<style>
    </style>
	<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>

	<script src="sorttable.js" type="text/javascript"></script>

	<script src="dropdown.js" type="text/javascript"></script>
	<script src="ledgerDetails.js" type="text/javascript"></script>


	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title>Transworld Compressor-Technologies LTD, ERP</title>
	<link href="css/style.css" rel="stylesheet" type="text/css"
		media="screen" />
	<link href="css/table.css" rel="stylesheet" type="text/css"
		media="screen" />
	<style type="text/css">
    </style>
	
	<link rel="stylesheet" type="text/css" href="css/chromestyle2.css" />
	
	<script type="text/javascript" src="css/chrome.js">
	</script>	
	<script type="text/javascript" src="convert.js">
	</script>
	<script type="text/javascript" >
	function popUp(webadd,trancactionId,company)
	{ 
			window.open(webadd+'?company='+company+'&transactionId='+trancactionId,'jav','width=870,height=500,top=150,left=250,resizable=no');
	}


	function validate()
	{
		calculate();
		var cnt=document.generatequo.checkedNumber.value;

		var agree=confirm("Please conform following values\n\n Total Items in Order: "+cnt+"\n Total Amount : "+document.getElementById('total').value+"");
	    		if (agree)
	    			return true ;
	    		else
	    			return false ;
	}

	
	function calculate()
	{
		var a=0;var k=0;
		var rowCount = document.generatequo.checkedNumber.value;
		for(k=0;k<rowCount;k++)
		{
			var tax=document.getElementById("tax"+k).value;
			var discount=document.getElementById("discount"+k).value;
			var qua=document.getElementById("quantity"+k).value;
			
			var unitprice=document.getElementById("sellingPrice"+k).value;
			var discount1=((discount)*unitprice/100);
			//alert("disc"+discount1);
			var afterdiscprice=unitprice-discount1;
			//alert("aft disc"+afterdiscprice);
			var tax1=((tax)*afterdiscprice)/100;
			//alert("aft tax"+tax1);
			unitprice++;
			unitprice--;
			tax1++;
			tax1--;
			a=unitprice+tax1;
			//alert("a vvv"+a);
			a=a-discount1;
			//alert("a vvv11"+a);
			var bb=a*qua;
			//alert("valll"+bb);
			a++;
			a--;
			
			//alert("after calc-->"+a);
			//var tax1=(tax)/100*unitprice*qua;
			//var discount1=(discount)/100*unitprice*qua;
			 
			//a=unitprice*qua+tax1-discount1;
			document.getElementById("amount"+k).value=bb.toFixed(2);
		}	
			var rowCount = document.generatequo.checkedNumber.value; 
			var z; 
			var i;
			var total;
			var s=0;
			var sss=0;
			for(i=0;i<rowCount;i++)
			{
				//alert("Inside Addition");
				var z=(document.getElementById("amount"+i).value);
				//alert("val of amt=====>"+z);
				s=parseFloat(s)+parseFloat(z);
				sss=s+z;
				//alert("after round of"+s);
			}
			//var s1=s1+s;
			var s = Math.round(s).toFixed(2); // "160678.00"

			//alert("after round S111111 "+s);
			
			document.getElementById('total').value=s;



		    var junkVal=document.getElementById('total').value;
		    /* alert("junkVal-----------"+junkVal);
		    if(junkVal.indexOf('.')!=-1)
			{
			junkVal = junkVal.substring(junkVal.indexOf('.')+1,junkVal.length);
			
			alert("In junkVal paisa"+junkVal);
			if(junkVal.length==0 || junkVal.length=='00')
			{
				
			}
			else
				{
				junkVal1=junkVal.replace("junkVal","");
				alert("in calculate junkVal1-------"+	junkVal1);
				}*/
				
		   junkVal=Math.floor(junkVal); 
		    var obStr=new String(junkVal);
		 
		 
		     numReversed=obStr.split("");
		     actnumber=numReversed.reverse();
		 //    alert("Number1--------------"+actnumber);
		 
		  var result = sss.lastIndexOf(".");
		     
		    // alert("result--before-"+ result);

		     result = sss.substring(sss.lastIndexOf(".")+1);
		   //  alert("result---"+ result);
		     
		     
	
		   if(Number(junkVal) >=0){
		        //do nothing
		    }
		    else{
		    alert('wrong Number cannot be converted');
		    return false;
		    }
		    /* if(Number(junkVal)==0){
		        document.getElementById('container').innerHTML=obStr+''+'Rupees Zero Only';
		        return false;
		    } */
		    if(actnumber.length>9){
		        alert('Oops!!!! the Number is too big to covertes');
		        return false;
		    }
		 
		    var iWords=["Zero", " One", " Two", " Three", " Four", " Five", " Six", " Seven", " Eight", " Nine"];
		    var ePlace=['Ten', ' Eleven', ' Twelve', ' Thirteen', ' Fourteen', ' Fifteen', ' Sixteen', ' Seventeen', ' Eighteen', ' Nineteen'];
		    var tensPlace=['dummy', ' Ten', ' Twenty', ' Thirty', ' Forty', ' Fifty', ' Sixty', ' Seventy', ' Eighty', ' Ninty' ];
		 
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
		            inWords[j]=inWords[j];
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
		            else {2
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
		    //document.getElementById('rupees').value=finalWord;
		return finalWord;
		    
	}
		    function calculate1()
			{
				var a=0;var k=0;
				var rowCount = document.generatequo.checkedNumber.value;
				for(k=0;k<rowCount;k++)
				{
					var tax=document.getElementById("tax"+k).value;
					var discount=document.getElementById("discount"+k).value;
					var qua=document.getElementById("quantity"+k).value;
					
					var unitprice=document.getElementById("sellingPrice"+k).value;
					var discount1=((discount)*unitprice/100);
					//alert("disc"+discount1);
					var afterdiscprice=unitprice-discount1;
					//alert("aft disc"+afterdiscprice);
					var tax1=((tax)*afterdiscprice)/100;
					//alert("aft tax"+tax1);
					unitprice++;
					unitprice--;
					tax1++;
					tax1--;
					a=unitprice+tax1;
					//alert("a vvv"+a);
					a=a-discount1;
					//alert("a vvv11"+a);
					var bb=a*qua;
					//alert("valll"+bb);
					a++;
					a--;
					
					//alert("after calc-->"+a);
					//var tax1=(tax)/100*unitprice*qua;
					//var discount1=(discount)/100*unitprice*qua;
					 
					//a=unitprice*qua+tax1-discount1;
					document.getElementById("amount"+k).value=bb.toFixed(2);
				}	
					var rowCount = document.generatequo.checkedNumber.value; 
					var z; 
					var i;
					var total;
					var s=0;
					var sss=0;
					for(i=0;i<rowCount;i++)
					{
						//alert("Inside Addition");
						var z=(document.getElementById("amount"+i).value);
						//alert("val of amt=====>"+z);
						
						//alert("z----------------"+z);
						s=parseFloat(s)+parseFloat(z);
						sss=s+z;
						//alert("after round of"+s);
					}
					var s1=z;
					//alert("s1------------------"+s1);
					//document.getElementById('total').value=s1;



				    var junkVal=document.getElementById('total').value;
				   // alert("junkVal--------------"+junkVal);

				    if(junkVal.indexOf('.')!=-1)
			{
				    	
					  //  alert("junkVal--in if ------------"+junkVal);

			junkVal = junkVal.substring(junkVal.indexOf('.')+1,junkVal.length);
			}
				   // alert("junkVal--------------"+junkVal);

				   //junkVal=Math.floor(junkVal); 
				    var obStr=new String(junkVal);
				 
				   // alert("obStr--------------"+obStr);

				    numReversed=obStr.split("");
				   // alert("numReversed--------------"+numReversed);
				     actnumber=numReversed.reverse();
				    // alert("actnumber--------------"+actnumber);
				      var result = sss.lastIndexOf(".");
		     
		     //alert("result--before-"+ result);

		     result = sss.substring(sss.lastIndexOf(".")+1);
		     //alert("result---"+ result);
		     
		     //alert("numReversed---"+ numReversed);

			
				   if(Number(junkVal) >=0){
				        //do nothing
				    }
				    else{
				    alert('wrong Number cannot be converted');
				    return false;
				    }
				    if(Number(result)==0){
				        document.getElementById('container').innerHTML=obStr+''+'Rupees Paisa Only';
				        return false;
				    }
				    if(actnumber.length>9){
				        alert('Oops!!!! the Number is too big to covertes');
				        return false;
				    }
				 
				    var iWords=["Zero", " One", " Two", " Three", " Four", " Five", " Six", " Seven", " Eight", " Nine"];
				    var ePlace=['Ten', ' Eleven', ' Twelve', ' Thirteen', ' Fourteen', ' Fifteen', ' Sixteen', ' Seventeen', ' Eighteen', ' Nineteen'];
				    var tensPlace=['dummy', ' Ten', ' Twenty', ' Thirty', ' Forty', ' Fifty', ' Sixty', ' Seventy', ' Eighty', ' Ninty' ];
				 
				    var iWordsLength=numReversed.length;
				    var totalWords="";
				    var inWords=new Array();
				    var finalWord1="";
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
				            inWords[j]=inWords[j];
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
				            else {2
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
				    finalWord1+=inWords[i];
				}
				    //document.getElementById('rupees').value=finalWord1;
				return finalWord1;
				    
			}
	
	function convert_amount_into_rupees_paisa()

	{
		//alert("Hi");
	var finalWord1 = calculate();
	
	//alert("calculate-----------"+finalWord1);
	var finalWord2 = "";


	 var junkVal=document.getElementById('total').value;
	 var actual_junkVal=document.getElementById('total').value;
	 
	// alert("actual_junkVal-------"+actual_junkVal);
	//document.getElementById('total').value=junkVal;
     //alert("junkVal-----------"+junkVal);
	if(junkVal.indexOf('.')!=-1)
	{
	junkVal = junkVal.substring(junkVal.indexOf('.')+1,junkVal.length);
	
	//alert("In junkVal paisa"+junkVal);
	//alert("In junkVal paisa length"+junkVal.length);

	if(junkVal==0 || junkVal=='00')
	{
		//alert("In junkVal 00---------"+junkVal);
	finalWord2 = "zero paisa only";
	}
	else
	{
		//document.getElementById('total').value = junkVal;
	//alert("Rupees and Paisa junkVal------------"+junkVal);
	finalWord2 = calculate1() + " paisa only";
	}
	//alert("finalWord1------------"+finalWord1+".......finalWord2.."+finalWord2);

	document.getElementById('rupees').value=finalWord1 +" Rupees and "+finalWord2;
	}
	else
	{
	//finalWord2 = " Zero paisa only";
	//alert("Paisa junkVal------------"+junkVal);
	document.getElementById('rupees').value=finalWord1 +" Rupees Only";
	}
/* 	finalWord2="and "+calculate1() +" paisa only";
	document.getElementById('rupees').value = finalWord1 +" Rupees "+finalWord2;
 */	}
	
	function checkAll()
	{
	var field=document.getElementsByName('check');
	var i;
	try{
	for (i = 0; i < field.length; i++)
	field[i].checked = true ;
	}catch(e){alert(e);}
	}

	function unCheckAll()
	{
	var field=document.getElementsByName('check');
	var i;
	try{
	for (i = 0; i < field.length; i++)
	field[i].checked = false ;
	}catch(e){alert(e);}
	}

	function newwindow(webadd,salesenqno1,company)
	{ 
		
			window.open(webadd+'?salesenqno1='+salesenqno1+'&company='+company,'jav','width=470,height=500,top=250,left=600,resizable=no');
	}

	function newwindow1(webadd,salesenqno1,company)
	{
		window.open(webadd+'?salesenqno1='+salesenqno1+'&company='+company,'jav','width=470,height=500,top=250,left=600,resizable=no');
	}
	</script>
	</head>
	<body>
	
<%
	erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
%>

<%
	
	Connection conn = null;
	Statement st = null, st1 = null,st2=null,st3=null,stlbl=null,st4=null;
	
	String fromDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String toDate="";
	String fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	String fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	String fromDateCal1=new SimpleDateFormat("dd-MMM-yyyy").format(new Date());
	 
	double sumAmount=0,amount=0; 
	int groupCode=0,makeCode=0;
	int sumOfQuotation=0,TWSalesRefNo=0;
	
	int i=0,a=0;
	int k=0;
	int d=0;
	String words="";
	String groupName="",makeName="",itemCode="";
	String refMakeNameTable="";
	String sqlDisplayDesc=" ",salesquodate="",enqtime="",amountInWords="",termsconditions="";

	
	String addresscode1=request.getParameter("addresscode");
	String company=request.getParameter("company");
	System.out.println("COMPANY    COMPANY    "+company);
	String salesrefno=request.getParameter("SalesEnqRefNo");
	String salesenqno1=request.getParameter("salesenqno");
	
	String sellingPrice=request.getParameter("sellingPrice");
	String remarks=request.getParameter("remarks");
	String quantity1=request.getParameter("quantity");
	System.out.println(sellingPrice);
	String group=request.getParameter("group");
	String check=request.getParameter("check");
	String description=request.getParameter("description");
	
	String text = "";
	
	try {
	conn = erp.ReturnConnection();
	st = conn.createStatement();
	st2 = conn.createStatement();
	st1 = conn.createStatement();
	st3 = conn.createStatement();
	stlbl = conn.createStatement();
	st4 = conn.createStatement();
	} catch (Exception e) {
	}
	
	StringBuffer buffer=new StringBuffer(","); 
	while( i!=(Integer.parseInt(request.getParameter("checkedNumber").toString())))
	{
	if(request.getParameter("check"+i)!=null)
	buffer.append(i+",");
 	i++;
	}

%>
	<div align="center"
		style="font-size: 1.5em; margin-top: 0.6em; height: 3px; background-color: #339CCB">
	</div>
	<div align="center" style="font-size: 1.6em;"><a> Generate Quotation</a></div>
 	<div align="center"
		style="font-size: 1.5em; margin-top: 0.3em;   height: 3px; background-color: #339CCB">
	</div>
							
	<br> 
	<form name="generatequo" method="get" action="insertquo.jsp" onSubmit="return validate();" >
	<input type="hidden" id="buffer" name="buffer" value="<%=buffer %>">
<%

	String SqlDet="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det WHERE SalesEnqNo='"+salesenqno1+"' ";
	ResultSet rsDet=st.executeQuery(SqlDet);
	while(rsDet.next()){
	
%>	
	<table border="0" align="left" valign="top" width="50%" cellpadding="3" cellspacing="3">
	
	<tr>
	<td><b>SE ID:</b></td>
	<td><a href="#" style="font-weight: bold;" onclick="popUp('SEDetails.jsp','<%=rsDet.getString("SalesEnqRefNo")%>','<%=rsDet.getString("CompanyName") %>')">
	<%=rsDet.getString("SalesEnqRefNo") %></a></td>
	
	</tr>
	<tr>
	<td><b>SE Expiry date:</b></td>
	<%
	Date today = new Date();
	Calendar cal = Calendar.getInstance();
	cal.setTime(today);
	cal.add(Calendar.DAY_OF_MONTH, +30);
	Date today30 = cal.getTime();
	String expdate=new SimpleDateFormat("dd-MMM-yyyy").format(today30);
	%>
	<td><input type="text" id="todate" onmousedown="unCheckAll()"
	name="todate" value="<%=expdate %>" size="15"
	readonly="readonly"
	style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />

	<script type="text/javascript">
	Calendar.setup(
	{
	inputField  : "todate",         // ID of the input field
	ifFormat    : "%d-%b-%Y",    // the date format
	button      : "todate"       // ID of the button
	}
	);
	</script></td>
	</tr>
	<tr>
	<td><b>Group:</b></td>
	<td><input type="text" value="-" id="groupTop"  name="groupTop" style="border: none;" /></td>
	</tr>
	</table>
	<table  border="0" bgcolor="#C6DEFF" align="right" valign="top" width="50%" cellpadding="3" cellspacing="3">
	<tr>
	<td><b>Code:</b></td>
	<td><input type="hidden" name="customercode" value="<%=rsDet.getString("CustomerCode") %>"/><%=rsDet.getString("CustomerCode") %></td>
	
	<td><b>Contact:</b></td>
	<td><input type="hidden" name="contactperson" value="<%=rsDet.getString("ContactPerson") %>"/><%=rsDet.getString("ContactPerson") %></td>
	<td><b>Address:</b></td>
	<td  style="width: 220px;"><input type="hidden" name="address" value="<%=rsDet.getString("Address") %>"/><%=rsDet.getString("Address") %></td>
	</tr>
	<tr>
	<td><b>City:</b></td>
	<td><input type="hidden" name="city" value="<%=rsDet.getString("city") %>"/><%=rsDet.getString("city") %></td>
	<td><b>State:</b></td>
	<td><input type="hidden" name="state" value="<%=rsDet.getString("State") %>"/><%=rsDet.getString("State") %></td>
	<td><b>Country:</b></td>
	<td><input type="hidden" name="country" value="<%=rsDet.getString("country") %>"/><%=rsDet.getString("country") %></td>
	</tr>
	<tr>
	<td><b>Phone:</b></td>
	<td><input type="hidden" name="phone" value="<%=rsDet.getString("Phone") %>"/><div align="left"><%=((rsDet.getString("Phone")!=null) ? rsDet.getString("Phone") : "-") %></div></td>
	<td><b>Fax:</b></td>
	<td><input type="hidden" name="fax" value="<%=rsDet.getString("Fax") %>"/><div align="left"><%=((rsDet.getString("Fax")!=null) ? rsDet.getString("Fax") : "-") %></div></td>
	<td><b>Zip code:</b></td>
	<td><input type="hidden" name="zip" value="<%=rsDet.getString("Zip") %>"/><div align="left"><%=((rsDet.getString("Zip")!=null) ? rsDet.getString("Zip") : "-") %></div></td>
	</tr> 
<%}%>	
	</table>
	<br>
	
	<table>
	</table>																				
	<br>
	<input type="hidden" name="addresscode" id="addresscode" value="<%=addresscode1 %>">
	<input type="hidden" id="check" name="check" value="<%=i%>" />   
	<input type="hidden" name="company" id="company" value="<%=company %>"/>
          
	<table border="1px"  class="sortable">
	<tr>
	<th>Option No</th>
	<th>Insert Or</th>
		<%
			String sqllbl="select * from LableMaster where CompanyId="+session.getAttribute("CompanyMasterID").toString();		
			ResultSet rslbl=stlbl.executeQuery(sqllbl);
			while(rslbl.next()){
		%>
	<th><%=rslbl.getString("Make") %></th>
	<th><%=rslbl.getString("Model") %></th>
	<th><%=rslbl.getString("PartNO") %></th>
	<th><%=rslbl.getString("Description") %></th>
	<%} %>
	<th>Quantity</th>
	<th>Unit prize</th>
	<th>Discount %</th>
	<th>Tax %</th>
	<th>Amount</th>	
	<th>Raised PO</th>
	</tr>
<% 
 	 //i=0;
 	double tax=0,discount=0.00 ,total=0.00;
	i=0;
	 		
	String sqlEnq="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items WHERE SalesEnqNo='"+salesenqno1+"'";
	System.out.println(sqlEnq);
	ResultSet rsEnq=st1.executeQuery(sqlEnq);
	while(rsEnq.next()){
	
	groupName="";makeName="";refMakeNameTable="";
	groupCode=rsEnq.getInt("TheGroup");
	makeCode=rsEnq.getInt("Make");
	itemCode=rsEnq.getString("ItemCode");
	     
	//System.out.println("++++++++++++++++++++++++++++++++++++");
	  
	String  sqlGroup="SELECT TheGroupName from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"+groupCode+"'";
	ResultSet rsGroup=st2.executeQuery(sqlGroup);
	if(rsGroup.next())
	groupName=rsGroup.getString("TheGroupName");
	if(groupCode<5){
	refMakeNameTable=session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5)+"makemaster";
	   	  	
	String sqlMakename="SELECT MakeName FROM "+refMakeNameTable.toLowerCase()+"  WHERE makecode='"+makeCode+"' ";
	ResultSet rsMakeName=st3.executeQuery(sqlMakename);
	if(rsMakeName.next())
	makeName=rsMakeName.getString(1);
	else
	makeName="-";
			      
	sqlDisplayDesc="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5).toLowerCase()+"im_make"+makeCode+" where ItemCode='"+itemCode+"'";
	}
	else{
	sqlDisplayDesc="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+groupCode+" where ItemCode='"+itemCode+"' ";
	makeName="-"  ;
	}
	
	System.out.println(k+"///////  "+groupCode);
	  %>
		<input type="hidden" name="icode<%=k %>" id="icode<%=k %>" value="<%=itemCode %>"/>	
		<input type="hidden" name="gcode<%=k %>" id="gcode<%=k %>" value="<%=groupCode %>">
		<input type="hidden" name="mcode<%=k %>" id="mcode<%=k %>" value="<%=makeCode %>"/>
	    
	    <script type="text/javascript">
	  	document.getElementById('groupTop').value='<%=groupName%>';
	  
	  </script>
	  <%   
	
	ResultSet rsSql=st3.executeQuery(sqlDisplayDesc);
	
	while(rsSql.next()){
		
	
	if(buffer.toString().contains(","+k+","))
	{
%>	
	<tr>
	<td><div align="right"><%=rsEnq.getString("TheOptionNo") %></div></td>
	<td><div align="left"><%=rsEnq.getString("InsertOR") %></div></td>
	<td><div align="left"><input type="hidden" name="make<%=d %>" id="make<%=d %>" value="<%=makeName %>"/><%=makeName %></div></td>
	<td><div align="left"><%=rsSql.getString("Model") %></div></td>
	<td><div align="left"><%=rsSql.getString("Partno") %></div></td>
	<td><div align="left"><input type="hidden" id="description<%=d %>"  name="description<%=d %>" value="<%=request.getParameter("description"+k)%>" /><%=request.getParameter("description"+k) %></div></td>
	<td><div align="right"><input type="hidden"  id="quantity<%=d %>" name="quantity<%=d %>" value="<%=request.getParameter("quantity"+k)%>" /><%=request.getParameter("quantity"+k) %></div></td>
	<td><div align="right"><input type="hidden" id="sellingPrice<%=d %>" name="sellingPrice<%=d %>"  value="<%=request.getParameter("sellingPrice"+k) %>" /><%=request.getParameter("sellingPrice"+k) %></td>
	<td style="width: 85px;"><input type="text"  id="discount<%=d %>"  name="discount<%=d %>" style="width : 70px;padding: 4px 5px 2px 5px;
	border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;" value="0" /></td>
	<td style="width: 85px;"><input type="text"  id="tax<%=d %>" name="tax<%=d %>" style="width : 70px; padding: 4px 5px 2px 5px;
	border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;" value="0" /></td>
	<td style="width: 85px;"><input type="text" id="amount<%=d %>" style="width : 70px;padding: 4px 5px 2px 5px;
	border:none; text-align:right;	background:inherit; " value="<%= amount%>" /></td>
	<td style="width: 85px;">NO</td>
	</tr>
	<input type="hidden" name="priceaccepted<%=d %>" id="priceaccepted<%=d %>" value="<%=request.getParameter("priceAccepted"+k )%>"/>  
<% 	
sumOfQuotation++;d++;
   }
   k=k+1;
   
   }
   }
		
%>

  	<input type="hidden" name="tax<%=k %>" id="tax<%=k %>" value="<%=tax %>"/>
	<input type="hidden" name="discount<%=k %>" id="discount<%=k %>"  value="<%=discount%>"/>
	</table>
	<input type="hidden" name="checkedNumber" id="checkedNumber" value="<%=sumOfQuotation %>"/>
	<%if(!(session.getAttribute("userLevel").toString().equalsIgnoreCase("level5"))){ %>
    <input type="hidden" name="twempname" id="twempname" value="<%=session.getAttribute("EmpName") %>"/>
	<%} %>
  	
	
	<input type="hidden" name="remarks" id="remarks" value="<%=remarks %>"/>
	<input type="hidden" name="salesenqno" value="<%=salesenqno1 %>" />
	<input type="hidden" name="group" value="<%=groupName %>"/>
	<br>
	
			<div align="left"   style="position:absolute;   font-size: 1.1em"><b> &nbsp;TERMS & CONDITIONS :</b></div>
		<textarea name="termsconditions" id="search-text" style='width: 430px; height: 160px;'>
		<%
			out.println("");
				String termsql="select * from "+session.getAttribute("CompanyMasterID").toString()+"saleTermsancond";
				String terms="";	
			ResultSet rsterms=st4.executeQuery(termsql);
				while(rsterms.next())
				{
					
					out.println(rsterms.getString("id")+":- "+rsterms.getString("terms"));
				}
				
					
				%>
		</textarea>
	
	<div align="right">
	<input type="button" style="border: outset; background-color: #C6DEFF;width: 165px;" onclick="convert_amount_into_rupees_paisa();"	name="Calculate" value="Calculate Amount" />
	</div>
	 
	
	<div style="font-size: 1.0em" align="right">
	 <b>Total:</b> &nbsp;&nbsp;
	 <input type="text" readonly="readonly" name="total" id="total" style="width: 230px; border: none;" value=""/>
	</div>
	
	<div  style="font-size: 1.0em" align="right" ><table><tr><td valign="top">
		<b>Total In Words : </b></td><td>
		<textarea readonly="readonly" name="rupees" id="rupees"   style="width: 230px; border: none;" ></textarea>
		</td></tr></table>
	</div>
	
	<div align="right"  >
		<input type="submit"  
	value="Save sales Quotation" style="border: outset; background-copurchalor: #C6DEFF; width: 165p" onclick="insertquo.jsp" />
	</div>
	
	<input type="hidden" name="termsconditions" value="termsconditions">
</form>
	<br><br><br><br><br><br><br><br>        
	<br><br><br>
	
	<!-- end #footer -->
	</body>
	</html>
</jsp:useBean>
<%@include file="footer_new.jsp"%>