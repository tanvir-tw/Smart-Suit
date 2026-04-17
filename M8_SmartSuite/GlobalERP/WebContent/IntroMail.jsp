<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%-- <%@ include file="conn.jsp"%> --%>
<%@ include file="header.jsp"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.*"%>
<%@page import="java.text.*"%>
<%@page import="java.util.TimeZone"%>
<%@page import="com.erp.beans.*"%> 


<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
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
			var v=document.getElementById("emailTo").value;
			alert(v);
			var data=document.getElementById("wysiwyg").value;
			data=encodeURIComponent(data);
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
			alert("----"+emailTotal);
			if(v==""){
				window.open(webadd+'?salesQuotation='+salesQuotation+"&data="+data+"&reportnumber="+report+"&pagename="+page,"Mail Sending","height=200px,width=400px").document.body.innerHTML="Sending Mail...!";		
			}else{
				window.open(webadd+'?salesQuotation='+salesQuotation+"&email="+emailTotal+"&data="+data+"&reportnumber="+report+"&pagename="+page,"Mail Sending","height=200px,width=400px").document.body.innerHTML="Sending Mail...!";
			}
		}catch(Exception){alert("Something went Worng")}
	}
	
	
	</script>
	<link rel="stylesheet" href="js/jquery.wysiwyg.css" type="text/css" />
<script type="text/javascript" src="js/jquery-1.3.2.js"></script>
<script type="text/javascript" src="js/jquery.wysiwyg.js"></script>
<script type="text/javascript" src="js/wysiwyg.colorpicker.js"></script>
<script type="text/javascript" src="js/wysiwyg.table.js"></script>


<script type="text/javascript" src="js/jquery.autoload.js"></script>
<script type="text/javascript" src="js/farbtastic.js"></script>
<link rel="stylesheet" href="js/farbtastic.css" type="text/css"/>
<link rel="stylesheet" href="js/jquery.wysiwyg.modal.css" type="text/css"/>
<script type="text/javascript" src="js/jquery.wysiwyg.js"></script>

<script type="text/javascript" src="js/wysiwyg.colorpicker.js"></script>




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
			
			cut   : { visible : false },
			copy  : { visible : false },
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


function myemail()
{
	document.getElementById("email3").style.display="none";
	var ro=document.getElementById("emailTo1").value;
	
	//var text= /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,15})+$/;

	if(ro.trim()=="")
	{
		document.getElementById("email3").style.display="";
	//alert("Please enter Email value ToId");
	return false;
	}
	
	
	/* if(!text.test(ro))
		{
		alert("Please enter EmailId In Proper Format");
		return false;
		
		} */
	
	return true;
	
}
function myemail1()
{
	
	document.getElementById("email4").style.display="none";
	var ro=document.getElementById("emailTo2").value;
	
	//var text= /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,15})+$/;
	
	if(ro.trim()=="")
		{
		document.getElementById("email4").style.display="";	
		//alert("Please enter Email value CcId");
			return false;
		}
	
	/* if(!text.test(ro))
	{
		alert("Please enter EmailId In Proper Format");
		return false;
	
	} */
	return true;
	
}
function validate()
{
	
	document.getElementById("email3").style.display="none";
var ro1=document.getElementById("emailTo1").value;
	
	//var text= /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,15})+$/;
	
	if(ro1.trim()=="")
		{	
			document.getElementById("email3").style.display="";
			//alert("Please enter Email Value For ToId");
			return false;
		}
	
	
	/* if(!text.test(ro1))
	{
		alert("Please enter EmailId In Proper Format");
		return false;
	
	} */
	document.getElementById("email4").style.display="none";
var ro=document.getElementById("emailTo2").value;
	
	//var text= /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,15})+$/;
	
	if(ro.trim()=="")
		{	
			document.getElementById("email4").style.display="";
			//alert("Please enter Email Value For CcId");
			return false;
		}
	
	/* if(!text.test(ro))
	{
		alert("Please enter EmailId In Proper Format");
		return false;
	
	} */
	return true;
	
}

function testchk(){
	var totcount="";
	
	var cntr=document.getElementById("cntr").value;
	alert("hi---"+cntr);
	
	for(var j=0;j<cntr;j++)
	{	
		if(document.getElementById("cb"+j).checked==true)
		{
        	 //url="MailIntro.jsp?&id="+document.getElementById("cb"+j).value;
			 //totcount+='cb'+[j]+',';
			 var te=document.getElementById("cb"+j).value;
			 alert("te"+te);
			 totcount+=te+',';
			 //count++;
			 alert("totcount:-"+totcount);
		}		
	}
	url="MailIntro.jsp?&id="+totcount;
	alert("url outer loop:-"+url);
	alert("totcount outer loop:-"+totcount);
	document.IntroMail.action=url+"&cntr="+cntr;
	/* var i;
	var totcountreslt=totcount.split(",");
	alert("totcountreslt:-"+totcountreslt);
	for(i=0;i< totcountreslt.length-1; i++)
		{
		alert("totcountreslt:-"+totcountreslt[i]);
		} */
}

function changeAction()
{ //alert("hi");
	var toemail=document.getElementById("emailTo1").value;
	//alert("chk1---"+toemail);
	
	var ccemail=document.getElementById("emailTo2").value;
	//alert("chk2---"+ccemail);
	var cntr=document.getElementById("cntr").value;
	//alert("hi---"+cntr);
	
	var data=document.getElementById("wysiwyg").value;
	data=encodeURIComponent(data);
	//var dt=document.getElementsByName("data12").value;
	
	//alert("dt-----"+dt);
	//var data=document.getElementById("data12").value;
	//alert("data"+data);
	var companyname=document.getElementById("CustomerNamed").value;
	companyname=companyname.replace("&","..");
	//var url="MailIntro.jsp?&cntr="+cntr;
	//cntr=cntr-1;
	//alert("hi"+cntr);
	
      	var i=0;
   	/* for(var j=0;j<cntr;j++)
    	{	
   		
   		
   		//alert("j loop");
    		//var count=0;
    		//var chk=document.getElementById("cb"+j).checked;
    		
    		if(document.getElementById("cb"+j).checked==true)
    		{
            	 url="MailIntro.jsp?&id="+document.getElementById("cb"+j).value;
				 j++;
				 count++;
				// alert("map"+url);
    		}		
    	}
   	//var cntr=document.getElementById("cntr").value;
   	//alert("cntr after-------"+j);
   	document.IntroMail.action=url+"&cntr="+cntr; */
   	
   	var totcount="";
   	var tcnt=0;
   	for(var j=0;j<cntr;j++)
	{	
		if(document.getElementById("cb"+j).checked==true)
		{
        	 //url="MailIntro.jsp?&id="+document.getElementById("cb"+j).value;
			 //totcount+='cb'+[j]+',';
			 var te=document.getElementById("cb"+j).value;
			// alert("te"+te);
			 totcount+=te+',';
			 //count++;
			 tcnt=tcnt+1;
			 //alert("totcount:-"+totcount);
		}		
	}
	url="MailIntro.jsp?&id="+totcount;
	//alert("url outer loop:-"+url);
	//alert("totcount outer loop:-"+totcount);
	try{
		
	window.location="MailIntro.jsp?&id="+totcount+"&emailTo1="+toemail+"&emailTo2="+ccemail+"&cntr="+tcnt+"&data="+data+"&companyname="+companyname;
	}catch(e){
		alert(e);
	}
	//document.IntroMail.action=url+"&cntr="+cntr;
   	
   	
        // write function to check no of check boxes get value
       // document.IntroMail.action=url+"&cntr="+j;
      	//document.fullfleet.action="Changewarranty1.jsp";
        //alert(document.fullfleet.action);
        //document.IntroMail.submit();
}
</script>
	
	</head>
	<body>
	
	<%
	erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
%>
<%
	
Connection conn = null;
	Connection conn1 = null;
	Statement st = null, st1 = null,st2=null,st3=null,st4=null,st5=null,stlbl=null;
	
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
	st5 = conn.createStatement();
	stlbl = conn.createStatement();
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	String PageName1=this.getClass().getName();
	String reportno1 = "";
	String reportname1 = "";
	String html="";
	String companyMaster="",companyMaster1="",companyname="";
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
	String CustomerCode=request.getParameter("customercode");
	%>
	
	<input type="hidden" name="customercode"  id="customercode" value="<%=CustomerCode%>"></input>


		<%
	String SqlQuotaionDet="select * from db_GlobalERP.100015prospectivecustmaster where CustomerCode='"+CustomerCode+"'";
	System.out.println(">>>>>>>>>>>      "+SqlQuotaionDet);
	ResultSet rsQuotaionDet=st4.executeQuery(SqlQuotaionDet);
	if(rsQuotaionDet.next()){
		String Company=rsQuotaionDet.getString("CompanyName");
	}
	
	DateFormat df = new SimpleDateFormat("dd-MMM-yyyy HH:mm");
	String dt_sub=df.format(new Date());
	System.out.println("dt_sub========"+dt_sub);
	System.out.println(">>>>61>");
	String Signature="",Website="";
	String DocumentName1="",DocumentName2="",DocumentPath="";
		String emailTo="";
		String CcMail="",EmpName="",MobNo="",Sign="",Email="";
		Statement st_email=conn.createStatement();
		Statement st_email1=conn.createStatement();
		Statement stEmailDetails=conn.createStatement();
				ResultSet rs_email=null;
				ResultSet rs_email1=null;
		System.out.println(">>>>1>");
		
		//select * from db_GlobalERP.100015prospectivecustmaster where CustomerCode='1491'------CompanyName
				
		String Company=request.getParameter("companyname");
		String sql_email="select * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CompanyName='"+Company+"'";
		rs_email=st_email.executeQuery(sql_email);
		if(rs_email.next()){
			//emailTo=rs_email.getString("EMail");
		}
		
		emailTo=request.getParameter("companyEmail");
		String sql_email1="select * from db_GlobalERP.CompanyMaster where  companymid='"+session.getAttribute("CompanyMasterID").toString()+"'";
			rs_email1=st_email1.executeQuery(sql_email1);
			
			while(rs_email1.next()){
				//CcMail=rs_email1.getString("AlertMailId");
				companyname=rs_email1.getString("Companyname");
				Website=rs_email1.getString("Website");
			} 
			System.out.println("====="+emailTo);
			
			
			String sql_email12="select * from db_GlobalERP.UserMaster  where Empcode='"+session.getAttribute("EmpCode").toString()+"'";
			rs_email1=st_email1.executeQuery(sql_email12);
			
			System.out.println("EmpName---------sql_email12-"+sql_email12);
			while(rs_email1.next()){
				CcMail=rs_email1.getString("email");
				EmpName=rs_email1.getString("EmpName");
				MobNo=rs_email1.getString("mobileno");
				Sign=rs_email1.getString("Signature");
				Email=rs_email1.getString("email");
				
			} 
			System.out.println("EmpName----------"+EmpName);
			
				StringBuilder sb=new StringBuilder();
				StringBuilder sb1=new StringBuilder();
			companyMaster1=session.getAttribute("CompanyMasterID").toString();
			String Docs="select DocumentName,DocumentPath from db_GlobalERP.ERPIntroDocsMaster where CompanyId='"+companyMaster1+"'";
			ResultSet rs1=st5.executeQuery(Docs);
			while(rs1.next())
			{
				DocumentName1=rs1.getString("DocumentName");
				DocumentPath=rs1.getString("DocumentPath");
				System.out.println("DocumentName1----------**************"+DocumentName1);
				sb.append(DocumentName1+",");
				System.out.println("DocumentName1----------**************"+sb.toString());
				sb1.append(DocumentPath+",");
				//DocumentName2=rs1.getString(2);
			}			System.out.println("DocumentName1----------"+DocumentName1+"DocumentName2-------------"+DocumentName2);
			
			String DocumentName123[]=sb.toString().split(",");
			int j=0;
			String pth=DocumentPath;
			%>
			<td></div><input type="hidden" id="path<%=j%>" name="path<%=j%>" value="<%=pth %>" />
			<%
			int num=DocumentName123.length;
			
			String DocumentPath1[]=sb1.toString().split(",");
			
			/* String FileName1=DocumentName123[0];
	FileName1=FileName1.replaceAll(" ", "");
	System.out.println("FileName1----------"+FileName1);
	String FileName2=DocumentName123[1];
	FileName2=FileName2.replaceAll(" ", "");
	System.out.println("FileName2----------"+FileName2); */
	
	/* String AttachFilePath1=""+DocumentPath1[0]+""+companyMaster1+"/"+FileName1;
	System.out.println("AttachFilePath1---------"+AttachFilePath1);
	
	String AttachFilePath2=""+DocumentPath1[1]+""+companyMaster1+"/"+FileName1;
	System.out.println("AttachFilePath2----------"+AttachFilePath2); */
	
	// companyname=test by romil&customercode=438&contact=Ajinkya Patil&companyEmail=shahromil12345@gmail.com
	
	
	
	
	//String AttachFilePath=AttachFilePath1+","+AttachFilePath2;
	//String FileName=FileName1+","+FileName2;
	//System.out.println("AttachFilePath***********----------"+AttachFilePath);
	//System.out.println("FileName***********----------"+FileName);
	
	try
	{
		
		companyMaster=session.getAttribute("CompanyMasterID").toString();
		String getEmailDetails="select * from db_GlobalERP.ComapnayIntroMaster where CompanyId='"+companyMaster1+"'";
		ResultSet rs=stEmailDetails.executeQuery(getEmailDetails);
		
		while(rs.next())
		{
			 Signature=rs.getString("MailBodyDesc");
			 //Website=rs.getString("Website");
		}
		
	}catch(Exception e)
	{
		System.out.println("Exception "+e.getMessage());
	}
	String CustomerName=request.getParameter("companyname");
	
	CustomerName=CustomerName.replace("..","&");
	//CustomerName=CustomerName.replace("..","&");
	//String html1="To,"+"<html>"+" \n </html>"+CustomerName;
	String a="To,";
	String firstContact=request.getParameter("contact");
	%>
		<input type="hidden" name="firstContact"  id="firstContact" value="<%=firstContact%>"></input>
	<%
	 //html ="<html><div width = ^100%^><font size = ^3^ face = ^Arial^>"+a+"</font><body><table border=^18^  bordercolor=^#E6E6FA^ align=^center^ width=^60%^><div width = ^100%^><font size = ^3^ face = ^Arial^>"+"\n "+"\n "+CustomerName+"</font><br><div width = ^100%^><font size = ^3^ face = ^Arial^>"+"\n Kind Attn: Mr."+firstContact+"</font><br><div width = ^100%^><font size = ^3^ face = ^Arial^><br>"+"\n"+"\n <br> Dear Sir/Madam,</font><br><div width = ^100%^><font size = ^3^ face = ^Arial^>"+"\n "+"\n "+Signature+"</font><br><div width = ^100%^><font size = ^3^ face = ^Arial^><br>"+"\n Thanks and Regards,</font><div width = ^100%^><font size = ^3^ face = ^Arial^>"+"\n "+EmpName+"</font><div width = ^100%^><font size = ^3^ face = ^Arial^>"+"\n "+MobNo+"</font><div width = ^100%^><font size = ^3^ face = ^Arial^>"+"\n "+Email+"</font><div width = ^100%^><font size = ^3^ face = ^Arial^>"+"\n "+companyname+"</font></table><div width = ^100%^><font size = ^3^ face = ^Arial^><u><a href=http://"+Website+"></u>"+Website+"</a></b></font></html>";
 	%>
 	
 	<input type="hidden" name="CustomerNamed"  id="CustomerNamed" value="<%=CustomerName%>"></input>
 	<% 
	String customercode=request.getParameter("customercode");
	/* String companyname123=request.getParameter("companyname");
	String contact=request.getParameter("contact");
	String companyEmail=request.getParameter("companyEmail"); */
	 
	
try{
	%>
<form name="IntroMail" id="IntroMail" method="" action="">
<div align="center" style="margin-top:0.3em;  margin-bottom:0.3em; font-size: 16px;">
	 <b>Introduction Profile Email</b>
	 </div>
	<table  align="center" valign="top" width="100%">
	<tr></tr>
	  
	<%-- <input type="hidden" name="emailTo"  id="emailTo" value="<%=emailTo%>"></input>
<input type="hidden" name="emailTo"  id="emailTo" value="<%=CcMail%>"></input>
<input type="hidden" name="companyname"  id="companyname" value="<%=Company%>"></input> --%>

	<tr>
	<td style="width: 100%">
		<table border="0" align="center" valign="top" width="100%" >
		<tr>
			<td ><font color='black' style='font-size:13px;'>Company:</font></td>
			<td><%=CustomerName %> 
			</td>
			<input type="hidden" name="companyname"  id="companyname" value="<%=CustomerName%>"></input>
		</tr>	
			<tr ><td><font color='black' style='font-size:13px;'><font color='red' style='font-size:10px;'>*</font>To Email:</font></td> 
		<td>
		 <textarea id=emailTo1 name="emailTo1" class="element textarea medium" onblur="return myemail();" ><%=emailTo %> </textarea>
		 
		<%-- <textarea name="emailTo1" id="emailTo1" style='width: 235px; height: auto;' ><%=emailTo %>
		</textarea> --%>
		<input type="hidden" name="emailTo1"  id="emailTo1" value="<%=emailTo%>"></input>
		<font color='red' style='font-size:10px;'>(separated by comma (,))
		
		<div>
<label  id="email3" style="display: none;"><font color='red' style='font-size:10px;'>Please Enter Correct Value </font></label> 
 
 
</div>
		</td>
		
		</tr>
		<%-- <input type="text" value="<%=emailTo %>" id="emailTo" name="emailTo" /></td> --%>
		<td> <font color='red' style='font-size:10px;'>*</font>Cc Email:</b></td>
		<td>
		
		
		
		
		
		
		
		
		
		<textarea id="emailTo2" name="emailTo2" class="element textarea medium" onblur="return myemail1();" ><%=CcMail %> </textarea>
		
		<%-- <textarea name="emailTo2" id="emailTo2" style='width: 235px; height: auto;' ><%=CcMail %>
		</textarea> --%>
		<input type="hidden" name="emailTo2"  id="emailTo2" value="<%=CcMail%>"></input>
		<font color='red' style='font-size:10px;'>(separated by comma (,))
		<div>
<label  id="email4" style="display: none;"><font color='red' style='font-size:10px;'>Please Enter Correct Value </font></label> 
 
 
</div>
		
		</td>
		<%-- <input type="text" value="<%=CcMail %>" id="extraemail" name="extraemail" /><font color='red' style='font-size:10px;'>(separated by comma (,))</td> --%>
		</tr>
		</table>
		</td>
		</tr>
		<tr>
		<div style="width: 700px;font-size:6px;">
<table>
<tr>
<td>
<% html="<html><div width = ^100%^><font size = ^3^ face = ^Arial^>"+a+"</font><body><table border=^18^  bordercolor=^#E6E6FA^ align=^center^ width=^60%^><div width = ^100%^><font size = ^3^ face = ^Arial^>"+"\n "+"\n "+CustomerName+"</font><br><div width = ^100%^><font size = ^3^ face = ^Arial^>"+"\n Kind Attn: Mr."+firstContact+"</font><br><div width = ^100%^><font size = ^3^ face = ^Arial^><br>"+"\n"+"\n <br> Dear Sir/Madam,</font><br><div width = ^100%^><font size = ^3^ face = ^Arial^>"+"\n "+"\n "+Signature+"</font><br><div width = ^100%^><font size = ^3^ face = ^Arial^><br>"+"\n Thanks and Regards,</font><div width = ^100%^><font size = ^3^ face = ^Arial^>"+"\n "+EmpName+"</font><div width = ^100%^><font size = ^3^ face = ^Arial^>"+"\n "+MobNo+"</font><div width = ^100%^><font size = ^3^ face = ^Arial^>"+"\n "+Email+"</font><div width = ^100%^><font size = ^3^ face = ^Arial^>"+"\n "+companyname+"</font></table><div width = ^100%^><font size = ^3^ face = ^Arial^><u><a href=http://"+Website+"></u>"+Website+"</a></b></font></html>";%>
<textarea name="data" id="wysiwyg" cols="100" rows="10" >

<%=html %>
</textarea>
</td>

</tr>
	

		
		
		<tr>
		<td>
		<font color="red">*Only standard key-board characters are allowed</font>
			
	</td></tr>
	
	<tr><td>&nbsp;</td></tr></table>
	<tr>
	
	<td >
		<font color="Black"><b>Attachment:</b></font>
	</td>
	
	<% 
	String comid=session.getAttribute("CompanyMasterID").toString();
	int i = 0;
	int j1=0;
	for ( i = 0; i < num; i++)
		
 { %>	
	
	<td >
	<input type="checkbox" name="cb<%=i %>" id="cb<%=i%>"  value="<%=DocumentName123[i]%>" ><%=DocumentName123[i] %></input>
	<%-- <input type="checkbox" name ="Doc1" id="Doc1" ><%=DocumentName123[i] %> --%>
	
	<%-- <input type="hidden" name="cb" id="cb" value="<%=DocumentName123[i]%>" /> --%>  
	</td>
	
	
	
	<% }
	
	%>
	<%-- <input type="hidden" name="pt<%=i %>" id="pt<%=i%>"  value="<%=DocumentPath1[i]%>"><%=DocumentPath1[i] %></input> --%>
	
	<input type="hidden" name="cntr" id="cntr" value="<%=i%>" />
	
			
			
	<td>
	<input  type="button" name ="button" id="button" style="margin-left: 372px; align="center" value="Email" onclick="changeAction()"/>
	</td>
	</tr>
		</table>
		
		<%
	}
catch(Exception e)
{
	e.printStackTrace();
}
	%>
	</form>
	
	</body>
	</html>
	
</jsp:useBean>
<%@include file="footer_new.jsp"%>