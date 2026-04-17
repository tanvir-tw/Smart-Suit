<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%-- <%@ include file="conn.jsp"%> --%>
<%@ include file="header.jsp"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.*"%>
<%@page import="java.text.*"%> 
<%@page import="java.util.TimeZone"%>

<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<style type="text/css">
    @import url(jscalendar-1.0/calendar-win2k-1.css);
    </style>
	<style>
    </style>
	
	<script src="sorttable.js" type="text/javascript"></script>
	
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title>Transworld Technologies LTD, ERP</title>
	<link href="css/style.css" rel="stylesheet" type="text/css"
		media="screen" />
	<link href="css/table.css" rel="stylesheet" type="text/css"
		media="screen" />
		<link href="css/footer.css" rel="stylesheet" type="text/css"
		media="screen" />
		<link href="css/style2.css" rel="stylesheet" type="text/css"
		media="screen" />
	<style type="text/css">
    </style>
	
	<link rel="stylesheet" type="text/css" href="css/chromestyle2.css" />
	
	<script type="text/javascript" src="css/chrome.js">
	</script>	
	
		
	
	<script language="javascript">
	function kk(){
		var v=document.getElementById("wysiwyg").value;
		alert(v);
	}
	function validrs(){ 

		var cancel=document.getElementById("reasoncancel").value;
		if(cancel=="")
			{
			alert("Please Insert Reason First");
			return false;
			}
		}
	
	function popUp(webadd,trancactionId,company)
	{ 
			window.open(webadd+'?company='+company+'&transactionId='+trancactionId,'jav','width=870,height=500,top=150,left=250,resizable=no');
	}

	
	
	
	function closeQuotation()
	{
		var agree=confirm("Are you sure you want to close this Quotation?");
		if (agree)
		{
		document.getElementById("header").style.visibility="visible";
		document.getElementById("cancellingreason").style.visibility="visible";
		document.getElementById("submitbutton").style.visibility="visible";
		
		return true ;
		}
		else return false;
	}

	function calculate()
	{	
		alert("HTTT  ");
		var a;var k=0;
		var rowCount = document.getElementById("checkedNumber").value;
		//var rowCount = document.generatequo.checkedNumber.value; 
		//alert(rowCount);
		for(k=0;k<rowCount;k++)
		{
			var tax=document.getElementById("stpercent"+k).value;//alert(tax);
			var discount=document.getElementById("discount"+k).value;//alert(discount);
			var qua=document.getElementById("quantity"+k).value;//alert(qua);
			var unitprice=document.getElementById("sellingPrice"+k).value;//alert(unitprice);
			
			//var tax1=(tax)/100*unitprice*qua;
			//var discount1=(discount)/100*unitprice*qua;
			//a=unitprice*qua+tax1-discount1;//alert(a);
			
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
			//alert("valll==>"+bb);
			a++;
			a--;
			alert("val of kkkkkkkkkkkkkkkkk AMOUNT"+k+" total amount==>"+bb.toFixed(2));
			document.getElementById("amount"+k).value=bb.toFixed(2);
		}
		//alert("Outside for");	
		//	var rowCount = document.getElementById("count").value;
		var rowCount = document.getElementById("checkedNumber").value; 
			var z; 
			var i;
			var total;
			var s=0;
			
			for(i=0;i<rowCount;i++)
			{
				//alert("Inside Addition");
				var z=(document.getElementById("amount"+i).value);
				//alert("val of amt=====>"+z);
				s=parseFloat(s)+parseFloat(z);
				
				//alert("after round of"+s);
			}
			var s1=s;
			//alert("after round of"+s);
			document.getElementById('total').value=parseInt(s1);
			
		    var junkVal=document.getElementById('total').value;
		    junkVal=Math.floor(junkVal);
		    var obStr=new String(junkVal);
		    numReversed=obStr.split("");
		    actnumber=numReversed.reverse();

		    if(Number(junkVal) >=0){
		        //do nothing
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
		    document.getElementById('rupees').value=finalWord;
		    
	}
	
	function redirect(webadd,salesQuotation)
	{
		//alert("IN FUNCYION  ");
		window.open(webadd+'?salesQuotation='+salesQuotation,'jav');
	}

	function redirectforpdf(webadd,salesQuotation)
	{
		window.open(webadd+'?salesQuotation='+salesQuotation,'jav');
	}
	function redirectforMail(webadd,salesQuotation)
	{
		try{
			var v1=document.getElementById("emailTo").value;
			var v=document.getElementById("extraemail").value;
			//alert(v);
			var data=document.getElementById("wysiwyg").value;
			//alert(data);
			var page=document.getElementById("pagename").value;
			//alert(page);
			var report=document.getElementById("reportnumber").value;
			//alert(report);
			var find = '"';
// 			var re = new RegExp(find, 'g');
// 			data = data.replace(re, '^');
 			//data="<font size=^2^ face=^Arial^>"+data+"</font>";
			
			
// 			data = data.replace(/"/g, "^");
// 			data = data.replace(/#/g, "");
// 			data = data.replace(/&amp;/g, "_and_");
// 			data = data.replace(/%/g, "__per__");
// 			data = data.replace(/'/g, "_1_");


				data = data.replace(/"/g, "__12__");
				data = data.replace(/#/g, "_123A_");
				data = data.replace(/&amp;/g, "_and_");
				data = data.replace(/%/g, "__per__");
				data = data.replace(/'/g, "_1_");
				data = data.replace(/&lt;/g, "_ll_");
				data = data.replace(/&gt;/g, "_rr_");
				
				
				
			//	alert("1");
				data = data.replace(/\+/g, "_plus_");
				
				//alert(v);
				//alert(data);
				//data = data.replace("^", "123");
				
				 //$(data).replaceAll("p");
				var data = data.replace(/\^/g, "_1k_");
				var data = data.replace(/&nbsp;/g, " ");
				//alert(data);


			
			//alert(v);
			//alert(data);
			var emailTotal=v+","+v1;
			if(v==""){
				window.open(webadd+'?salesQuotation='+salesQuotation+"&data="+data+"&reportnumber="+report+"&pagename="+page,"Mail Sending","height=200px,width=400px").document.body.innerHTML="Sending Mail...!";		
			}else{
				window.open(webadd+'?salesQuotation='+salesQuotation+"&email="+emailTotal+"&data="+data+"&reportnumber="+report+"&pagename="+page,"Mail Sending","height=200px,width=400px").document.body.innerHTML="Sending Mail...!";
			}
		}catch(Exception){alert("Something went Worng")}
	}
	
	
	</script>
	
	<link rel="stylesheet" href="js/jquery.wysiwyg.css" type="text/css" />
	

<script type="text/javascript" src="js/jquery.wysiwyg.js"></script>

<script type="text/javascript" src="js/wysiwyg.colorpicker.js"></script>


<script type="text/javascript" src="js/jquery.autoload.js"></script>


<link rel="stylesheet" href="js/farbtastic.css" type="text/css"/>

<link rel="stylesheet" href="js/jquery.wysiwyg.modal.css" type="text/css"/>

	<script type="text/javascript" src="js/wysiwyg.table.js"></script>




<script type="text/javascript">
// $(function()
// {
// $('#wysiwyg').wysiwyg();
// });

(function($) {
	$(document).ready(function() {
		$('#wysiwyg').wysiwyg({
		  
			plugins: {
				autoload: true,
				i18n: { lang: "en" },
				rmFormat: { rmMsWordMarkup: true }
			},
			controls: {
			  
			  html: {visible: true},
				colorpicker: {
					groupIndex: 11,
					visible: true,
					css: {
						"color": function (cssValue, Wysiwyg) {
							var document = Wysiwyg.innerDocument(),
								defaultTextareaColor = $(document.body).css("color");

							if (cssValue !== defaultTextareaColor) {
								return true;
							}

							return false;
						}
					},
					exec: function() {
						if ($.wysiwyg.controls.colorpicker) {
							$.wysiwyg.controls.colorpicker.init(this);
						}
					},
					tooltip: "pick color."
				},  
			  
			bold          : { visible : true },
			italic        : { visible : true },
			underline     : { visible : true },
			strikeThrough : { visible : true },
			
			justifyLeft   : { visible : true },
			justifyCenter : { visible : true },
			justifyRight  : { visible : true },
			justifyFull   : { visible : true },

			indent  : { visible : true },
			outdent : { visible : true },

			subscript   : { visible : true },
			superscript : { visible : true },
			
			undo : { visible : true },
			redo : { visible : true },
			
			insertOrderedList    : { visible : true },
			insertUnorderedList  : { visible : true },
			insertHorizontalRule : { visible : true },
			insertTable : { visible : false },
			insertImage : { visible : false },
			
			
			
			
			h4: {
				visible: false,
				className: 'h4',
				command: ($.browser.msie || $.browser.safari) ? 'formatBlock' : 'heading',
				arguments: ($.browser.msie || $.browser.safari) ? '<h4>' : 'h4',
				tags: ['h4'],
				tooltip: 'Header 4'
			},
			h5: {
				visible: false,
				className: 'h5',
				command: ($.browser.msie || $.browser.safari) ? 'formatBlock' : 'heading',
				arguments: ($.browser.msie || $.browser.safari) ? '<h5>' : 'h5',
				tags: ['h5'],
				tooltip: 'Header 5'
			},
			h6: {
				visible: false,
				className: 'h6',
				command: ($.browser.msie || $.browser.safari) ? 'formatBlock' : 'heading',
				arguments: ($.browser.msie || $.browser.safari) ? '<h6>' : 'h6',
				tags: ['h6'],
				tooltip: 'Header 6'
			},
			h1: {
				visible: false,
				className: 'h1',
				command: ($.browser.msie || $.browser.safari) ? 'formatBlock' : 'heading',
				arguments: ($.browser.msie || $.browser.safari) ? '<h1>' : 'h1',
				tags: ['h1'],
				tooltip: 'Header 1'
			},
			h2: {
				visible: false,
				className: 'h2',
				command: ($.browser.msie || $.browser.safari) ? 'formatBlock' : 'heading',
				arguments: ($.browser.msie || $.browser.safari) ? '<h2>' : 'h2',
				tags: ['h2'],
				tooltip: 'Header 2'
			},
			h3: {
				visible: false,
				className: 'h3',
				command: ($.browser.msie || $.browser.safari) ? 'formatBlock' : 'heading',
				arguments: ($.browser.msie || $.browser.safari) ? '<h3>' : 'h3',
				tags: ['h3'],
				tooltip: 'Header 3'
			},
			
			cut   : { visible : true },
			copy  : { visible : true },
			paste : { visible : false },
			html  : { visible: true },
			increaseFontSize : { visible : true },
			decreaseFontSize : { visible : true },
			exam_html: {
				exec: function() {
					this.insertHtml('<abbr title="exam">Jam</abbr>');
					return true;
				},
				visible: false
			}
		  },
		  events: {
			click: function(event) {
				if ($("#click-inform:checked").length > 0) {
					event.preventDefault();
					alert("You have clicked jWysiwyg content!");
				}
			}
		  }
		});

		$('#wysiwyg').wysiwyg("insertHtml", "");
	});
})(jQuery);


</script>
	
	</head>
	<body>
	
<%
	erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
%>

	
<%

	if(null!=request.getParameter("inserted")){
		%>
		<script language="javascript">
			alert('Quotaion saved successfully in System with ID <%=request.getParameter("salesQuotation")%>');
		</script>
	
		<%
	}

	Connection conn = null;
	Connection conn1 = null;
	Statement st = null, st1 = null,st2=null,st3=null,st4=null,stlbl=null;
	
	int groupCode=0;
	int d=0,k=0;
	
	int i=0;
	String groupName="",makeName="",itemCode="",makeCode="";
	String EmpName="",MobNo="",Sign="",Email1="";
	String refMakeNameTable="";
	String sqlDisplayDesc=" ",totalAmount="",totalAmountInWords="",termsconditions="",status="",statusTD="",statusData="";
	String salesEnqNumber="",salesenqno="",salesquorefno="";
	String customercode="",fromdate="",TermsAndConditions = "";
	double tax=0,discount=0.00 ,total=0.00;
	double stpercent=0,amount=0,sellingPrice=0;
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat("HH:mm:ss").format(new java.util.Date());
	
	Date today = new Date();
	String fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(today);
	
	String type=request.getParameter("condition");
	System.out.println(">>>>>>>>>>>>>>>"+type);
	NumberFormat nf = new DecimalFormat("#0.00");
	String salesQuotaion=request.getParameter("salesQuotation");
	
	System.out.println("IN THE VIEW PAGE    "+salesQuotaion);
	try {
	conn = erp.ReturnConnection();
	conn1=erp.ReturnConnection();
	st = conn.createStatement();
	st2 = conn.createStatement();
	st1 = conn.createStatement();
	st3 = conn.createStatement();
	st4 = conn.createStatement();
	stlbl = conn.createStatement();
	} catch (Exception e) {
		e.printStackTrace();
	}

	String msgmsg="";
	try{
		
		msgmsg=request.getParameter("msg");
		if(msgmsg!=null){
			//out.println(msgmsg);
		out.println("<script>alert('"+msgmsg+"')</script>");
		}
		}catch(Exception e){
		}
	
int ThisIsSalesOrder=0;
	String sqlRef="select ThisIsSalesOrder from " +session.getAttribute("CompanyMasterID").toString()+"salesquo_det where SalesQuoNo='"+salesQuotaion+"' ";
	System.out.println("sqlRef  "+sqlRef);
	Statement strno11=conn1.createStatement();
	ResultSet rsreport11 = strno11.executeQuery(sqlRef);
	if(rsreport11.next())
	{
		ThisIsSalesOrder = rsreport11.getInt("ThisIsSalesOrder");
		System.out.println("ThisIsSalesOrder "+ThisIsSalesOrder);

	}
	
/* 	if(ThisIsSalesOrder==1)
	{
		out.println("<script>  Redirect1();</script>");		

		System.out.println("ThisIsSalesOrder "+ThisIsSalesOrder);

	} */
	
	%>
				<input type="hidden" name="ThisIsSalesOrder"  id="ThisIsSalesOrder" value="<%=ThisIsSalesOrder%>"></input>
				
				
	
	<%
	
	String PageName1=this.getClass().getName();
	String reportno1 = "";
	String reportname1 = "";
	PageName1=PageName1.substring(PageName1.lastIndexOf(".")+1,PageName1.length());
	System.out.println(PageName1);
	PageName1=PageName1.replace("_",".");
	PageName1=PageName1.replace(".005f","_");
	PageName1 = PageName1.replace(".0020"," ");
	System.out.println("PageName   "+PageName1);
	String sqlreport1 = "select ReportNo,ReportName from t_reportnumber where PageName = '"+PageName1+"'";
	Statement strno1=conn1.createStatement();
	ResultSet rsreport1 = strno1.executeQuery(sqlreport1);
	if(rsreport1.next())
	{
		reportno1 = rsreport1.getString("ReportNo");
		reportname1= rsreport1.getString("ReportName");
	}
	System.out.println(reportno1);
	
	String SqlQuotaionDet="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det WHERE SalesQuoNo='"+salesQuotaion+"' ";
	System.out.println(">>>>>>>>>>>      "+SqlQuotaionDet);
	ResultSet rsQuotaionDet=st4.executeQuery(SqlQuotaionDet);
	System.out.println(">>>>61>");
	if(type.equals("View")) { 
		String emailTo="";
		String CcMail="",companyname="",Website="",html="";
		
		Statement st_email=conn.createStatement();
		Statement st_email1=conn.createStatement();
		Statement st_email2=conn.createStatement();
		Statement stEmailDetails=conn.createStatement();
				ResultSet rs_email=null;
				ResultSet rs_email1=null,rs_email2=null;
				ResultSet rs=null;
		System.out.println(">>>>1>");
		
		if(rsQuotaionDet.next()){
			totalAmount=rsQuotaionDet.getString("Total");
			totalAmountInWords=rsQuotaionDet.getString("TotalinWords");
			termsconditions=rsQuotaionDet.getString("termsandconditions");
			customercode=rsQuotaionDet.getString("CustomerCode");
			salesenqno=rsQuotaionDet.getString("SalesEnqNo"); 
			salesquorefno=rsQuotaionDet.getString("SalesquoRefNo");
			TermsAndConditions=rsQuotaionDet.getString("TermsAndConditions");
				
			
			//select * from db_GlobalERP.100015prospectivecustmaster where CustomerCode='1491'------CompanyName
			String sql_email="select * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CompanyName like '%"+rsQuotaionDet.getString("CompanyName")+"%' ";
			rs_email=st_email.executeQuery(sql_email);
			
			while(rs_email.next()){
				emailTo=rs_email.getString("EMail");
			}
			%>
			<input type="hidden" name="ToMail"  id="ToMail" value="<%=emailTo%>"></input>
			<% 
			String sql_email1="select * from db_GlobalERP.CompanyMaster where  companymid='"+session.getAttribute("CompanyMasterID").toString()+"'";
				rs_email1=st_email1.executeQuery(sql_email1);
				
				while(rs_email1.next()){
					//CcMail=rs_email1.getString("AlertMailId");
					companyname=rs_email1.getString("Companyname");
					Website=rs_email1.getString("Website");
				} 
				
				String sql_email12="select * from db_GlobalERP.UserMaster  where Empcode='"+session.getAttribute("EmpCode").toString()+"'";
				rs_email2=st_email2.executeQuery(sql_email12);
				
				while(rs_email2.next())
				{
					CcMail=rs_email2.getString("email");
					EmpName=rs_email2.getString("EmpName");
					MobNo=rs_email2.getString("mobileno");
					//Sign=rs_email2.getString("Signature");
					Email1=rs_email2.getString("email");
				
				} 
				
				%>
				<input type="hidden" name="CcMail1"  id="CcMail1" value="<%=CcMail%>"></input>
				<% 
				//String CcMail1[]=CcMail.split(",");
				//String CcMail123=CcMail1.toString();
				//out.println("CCmail-------------"+CcMail);
%>

<!-- 	<div align="center" -->
<!-- 		style="font-size: 1.5em; margin-top: 0.3em;   height: 3px; background-color: #339CCB"> -->
<!-- 	</div> -->
	<%
	
	
	
		if(null!=request.getParameter("inserted")){
		%>
	<div  style="position: absolute; margin-top: 1em; left: 0.7em; ">
		<a href="#" onclick="window.location='orderdet.jsp?CompanyName=<%=rsQuotaionDet.getString("CompanyName") %>&SalesQuoRefNo=<%=rsQuotaionDet.getString("SalesQuoRefNo") %>&SalesQuoNo=<%=rsQuotaionDet.getString("SalesQuoNo") %>'" style="border: outset;  
				 ">
			<b><font color="black">GENERATE ORDER</font></b>
		</a>
	</div>
	<%} %>
	
	
	<div align="center" style="margin-top:0.3em;  margin-bottom:0.3em; font-size: 1.5em;">
	 Sales Quotation :<a><%=rsQuotaionDet.getString("SalesquoRefNo") %></a>
	 </div>
	 <div align="right" style="margin-bottom: 0.3em; font-weight: bold; margin-top: -2em;margin-right: 110px;">
	 <a href="#" onclick="redirect('printsalesquotation.jsp','<%=salesQuotaion %>');"  >Print</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="#" href="#" onclick="redirectforpdf('pdf_salesquotation.jsp','<%=salesQuotaion %>');"  >PDF</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<%--  <a href="#" onclick="redirectforMail('pdf_salesquotationMail.jsp','<%=salesQuotaion %>');"  />Additional Email Id<input type="text" value="" id="extraemail" name="extraemail" /><font color='red' style='font-size:10px;'>(seperated by comma (,))</font><br> --%>
 	<%-- <a href="#" onclick="redirectforMail('pdf_salesquotationMail.jsp','<%=salesQuotaion %>');"  >Email --%>
	 
	 </div><br>
<!-- 		<div align="center"	style="font-size: 1.5em; margin-top: 0.3em; margin-bottom:0.3em;  height: 3px; background-color: #339CCB"> -->
<!-- 	</div> -->
	
<%
			
			rs=st3.executeQuery("SELECT TheGroupName from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"+rsQuotaionDet.getString("TheGroup")+"'");
			if(rs.next())
				groupName=rs.getString(1);
			
			rs=st3.executeQuery("SELECT SalesEnqRefNo FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det where SalesEnqNo="+rsQuotaionDet.getString("SalesEnqNo")+" ");
			if(rs.next())
				salesEnqNumber=rs.getString(1);
			
			if(rsQuotaionDet.getInt("InvoiceGenerated")==1)
			{
				status="Invoice Generated";	statusTD="Invoice ID :"; 
			}
			else if(rsQuotaionDet.getInt("ThisIsSalesOrder")==1)
			{
				status="Order Generated"; statusTD="Sales Order ID :";
			}
			else if(rsQuotaionDet.getInt("SalesQuoCancelled")==1)
			{
				status="Cancelled"; statusTD="Reason For Cancelling :";
			}
			else{
				status="Pending"; statusTD="";
			}
			System.out.println(">>>>>");
			
	%>
		
				<form name="geneOrder" method="post" action="orderdet.jsp" onSubmit="return fun();" >
				
				<% String CustomerName=rsQuotaionDet.getString("CompanyName");
				System.out.println(">>1111111111111111111>>>"+CustomerName);


%>
									<input type="hidden" name="CompanyName" id="CompanyName" value="<%=CustomerName%>"></input>

					<input type="hidden" name="pagename" id="pagename" value="<%=reportname1%>"></input>
<input type="hidden" name="reportnumber" id="reportnumber" value="<%=reportno1%>"></input>
 <%-- <input type="hidden" name="CcMail2"  id="CcMail2" value="<%=emailTo%>"></input> --%>
<input type="hidden" name="extraemail"  id="extraemail" value="<%=CcMail%>"></input> 
<input type="hidden" name="quonum"  id="email" value="<%=request.getParameter("salesQuotation")%>"></input>
	<input type="hidden" name="SalesQuoNo" id="SalesQuoNo" value="<%=salesQuotaion%>"></input>
									<input type="hidden" name="SalesQuoRefNo" id="SalesQuoRefNo" value="<%=salesquorefno%>"></input>
								
							<%
								System.out.println(">>>>>"+salesQuotaion);
								System.out.println(">>>>>"+salesquorefno);

								%>
	
	<table  align="left" valign="top" width="100%">
	<tr></tr>
	<tr>
	<td style="width: 100%">
		<table border="0" align="left" valign="top" width="100%" >
		<tr>
			<td><b>Company:</b></td>
			<td><%=rsQuotaionDet.getString("CompanyName") %> <input type="hidden" name="salesQuotation" value="<%=salesQuotaion %>" /></td>
<!-- 			<td><b>Customer RefNo:</b></td> -->
<%-- 			<td><%=rsQuotaionDet.getString("CustRefNo") %></td> --%>
			<td><b>Sign:</b></td>
			<td><%=rsQuotaionDet.getString("TWEmpName") %></td>
<!-- 		</tr> -->
<!-- 		<tr> -->
			<td><b>Ref NO:</b></td> 
			<td><%=rsQuotaionDet.getString("TWSalesRefNo") %></td>
			<td><b>SE ID:</b></td>
			<td><%=salesEnqNumber%>
		</tr>
		<tr>
		<%
		String SalesQuoTime=rsQuotaionDet.getString("SalesQuoTime");
		String Signature="";
		String inputDate = SalesQuoTime;
		String[] split = inputDate.split(":");
		int hours = Integer.valueOf(split[0]);
		int minutes = Integer.valueOf(split[1]);
		SalesQuoTime=hours+":"+minutes;
		String date1=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsQuotaionDet.getString("SalesQuoDate")));
		String date111=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsQuotaionDet.getString("SQValidityPeriod")));

		
		%>
		<input type="hidden" name="date111" id="date111" value="<%=date111%>"></input>
		
		<td><b>Quotation Date:</b></td>
		<td><%=date1 +" "+SalesQuoTime%></td>
		<td><b>Expiry date:</b></td>
		<td><input type="text" id="todate" onmousedown="unCheckAll()"
		name="todate" value="<%=date111%>" size="10"
		readonly="readonly"
		style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
	 	</td>

			<td><b><font color='red' style='font-size:10px;'>*</font>To Email:</b></td> 		          
			
		<td>
		
		
		 <textarea id="CcMail2" name="CcMail2" class="element textarea medium" onblur="return myemail();" ><%=emailTo %> </textarea>
		 <%-- <textarea name="Mail" id="Mail" class="element textarea medium" onblur="return myemail();" style='width:px; height: px;' ><%=emailTo %>
		</textarea> --%> 
		<input type="hidden" name="CcMail2"  id="CcMail2" value="<%=emailTo%>"></input>
		<font color='red' style='font-size:10px;'>(separated by comma (,))
		
		<div>
<label  id="email3" style="display: none;"><font color='red' style='font-size:10px;'>Please Enter Correct Value </font></label> 
 
 
</div>
		</td>
		<%-- <input type="text" value="<%=emailTo %>" id="emailTo1" name="emailTo1" /></td> --%>
		<td><b><font color='red' style='font-size:10px;'>*</font>Cc Email:</b></td>
		
		<td>
		<textarea id="CcMail1" name="CcMail1" class="element textarea medium" onblur="return myemail1();" ><%=CcMail %> </textarea>
		<%-- <textarea name="emailTo2" id="emailTo2" style='width: 235px; height: auto;' ><%=CcMail %>
		</textarea> --%>
		<input type="hidden" name="CcMail1"  id="CcMail1" value="<%=CcMail%>"></input>
		<font color='red' style='font-size:10px;'>(separated by comma (,))
		<div>
<label  id="email4" style="display: none;"><font color='red' style='font-size:10px;'>Please Enter Correct Value </font></label> 
 
 
</div>
		</td>
		</tr>
		<!--  	<tr>
				<td><b>< %=sta tusTD %></b></td>
				<td colspan="3">< %=statusData %></td>
			</tr>
			 -->
	</table>
	</td>
<tr>	<td>	

<%
		try
		{
			
			String companyMaster=session.getAttribute("CompanyMasterID").toString();
			String getEmailDetails="select * from db_GlobalERP.ComapnayIntroMaster where CompanyId='"+companyMaster+"'";
			rs=stEmailDetails.executeQuery(getEmailDetails);
			
			while(rs.next())
			{
				 Signature=rs.getString("MailBodyDesc");
			}
			
		}catch(Exception e)
		{
			System.out.println("Exception "+e.getMessage());
		}


%>


<%
String a="To,";

String msg="Please Find Attachment as Quotation From "+companyname;
String html2="";
String html1 ="<html><div width = ^100%^><font size = ^3^ face = ^Arial^>"+a+"</font><body><table border=^18^  bordercolor=^#E6E6FA^ align=^center^ width=^60%^><div width = ^100%^><font size = ^3^ face = ^Arial^>"+"\n "+CustomerName+"</font><br><div width = ^100%^><font size = ^3^ face = ^Arial^>"+"\n Kind Attn: </font><br><div width = ^100%^><font size = ^3^ face = ^Arial^><br>"+"\n Dear Sir,</font><br><div width = ^100%^><font size = ^3^ face = ^Arial^>"+"\n "+msg+"</font><br><div width = ^100%^><font size = ^3^ face = ^Arial^><br>"+"\n Thanks and Regards,</font><div width = ^100%^><font size = ^3^ face = ^Arial^>"+"\n "+EmpName+"</font><div width = ^100%^><font size = ^3^ face = ^Arial^>"+"\n "+MobNo+"</font><div width = ^100%^><font size = ^3^ face = ^Arial^>"+"\n "+Email1+"</font><div width = ^100%^><font size = ^3^ face = ^Arial^>"+"\n "+companyname+"</font></table><div width = ^100%^><font size = ^3^ face = ^Arial^><u><a href=http://"+Website+"></u>"+Website+"</a></b></font></html>";
//html ="<html><head></head><div width = ^100%^><font size = ^3^ face = ^Arial^>"+"\n "+a+"</font><body><table border=^18^  bordercolor=^#E6E6FA^ align=^center^ width=^60%^><div width = ^100%^><font size = ^3^ face = ^Arial^>"+"\n "+CustomerName+"</font><br><div width = ^100%^><font size = ^3^ face = ^Arial^>"+"\n Kind Attn:</font><br><div width = ^100%^><font size = ^3^ face = ^Arial^><br>"+"\n Dear Sir,</font><br><font size = ^3^ face = ^Arial^>"+"\n "+Signature+"</font><br><div width = ^100%^><font size = ^3^ face = ^Arial^><br>"+"\n Thanks and Regards,</font><div width = ^100%^><font size = ^3^ face = ^Arial^>"+"\n "+companyname+"</font></table><div width = ^100%^><font size = ^3^ face = ^Arial^><u><a href=http://"+Website+"></u>"+Website+"</a></b></font><table>";
		%>
<div style="width: 700px;font-size:6px;">

<textarea name="data" id="wysiwyg" cols="100" rows="10" >
 <%=html1 %>
</textarea>
</div>	
<br>
<br>
<%-- <div style="width: 700px;font-size:6px;">

<!-- <textarea name="data" id="wysiwyg1" cols="100" rows="10" maxlength="5000" >
 -->&nbsp;&nbsp;&nbsp;&nbsp;<textarea name="data" id="wysiwyg1" rows="10" cols="100" maxlength="500000000" >
 <%=html2 %>

</textarea>
</div> --%>	

		 <%} %>
		 <font color="red">*Only standard key-board characters are allowed</font>
		 <input style="margin-left: 392px;" type="submit" value="Email"/>	
		 
		 
	</td></tr></tr><tr><td>&nbsp;</td></tr></table>

<div style="font-size:16px; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;">
		  											 <input type="submit"  name="submitOrder"
	value="Generate Order" style="border: outset; background-color: #C6DEFF; width: 150px; " />
 
								</div>

		 
<!-- 	<div align="right"  >
 -->		
<!-- 	</div>					
 -->
</form>
<div>&nbsp;&nbsp;</div>


	<table class="sortable" style="margin-top: -1;">
	<tr>
	<th>Sr No</th>
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
	</tr>
<% 
 	
	i=0;
	 		
	String sqlQuoItems="SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items WHERE SalesQuoNo='"+salesQuotaion+"'";
	ResultSet rsQuoItems=st1.executeQuery(sqlQuoItems);
	i=1;
		while(rsQuoItems.next())
		{
			groupName="";makeName="";refMakeNameTable="";
			groupCode=rsQuoItems.getInt("TheGroup");
			makeCode=rsQuoItems.getString("Make");
			itemCode=rsQuoItems.getString("ItemCode");
			  
			String  sqlGroup="SELECT TheGroupName from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"+groupCode+"'";
			ResultSet rsGroup=st2.executeQuery(sqlGroup);
			if(rsGroup.next())
			groupName=rsGroup.getString("TheGroupName");
			if(groupCode<5)
			{
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
		
			ResultSet rsDisplayDesc=st3.executeQuery(sqlDisplayDesc);
			
			if(rsDisplayDesc.next())
			{
				//makeName=rsDisplayDesc.getString("MakeName");
		    %>
		    <tr>
			    <td><%=i++ %></td>
			    <td><div align="left"><%=makeName %></div></td>
			    <td><div align="left"><%=rsDisplayDesc.getString("Model") %></div></td>
			    <td><div align="left"><%=rsDisplayDesc.getString("Partno") %></div></td>
		   	    <td><div align="left"><%=rsDisplayDesc.getString("Description") %></div></td>
			    <td><div align="right"><%=rsQuoItems.getString("Quantity") %></div></td>
			    <td><div align="right"><%=rsQuoItems.getString("SellingPrice") %></div></td>
			    <td><div align="right"><%=rsQuoItems.getString("DiscountPercent") %></div></td>
			    <td><div align="right"><%=rsQuoItems.getString("STPercent") %></div></td>
			    <% double sp=rsQuoItems.getDouble("SellingPrice");
				      double dp=rsQuoItems.getDouble("DiscountPercent");
				      double stper=rsQuoItems.getDouble("STPercent");
				      double qty=rsQuoItems.getInt("Quantity");
				      double disval=(sp-((dp/100)*sp));
				      System.out.println("disc value-->"+disval);
				      double tot=((sp-((dp/100)*sp))+((stper/100)*disval))*qty;
				      System.out.println("(("+sp+"-(("+dp+"/100)*"+sp+"))+(("+stper+"/100)*"+sp+"))*"+qty+"====>"+tot);
				    
				    %>
			    <td><div align="right"><%=nf.format(tot)%></td>
		    </tr>
		    <% 
		   }
			
		   }
%>
	</table>
	<br>
			<div align="left"   style="position:absolute;   font-size: 1.1em"><b> &nbsp;TERMS & CONDITIONS :</b></div>
		<div align="left"   style="position:absolute; margin-top: 1em; font-size: 1.1em"> &nbsp;<textarea readonly="readonly" name="termsconditions"
	id="search-text" style='border:none; width: 430px; height: 150px;'><%=termsconditions %></textarea></div>
	
	<div style="font-size: 1.0em" align="right">
	 <b>Total:</b> &nbsp;&nbsp;<input type="text" readonly="readonly" name="total" id="total" style="width: 230px; border: none;" value="<%=totalAmount%>"/>
	</div>
	
	<div style="font-size: 1.0em" align="right" ><table border="0"><tr><td valign="top">
		<b>Total In Words : </b></td><td>
		<textarea readonly="readonly" name="rupees" id="rupees"   style="width: 230px; border: none;" ><%=totalAmountInWords %></textarea>
		</td></tr></table>
	</div>
	
	<br>
<!-- <div align="center" id="printbutton" style="margin-top: 3em;"> -->
<%-- 	<input type="submit" name="printquotation" value="Print" onclick="redirect('printsalesquotation.jsp','<%=salesQuotaion %>');"  style="border: outset; background-color: #C6DEFF"  /> --%>
<!-- </div>	 -->


<!-- <div align="center" id="pdfbutton" style="margin-top: 3em;"> -->
<%-- 	<input type="submit" name="pdfquotation" value="PDF" onclick="redirectforpdf('pdf_salesquotation.jsp','<%=salesQuotaion %>');"  style="border: outset; background-color: #C6DEFF"  /></div> --%>
	
<!-- <div align="center" id="pdfbutton" style="margin-top: 3em;margin-left: 34%;"> -->
<%-- <input type="submit" name="pdfquotation" value="Email" onclick="redirectforMail('pdf_salesquotationMail.jsp','<%=salesQuotaion %>');"  style="border: outset; background-color: #C6DEFF"  />Additional Email Id<input type="text" value="" id="extraemail" name="extraemail" /><font color='red' style='font-size:10px;'>(seperated by comma (,))</font><br> --%>
<!-- </div>	 -->
<% %>
<input type="hidden" name="pagename" id="pagename" value="<%=reportname1%>"></input>
<input type="hidden" name="reportnumber" id="reportnumber" value="<%=reportno1%>"></input>
<input type="hidden" name="emailTo" id="emailTo" value="<%=emailTo%>"></input>
<%
}
%>
	
<table><tr><td>&nbsp;</td></tr></table>

<div>&nbsp;&nbsp;</div>

<!-- ******************************************************************************************************************************************* -->
<!-- ********************* Start of close ********************************************************************  ************************* -->
	
	<%
	
	
	
	
	
	if(type.contains("close")) { 			
	
		if(rsQuotaionDet.next()){
			totalAmount=rsQuotaionDet.getString("Total");
			totalAmountInWords=rsQuotaionDet.getString("TotalinWords");
			termsconditions=rsQuotaionDet.getString("termsandconditions");
			customercode=rsQuotaionDet.getString("CustomerCode");
			salesenqno=rsQuotaionDet.getString("SalesEnqNo"); 
			salesquorefno=rsQuotaionDet.getString("SalesquoRefNo");
				
%>

	<div align="center"
		style="font-size: 1.5em; margin-top: 0.3em;   height: 3px; background-color: #339CCB">
	</div>
	<%
	
	
	
		if(null!=request.getParameter("inserted")){
		%>
	<div  style="position: absolute; margin-top: 1em; left: 0.7em; ">
		<a href="#" onclick="window.location='orderdet.jsp?CompanyName=<%=rsQuotaionDet.getString("CompanyName") %>&SalesQuoRefNo=<%=rsQuotaionDet.getString("SalesQuoRefNo") %>&SalesQuoNo=<%=rsQuotaionDet.getString("SalesQuoNo") %>'" style="border: outset;  
				 ">
			<b><font color="black">GENERATE ORDER</font></b>
		</a>
	</div>
	<%} %>
	
	
	<div align="center" style="margin-top:0.3em;  margin-bottom:0.3em; font-size: 1.5em;"> Sales Quotation :<a><%=rsQuotaionDet.getString("SalesquoRefNo") %></a></div>
		<div align="center"
		style="font-size: 1.5em; margin-top: 0.3em; margin-bottom:0.3em;  height: 3px; background-color: #339CCB">
	</div>
	
<%
			
			ResultSet rs=st3.executeQuery("SELECT TheGroupName from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"+rsQuotaionDet.getString("TheGroup")+"'");
			if(rs.next())
				groupName=rs.getString(1);
			
			rs=st3.executeQuery("SELECT SalesEnqRefNo FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det where SalesEnqNo="+rsQuotaionDet.getString("SalesEnqNo")+" ");
			if(rs.next())
				salesEnqNumber=rs.getString(1);
			
			if(rsQuotaionDet.getInt("InvoiceGenerated")==1)
			{
				status="Invoice Generated";	statusTD="Invoice ID :"; 
			}
			else if(rsQuotaionDet.getInt("ThisIsSalesOrder")==1)
			{
				status="Order Generated"; statusTD="Sales Order ID :";
			}
			else if(rsQuotaionDet.getInt("SalesQuoCancelled")==1)
			{
				status="Cancelled"; statusTD="Reason For Cancelling :";
			}
			else{
				status="Pending"; statusTD="";
			}

			
	%>
		

	<table  align="left" valign="top" width="100%">
	<tr>
	<td style="width: 45%">
		<table border="0" align="left" valign="top" width="100%" >
		
		<tr>
		<td><b>Quotation Date:</b></td>
	<td>
	 <%=rsQuotaionDet.getString("SalesQuoDate").substring(0,11) %>
	 </td>
		<td><b>Ref NO:</b></td> 
		<td><%=rsQuotaionDet.getString("TWSalesRefNo") %></td>
		</tr>
		<tr>
		<td><b>Time :</b></td>
		<td><font size="2.5"><%=rsQuotaionDet.getString("SalesQuoTime") %></font></td>
		<td><b>Expiry date:</b></td>
		 
		<td><input type="text" id="todate" onmousedown="unCheckAll()"
		name="todate" value="<%=rsQuotaionDet.getString("SQValidityPeriod").substring(0,11) %>" size="10"
		readonly="readonly"
		style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
	 	</td>
		</tr>
		<tr>
		<td><b>SE ID:</b></td>
		<td>
	<a href="#" style="font-weight: bold;" onclick="popUp('SEDetails.jsp','<%=salesEnqNumber%>','<%=rsQuotaionDet.getString("CompanyName") %>')">
 <%=salesEnqNumber %></a></td>
		<td><b>Group:</b></td>
		<td><%=groupName %></td>
		</tr>
		
		<tr>
			<td><b>Customer RefNo:</b></td>
			<td><%=rsQuotaionDet.getString("CustRefNo") %></td>
			<td><b>Sign:</b></td>
			<td><%=rsQuotaionDet.getString("TWEmpName") %></td>
			
		</tr>
		<tr>
			<td><b>Status:</b></td>
			<td><%=status %></td>
			
		</tr>
		<!--  	<tr>
				<td><b>< %=sta tusTD %></b></td>
				<td colspan="3">< %=statusData %></td>
			</tr>
			 -->
	</table>
	</td>
	<td>	
		<table bgcolor="#C6DEFF" align="right" valign="top">
		<tr>
		<td><b>Company:</b></td>
		<td><%=rsQuotaionDet.getString("CompanyName") %></td>
		
		<td><b>Contact:</b></td>
		<td><%=rsQuotaionDet.getString("ContactPerson") %></td>
		<td><b>Address:</b></td>
		<td style="width: 280px;"><%=rsQuotaionDet.getString("Address") %></td>
		</tr>
		<td>&nbsp;</td>
		<tr>
		<td><b>City:</b></td>
		<td><%=rsQuotaionDet.getString("city") %></td>
		<td><b>State:</b></td>
		<td><%=rsQuotaionDet.getString("State") %></td>
		<td><b>Country:</b></td>
		<td><%=rsQuotaionDet.getString("country") %></td>
		</tr>
		<td>&nbsp;</td>
		<tr>
		<td><b>Phone:</b></td>
		<td><div align="left"><%=((rsQuotaionDet.getString("Phone")!=null) ? rsQuotaionDet.getString("Phone") : "-") %></div></td>
		<td><b>Fax:</b></td>
		<td><div align="left"><%=((rsQuotaionDet.getString("Fax")!=null) ? rsQuotaionDet.getString("Fax") : "-") %></div></td>
		<td><b>Zip code:</b></td>
		<td><div align="left"><%=((rsQuotaionDet.getString("Zip")!=null) ? rsQuotaionDet.getString("Zip") : "-") %></div></td>
		</tr> 
		 
	<%}%>	
	</table>
		 
	</td></tr><tr><td>&nbsp;</td></tr>
</table>	
<div>&nbsp;&nbsp;</div>


	<table class="sortable">
	<tr>
	<th>Sr No</th>
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
	</tr>
<% 
 	
	i=0;
	 		
	String sqlQuoItems="SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items WHERE SalesQuoNo='"+salesQuotaion+"'";
	ResultSet rsQuoItems=st1.executeQuery(sqlQuoItems);
	i=1;
		while(rsQuoItems.next())
		{
			groupName="";makeName="";refMakeNameTable="";
			groupCode=rsQuoItems.getInt("TheGroup");
			makeCode=rsQuoItems.getString("Make");
			itemCode=rsQuoItems.getString("ItemCode");
			  
			String  sqlGroup="SELECT TheGroupName from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"+groupCode+"'";
			ResultSet rsGroup=st2.executeQuery(sqlGroup);
			if(rsGroup.next())
			groupName=rsGroup.getString("TheGroupName");
			if(groupCode<5)
			{
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
		
			ResultSet rsDisplayDesc=st3.executeQuery(sqlDisplayDesc);
			
			if(rsDisplayDesc.next())
			{
		    %>
		    <tr>
			    <td><%=i++ %></td>
			    <td><div align="left"><%=makeName %></div></td>
			    <td><%=rsDisplayDesc.getString("Model") %></td>
			    <td><%=rsDisplayDesc.getString("Partno") %></td>
		   	    <td><div align="left"><%=rsDisplayDesc.getString("Description") %></div></td>
			    <td><div align="right"><%=rsQuoItems.getString("Quantity") %></div></td>
			    <td><div align="right"><%=rsQuoItems.getString("SellingPrice") %></div></td>
			    <td><div align="right"><%=rsQuoItems.getString("DiscountPercent") %></div></td>
			    <td><div align="right"><%=rsQuoItems.getString("STPercent") %></div></td>
			    <% double sp=rsQuoItems.getDouble("SellingPrice");
				      double dp=rsQuoItems.getDouble("DiscountPercent");
				      double stper=rsQuoItems.getDouble("STPercent");
				      double qty=rsQuoItems.getInt("Quantity");
				      double disval=(sp-((dp/100)*sp));
				      System.out.println("disc value-->"+disval);
				      double tot=((sp-((dp/100)*sp))+((stper/100)*disval))*qty;
				      System.out.println("(("+sp+"-(("+dp+"/100)*"+sp+"))+(("+stper+"/100)*"+sp+"))*"+qty+"====>"+tot);
				    
				    %>
			    <td><div align="right"><%=nf.format(tot)%></td>
		    </tr>
		    <% 
		   }
			
		   }
%>
	</table>
	<br>
			<div align="left"   style="position:absolute;   font-size: 1.1em"><b> &nbsp;TERMS & CONDITIONS :</b></div>
		<div align="left"   style="position:absolute; margin-top: 1em; font-size: 1.1em"> &nbsp;<textarea readonly="readonly" name="termsconditions"
	id="search-text" style='border:none; width: 430px; height: 150px;'><%=termsconditions %></textarea></div>
	
	<div style="font-size: 1.0em" align="right">
	 <b>Total:</b> &nbsp;&nbsp;<input type="text" readonly="readonly" name="total" id="total" style="width: 230px; border: none;" value="<%=totalAmount%>"/>
	</div>
	
	<div style="font-size: 1.0em" align="right" ><table border="0"><tr><td valign="top">
		<b>Total In Words : </b></td><td>
		<textarea readonly="readonly" name="rupees" id="rupees"   style="width: 230px; border: none;" ><%=totalAmountInWords %></textarea>
		</td></tr></table>
	</div>
	
	
<div align="center" id="closebutton" style="margin-top: 3em;">
	<input type="submit" name="closeQuotation" value="close Quotation" onclick="closeQuotation();"  style="border: outset; background-color: #C6DEFF"  />
</div>	

<form name="quotation" id="quotation" method="get" action="closeQuotation.jsp">	
<div align="left"  id="header" style="position:absolute;   font-size: 1.1em"><b> &nbsp;Reason For Cancelling :</b>
	<script>document.getElementById("header").style.visibility="hidden";</script>
</div>
<div align="left"  id="cancellingreason" style="position:absolute; margin-top: 1em; font-size: 1.1em"> &nbsp;
<textarea name="reasoncancel" id="reasoncancel" style='width: 430px; height: 130px;'></textarea>
	<script>document.getElementById("cancellingreason").style.visibility="hidden";</script>
</div>

<div align="center" id="submitbutton" style="margin-top: 3em;">
	<input type="submit" name="Submit TT" value="Submit Reason" style="border: outset; background-color: #C6DEFF" onclick="return validrs();" />
	<script>document.getElementById("submitbutton").style.visibility="hidden";
	</script>
</div>

<input type="hidden" name="salesquono" value="<%=salesQuotaion %>">
<input type="hidden" name="reasonforcancel" value="reasonforcancel">
</form></br>

<%
}
%>
	
<table><tr><td>&nbsp;</td></tr></table>

<div>&nbsp;&nbsp;</div>
<%
//*****************************************   FOR REVISE ************************************************************************* 

if(type.contains("revise"))
{
System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
	
	String sqldata="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det WHERE SalesQuoNo='"+salesQuotaion+"'";
	ResultSet rsdata=st4.executeQuery(sqldata);
	if(rsdata.next())
	{	
		
		System.out.println("%66666666666666666666666666666666666%%");
%>	

	
	<div align="center" style="margin-top:0.3em;  margin-bottom:0.3em; font-size: 1.5em;"> 
		Sales Quotation :<a><%=rsdata.getString("SalesquoRefNo") %></a></div>
	<div align="center"	style="font-size: 1.5em; margin-top: 0.3em; margin-bottom:0.3em;  height: 3px; background-color: #339CCB"></div>

<form name="revicequo" method="get" action="ReviseQuotation.jsp">
 	 <table  align="left" valign="top" width="100%">
	<tr>
	<td style="width: 45%">
		<table border="0" align="left" valign="top" width="100%" >
		
		<tr>
		<td><b>Quotation Date:</b></td>
		<td><%=todaysDate %></td>
		<td><b>Quotation Time:</b></td>
		<td><%=todaysTime %></td>
		</tr>
		<tr>
		<td><b>Expiry date:</b></td>
		<td><input type="hidden" name="expirydate" value="<%=fromdate %>"/>
					 <div id="seRefNo">
					 <input type="text" id="fromdate"
						name="fromdate" value="<%=fromDateCal %>" size="15" readonly
						style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
					
			<!--<input type="button" name="From Date" value="From Date" id="trigger">-->
			<script type="text/javascript">
			  Calendar.setup(
			    {
			      inputField  : "fromdate",         // ID of the input field
			      ifFormat    : "%d-%b-%Y",     // the date format
			      button      : "fromdate"       // ID of the button
			    }
			  );
			</script></div>
		</td>
		
		
		
		<td>Group : </td>
		
		<%
		String group="";
		String sqlgroup="SELECT TheGroupName from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"+rsdata.getString("TheGroup")+"'";
		ResultSet rs=st.executeQuery(sqlgroup);
		if(rs.next())
		group=rs.getString("TheGroupName");
		System.out.println("THE GROUP  IS           "+group);
		 %>
		<td><input type="hidden" name="group" value="<%=group %>"/><%=group %></td>
		
		</tr>
	</table>
	</td>
		<td>	
		<table bgcolor="#C6DEFF" align="right" valign="top">
		<tr>
		<td><b>Company:</b></td>
		<td><input type="hidden" name="company" value="<%=rsdata.getString("CompanyName") %>"/><%=rsdata.getString("CompanyName") %></td>
		
		<td><b>Contact:</b></td>
		<td><input type="hidden" name="contactperson" value="<%=rsdata.getString("ContactPerson") %>"/><%=rsdata.getString("ContactPerson") %></td>
		<td><b>Address:</b></td>
		<td style="width: 280px;"><input type="hidden" name="address" value="<%=rsdata.getString("Address") %>"/><%=rsdata.getString("Address") %></td>
		</tr>
		<td>&nbsp;</td>
		<tr>
		<td><b>City:</b></td>
		<td><input type="hidden" name="city" value="<%=rsdata.getString("city") %>"/><%=rsdata.getString("city") %></td>
		<td><b>State:</b></td>
		<td><input type="hidden" name="state" value="<%=rsdata.getString("state") %>"/><%=rsdata.getString("State") %></td>
		<td><b>Country:</b></td>
		<td><input type="hidden" name="country" value="<%=rsdata.getString("country") %>"/><%=rsdata.getString("country") %></td>
		</tr>
		<td>&nbsp;</td>
		<tr>
		<td><b>Phone:</b></td>
		<td><input type="hidden" name="phone" value="<%=rsdata.getString("Phone") %>"/><div align="left"><%=((rsdata.getString("Phone")!=null) ? rsdata.getString("Phone") : "-") %></div></td>
		<td><b>Fax:</b></td>
		<td><input type="hidden" name="fax" value="<%=rsdata.getString("Fax") %>"/><div align="left"><%=((rsdata.getString("Fax")!=null) ? rsdata.getString("Fax") : "-") %></div></td>
		<td><b>Zip code:</b></td>
		<td><input type="hidden" name="zip" value="<%=rsdata.getString("Zip") %>"/><div align="left"><%=((rsdata.getString("Zip")!=null) ? rsdata.getString("Zip") : "-") %></div></td>
		</tr> 
		 
	<%}%>	
	</table>
		 <input type="hidden" name="custremark" value="<%=rsdata.getString("CustRemarks") %>"/>
		 <input type="hidden" name="addresscode" value="<%=rsdata.getString("AddressCode") %>"/>
		 <input type="hidden" name="salenqno" value="<%=rsdata.getString("SalesEnqNo") %>"/>
		 <input type="hidden" name="customercode" value="<%=rsdata.getString("CustomerCode") %>"/>
		 
		 		 <input type="hidden" name="salesquorefno" value="<%=rsdata.getString("salesquorefno") %>"/>
		 
		 
	</td>
	
	
	
	</tr><tr><td>&nbsp;</td></tr>
	

</table>	
<div>&nbsp;&nbsp;</div>
 	 
	
	<table border="1px" class="sortable">
	<tr>
	<th>Sr No</th>
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
	</tr>
<% 		 		
	String sqlQuoItemsForRevise="SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items WHERE SalesQuoNo='"+salesQuotaion+"'";
	ResultSet rsQuoItemsRevise=st1.executeQuery(sqlQuoItemsForRevise);
	int j=1,cnt=0;
	while(rsQuoItemsRevise.next())
	{
		System.out.println("rIN WHILE %");
			groupName="";makeName="";refMakeNameTable="";
			groupCode=rsQuoItemsRevise.getInt("TheGroup");
			makeCode=rsQuoItemsRevise.getString("Make");
			itemCode=rsQuoItemsRevise.getString("ItemCode");
			  
			String  sqlGroup="SELECT TheGroupName from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"+groupCode+"'";
			ResultSet rsGroup=st2.executeQuery(sqlGroup);
			if(rsGroup.next())
			groupName=rsGroup.getString("TheGroupName");
			if(groupCode<5)
			{
				refMakeNameTable=session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5)+"makemaster";
				String sqlMakename="SELECT MakeName FROM "+refMakeNameTable.toLowerCase()+"  WHERE makecode='"+makeCode+"' ";
				ResultSet rsMakeName=st3.executeQuery(sqlMakename);
				if(rsMakeName.next())
				makeName=rsMakeName.getString(1);
				else
				makeName="-";
				sqlDisplayDesc="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5).toLowerCase()+"im_make"+makeCode+" where ItemCode='"+itemCode+"'";
			}
			else
			{
				sqlDisplayDesc="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+groupCode+" where ItemCode='"+itemCode+"' ";
				makeName="-"  ;
			}
			ResultSet rsDisplayDesc=st3.executeQuery(sqlDisplayDesc);
			System.out.println(sqlDisplayDesc);
			if(rsDisplayDesc.next())
			{System.out.println("rIN IFF %");
			
		
%>			
			<tr>
			    <td><%=j++%></td>
			    <td><div align="left"><%=makeName %></div></td>
			   <td><%=rsDisplayDesc.getString("Model") %></td>
			    <td><%=rsDisplayDesc.getString("Partno") %></td>
		   	    <td><div align="left"><input type="hidden" name="description<%=d %>" value="<%=rsDisplayDesc.getString("Description") %>"/><%=rsDisplayDesc.getString("Description") %></div></td>
			    <td style="width: 85px;"><div align="right"><input type="text"  id="quantity<%=d %>" name="quantity<%=d %>" style="width : 70px; padding: 4px 5px 2px 5px;
	               border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	               color: #000000;" value="<%=rsQuoItemsRevise.getString("Quantity") %>" /></div></td>
			    <td style="width: 85px;"><div align="right"><input type="text"  id="sellingPrice<%=d %>" name="sellingPrice<%=d %>" style="width : 70px; padding: 4px 5px 2px 5px;
	               border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	               color: #000000;" value="<%=rsQuoItemsRevise.getString("SellingPrice") %>" /></div></td>
			    <td style="width: 85px;"><div align="right"><input type="text"  id="discount<%=d %>" name="discount<%=d %>" style="width : 70px; padding: 4px 5px 2px 5px;
	               border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	               color: #000000;" value="<%=rsQuoItemsRevise.getString("DiscountPercent") %>" /></div></td>
			    <td style="width: 85px;"><div align="right"><input type="text"  id="stpercent<%=d %>" name="stpercent<%=d %>" style="width : 70px; padding: 4px 5px 2px 5px;
	               border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	               color: #000000;" value="<%=rsQuoItemsRevise.getString("STPercent") %>" /></div></td>
			    <% double sp=rsQuoItemsRevise.getDouble("SellingPrice");
				      double dp=rsQuoItemsRevise.getDouble("DiscountPercent");
				      double stper=rsQuoItemsRevise.getDouble("STPercent");
				      double qty=rsQuoItemsRevise.getInt("Quantity");
				      double disval=(sp-((dp/100)*sp));
				      System.out.println("disc value-->"+disval);
				      double tot=((sp-((dp/100)*sp))+((stper/100)*disval))*qty;
				      System.out.println("(("+sp+"-(("+dp+"/100)*"+sp+"))+(("+stper+"/100)*"+sp+"))*"+qty+"====>"+tot);
				    
				    %>
				     <td><input type="text" id="amount<%=d%>" style="width : 70px;padding: 4px 5px 2px 5px;
	border:none; text-align:right;	background:inherit; " value="<%=nf.format(tot)%>" /></td>
			   
			    	
		    </tr>
		    <input type="hidden" name="groupcode<%=d %>" value="<%=groupCode%>"/>
			<input type="hidden" name="makecode<%=d %>" value="<%=makeCode%>"/>
			<input type="hidden" name="itemcode<%=d %>" value="<%=itemCode%>"/>
			<input type="hidden" name="stpercent<%=d %>" id="stpercent<%=d %>" value="<%=stpercent %>"/>
			<input type="hidden" name="discount<%=d %>" id="discount<%=d %>"  value="<%=discount %>"/>
			<input type="hidden" name="quantity<%=d %>" value="<%=rsQuoItemsRevise.getString("Quantity") %> "/>
			<input type="hidden" name="sellingPrice<%=d %>" value="<%=rsQuoItemsRevise.getString("SellingPrice") %> "/>
			<input type="hidden" name="description<%=d %>" value="<%=rsDisplayDesc.getString("Description") %> "/>
			<input type="hidden" name="amount<%=k %>" id="amount<%=k %>" value="<%=amount %>"/>
			<input type="hidden" name="sellingPrice<%=k %>" id="sellingPrice<%=k %>" value="<%=sellingPrice %>"/>
<%      cnt++;
		d++;
		 }  
	   }    
	int count=j-1;
	System.out.println("00000000000000");
%>	
	<%-- <tr>
    <td>
	<input type="hidden" name="amount<%=k %>" id="amount<%=k %>" value="<%=amount %>"/>
	<input type="hidden" name="sellingPrice<%=k %>" id="sellingPrice<%=k %>" value="<%=sellingPrice %>"/>
	</td>
	</tr> --%>
	
	</table>
	
	
	<input type="hidden" name="checkedNumber" id="checkedNumber" value="<%=cnt %>"/>
	<input type="hidden" name="salesenqno" value="<%=salesenqno %>"/>
	<input type="hidden" name="salesquono" value="<%=request.getParameter("salesQuotation") %>">
	<input type="hidden" id="count" name="count" value="<%=count %>"/>
	<input type="hidden" name="quodate" value="<%=todaysDate%>"/>
	<input type="hidden" name="quotime" value="<%=todaysTime %>">
	
	<br>
<div align="left"   style="position:absolute;   font-size: 1.1em"><b> &nbsp;TERMS & CONDITIONS :</b></div>
			
		<div align="left"   style="position:absolute; margin-top: 1em; font-size: 1.1em"> &nbsp;<textarea name="termsconditions"
	id="search-text" style='width: 430px; height: 160px;'><%= rsdata.getString("TermsAndConditions") %></textarea></div>
	<input type="hidden" name="termsconditions" value="<%=rsdata.getString("TermsAndConditions") %>"/>
	<div align="right">
	<input type="button" style="border: outset; background-color: #C6DEFF;width: 165px;" onclick="calculate();"	name="Calculate" value="Calculate Amount" />
	</div>
	
	<br>
	
	<div style="font-size: 1.0em" align="right">
	 <b>Total:</b> &nbsp;&nbsp;<input type="text" readonly="readonly" name="total" id="total" style="width: 230px; border: none;" value="<%=totalAmount%>"/>
	 <input type="hidden" name="total" value="<%=totalAmount %>">
	</div>
	
	<div style="font-size: 1.0em" align="right" ><table border="0"><tr><td valign="top">
		<b>Total In Words : </b></td><td>
		<textarea name="rupees" id="rupees"   style="width: 230px; border: none;" ><%=totalAmountInWords %></textarea>
		</td></tr></table>
		
	</div>
	<input type="hidden" name="rupees" value="<%=totalAmountInWords %>"/>
	
	<br>	
	<div align="center">
	<input type="submit" style="border: outset; background-color: #C6DEFF;width: 165px;"  name="ReviseQuotation" value="Revise Quotation" />
	</div>
	</form></br></div></br></br>
<%} %>
<!-- <br><br><br><br><br><br> -->
<!--     <br><br><br><br><br><br><br><br><br><br><br>  -->
<!-- 	<div id="footer"> -->
<!-- 	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009-2015 -->
<!-- 	by Transworld  Technologies Ltd. All Rights Reserved.</a></p> -->
<!-- 	</div> -->
<br><br><br><br>
	</body>
	</html>
</jsp:useBean>
<%@include file="footer_new.jsp"%>