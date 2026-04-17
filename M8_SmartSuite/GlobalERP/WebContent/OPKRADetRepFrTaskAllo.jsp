     <%--  --%>
<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
 <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style type="text/css">@import url(jscalendar-1.0/calendar-blue.css);</style>
<%@ page import = "java.io.FileNotFoundException"%>
<%@ page import = "java.io.FileOutputStream"%>
<%@ page import = " java.io.IOException"%>
<%@ page import="javax.activation.*" %>
<%@include file="PostgressConn.jsp" %>


<html> 
<head>
<style>
</style>

<%@ include file="header.jsp"%>
 
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page"> 
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css">
<!-- <script type="text/javascript"  src="https://code.jquery.com/jquery-1.12.4.js"></script> 
 -->

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.14.0/jquery.validate.min.js"></script>

  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
 <!--  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->

<!-- Export Options Links of DataTables -->
<script type="text/javascript"  src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script> 
<link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.5.1/css/buttons.dataTables.min.css">
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/dataTables.buttons.min.js"></script> 
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.flash.min.js"></script> 
<script src=" https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js"></script>
<script src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js"></script>
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.html5.min.js"></script>
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.print.min.js "></script>
<style>
/* visited link */
a:visited {
	color: #660066;
}
</style>
<script type="text/javascript">
function cancel()
{
	//alert("in cancel");
	var cnt=document.form1.counter.value;
   
    cnt--;
   // alert(cnt);
    if(cnt==0)
    {
    	document.form1.counter.value=cnt;
 		cleareall();
 		document.getElementById("f1").innerHTML=""; 	
 		
    }
    else
    {

    document.form1.counter.value=cnt;
	 document.form1.Filename1.value="";

	 document.form1.Filename2.value="";
	     document.getElementById("tr1").style.display="none";  
	     //document.getElementById("comm").style.display="";   
	      
       document.getElementById("tr2").style.display="none"; 
       document.getElementById("f1").innerHTML=""; 	
}
}
function cancel1()
{//alert("in cancel 1");
	var cnt=document.form1.counter.value;
   
    cnt--;
  // alert(cnt);
    if(cnt==0)
    {
    	document.form1.counter.value=cnt;
		cleareall();
		document.getElementById("f2").innerHTML=""; 
    }
    else
    {

    document.form1.counter.value=cnt;
	
		  document.form1.Filename2.value="";
	       document.getElementById("tr5").style.display="none";   
	       document.getElementById("f2").innerHTML="";
	       //document.getElementById("tr2").style.display=""; 
}
}
function cancel2()
{//alert("in cancel 2");
	var cnt=document.form1.counter.value;
   
    cnt--;
   // alert(cnt);
    if(cnt==0)
    {
    	document.form1.counter.value=cnt;
		cleareall();
		document.getElementById("f3").innerHTML=""; 
    }
    else
    {
 
    document.form1.counter.value=cnt;
	
	 document.form1.Filename3.value="";
		document.getElementById("tr7").value=""; 
       document.getElementById("tr7").style.display="none"; 
       document.getElementById("f3").innerHTML=""; 
       //document.getElementById("tr6").style.display="";
}
}
function cancel3()
{//alert("in cancel 3");
	var cnt=document.form1.counter.value;

    cnt--;
  // alert(cnt);
    if(cnt==0)
    {
    	document.form1.counter.value=cnt;
		cleareall();
		document.getElementById("f4").innerHTML=""; 
    }
    else
    {

    document.form1.counter.value=cnt;
	
	 document.form1.Filename4.value="";
	document.getElementById("tr9").value=""; 
    document.getElementById("tr9").style.display="none";
    document.getElementById("f4").innerHTML="";
    //document.getElementById("tr8").style.display=""; 
   
}
}
function cancel4()
{//alert("in cancel 4");
	var cnt=document.form1.counter.value;

    cnt--;
   //alert(cnt);
    if(cnt==0)
    {
    	document.form1.counter.value=cnt;
		cleareall();
		document.getElementById("f5").innerHTML=""; 
    }
    else
    {

    document.form1.counter.value=cnt;
	
	 document.form1.Filename5.value="";
	document.getElementById("tr11").value=""; 
       document.getElementById("tr11").style.display="none";  
       document.getElementById("f5").innerHTML=""; 
       //document.getElementById("tr10").style.display="";
  	
}
}

function cleareall()
{
	//alert("in clear");
	var cnt = document.form1.counter.value;
	//alert("cnt =>"+cnt);
	 document.getElementById("tr").style.display="";
	// document.getElementById("plusN").style.display="";
	 document.getElementById("tr1").style.display="none"; 
     document.getElementById("tr5").style.display="none"; 
     document.getElementById("tr7").style.display="none"; 
     document.getElementById("tr9").style.display="none"; 
     document.getElementById("tr11").style.display="none"; 
     document.form1.Filename1.value="";
	 document.form1.Filename2.value="";
	 document.form1.Filename3.value="";
	 document.form1.Filename4.value="";
	 document.form1.Filename5.value="";
	 //alert("cnt =>"+cnt);
	 document.form1.counter.value=cnt;
}


function attach()
{
	try{
	//alert("Hii att");
	//alert("in attach ");
	
		
var cnt=document.form1.counter.value;
//alert("351 count "+cnt);
if(cnt>0)
{
	//alert("count "+cnt);
}
else 
{
cnt=1;
var flagvalue=document.form1.flagvalue.value;
flagvalue++;
document.form1.flagvalue.value=flagvalue;
//alert(cnt);
document.form1.counter.value=cnt;

       document.getElementById("tr1").style.display="";   
	     //document.getElementById("comm").style.display="";   
	       	
       document.form1.Filename1.style.display="";
      // document.incident.Filename1.value="";
      //document.getElementById("imageDiv").innerHTML="";
       document.getElementById("imageDiv").style.display="none";
     //  document.incident.Upload.style.display="";  
       document.getElementById("tr2").style.display="";   
}
	}catch(e)
	{
		alert(e);
	}
}

function attach1()
{
	var cnt=document.form1.counter.value;
	cnt++;
	//alert(cnt);
	document.form1.counter.value=cnt;
	//alert("in attach1 ");
	
	document.getElementById("tr5").style.display="";  
	document.form1.Filename2.style.display="";
	//document.getElementById("imageDiv1").innerHTML="";
    document.getElementById("imageDiv1").style.display="none" ;	
    document.getElementById("tr2").style.display="none"; 
    document.getElementById("tr6").style.display="";  
}
function attach2()
{
	var cnt=document.form1.counter.value;
	cnt++;
	//alert(cnt);
	document.form1.counter.value=cnt;
	//alert("in attach2 ");
	document.getElementById("tr7").style.display="";   
	document.form1.Filename3.style.display="";
	//document.getElementById("imageDiv2").innerHTML="";
    document.getElementById("imageDiv2").style.display="none";
    document.getElementById("tr6").style.display="none"; 
    document.getElementById("tr8").style.display="";  
}
function attach3()
{
	var cnt=document.form1.counter.value;
	cnt++;
	//alert(cnt);
	document.form1.counter.value=cnt;
	//alert("in attach3 ");
	document.getElementById("tr9").style.display="";   
	document.form1.Filename4.style.display="";
	//document.getElementById("imageDiv3").innerHTML="";
    document.getElementById("imageDiv3").style.display="none";
    document.getElementById("tr8").style.display="none"; 
    document.getElementById("tr10").style.display="";  
}
function attach4()
{
	var cnt=document.form1.counter.value;
	cnt++;
	//alert(cnt);
	document.form1.counter.value=cnt;
	//alert("in attach4 ");
	document.getElementById("tr11").style.display="";
	document.form1.Filename5.style.display="";
	//document.getElementById("imageDiv4").innerHTML="";
    document.getElementById("imageDiv4").style.display="none";   	
    document.getElementById("tr10").style.display="none"; 
    //document.getElementById("tr12").style.display="";  
   // document.write("<tr align='center' id='tr23' style='' bgcolor='#FFF6F7'><td><div id='imageDiv' align='center'><font color='maroon' size='2'><b></b></font></div></td><td><input type='file' cols='40' name='Filename' value=''></td></tr>");
}


function upload()
{
	try{
		var id_value = document.getElementById('up').value;
		//alert(id_value);
		var file1=document.form1.Filename1.value;
		file1 = file1.substring(12);
		// alert(file1);

		 if(id_value != '')
		 { 
			 var valid_extensions = /(.jpg|.jpeg|.doc~|.doc|.txt|.png|.pdf|.ods|.xls|.txt~)$/i;
			// var valid_type = /(.txt|.jpeg|.doc)$/i;
			    
		  if(valid_extensions.test(id_value))
		  { 
			
			  document.form1.Filename1.style.display="none";
				document.getElementById("imageDiv").style.display="";
				document.getElementById("f1").innerHTML=file1;
			  
		  // alert(file1);
		  }
		 // else if()
		  else
		  {
			 
			 
			 
			 var cnt=document.form1.counter.value;
   
   /// cnt--;
   // alert(cnt);
    if(cnt==0)
    {
    	document.form1.counter.value=cnt;
 		cleareall();
 		document.getElementById("f1").innerHTML=""; 	
 		
    }
    else
    {
    	 document.form1.Filename1.style.display="none";
			document.getElementById("imageDiv").style.display="";
			document.getElementById("f1").innerHTML=file1;
/*
    document.form1.counter.value=cnt;
	 document.form1.Filename1.value="";

	 document.form1.Filename2.value="";
	     document.getElementById("tr1").style.display="none";
	     //document.getElementById("comm").style.display="none";   
	        
       document.getElementById("tr2").style.display="none"; 
       document.getElementById("f1").innerHTML="";
        */ 	
}
		//	  alert("Please Upload only doc,jpg,pdf,png,ods,xls,txt and jpeg Formatted File");
		   
		  }
		 }
	
	//alert(file1);
	
	
	//document.incident.Upload.style.display="none";
	
	
	} catch(e)
	{
		alert(e);
	}

}

function upload1()
{
	try{
		var file1=document.form1.Filename2.value;
		var id_value = document.getElementById('up1').value;
		file1 = file1.substring(12);
		 if(id_value != '')
		 { 
			  var valid_extensions = /(.jpg|.jpeg|.doc~|.doc|.txt|.png|.ods|.xls|.pdf|.txt~)$/i;
		  if(valid_extensions.test(id_value))
		  { 
		//alert(file1);
		
		document.form1.Filename2.style.display="none";
		document.getElementById("imageDiv1").style.display="";
		document.getElementById("f2").innerHTML=file1;
		//document.incident.Upload.style.display="none";
		
		
		}
		  else
		  {

			  var cnt=document.form1.counter.value;
			   
			//    cnt--;
			  // alert(cnt);
			    if(cnt==0)
			    {
			    	document.form1.counter.value=cnt;
					cleareall();
					document.getElementById("f2").innerHTML=""; 
			    }
			    else
			    {

			    	document.form1.Filename2.style.display="none";
					document.getElementById("imageDiv1").style.display="";
					document.getElementById("f2").innerHTML=file1;
/*
			    document.form1.counter.value=cnt;
				
					  document.form1.Filename2.value="";
				       document.getElementById("tr5").style.display="none";   
				       document.getElementById("f2").innerHTML="";
				       */ 
			}
		//	  alert("Please Upload only doc,jpg,pdf,png,ods,xls,txt and jpeg Formatted File");
		   
		  }
		 }
	}catch(e)
		{
			alert(e);
		}
}

function upload2()
{
	try{
		var file1=document.form1.Filename3.value;
		var id_value = document.getElementById('up2').value;
		file1 = file1.substring(12);
		 if(id_value != '')
		 { 
			  var valid_extensions = /(.jpg|.jpeg|.doc~|.doc|.txt|.png|.pdf|.ods|.xls|.txt~)$/i;
		  if(valid_extensions.test(id_value))
		  { 
		//alert(file1);
		
		document.form1.Filename3.style.display="none";
		document.getElementById("imageDiv2").style.display="";
		document.getElementById("f3").innerHTML=file1;
		//document.incident.Upload.style.display="none";
		

			}
			  else
			  {

				  var cnt=document.form1.counter.value;
				   
				//    cnt--;
				   // alert(cnt);
				    if(cnt==0)
				    {
				    	document.form1.counter.value=cnt;
						cleareall();
						document.getElementById("f3").innerHTML=""; 
				    }
				    else
				    {

				    	document.form1.Filename3.style.display="none";
						document.getElementById("imageDiv2").style.display="";
						document.getElementById("f3").innerHTML=file1;
					    /*
				 
				    document.form1.counter.value=cnt;
					
					 document.form1.Filename3.value="";
					document.getElementById("tr7").value=""; 
				       document.getElementById("tr7").style.display="none"; 
				       document.getElementById("f3").innerHTML="";
					       */ 
				} 
			//	  alert("Please Upload only doc,jpg,pdf,png,ods,xls,txt and jpeg Formatted File");
			   
			  }
			 }
		}catch(e)
		{
			alert(e);
		}
}

function upload3()
{
	try{
		var file1=document.form1.Filename4.value;
		var id_value = document.getElementById('up3').value;
		file1 = file1.substring(12);
		 if(id_value != '')
		 { 
			  var valid_extensions = /(.jpg|.jpeg|.doc~|.doc|.txt|.png|.pdf|.ods|.xls|.txt~)$/i;
		  if(valid_extensions.test(id_value))
		  { 
		//alert(file1);
		
		document.form1.Filename4.style.display="none";
		document.getElementById("imageDiv3").style.display="";
		document.getElementById("f4").innerHTML=file1;
		//document.incident.Upload.style.display="none";


	}
	  else
	  {
		  var cnt=document.form1.counter.value;

		  //  cnt--;
		  // alert(cnt);
		    if(cnt==0)
		    {
		    	document.form1.counter.value=cnt;
				cleareall();
				document.getElementById("f4").innerHTML=""; 
		    }
		    else
		    {

		    	document.form1.Filename4.style.display="none";
				document.getElementById("imageDiv3").style.display="";
				document.getElementById("f4").innerHTML=file1;
			    /*

		    document.form1.counter.value=cnt;
			
			 document.form1.Filename4.value="";
			document.getElementById("tr9").value=""; 
		    document.getElementById("tr9").style.display="none";
		    document.getElementById("f4").innerHTML="";
			    */ 
		   
		}
		 
		//  alert("Please Upload only doc,jpg,pdf,png,ods,xls,txt and jpeg Formatted File");
	   
	  }
	 }
		
		}catch(e)
		{
			alert(e);
		}
}

function upload4()
{
	try{
		var file1=document.form1.Filename5.value;
		var id_value = document.getElementById('up4').value;
		file1 = file1.substring(12);
		 if(id_value != '')
		 { 
			  var valid_extensions = /(.jpg|.jpeg|.doc~|.doc|.txt|.png|.pdf|.ods|.xls|.txt~)$/i;  
		  if(valid_extensions.test(id_value))
		  { 
		//alert(file1);
		
		document.form1.Filename5.style.display="none";
		document.getElementById("imageDiv4").style.display="";
		document.getElementById("f5").innerHTML=file1;
		//document.incident.Upload.style.display="none";
		


	}
	  else
	  {
		  var cnt=document.form1.counter.value;

		//    cnt--;
		   //alert(cnt);
		    if(cnt==0)
		    {
		    	document.form1.counter.value=cnt;
				cleareall();
				document.getElementById("f5").innerHTML=""; 
		    }
		    else
		    {

		    	document.form1.Filename5.style.display="none";
				document.getElementById("imageDiv4").style.display="";
				document.getElementById("f5").innerHTML=file1;

		/*    document.form1.counter.value=cnt;
			
			 document.form1.Filename5.value="";
			document.getElementById("tr11").value=""; 
		       document.getElementById("tr11").style.display="none";  
		       document.getElementById("f5").innerHTML="";
			       */ 
		  	
		}
		//  alert("Please Upload only doc,jpg,pdf,png,ods,xls,txt and jpeg Formatted File");
	   
	  }
	 }
		}catch(e)
		{
			alert(e);
		}
}



</script>



<script type="text/javascript">


 $(document).ready(function() {
	    $('#example').DataTable( {
	    	"pagingType": "full_numbers",
	    	
	        dom: 'Blfrtip',
	        
	        buttons: [
	        	
	        	{
	        		extend: 'collection',
	        		
	        		text: 'Export',
	        		buttons: [
	        			{
	                        extend: 'excel',
	                        title: 'KRA Task Description Report '+$("#data").val()+'-'+$("#data1").val(), 
	                    },
	                    {
	                        extend: 'pdf',
	                        orientation: 'landscape',
	                        pageSize: 'LEGAL',
	                        title: 'KRA Task Description Report '+$("#data").val()+'-'+$("#data1").val(), 
	                    },
	                    {
	                        extend: 'csv',
	                        title: 'KRA Task Description Report '+$("#data").val()+'-'+$("#data1").val(),
	                    },
	                    {
	                        extend: 'print',
	                        title: 'KRA Task Description Report '+$("#data").val()+'-'+$("#data1").val(),
	                    },
	                    {
	                        extend: 'copy',
	                        title: 'KRA Task Description Report '+$("#data").val()+'-'+$("#data1").val(),
	                    },
	                    
	            				/* 'copy', 'csv', 'excel', 'pdf', 'print' */
	            			]
	        	}
	        ],
	        lengthMenu: [[-1, 10, 25, 50, 100], ["All", 10, 25, 50, 100 ]],
	        
	     
	    
	    
	    
	    	
	    } );
	} );

</script>



<script type="text/javascript">


function consig()
{
	var dept=document.getElementById("companyName1").value;
	
		
	//alert("Customer---------"+customername);
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
	//alert("eeeeeeeeeeeeeeeeeeeeeeeeee");
	// Create a function that will receive data sent from the server
	ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
		{//alert("######################### ");
			
		   var reselt=ajaxRequest.responseText;
		   //alert("Original result"+reselt);
			var finalres=reselt.split("#");
			document.getElementById("EmpName").innerHTML=finalres[0];
			//alert("After trim"+finalres[0]);
			
			  
		 
		}
	
	}
	
	var queryString = "?dept="+dept;
     //alert("Query String ---"+queryString);
	ajaxRequest.open("GET", "EmpAjax.jsp"+queryString, true);
	ajaxRequest.send(null);
}

</script>


<script>

function hello()
{

	var dept=document.getElementById("companyName1").value;
	if(dept=="Select")
		{
		
		alert("Please Select Department");
		return false;
		} 
	var EmpName=document.getElementById("EmpName").value;
	if(EmpName=="Select")
		{
		
		alert("Please Select Name");
		return false;
		}
	
	//alert("IN");
	var chkf="";
	var chkt="";
	var objFromDate = document.getElementById("data").value;
	//alert(objFromDate);
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
    var objToDate = document.getElementById("data1").value;
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
     
    var date1 = new Date(objFromDate1);
    var date2 = new Date(objToDate1);
    
    //alert("from > "+date1+" Todate > "+date2);
    
    var date3 = new Date();
    var date4 = date3.getMonth() + "-" + date3.getDay() + "-" + date3.getYear();
    var currentDate = new Date(date4);
     
        if(date1 > date2)
        {
            alert("From Date Should be Less Than To Date");
            return false; 
        }
//         else if(date1 > currentDate)
//         {
//             alert("From Date should be less than current date");
//             return false; 
//         }
//         else if(date2 > currentDate) 
//         {
//             alert("To Date should be less than current date");
//             return false; 
//         }

        return true;
}
</script>
<script>

function senddata2(UserId,dt,dt1,HOD,Department,User,Status,Sesrole2)
{
	 System.out.println("Inside senddata2");
	 //alert("Hi");
	 //alert("Id :- "+id);
	 //alert("Name :- "+Name);
	 window.location="TaskDetailsReport.jsp?UserId="+UserId+"&fromdate="+dt"&todate="+dt1"&HOD="+HOD"&Dept="+Department"&User="+User"&Status="+Status"&Role="+Sesrole2"";
}
function gotoExcel(elemId, frmFldId)  
{  
	      
          var obj = document.getElementById(elemId);
          var oFld = document.getElementById(frmFldId);
          oFld.value = obj.innerHTML;
          document.index_total_cat.action ="excel.jsp";
          document.forms["index_total_cat"].submit();
}
function checkAll()
{

	//alert("ok");
	var field = document.getElementById("checkedNumber").value;

//	var field=document.getElementsByName("chkbx");
//	alert("ok"+field);
	var i, chk=1;
	try{
	for (i = 0; i < field; i++)
	{
		 if(document.getElementById("chkbx"+chk).checked == false)
		 {
			 document.getElementById("chkbx"+chk).checked = true;
		 }

		 chk++;
		
	}
}catch(e){alert(e);}
}

function unCheckAll()
{

	//alert("ok");
var field = document.getElementById("checkedNumber").value;

//var field=document.getElementsByName("chkbx");
//alert("ok"+field);
var kj=1,i;
try{
for (i = 0; i < field; i++)
{
	
	 if(document.getElementById("chkbx"+kj).checked == true )
	 {
		 document.getElementById("chkbx"+kj).checked = false;
	 }
	 kj++;
}
}catch(e){alert(e);}
}

function getcheckedrow()
{
	//alert("hiiiii");
	var cnt1=0,cnt2=0,k=1,flag="t",flag1="t",l=1;
	var id="";
	var chklength=document.getElementsByName("chkbx");
	//var chklength = document.getElementById("checkedNumber").value;
	//alert("hiiiii"+chklength);
	for(cnt1=0;cnt1<chklength.length;cnt1++)
	{
		if( document.getElementById("chkbx"+k).checked == true )
		{
			flag="success";
		//	alert("flag"+flag);
		}
	k++;	
	}


	
	//alert("flg"+flag+"flg1"+flag1);
	if(flag == "success")
	{
		//alert("Inside Success");
		var i=1,j,cnt=0;
		id="";
		var approvalComment="";
		//alert("hiiiii1");
		
		
	//	var chklengthnew = document.getElementById("checkedNumber").value;
		for(cnt=0;cnt<chklength.length;cnt++)
		{
			//alert("for Length of for==>"+chklengthnew.length);
			
			if(document.getElementById("chkbx"+i).checked)
			{
				//alert("if");
				id=id+","+document.getElementById("net_id1"+i).innerHTML;
			//	approvalComment=approvalComment+"/"+document.getElementById("approvalcomment"+i).value;
			}
			i++;
		}
	//	alert("check"+id);
	//	DeleteRow(id,approvalComment);
		DeleteRow(id);
	}
	else
	{
		alert("Please Check Task Id ");
	}
	
}

function DeleteRow(id)
{
	//alert("Control inside deldte function"+id);

	var agree=confirm("Do You Want To Approve Task ?");
	    //alert(agree);
	    if(agree)
	    {
	    	 
	    	window.location="OPApprovedTask.jsp.jsp?action=approve&id="+id+"";
			
	    }
	    else
	    {
	    	return false;
	    }
 }


function getcheckedrow1()
{
	//alert("hiiiii");
	var cnt1=0,cnt2=0,k=1,flag="t",flag1="t",l=1;
	var id="";
	var chklength=document.getElementsByName("chkbx");
	//var chklength = document.getElementById("checkedNumber").value;
	//alert("hiiiii"+chklength);
	for(cnt1=0;cnt1<chklength.length;cnt1++)
	{
		if( document.getElementById("chkbx"+k).checked == true )
		{
			flag="success";
		//	alert("flag"+flag);
		}
	k++;	
	}


	
	//alert("flg"+flag+"flg1"+flag1);
	if(flag == "success")
	{
		//alert("Inside Success");
		var i=1,j,cnt=0;
		id="";
		var approvalComment="";
		//alert("hiiiii1");
		
		
	//	var chklengthnew = document.getElementById("checkedNumber").value;
		for(cnt=0;cnt<chklength.length;cnt++)
		{
			//alert("for Length of for==>"+chklengthnew.length);
			
			if(document.getElementById("chkbx"+i).checked)
			{
				//alert("if");
				id=id+","+document.getElementById("net_id1"+i).innerHTML;
			//	approvalComment=approvalComment+"/"+document.getElementById("approvalcomment"+i).value;
			}
			i++;
		}
		//alert("check count"+cnt);
	//	DeleteRow(id,approvalComment);
		DeleteRow1(id,cnt);
	}
	else
	{
		alert("Please Check Task Id ");
	}
	
}

function DeleteRow1(id,cnt)
{
	//alert("Control inside deldte function"+id);

	var agree=confirm("Do You Want To Reject Task ?");
	    //alert(agree);
	    if(agree)
	    {
	    	window.location="OPApprovedTask.jsp.jsp?action=reject&id="+id+"&cnt="+cnt+"";
			
	    }
	    else
	    {
	    	return false;
	    }
 }	


 
 
</script>

<script>

function approve1()
{
	//alert("hello");
	
	var Dept=document.getElementById('Dept').value;
	document.getElementById('DeptHidden').value=Dept;
	console.log("DeptHidden : "+Dept);
//alert("DeptHidden "+Dept);

var Usern=document.getElementById('Usern').value;
document.getElementById('UsernHidden').value=Usern;
console.log("UsernHidden : "+Usern);
//alert("UsernHidden=== "+Usern);
//alert(Usern);
	
	var HOD=document.getElementById('HOD').value;
	document.getElementById('HODHidden').value=HOD;
	console.log("HODHidden : "+HOD);
	//alert("HODHidden=== "+HOD);

//alert(HOD);
	var dd=document.getElementById('datenew1').value;
	document.getElementById('datenew1Hidden').value=dd;
	console.log("datenew1Hidden : "+dd);
	//alert("datenew1Hidden=== "+dd);

//alert(dd);
	
	var dd1=document.getElementById('datenew2').value;
	document.getElementById('datenew2Hidden').value=dd1;
	console.log("datenew2Hidden : "+dd1);
	//alert("datenew2Hidden=== "+dd1);
	
	
//alert(dd1);
	
 	var Status=document.getElementById("Status").value;
 	document.getElementById('StatusHidden').value=Status;
	console.log("StatusHidden : "+Status);
	//alert("StatusHidden=== "+Status);
	

	var Role=document.getElementById('Role').value;
	document.getElementById('RoleHidden').value=Role;
	console.log("RoleHidden : "+Role);
	//alert("RoleHidden=== "+Role);
	

 	var userId=document.getElementById("usrid1").value;
 	document.getElementById('usrid1hidden').value=userId;
	console.log("usrid1hidden : "+userId);
	//alert("usrid1hidden=== "+userId);
	//alert(userId);

	var User=document.getElementById("tsk1").value;
	document.getElementById('tsk1hidden').value=User;
	console.log("tsk1hidden : "+User);
	//alert("tsk1hidden=== "+User);
	//alert(User);

	var TaskID=document.getElementById("tskid").value;
	document.getElementById('tskidhidden').value=TaskID;
	console.log("tskidhidden : "+TaskID);
	//alert("tskidhidden=== "+TaskID);
	//alert(TaskID);
	
	var satat=document.getElementById('status').value;
	document.getElementById('satathidden').value=satat;
	console.log("statushidden : "+satat);
	//alert("statushidden=== "+satat);
	//alert(satat);
	
	var other=document.getElementById('other12').value;
	
	//alert(other);
	
	other = other.replace("%", "");
	document.getElementById('other12hidden').value=other;
	console.log("other12hidden : "+other);
	//alert("other12hidden=== "+other);
	
	
	var comment=document.getElementById('comments31').value;
	document.getElementById('comments31hidden').value=comment;
	console.log("comments31hidden : "+comment);
	//alert("comments31hidden=== "+comment);
	
	//alert(comment);
	if(comment=="")
		{
		vali();
		
		}
						/* 
						
					
						var file=document.getElementById('MyFile').value;
						//alert(file);
						
						 var f = file.replace("C:", "");
					
						 f = file.replace("C:", "");
						 	
						 f = f.replace(/\\/g, "");
						
						 f = f.replace("fakepath", "");
						
						//alert(f); */
	
//var li=location.assign("TaskNext.jsp");
		//location.assign("TaskNext.jsp?userId1="+userId+"&User1="+User+"&Role="+Role+"&Usern="+Usern+"&TaskID1="+TaskID+"&Dept="+Dept+"&Status="+Status+"&datenew1="+dd+"&HOD="+HOD+"&datenew2="+dd1+"&satat1="+satat+"&other123="+other+"&comment1="+comment+"&file1="+f);
	 
	document.getElementById("newModalForm").submit(); 
// var li=location.assign("TaskNext.jsp?userId1="+userId+"&User1="+User+"&Role="+Role+"&Usern="+Usern+"&TaskID1="+TaskID+"&Dept="+Dept+"&Status="+Status+"&datenew1="+dd+"&HOD="+HOD+"&datenew2="+dd1+"&satat1="+satat+"&other123="+other+"&comment1="+comment);
alert("Loading...Please click OK");
}
</script>


<script>
function demo(datenew1,datenew2,HOD,Dept,User,Status,Role,TaskName,UserID,TaskId)
{
/* 	alert("DEMO:");
	
	
alert(datenew1);
alert(datenew2);
alert(User);

alert(Status);
alert(Role);

	alert(HOD);
	alert(Dept); 
	alert(UserID); 
	alert(TaskName); 
	alert(TaskId); 
 */

	document.getElementById('tsk1').value = TaskName;

   	document.getElementById('usrid1').value = UserID;

	document.getElementById('tskid').value = TaskId;
	
	document.getElementById('datenew1').value = datenew1;
	
    document.getElementById('datenew2').value = datenew2;

	document.getElementById('HOD').value = HOD;
	
	document.getElementById('Dept').value = Dept;
	
	document.getElementById('Usern').value = User;
	
	document.getElementById('Status').value = Status;
	
	document.getElementById('Role').value = Role;


    
}
</script>
<script>
function demoo(datenew1,datenew2,HOD,Dept,User,Status,TaskName,UserID,TaskId)
{
 	//alert("IN DEMOO:");
/* alert("from:"+datenew1);
 alert("to:"+datenew2);
 alert("user:"+User);
 alert("status:"+Status);
  alert("userid:"+UserID); 
	alert("tskname:"+TaskName); 
	alert("taskid:"+TaskId);  */
	

	document.getElementById("tsk11").value = TaskName;
	//alert("hod:"+HOD);

   	document.getElementById("usrid11").value = UserID;
   	//alert("hod 1 :"+HOD);
	document.getElementById("usrid12").value = UserID;

	document.getElementById("tskid1").value = TaskId;
	
	//alert("hod: 2 "+HOD);
	
	
	document.getElementById("datefrom").value = datenew1;
	//alert("hod: 3 "+HOD);
	
    document.getElementById("dateto").value = datenew2; 

    //alert("hod: 34444444444444 "+HOD);
	
	
	document.getElementById("HOD1").value = HOD;
	
	
	//alert("hod:"+HOD);
	
	//alert("dept:"+Dept); 
	
	document.getElementById("Dept1").value = Dept;
	
	//alert("value set in dept:"+document.getElementById("Dept1").value); 
	
	document.getElementById("Usern1").value = User;
	//alert("value set in UserName:"+document.getElementById("Usern1").value);
	
	document.getElementById("Status1").value = Status;
	//alert("value set in Status:"+document.getElementById("Status1").value);
	
	
	
	document.getElementById("Task1").value = TaskId;
	//alert("value set in TaskId:"+document.getElementById("Task1").value);
    
}

/* function approve11()
{
	alert("hello in approve11");
	
 	var userId=document.getElementById("usrid11").value;
 	var tskid1=document.getElementById("tskid1").value;

 	var comments311=document.getElementById("comments311").value;
	alert("comments311"+comments311);  

 	var datefrom=document.getElementById("data").value;
	//document.getElementById('datefrom').value=TaskID;
	//console.log("datefrom : "+datefrom);
	
	alert("datefrom::"+datefrom);

	
	var dateto=document.getElementById("data1").value;
	
	alert("datefrom::"+dateto);//till here execution is fine

 	
	var hod=document.getElementById("HOD1").value;
	
	alert("hod::"+hod);
	
	var dep=document.getElementById("Dept1").value;
	
	alert("dep::"+dep);
	
	var stst=document.getElementById("Status1").value;

	alert("stst::"+stst);
	
	var usr=document.getElementById("Usern1").value;
	
	alert("usr::"+usr);
 	
	var rol=document.getElementById("Role1").value;

 	
	alert("role::"+rol);
	
	alert("url::::TaskNextAdd.jsp?userId1="+userId+"&tskid1="+tskid1+"&comments311="+comments311+"&datefrom="+datefrom+"&dateto="+dateto+"&hod="+hod+"&dep="+dep+"&stst="+stst+"&usr="+usr+"&rol="+rol)

 //var li=location.assign("TaskNextAdd.jsp?userId1="+userId+"&tskid1="+tskid1+"&comments311="+comments311+"&datefrom="+datefrom+"&dateto="+dateto+"&hod="+hod+"&dep="+dep+"&stst="+stst+"&usr="+usr+"&rol="+rol);
alert("Loading...Please click OK");
} */

</script>



<script>
function fun()
{
	var a=document.getElementById('status').value;
   // alert(a);


     if(a=='Completed')
 	  {

    	 var aa='<label class="control-label col-md-3" for="email">Percentage*:</label><input type="text" id="other12" name="other12" style="width:30%;" value="100%" readonly align="left"></input></div>';
    	 
    	   document.getElementById('per').innerHTML=aa;
    	  
    	 
 	  }
     else if(a=='In Progress')
    	 {
    	 var bb='<label class="control-label col-md-3" for="email">Percentage*:</label><select name="other12" id="other12" style="width: 100px; height:20px; border: 1px solid black;" align="left"><option>25%</option><option>50%</option><option>75%</option</select>';

    //	 var bb='<input type="text" id="other12" name="other12" style="width:100%;"></input>  </div>';
  	   document.getElementById('per').innerHTML=bb;


    	 }
}
</script>
<script>
function vali()
{
	//alert("IN");
	var comment=document.getElementById("comment").value;

	if(comment=="")
		{
		alert("Enter comment");
		return false;
		}
	
	
	
	}


</script>

<input type="hidden" name="datenew1" id="datenew1" value=""></input>
  <input type="hidden" name="datenew2" id="datenew2" value=""></input>       
  <input type="hidden" name="HOD" id="HOD" value=""></input>   
    <input type="hidden" name="Dept" id="Dept" value=""></input>       
        <input type="hidden" name="Usern" id="Usern" value=""></input>  
                <input type="hidden" name="Status" id="Status" value=""></input>       
                                <input type="hidden" name="Role" id="Role" value=""></input>       
                
             
    
<!-- <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#addMyModal">Open Modal</button>
 -->
  
  
      
  

  
<script>
$(function() {
	var vale=$("#status").val();
	 // alert(vale);
	  if(vale=="Select")
		  {
		 // alert("IN");
		  }
	  vale="";
	  //alert(vale);
	  
		document.getElementById('status').value = vale;
		//alert(status);
			

		var vale2=$("#status").val();
		//	alert(vale2);


	  $("#newModalForm").validate({
		  
	    rules: {
	    	comments31: {
	        required: true,
	      },
	      status: "required"
	    },
	    messages: {
	    	comments31: {
	        required: "Please Enter Comments",
	      },
	      status: "Select Status"
	      }
	    
	    
	  });
	  
	  
	  
	});
</script> 
  
<div class="modal fade" id="addMyModal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
       <div align="center">
          <h4 class="modal-title" style=" background-color: #1582AB;color: white;">Task Missed</h4>
        	</div>
        
        UserID:<input type="text" id="usrid1" readonly="readonly" style="width: 25%;border: none; font-weight:bold;">&nbsp;&nbsp;&nbsp;<br>
        
        
        Task Description:<input type="text" id="tsk1" readonly="readonly" style="width: 70%;border: none; font-weight:bold;">&nbsp;&nbsp;<br>
        
        
        TaskID:<input type="text" id="tskid" readonly="readonly" style="width: 25%;border: none; font-weight:bold;">&nbsp;&nbsp;
 
        </div>
    <div class="modal-body">
        <div align="center">
        
        <div id="show" class="headerlay" style="background-color: #ffffff; margin-left: 4px;">
        
     
        
<div class="container-fluid">
 
   <div class="row">
 <div class="col-sm-2">
 <b></b>
 </div>
 </div>
 </div>
 </div>
 </div>
 
  
    
        <form role="form" action="OPTaskNextKRA.jsp" id="newModalForm" name="form1" method="post" enctype="multipart/form-data">
        
    <%int counter=0;%>
   <input type="hidden"  name="counter" id="counter" value="<%=counter%>"></input>
   <input type="hidden"  name="DeptHidden" id="DeptHidden" ></input>
   <input type="hidden"  name="UsernHidden" id="UsernHidden" ></input>
	<input type="hidden"  name="HODHidden" id="HODHidden" ></input>
	<input type="hidden"  name="datenew1Hidden" id="datenew1Hidden" ></input>
	<input type="hidden"  name="datenew2Hidden" id="datenew2Hidden" ></input>
	<input type="hidden"  name="StatusHidden" id="StatusHidden" ></input>
	<input type="hidden"  name="RoleHidden" id="RoleHidden" ></input>
	<input type="hidden"  name="usrid1hidden" id="usrid1hidden" ></input>
	<input type="hidden"  name="tsk1hidden" id="tsk1hidden" ></input>
	<input type="hidden"  name="tskidhidden" id="tskidhidden" ></input>
	<input type="hidden"  name="satathidden" id="satathidden" ></input>
	<input type="hidden"  name="other12hidden" id="other12hidden" ></input>
	<input type="hidden"  name="comments31hidden" id="comments31hidden" ></input>
	
			<input type="hidden"  name="flagvalue" id="flagvalue" value="<%=counter%>"></input>
	   
 	<center>
   <table border="1" >
   
   <tr>
          <div class="form-group" align="left">
            <label class="control-label col-md-3" for="email">Status(Current)*:</label>
            
<select name="status" id="status" onchange="fun()";  style="width: 100px; height:20px; border: 1px solid black; " require>

<!--   	  				<option id="Process">Select</option>
 --> 
     <option value="" disabled selected>Select</option>
    	  				<option id="Process">In Progress</option>
 
  	  	  				<option id="Submitted">Completed</option>
  	
  	  				</select>
  	  		</div>
  	  </tr>
  	  
  	  <tr>		
          
         <div class="form-group" align="left">
            <label class="control-label col-md-3" for="email">Comments*:</label>
      <textarea id="comments31"  name="comments31" rows="2" cols="15"  placeholder="Comments" require></textarea><br></br>
                  </div>
                  
               </tr>
         <tr>	       
           
                  <div class="form-group" align="left">
           <div id="per">
                      </div>
                       </div>
                    
           </tr>         
                    
                     
   <tr  >
   
    <td style="width:285px;" valign="top" align="left" colspan="3"><b><a href="#!" onclick="attach();"><font size="2" face="Arial">Attach File</font></a></b><font size="1" color="black" face="Arial">&nbsp;&nbsp;(You can attach a file related to this task.)&nbsp;</font></td> 

  </tr>     
			
          <tr align="center" id="tr1" style="display:none;">               
               <td align="center"><input type="file" cols="40" name="Filename1" id="up" value="" onchange="upload();"/></td>
                      <td style="display: none;width: 20%;" id="imageDiv" align="left" colspan="2"><font size="2" face="Arial" color="black" id="f1"></font></td>
                      <td>&nbsp;&nbsp;&nbsp;<b><a href="#!" onclick="cancel();"><font size="2" face="Arial">Remove</font></a></b></td>
             </tr>
                     
                   <tr align="center" id="tr2" style="display: none;" >  <td></td> <td></td><td></td>        
                   <td  align="center"><b> &nbsp;&nbsp;<a href="#!" onclick="attach1();"><font size="2" face="Arial">AttachMoreFiles</> </font></a></td></tr>
		            <tr align="center" id="tr5" style="display: none;" >
		             
                    <td>&nbsp;&nbsp;<input type="file" cols="40" name="Filename2" value="" id="up1"  onchange="upload1();"/></td>
                   <td style="display: none;width: 20%;" id="imageDiv1" align="left" colspan="2"><font size="2" face="Arial" color="black" id="f2"></font></td>
                  <td>&nbsp;&nbsp;&nbsp; <b><a href="#!" onclick="cancel1();"><font size="2" face="Arial">Remove</font></a></b></td>
                  </tr>
                    <tr align="center" id="tr6" style="display: none;" >   <td></td> <td></td><td></td>                     
                    <td valign="top" align="right"><b>&nbsp;&nbsp; <a href="#!" onclick="attach2();"><font size="2" face="Arial">AttachMoreFiles </font></a></td></tr>
		            <tr align="center" id="tr7" style="display: none;" >
		               
                       <td>&nbsp;&nbsp;<input type="file" cols="40" name="Filename3" value="" id="up2"  onchange="upload2();"/></td>
                      <td style="display: none;width: 20%;" id="imageDiv2" align="left" colspan="2"><font size="2" face="Arial" color="black" id="f3"></font></td>
                     <td>&nbsp;&nbsp;&nbsp;<b><a href="#!" onclick="cancel2();"><font size="2" face="Arial">Remove</font></a></b></td>
                    </tr>     
                    <tr align="center" id="tr8" style="display: none;" >  <td></td> <td></td><td></td>                      
                      <td valign="top" align="left"><b>&nbsp;&nbsp; <a href="#!" onclick="attach3();"><font size="2" face="Arial">AttachMoreFiles </font></a></td></tr>
		               <tr align="center" id="tr9" style="display: none;" >
		                
                    <td>&nbsp;&nbsp;<input type="file" cols="40" name="Filename4" value="" id="up3"  onchange="upload3();"/></td>
                   <td style="display: none;width: 20%;" id="imageDiv3" align="left" colspan="2"><font size="2" face="Arial" color="black" id="f4"></font></td>
                  <td>&nbsp;&nbsp;&nbsp;<b><a href="#!" onclick="cancel3();"><font size="2" face="Arial">Remove</font></a></b></td>
                 </tr>
                          
                  <tr align="center" id="tr10" style="display: none;" >  <td></td> <td></td><td></td>       
                   <td valign="top" align="left"><b>&nbsp;&nbsp; <a href="#!" onclick="attach4();"><font size="2" face="Arial">AttachMoreFiles </font></a></td></tr>
		             <tr align="center" id="tr11" style="display: none;" >
		                  <td>&nbsp;&nbsp;<input type="file" cols="40" name="Filename5" value="" id="up4"  onchange="upload4();"/></td>
                     <td style="display: none;width: 20%;" id="imageDiv4" align="left" colspan="2"><font size="2" face="Arial" color="black" id="f5"></font></td>
                     <td>&nbsp;&nbsp;&nbsp;<b><a href="#!" onclick="cancel4();"><font size="2" face="Arial">Remove</font></a></b></td>
                   </tr>   
                    
            </table>  
          <div class="modal-footer">
            <button type="submit" class="btn btn-success" id="btnSaveIt" onclick="return approve1()" ">Save</button>
            <button type="button" class="btn btn-default" id="btnCloseIt" data-dismiss="modal">Close</button>
          </div>
      
        </form>
      </div>
      </div>
      </div>
      </div>
 
<div class="modal fade" id="addMyModall" role="dialog"><!-- demoo()  -->
  <div class="modal-dialog">
    <div class="modal-content">
    <form action="OPKRANextAdd.jsp"  method="get" >
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
       <div align="center">
          <h4 class="modal-title" style=" background-color: #1582AB;color: white;">Task Assigned</h4>
        	</div>
        
         
        
        UserID:<input type="text" id="usrid12" readonly="readonly" style="width: 25%;border: none; font-weight:bold;">&nbsp;&nbsp;&nbsp;<br>
        
        
        Task Name:<input type="text" id="tsk11" readonly="readonly" style="width: 70%;border: none; font-weight:bold;">&nbsp;&nbsp;<br>
        
        
        TaskID:<input type="text" id="tskid1" readonly="readonly" style="width: 25%;border: none; font-weight:bold;">&nbsp;&nbsp;
 
        </div>
    <div class="modal-body">
        <div align="center">
        
        <div id="show" class="headerlay" style="background-color: #ffffff; margin-left: 4px;">
        
     
        
<div class="container-fluid">
 
   <div class="row">
 <div class="col-sm-2">
 <b></b>
 </div>
 </div>
 </div>
 </div>
 </div>
 
  
    
                         
        	               
 <table border="1" >
 <tr>		
 <div class="form-group" align="left">
            <label class="control-label col-md-3" for="email">Task Description*:</label>
            <textarea id="comments311"  name="comments311" rows="5" cols="30"  placeholder="Description" require></textarea><br></br>
    </div>
  </tr>
                 
                    
                    </table>
                    
                            <input type="hidden"  name="datefrom" id="datefrom" value="" />
                	        <input type="hidden"  name="dateto" id="dateto" value="" />
                        	<input type="hidden"  name="HOD1" id="HOD1" value="" />
                        	<input type="hidden"  name="Dept1" id="Dept1" value="" />
                        	<input type="hidden"  name="usrid11" id="usrid11" value="" />
                        	<input type="hidden"  name="Usern1" id="Usern1" value="" />
                        	<input type="hidden"  name="Status1" id="Status1" value="" />
                        	<input type="hidden"  name="Task1" id="Task1" value="" />
  
          <div class="modal-footer">
            <button type="submit" class="btn btn-success" id="btnSaveIt1">Save</button>
            <button type="button" class="btn btn-default" id="btnCloseIt1" data-dismiss="modal">Close</button>
          </div>
     
  
     
     </div>
     </form>
     </div>
    </div>
    </div>




</head>


<%!
Connection con1,conn1;

Statement st=null,st1=null,st2=null,stmt1=null,stmt2=null,stmt3=null;
%>
<%
Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
 st1=con1.createStatement();
 st2=con1.createStatement();

conn1=DriverManager.getConnection(postgresString,postgresUser,postgresPass); //postgresql
 
stmt1 = conn1.createStatement(); //all postgres queries
stmt2 = conn1.createStatement(); //all postgres queries
stmt3 = conn1.createStatement(); //all postgres queries


%>



<% 
String query12="";

ResultSet rs=null;
ResultSet rs1=null;


String type=request.getParameter("status");
//type="Customer";
System.out.println("-------->"+type);

String Sesrole2=session.getAttribute("role").toString();



%>
<%
   Statement st = null;
%>
<%
String datenew1="";
String datenew2="";
String date1 = "";
String date2 = "";
String dept = "";
String user_id1 = "";
String tDate1 = "";
String tDate2 = "";
String totalTask = request.getParameter("totalTask");
String frmDate = request.getParameter("frmDate");
String toTime = request.getParameter("toTime");
String user_id = request.getParameter("user_id");
System.out.println("user_id::"+user_id);

String user_name = request.getParameter("user_name");

String UserID="";
String fromdate="";
String todate="";
String HOD="";
String Dept="";
String User="";
String Status="",s="";
String Role="";
String EmpName1="";
String openprojectid = "";

//String FileUploadPath =getServletContext().getInitParameter("configuredUploadDirtwo");

String department="";


Class.forName("com.mysql.cj.jdbc.Driver");
//conn = DriverManager.getConnection("jdbc:mysql://115.112.36.134/dotproject","erp","1@erp");
//conn = DriverManager.getConnection("jdbc:mysql:// twdb.fleetview.in/dotproject","erp","1@erp");
conn =DriverManager.getConnection("jdbc:mysql://"+host1+"/dotproject",user1,pass1);
//conn = DriverManager.getConnection("jdbc:mysql://164.68.105.216/dotproject","erp","1@erp");
//conn = DriverManager.getConnection("jdbc:mysql://192.168.2.55/dotprojectfortesting","erp","1@erp");
//conn = DriverManager.getConnection("jdbc:mysql://192.168.2.55/dotproject","erp","1@erp");

st=conn.createStatement();

System.out.println("The total Tasks is :"+totalTask);
System.out.println("The frmDate is :"+frmDate);
System.out.println("The toTime is :"+toTime);
System.out.println("The user_id is :"+user_id);
System.out.println("The username is :"+user_name);

String Sesrole1=session.getAttribute("role").toString();


%>
<input type="hidden" id="role" name="role" value="<%=Sesrole1%>" />
<%

String Bt1=request.getParameter("button2");
System.out.println("----------In Button-------------11111111111"+Bt1);
		if(Bt1==null || Bt1=="null" || Bt1.equals("null"))
		{

	
	System.out.println("==in if==");
	datenew1 = request.getParameter("fromdate");
	datenew2 = request.getParameter("todate");

	
	 UserID=request.getParameter("userid");
	System.out.println("UserID::"+UserID);
	openprojectid = UserID;
	 fromdate=request.getParameter("fromdate");
	System.out.println("fromdate::"+fromdate);
	 todate=request.getParameter("todate");
		System.out.println("todate::"+todate);
	 HOD=request.getParameter("HOD");
		System.out.println("HOD::"+HOD);
	 Dept=request.getParameter("Dept");
		System.out.println("Dept::"+Dept);
	 User=request.getParameter("User");
		System.out.println("User::"+User);
	 Status=request.getParameter("Status");
		System.out.println("Status::"+Status);
	 Role=request.getParameter("role");
		System.out.println("role::"+Role);
		
		 
		if(Status.equals("Submited"))
		{
			System.out.println("IN SUBMITED");
			Status="Submitted";
		} 
			

	
	Calendar cal = Calendar.getInstance();
	String today_dt = new SimpleDateFormat("dd-MMM-yyyy")
			.format(cal.getTime());
	String data2 = today_dt;
	String temp = data2;
	String toDate = new SimpleDateFormat("yyyy-MM-dd")
			.format(new SimpleDateFormat("dd-MMM-yyyy").parse(temp));

	//cal.add(Calendar.DATE, -1);
	cal.set(Calendar.DAY_OF_MONTH, 1);
	String yesterday_dt = new SimpleDateFormat("dd-MMM-yyyy")
			.format(cal.getTime());
	String data1 = yesterday_dt;
	temp = data1;
	String fromDate =new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
	String fromDate1 =new SimpleDateFormat("dd-MMM-yyyy").format(cal.getTime());
	
	datenew1 = fromdate;
	datenew2 = todate;
	
	if(Sesrole1.equals("HOD") || Sesrole1.equals("AllAdmin"))
	{
		datenew1 = ""+datenew1;
		System.out.println("IN datenew1:: "+datenew1);

		datenew2 = ""+datenew2;
		System.out.println("IN datenew2:: "+datenew2);

	}
	else
	{
	tDate1 = datenew1;
	tDate2 = datenew2;
	}
}
else
{

	System.out.println("==in else==");
	datenew1 = request.getParameter("from_date1");
	System.out.println("IN datenew1"+datenew1);

	datenew2 = request.getParameter("to_date1");
	System.out.println("IN datenew12"+datenew2);

	
	 UserID=request.getParameter("userid");
	System.out.println("UserID::"+UserID);
	 openprojectid = UserID;
	
	 fromdate=request.getParameter("fromdate");
	System.out.println("fromdate::"+fromdate);
	 todate=request.getParameter("todate");
		System.out.println("todate::"+todate);
	 HOD=request.getParameter("HOD");
		System.out.println("HOD::"+HOD);
	 Dept=request.getParameter("Dept");
		System.out.println("Dept::"+Dept);
	 User=request.getParameter("User");
		System.out.println("User::"+User);
	 Status=request.getParameter("status");
		System.out.println("Status::"+Status);
	 Role=request.getParameter("role");
		System.out.println("role::"+Role);
		
		
		if(Status.equals("Submited"))
		{
			System.out.println("IN SUBMITED");
			Status="Submitted";
		}
			
 date1 = datenew1;
 date2 = datenew2;
 
 	tDate1 = date1;
	tDate2 = date2;
}

/* DateFormat df123= new SimpleDateFormat("dd-MMM-yyyy");
DateFormat df1234= new SimpleDateFormat("yyyy-MM-dd");
String dataDate1=df1234.format(df123.parse(datenew1));
String dataDate2=df1234.format(df123.parse(datenew2));
 */

 
 %>
 
 
		<input type="hidden" id="fromdate" name="fromdate" value="<%=datenew1%>" />
		<input type="hidden" id="todate" name="todate" value="<%=datenew2%>" />
		
 <% 
String name=session.getAttribute("EmpName").toString();
String sessiondept=session.getAttribute("department").toString();
%>

<body>

	<input type="hidden" id="sesname" name="sesname" value="<%=name%>" />
	
				<form name="custreport" id="custreport" method="post">
		
<table border="0" align="center" width="100%">
<tr><td align="center"><font color="black" size="3"><b>KRA Task Report </b></font></td></tr>
<tr></tr>
<tr>
<td>
<br>
<table border="0" width="60%" align="center">
<tr>

<td>

         <td bgcolor="#f5f5f5" align="center"><font size="2"><b>Dept</b></font></td>
           <td bgcolor="#f5f5f5" align="center"><select name="companyName1" id="companyName1" onchange="consig();" style="width: 70px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
         
         <%	String Bt4=request.getParameter("button2");
  		

          System.out.println("-INNNNNNNNNNNN-------------"+Bt4);
          if(Bt4==null || Bt4=="null" || Bt4.equals("null"))
        	  {%>

          
          <%if(Sesrole1.equals("AllAdmin")) {
           %>
            <option value="<%=Dept%>"><%=Dept%></option>
           <option value="All">All</option>
          
            
            <%} 
            else
            { %>
            <option value="<%=Dept%>"><%=Dept%></option>
            <%} %>
            <%}
            else 
            {
            System.out.println("INNN Elseeeeeeeee");
            String seldept=request.getParameter("companyName1"); 
    	    System.out.println("******seldept*"+seldept);
    	    if(Sesrole1.equals("AllAdmin")) {
           %>
            
             <option value="<%=seldept%>"><%=seldept%></option>
                        <option value="All">All</option>
             
             <%} 
            else
            {%>
            <option value="<%=seldept%>"><%=seldept%></option>
            <%}  } %>
            <%
           
            String sql1="";
            
             if(Sesrole1.equals("AllAdmin"))
        	
        	{
            	sql1="select distinct(dept) as department  from db_GlobalERP.UserMaster where  companymasterid="+session.getAttribute("CompanyMasterID").toString()+"  and ActiveStatus='Yes' and dotprojectid!='-'order by dept";
        	}
             
            else if (Sesrole1.equals("HOD"))
             {
            	sql1="select distinct(dept) as department  from db_GlobalERP.UserMaster where (HODReport='"+session.getAttribute("EmpName").toString()+"' OR EmpName='"+session.getAttribute("EmpName").toString()+"') and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"  and ActiveStatus='Yes' and dotprojectid!='-' order by dept";
             }
            else
            {
            	sql1="select distinct(dept) as department  from db_GlobalERP.UserMaster where EmpName='"+session.getAttribute("EmpName").toString()+"' and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"  and ActiveStatus='Yes' and dotprojectid!='-' order by dept";
            }
            	 
           	
		System.out.println("*******"+sql1);
        ResultSet rsregno = st.executeQuery(sql1);
		while(rsregno.next())
		{
			 
			department=rsregno.getString("department");
			// customer=customer.replaceAll("&", "*");
			 //customer=customer.replaceAll("&", "*");
			 
			 System.out.println("department-->"+department);
			%>
			
			<option value="<%=department%>"><%=department%></option>
	         <%
	        // customer=customer.replaceAll("&", "..");
      }
		%>
           </select>
           </td>

<td>
         <td bgcolor="#f5f5f5" align="center"><font size="2"><b>Name</b></font></td>
           <td bgcolor="#f5f5f5" align="center"><select  id="EmpName" name="EmpName" style="width: 170px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
            <%	String Bt2=request.getParameter("button2");
  		

          System.out.println("-INNNNNNNNNNNN-------------"+Bt2);
          if(Bt2==null || Bt2=="null" || Bt2.equals("null"))
        	  {%>
          <%if(Sesrole1.equals("AllAdmin")) {
           %>
                      <option value="<%=User%>"><%=User%></option>
           
           <option value="All">All</option>
           
           <%} else
           {%>
           <option value="<%=User%>"><%=User%></option>
           <%} }
            else 
            {
            System.out.println("INNN Elseeeeeeeee");
             EmpName1=request.getParameter("EmpName"); 
    	    System.out.println("******EmpName*"+EmpName1);
    	    if(Sesrole1.equals("AllAdmin")) {
           %>
            
             <option value="<%=EmpName1%>"><%=EmpName1%></option>
                        <option value="All">All</option>
             
             <%} 
            else
            {%>
            <option value="<%=EmpName1%>"><%=EmpName1%></option>
            <%}  } %>
          
           </select>
           </td>
           <td>

         <td bgcolor="#f5f5f5" align="center"><font size="2"><b>Status</b></font></td>
           <td bgcolor="#f5f5f5" align="center"><select name="status" id="status" style="width: 100px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
<%--             <option ><%=Status %></option>
 --%>                        <%
            String sql14="";
            
             
            	sql1="select distinct(TaskStatus) as status from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildataCopy where TaskStatus!='Duplicate'";
            
            	 
            	 
            	 
        System.out.println("*******"+sql1);
        ResultSet rsregno123 = st.executeQuery(sql1);
		while(rsregno123.next())
		{
			 
			s=rsregno123.getString("status");
			// customer=customer.replaceAll("&", "*");
			 //customer=customer.replaceAll("&", "*");
			 
			 System.out.println("s-->"+s);
			%>
			<option value="<%=s%>" <% if(Status.equalsIgnoreCase(s)){ %> Selected <%}%> ><%=s%></option>
	         <%
	        // customer=customer.replaceAll("&", "..");
      }
		%>
           </select>
           </td>
            


<td bgcolor="#f5f5f5" align="center"><font size="2"><b>From Date</b></font></td>
<td bgcolor="#f5f5f5" align="center"><font size="2">

			<input type="text" id="data" name="from_date1" size="12" value="<%=datenew1%>" 
			style="width: 90px; height: 20px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF;"readonly />
			<script type="text/javascript">
					  Calendar.setup(
					    {
					      inputField  : "data",         // ID of the input field
					      ifFormat    : "%d-%b-%Y",    // the date format
					      button      : "data"       // ID of the button
					    }
					  );
				</script>

		</font>
</td>
<td bgcolor="#f5f5f5" align="center"><font size="2"><b>To Date</b></font></td>
<td bgcolor="#f5f5f5" align="center"><font size="2">
		
			<input type="text" id="data1" name="to_date1" size="12" value="<%=datenew2%>"
			style="width: 90px; height: 20px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF;" readonly />
				<script type="text/javascript">
					  Calendar.setup(
					    {
					      inputField  : "data1",         // ID of the input field
					      ifFormat    : "%d-%b-%Y",    // the date format
					      button      : "trigger1"       // ID of the button
					    }
					  );
				</script>
		
		</font>
</td>
<td bgcolor="#f5f5f5" align="center"><font size="2">
<input type="submit" name="button2" id="button2" value="Submit" onclick="return hello()"  style="background-color:#f5f5f5; ">

</input></font></td>
</tr>
</table>
<br>

</td>
</tr>

</table>
</form>
		
		
<%
System.out.println("status::"+Status);
%>		
<%
if(Status.equals("Assigned")||Status.equals("Missed"))
{
%>
<div class="t1" style="width:100%">
<table id="example"  class="display"  a style="width:100%"  cellspacing="0" border="1"> 

<thead>


<tr>
<th style="font-size:11px ; background: #1582AB;  color:white;face:san-serif" align="centre">SrNo</th>
<th style="font-size:11px ; background: #1582AB;  color:white;face:san-serif;">User</th>


<th style="font-size: 11px ;background: #1582AB;  color:white;face:san-serif;">UserID</th>
<th style="font-size: 11px ;background: #1582AB;  color:white;face:san-serif;">TaskID</th>
<th style="font-size: 11px ; background: #1582AB;  color:white;face:san-serif;">TaskName</th>
<th style="font-size: 11px ;background: #1582AB;  color:white;face:san-serif;">TaskDescription</th>
<th style="font-size: 11px ;background: #1582AB;  color:white; face:san-serif;">Duration</th>
<th style="font-size: 11px ;background: #1582AB;  color:white; face:san-serif;">StartDate</th>
<th style="font-size: 11px ;background: #1582AB;  color:white; face:san-serif;">EndDate</th>

 <th style="font-size:11px ;background:#1582AB;  color:white; face:san-serif;">Status</th>

</tr>
</thead>
  
            <%} 
            else
            {%>
            <div class="t1" style="width:100%">
<table id="example"  class="display"  a style="width:100%"  cellspacing="0" border="1"> 

<thead>


<tr>
<th style="font-size:11px ; background: #1582AB;  color:white;face:san-serif" align="centre">SrNo</th>
<th style="font-size:11px ; background: #1582AB;  color:white;face:san-serif;">User</th>


<th style="font-size: 11px ;background: #1582AB;  color:white;face:san-serif;">UserID</th>
<th style="font-size: 11px ;background: #1582AB;  color:white;face:san-serif;">TaskID</th>
<th style="font-size: 11px ; background: #1582AB;  color:white;face:san-serif;">TaskName</th>
<th style="font-size: 11px ;background: #1582AB;  color:white;face:san-serif;">TaskDescription</th>
<th style="font-size: 11px ;background: #1582AB;  color:white; face:san-serif;">Duration</th>
<th style="font-size: 11px ;background: #1582AB;  color:white; face:san-serif;">StartDate</th>
<th style="font-size: 11px ;background: #1582AB;  color:white; face:san-serif;">EndDate</th>
 <th style="font-size:11px ;background:#1582AB;  color:white; face:san-serif;">Percentage</th>
 <th style="font-size:11px ;background:#1582AB;  color:white; face:san-serif;">Comment</th>
<th style="font-size:11px ;background:#1582AB;  color:white; face:san-serif;">Attachment</th>

 <th style="font-size:11px ;background:#1582AB;  color:white; face:san-serif;">Status</th>
 <th style="font-size:11px ;background:#1582AB;  color:white; face:san-serif;">RejectedComment</th>

</tr>
</thead>
              <%} %>

<tbody>
<%
	String fromDate = "", toDate = "",fromDate1="";
	String data2="",data1="";
	String CustomerCode="";
	String dotprojectid="";
	
	String stp="Pending";
	String comid=session.getAttribute("CompanyMasterID").toString();
	
	
	
	
	//CompanyName ---->null
	String dd = request.getParameter("data");
	if (dd == null) {
		Calendar cal = Calendar.getInstance();
		String today_dt = new SimpleDateFormat("dd-MMM-yyyy")
				.format(cal.getTime());
		data2 = today_dt;
		String temp = data2;
		toDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy").parse(temp));

		//cal.add(Calendar.DATE, -1);
		cal.set(Calendar.DAY_OF_MONTH, 1);
		String yesterday_dt = new SimpleDateFormat("dd-MMM-yyyy")
				.format(cal.getTime());
		data1 = yesterday_dt;
		temp = data1;
		fromDate =new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
		fromDate1 =new SimpleDateFormat("dd-MMM-yyyy").format(cal.getTime());

	} else {

		data1 = request.getParameter("data");
		System.out.println("Data 1-->"+data1);
		

		fromDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(data1));
		fromDate1 =request.getParameter("data");
		
		data2 = request.getParameter("data1");
		System.out.println("Data 2-->"+data2);
		toDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(data2));  

	} //end of else
%>
<%Date d=new Date();
	
String user="";
	Format df1= new SimpleDateFormat("dd-MMM-yyyy");
	String dtoday=df1.format(d);
	
	DateFormat df= new SimpleDateFormat("dd-MMM-yyyy");
	DateFormat d1= new SimpleDateFormat("yyyy-MM-dd"); 
	
	
	
	String name1=session.getAttribute("EmpName").toString();
	String department1=session.getAttribute("department").toString();

		
		
		
		String dt = new SimpleDateFormat("yyyy-MM-dd")
		.format(new SimpleDateFormat("dd-MMM-yyyy")
				.parse(datenew1));
		dt=dt+" 00:00:00";
		String dt1 = new SimpleDateFormat("yyyy-MM-dd")
		.format(new SimpleDateFormat("dd-MMM-yyyy")
				.parse(datenew2));
		dt1=dt1+" 23:59:59";
		
		System.out.println("dt:- "+dt);
		System.out.println("dt1:- "+dt1);
		System.out.println("fromDate1:- "+datenew1);
		System.out.println("dtoday:- "+datenew2);
		
		//cmp=cmp.replace("...","&");
		//cmp=cmp.replace("&","%26");
		%>
		
	<input type="hidden" id="comid" name="comid" value="<%=comid%>" />
		<input type="hidden" id="fromdate" name="fromdate" value="<%=datenew1%>" />
		<input type="hidden" id="todate" name="todate" value="<%=datenew2%>" />
		
		
		
<%
String name13="";
		String Bt=request.getParameter("button2");
System.out.println("----------In Button-------------"+Bt);
		if(Bt==null || Bt=="null" || Bt.equals("null"))
		{
			
			
			String POStatus="Pending";
			String comid2=session.getAttribute("CompanyMasterID").toString();
			 name13=session.getAttribute("EmpName").toString();
		//	String Sesrole2=session.getAttribute("role").toString();
			System.out.println("Role :- "+Sesrole2);

System.out.println("department-->"+department);
			
			String seldept=request.getParameter("companyName1"); 
        	System.out.println("******seldept*"+seldept);
        	
        	if(Sesrole2.equals("AllAdmin") || Sesrole2.equals("HOD"))
        	{
        		name13=User;	
        	}
        	else
        	{
        		name13=""+name13;
        	}
        	if(Sesrole2.equals("AllAdmin"))
        			{
        		department=Dept;
            	System.out.println("departmentkkk :- "+department);

        			}
        	else
        	{
        		department=Dept;
            	System.out.println("departmentggfgh :- "+department);

        	}
        	
        	
        	System.out.println("Date :- "+datenew1);
        	
        	System.out.println("Date :- "+datenew2);
        	System.out.println("Name :- "+name13);
        	
        	if(name13.equals("All"))

        	{
        		name13="";
        	}
        	
        	
        if(Status.equals("Assigned"))
        {
        	
			System.out.println("IN Assigned");

/*         	query12="select c.EmpName as User ,c.dotprojectid as UserID,a.task_id as TaskId,a.task_name as TaskName,a.task_duration as Duration,date_format(a.task_start_date,'%d-%b-%Y %T' ) as StartDate,date_format(a.task_end_date,'%d-%b-%Y %T') as EndDate  from dotproject.tasks a left join dotproject.user_tasks b on a.task_id=b.task_id left join db_GlobalERP.UserMaster c  on c.dotprojectid=b.user_id where task_end_date >='"+dt+"' and task_end_date <='"+dt1+"'  and c.EmpName like '%"+name13+"%'  and c.dept like '%"+department+"%'";
 */
 
 //query12="select c.EmpName as User ,c.KRAdotprojectid as UserID,a.task_id as TaskId,a.task_name as TaskName,a.task_duration as Duration,date_format(a.task_start_date,'%d-%b-%Y %T' ) as StartDate,date_format(a.task_end_date,'%d-%b-%Y %T') as EndDate  from dotproject.tasks a left join dotproject.user_tasks b on a.task_id=b.task_id left join db_GlobalERP.UserMaster c  on c.KRAdotprojectid=b.user_id where task_end_date >='"+dt+"' and task_end_date <='"+dt1+"'  and c.EmpName like '%"+name13+"%'  and c.dept like '%"+department+"%'";
 //query12="select c.EmpName as User ,c.KRAdotprojectid as UserID,a.task_id as TaskId,a.task_name as TaskName,a.task_description as TaskDescription,a.task_duration as Duration,date_format(a.task_start_date,'%d-%b-%Y %T' ) as StartDate,date_format(a.task_end_date,'%d-%b-%Y %T') as EndDate  from dotproject.tasks a left join dotproject.user_tasks b on a.task_id=b.task_id left join db_GlobalERP.UserMaster c  on c.KRAdotprojectid=b.user_id where task_end_date >='"+dt+"' and task_end_date <='"+dt1+"'  and c.EmpName like '%"+name13+"%'  and c.dept like '%"+department+"%'";       
query12="select a.id as TaskId,a.assigned_to_id as UserID,CONCAT(b.firstname, ' ', b.lastname) AS User,a.subject as TaskName,a.description as TaskDescription ,  TO_CHAR(a.start_date, 'DD-Mon-YYYY HH24:MI:SS') AS StartDate,TO_CHAR(a.due_date, 'DD-Mon-YYYY 23:59:59') AS EndDate, a.estimated_hours as Duration from work_packages a JOIN users  b ON a.assigned_to_id = b.id where a.assigned_to_id="+openprojectid+" and due_date >= '"+dt+"' and due_date <='"+dt1+"' and a.type_id = 9 order by a.id asc";			
			System.out.println("query12---"+query12);
			rs=stmt1.executeQuery(query12);
			
			int i=1;
			
			while(rs.next())
			{
			
				String TaskId="",TaskName="",Duration="",StartDate="",EndDate="";
				String TaskDescription="";
				User=rs.getString("User");
				System.out.println("-User------->"+User);
				
				UserID=rs.getString("UserID");
				System.out.println("-UserID------->"+UserID);
				
				
				TaskId=rs.getString("TaskId");
				System.out.println("-TaskId------->"+TaskId);
				
				TaskName=rs.getString("TaskName");
				System.out.println("-TaskName------->"+TaskName);
				
				TaskDescription=rs.getString("TaskDescription");
				System.out.println("-TaskDescription------->"+TaskDescription);
				
				Duration=rs.getString("Duration");
				System.out.println("-Duration------->"+Duration);
				
				StartDate=rs.getString("StartDate");
				System.out.println("-StartDate------->"+StartDate);
				
				EndDate=rs.getString("EndDate");
				System.out.println("-EndDate------->"+EndDate);
				
			
			%>
			<tr>
						<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=i%></td>
						<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("UserID")%></td>
						<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=rs.getString("User")%></td>
						
					<%
					if(Sesrole2.equals("AllAdmin") || Sesrole2.equals("HOD")) {
					//if(Sesrole2.equals("AllAdmin") || Sesrole2.equals("HOD") || Sesrole2.equals("-") ) {  %>
						
						<td style="font-size: 11px; face:san-serif; color:black" align="right"><a data-toggle="modal" href="#addMyModall" onclick="return demoo('<%=datenew1%>','<%=datenew2%>','<%=HOD%>','<%=department%>','<%=User%>','<%=Status%>','<%=TaskName%>','<%=UserID%>','<%=TaskId%>')"><%=TaskId%></a></td>
						
						<% } else{ %>
						<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("TaskId")%></td>
						
						<% } %>
						
						<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=rs.getString("TaskName")%></td>
						<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=rs.getString("TaskDescription")%></td>
						<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("Duration")%></td>
						<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("StartDate")%></td>
						<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("EndDate")%></td>
						<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=Status%></td>
						
					 </tr>
			<%
			i++;
			}
        
        }
        else if(Status.equals("Missed"))
        {
/*         	query12="select c.EmpName as User ,c.dotprojectid as UserID,a.task_id as TaskId,a.task_name as TaskName,a.task_duration as Duration,date_format(a.task_start_date,'%d-%b-%Y %T' ) as StartDate,date_format(a.task_end_date,'%d-%b-%Y %T') as EndDate  from dotproject.tasks a left join dotproject.user_tasks b on a.task_id=b.task_id left join db_GlobalERP.UserMaster c  on c.dotprojectid=b.user_id where task_end_date >='"+dt+"' and task_end_date <='"+dt1+"'  and c.EmpName like '%"+name13+"%' and a.task_id not in (select distinct(TaskID) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata where TaskEndDate >='"+dt+"' and TaskEndDate <='"+dt1+"' and userid=c.dotprojectid)  and c.dept like '%"+department+"%'";
 */       
	System.out.println("IN Missed");

 //query12="select c.EmpName as User ,c.KRAdotprojectid as UserID,a.task_id as TaskId,a.task_name as TaskName,a.task_duration as Duration,date_format(a.task_start_date,'%d-%b-%Y %T' ) as StartDate,date_format(a.task_end_date,'%d-%b-%Y %T') as EndDate  from dotproject.tasks a left join dotproject.user_tasks b on a.task_id=b.task_id left join db_GlobalERP.UserMaster c  on c.KRAdotprojectid=b.user_id where task_end_date >='"+dt+"' and task_end_date <='"+dt1+"'  and c.EmpName like '%"+name13+"%' and a.task_id not in (select distinct(TaskID) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata where TaskEndDate >='"+dt+"' and TaskEndDate <='"+dt1+"' and userid=c.KRAdotprojectid)  and c.dept like '%"+department+"%'";
//query12="select c.EmpName as User ,c.KRAdotprojectid as UserID,a.task_id as TaskId,a.task_name as TaskName,a.task_description as TaskDescription,a.task_duration as Duration,date_format(a.task_start_date,'%d-%b-%Y %T' ) as StartDate,date_format(a.task_end_date,'%d-%b-%Y %T') as EndDate  from dotproject.tasks a left join dotproject.user_tasks b on a.task_id=b.task_id left join db_GlobalERP.UserMaster c  on c.KRAdotprojectid=b.user_id where task_end_date >='"+dt+"' and task_end_date <='"+dt1+"'  and c.EmpName like '%"+name13+"%' and a.task_id not in (select distinct(TaskID) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata where TaskEndDate >='"+dt+"' and TaskEndDate <='"+dt1+"' and userid=c.KRAdotprojectid)  and c.dept like '%"+department+"%'";
query12="select a.id as TaskId,a.assigned_to_id as UserID,CONCAT(b.firstname, ' ', b.lastname) AS User,a.subject as TaskName,a.description as TaskDescription ,  TO_CHAR(a.start_date, 'DD-Mon-YYYY HH24:MI:SS') AS StartDate,TO_CHAR(a.due_date, 'DD-Mon-YYYY 23:59:59') AS EndDate, a.estimated_hours as Duration from work_packages a JOIN users  b ON a.assigned_to_id = b.id where a.assigned_to_id="+openprojectid+" and due_date >= '"+dt+"' and due_date <='"+dt1+"' and a.type_id= 9 and a.status_id = 1 order by a.id asc"; 
System.out.println("query12---"+query12);
			rs=stmt2.executeQuery(query12);
			
			int i=1;
			while(rs.next())
			{
				String TaskId="",TaskName="",Duration="",StartDate="",EndDate="";
				String TaskDescription="";
				User=rs.getString("User");
				System.out.println("-User------->"+User);
				
				UserID=rs.getString("UserID");
				System.out.println("-UserID------->"+UserID);
				
				
				TaskId=rs.getString("TaskId");
				System.out.println("-TaskId------->"+TaskId);
				
				TaskName=rs.getString("TaskName");
				System.out.println("-TaskName------->"+TaskName);
				
				TaskDescription=rs.getString("TaskDescription");
				System.out.println("-TaskDescription------->"+TaskDescription);
				
				Duration=rs.getString("Duration");
				System.out.println("-Duration------->"+Duration);
				
				StartDate=rs.getString("StartDate");
				System.out.println("-StartDate------->"+StartDate);
				
				EndDate=rs.getString("EndDate");
				System.out.println("-EndDate------->"+EndDate);
				
			
			%>
			<tr>
						<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=i%></td>
						<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("UserID")%></td>
									<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=rs.getString("User")%></td>
<%-- 						<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("TaskId")%></td>
 --%>						<td style="font-size: 11px;" align="right">
 <a data-toggle="modal" href="#addMyModal" onclick="return demo('<%=datenew1%>','<%=datenew2%>','<%=HOD%>','<%=department%>','<%=rs.getString("User")%>','<%=Status%>','<%=Role%>','<%=rs.getString("TaskName")%>','<%=rs.getString("UserID")%>','<%=rs.getString("TaskId")%>')"><%=rs.getString("TaskId")%></a></td>
 					
						<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=rs.getString("TaskName")%></td>
						<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=rs.getString("TaskDescription")%></td>
						<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("Duration")%></td>
						<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("StartDate")%></td>
						<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("EndDate")%></td>
						<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=Status%></td>
						
					 </tr>
			<%
			i++;
			}
        
        
        
        }
        
        else if(Status.equals("Submitted"))
        {
			System.out.println("IN Submitted");

  
           query12="SELECT a.id AS TaskId, a.assigned_to_id AS UserID, CONCAT(b.firstname, ' ', b.lastname) AS User, a.subject AS TaskName, a.description AS TaskDescription, TO_CHAR(a.start_date, 'DD-Mon-YYYY HH24:MI:SS') AS StartDate, TO_CHAR(a.due_date, 'DD-Mon-YYYY 23:59:59') AS EndDate, a.estimated_hours AS Duration, a.done_ratio AS TaskPercent, c.comments  as TaskComment FROM  work_packages a JOIN  users b  ON  a.assigned_to_id = b.id JOIN  time_entries c  ON  a.id = c.work_package_id WHERE  a.assigned_to_id = '"+openprojectid+"'  AND a.due_date >= '"+dt+"'  AND a.due_date <= '"+dt1+"' AND a.status_id = 12  and a.type_id = 9 ORDER BY  a.id ASC";
        	System.out.println("query12---"+query12);
			rs=stmt3.executeQuery(query12);
			
			int i=1;
			
			while(rs.next())
			{
			
				String TaskId="",TaskName="",Duration="",StartDate="",EndDate="",Stat="",TaskPercent="",TaskComment="",TaskAttachment="";
				String TaskDescription="";
				User=rs.getString("User");
				System.out.println("-User------->"+User);
				
				UserID=rs.getString("UserID");
				System.out.println("-UserID------->"+UserID);
				
				//TaskAttachment=rs.getString("TaskAttachment");
				//System.out.println("TaskAttachment--------->"+TaskAttachment);
				//String[] TA=TaskAttachment.split(",");
				//System.out.println("-TA is is------->"+TA);
				//System.out.println("-Arrays.toString(TA) is ------->"+ Arrays.toString(TA));
				//TaskAttachment=rs.getString("TaskAttachment");
			System.out.println("TaskAttachment is ------->"+TaskAttachment);
			
			String[] TA=TaskAttachment.split(",");
			System.out.println("TA issssss------->"+TA[0]);
			System.out.println("Arrays.toString(TA) issssss------->"+ Arrays.toString(TA).substring(1,(Arrays.toString(TA)).trim().length()-1));
			
				
				TaskId=rs.getString("TaskId");
				System.out.println("-TaskId------->"+TaskId);
				
				TaskName=rs.getString("TaskName");
				System.out.println("-TaskName------->"+TaskName);
				
				TaskDescription=rs.getString("TaskDescription");
				System.out.println("TaskDescription------->"+TaskDescription);
				
				Duration=rs.getString("Duration");
				System.out.println("-Duration------->"+Duration);
				
				StartDate=rs.getString("StartDate");
				System.out.println("-StartDate------->"+StartDate);
				
				EndDate=rs.getString("EndDate");
				System.out.println("-EndDate------->"+EndDate);
				
				Stat="Submitted";
				System.out.println("-Stat------->"+Stat);
				

				TaskPercent=rs.getString("TaskPercent");
				System.out.println("-TaskPercent------->"+TaskPercent);
				
				TaskComment=rs.getString("TaskComment");
				System.out.println("-TaskComment------->"+TaskComment);
				
				
			
			%>
			<tr>
						<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=i%></td>
						<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("UserID")%></td>
									<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=rs.getString("User")%></td>
<%-- 						<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("TaskId")%></td>
 --%>					
 <td style="font-size: 11px;" align="right">
<%--  <a data-toggle="modal" href="#myModal1" onclick="return demo('<%=rs.getString("TaskName")%>','<%=rs.getString("UserID")%>','<%=rs.getString("TaskId")%>')"><%=rs.getString("TaskId")%></a></td>
 --%>  <a data-toggle="modal" href="#addMyModal" onclick="return demo('<%=datenew1%>','<%=datenew2%>','<%=HOD%>','<%=department%>','<%=rs.getString("User")%>','<%=Status%>','<%=Role%>','<%=rs.getString("TaskName")%>','<%=rs.getString("UserID")%>','<%=rs.getString("TaskId")%>')"><%=rs.getString("TaskId")%></a></td>
 
 	                    <td style="font-size: 11px; face:san-serif; color:black" align="left"><%=rs.getString("TaskName")%></td>
						<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=rs.getString("TaskDescription")%></td>
						<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("Duration")%></td>
						<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("StartDate")%></td>
						<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("EndDate")%></td>
						<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("TaskPercent")%></td>
					<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=rs.getString("TaskComment")%></td>
					<%-- <td style="font-size: 11px; face: san-serif; color: black"
							align="left"><a
							href="viewInvoice.jsp?InvoiceRefNo=<%=InvoiceNo1%>&Invoiceno=<%=invoiceno%>&condition=close"
							target="_blank"><%=InvoiceNo1%></a></td> --%>
						<%-- <td style="font-size: 11px; face:san-serif; color:black" align="left"><a href="file:///home/twtech/<%=rs.getString("TaskAttachment")%>"><%=rs.getString("TaskAttachment")%></a></td>
						 --%>
	<!--  <td style="font-size: 11px; face:san-serif; color:black" align="left"><a href="file:///home/twtech/Transworld-workspace/TWERPV21/WebContent/Accounts/163067angular2_mock_test_iv-230Jun201917:18:40.pdf" target="_blank">163067angular2_mock_test_iv-230Jun201917:18:40.pdf</a></td> 
	 -->	<td style="font-size: 11px; face:san-serif; color:black" align="left">
	 <%for (int k=0;k<TA.length;k++) {%>
	 <a href=Downloadtaskattachment.jsp?filename=<%=TA[k]%> target="_blank"><%=TA[k]%><% if(k<(TA.length-1)){%><%=","%><%} %></a>
				<%} %></td> 
				
				<%-- <td style="font-size: 11px; face:san-serif; color:black" align="left">
	 <%for (int k=0;k<TA.length;k++) {%>
	 <a href="Accounts/<%=TA[k]%>" target="_blank"><%=TA[k]%></a>
				<%} %></td> --%>
				
				
					<!-- <td style="font-size: 11px; face:san-serif; color:black" align="left"><a href="#" onclick="window.location='file:///home/twtech/163074angular2_mock_test_iv-229Jun201913:31:46.pdf'">163074angular2_mock_test_iv-229Jun201913:31:46.pdf</a></td>
					 -->	<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=Stat%></td>
					 <td style="font-size: 11px; face:san-serif; color:black" align="left">-</td>
						
					 </tr>
			<%
			i++;
			}
        
        
        }
        else
        {

			System.out.println("IN else");

			query12="SELECT distinct(a.taskId) as TaskId,a.UserId,b.EmpName AS USER,a.TaskName,a.TaskDescription AS TaskDescription,a.AssignedDuration AS Duration, a.TaskPercent,a.TaskComment AS TaskComment,a.TaskAttachment,DATE_FORMAT(a.TaskStartDate,'%d-%b-%Y %T' ) AS StartDate,DATE_FORMAT(a.TaskEndDate,'%d-%b-%Y %T') AS EndDate,a.TaskRejectionComment AS RejectionReason ,a.TaskStatus AS STATUS  FROM  db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildataCopy  a JOIN db_GlobalERP.UserMaster b  ON a.UserID=b.KRAdotprojectid  WHERE  b.empname LIKE '%"+name13+"%' AND b.companymasterid=100000 AND b.activestatus='Yes'  AND b.dept LIKE '%"+department+"%'  AND  a.TaskEndDate >='"+dt+"' AND a.TaskEndDate <='"+dt1+"' AND a.TaskStatus LIKE '%"+Status+"%' ORDER BY a.TaskID ";	
        	
            System.out.println("query12---"+query12);
			rs=st1.executeQuery(query12);
			
			int i=1;
			
			while(rs.next())
			{
			
				String TaskId="",TaskName="",Duration="",StartDate="",EndDate="",Stat="",TaskPercent="",TaskComment="",TaskAttachment="";
				String TaskDescription="",RejectionComment="";
				
				User=rs.getString("User");
				System.out.println("-User------->"+User);
				
				UserID=rs.getString("UserID");
				System.out.println("-UserID------->"+UserID);
				
				
				TaskId=rs.getString("TaskId");
				System.out.println("-TaskId------->"+TaskId);
				
				TaskName=rs.getString("TaskName");
				System.out.println("-TaskName------->"+TaskName);
				
				TaskDescription=rs.getString("TaskDescription");
				System.out.println("TaskDescription------->"+TaskDescription);
				
				Duration=rs.getString("Duration");
				System.out.println("-Duration------->"+Duration);
				
				StartDate=rs.getString("StartDate");
				System.out.println("-StartDate------->"+StartDate);
				
				EndDate=rs.getString("EndDate");
				System.out.println("-EndDate------->"+EndDate);
				
				Stat=rs.getString("Status");
				System.out.println("-Stat------->"+Stat);
				
				//TaskAttachment=rs.getString("TaskAttachment");
				//System.out.println("-TaskAttachment------->"+TaskAttachment);
				TaskAttachment=rs.getString("TaskAttachment");
				System.out.println("TaskAttachment is ------->"+TaskAttachment);
				
				String[] TA=TaskAttachment.split(",");
				System.out.println("TA issssss------->"+TA[0]);
				System.out.println("Arrays.toString(TA) issssss------->"+ Arrays.toString(TA).substring(1,(Arrays.toString(TA)).trim().length()-1));
				
				
				Arrays.toString(TA);
		        /* String CSV = "Google,Apple,Microsoft";

		        String[] values = CSV.split(",");

		        System.out.println(Arrays.toString(values)); 
		        Output :[Google, Apple, Microsoft]
		        */


				
				
				TaskPercent=rs.getString("TaskPercent");
				System.out.println("-TaskPercent------->"+TaskPercent);
				
				TaskComment=rs.getString("TaskComment");
				System.out.println("-TaskComment------->"+TaskComment);
				
				RejectionComment=rs.getString("RejectionReason");

				
			
			%>
			<tr>
						<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=i%></td>
						<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=UserID%></td>
						<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=User%></td>
<%-- 						<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("TaskId")%></td>
 --%>					
 <td style="font-size: 11px;" align="right">
<%--  <a data-toggle="modal" href="#myModal1" onclick="return demo('<%=rs.getString("TaskName")%>','<%=rs.getString("UserID")%>','<%=rs.getString("TaskId")%>')"><%=rs.getString("TaskId")%></a></td>
 --%> 		
 
  <a data-toggle="modal" href="#addMyModal" onclick="return demo('<%=datenew1%>','<%=datenew2%>','<%=HOD%>','<%=department%>','<%=rs.getString("User")%>','<%=Status%>','<%=Role%>','<%=rs.getString("TaskName")%>','<%=rs.getString("UserID")%>','<%=rs.getString("TaskId")%>')"><%=rs.getString("TaskId")%></a></td>
 			
 	<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=TaskName%></td>
 	<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=TaskDescription%></td>
						<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=Duration%></td>
						<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=StartDate%></td>
						<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=EndDate%></td>
						<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=TaskPercent%></td>
					<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=TaskComment%></td>
					<%-- <td style="font-size: 11px; face:san-serif; color:black" align="left"><%=rs.getString("TaskAttachment")%></td>
					 --%>
					<%--  <td style="font-size: 11px; face:san-serif; color:black" align="left"><a href="TaskAttachment=<%=rs.getString("TaskAttachment")%>" target="_blank"><%=rs.getString("TaskAttachment")%></a></td>
				 --%>	<%-- <td style="font-size: 11px; face:san-serif; color:black" align="left"><a href="file:///home/twtech/<%=rs.getString("TaskAttachment")%>"><%=rs.getString("TaskAttachment")%></a></td>
 --%>					
					<!-- <td style="font-size: 11px; face:san-serif; color:black" align="left"><a  href="file:///home/twtech/Transworld-workspace/TWERPV21/WebContent/Accounts/163067angular2_mock_test_iv-230Jun201917:18:40.pdf" target="_blank">file:///home/twtech/Transworld-workspace/TWERPV21/WebContent/Accounts/163067angular2_mock_test_iv-230Jun201917:18:40.pdf</a></td> 
 -->	<!-- <td style="font-size: 11px; face:san-serif; color:black" align="left"><a href="reports/cp.txt" target="_blank">163074angular2_mock_test_iv-229Jun201913:31:46.pdf</a></td> 
 -->	<%-- <td style="font-size: 11px; face:san-serif; color:black" align="left"><a href="Accounts/<%=rs.getString("TaskAttachment")%>" target="_blank"><%=rs.getString("TaskAttachment")%></a></td> 
		 --%>		
		<td style="font-size: 11px; face:san-serif; color:black" align="left">
	 <%for (int k=0;k<TA.length;k++) {%>
	 <a href=Downloadtaskattachment.jsp?filename=<%=TA[k]%> target="_blank"><%=TA[k]%><% if(k<(TA.length-1)){%><%=","%><%} %></a>
				<%} %>	</td> 
						<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=Status%></td>
						<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=RejectionComment%></td>
						
					 </tr>
			<%
			i++;
			}
        
        
        
        }

%>
    
			
		<% 
		}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		else
		{
			System.out.println("----------In Button-------------");

		String POStatus="Pending";
		String comid2=session.getAttribute("CompanyMasterID").toString();
		 name13=session.getAttribute("EmpName").toString();
	//	String Sesrole2=session.getAttribute("role").toString();
		System.out.println("Role :- "+Sesrole2);

		

		
		System.out.println("department-->"+department);
		
		String seldept=request.getParameter("companyName1"); 
    	System.out.println("******seldept*"+seldept);
    	
    	if(Sesrole2.equals("AllAdmin") || Sesrole2.equals("HOD"))
    	{
    		name13=EmpName1;	
    	}
    	else
    	{
    		name13=""+name13;
    	}
    	if(Sesrole2.equals("AllAdmin"))
    			{
    		      department=seldept;
    			}
    	else
    	{
    		department=seldept;
    	}
    	
    	System.out.println("Date :- "+datenew1);
    	
    	System.out.println("Date :- "+datenew2);
    	System.out.println("Name :- "+name13);
    	
    	if(name13.equals("All"))
    	{
    		name13="";
    	}
    	
    if(Status.equals("Assigned"))
    {
    	
		System.out.println("IN Assigned");

/*     	query12="select c.EmpName as User ,c.dotprojectid as UserID,a.task_id as TaskId,a.task_name as TaskName,a.task_duration as Duration,date_format(a.task_start_date,'%d-%b-%Y %T' ) as StartDate,date_format(a.task_end_date,'%d-%b-%Y %T') as EndDate  from dotproject.tasks a left join dotproject.user_tasks b on a.task_id=b.task_id left join db_GlobalERP.UserMaster c  on c.dotprojectid=b.user_id where task_end_date >='"+dt+"' and task_end_date <='"+dt1+"'  and c.EmpName like '%"+name13+"%'  and c.dept like '%"+department+"%'";
 */
 //query12="select c.EmpName as User ,c.KRAdotprojectid as UserID,a.task_id as TaskId,a.task_name as TaskName,a.task_duration as Duration,date_format(a.task_start_date,'%d-%b-%Y %T' ) as StartDate,date_format(a.task_end_date,'%d-%b-%Y %T') as EndDate  from dotproject.tasks a left join dotproject.user_tasks b on a.task_id=b.task_id left join db_GlobalERP.UserMaster c  on c.KRAdotprojectid=b.user_id where task_end_date >='"+dt+"' and task_end_date <='"+dt1+"'  and c.EmpName like '%"+name13+"%'  and c.dept like '%"+department+"%'";
 //query12="select c.EmpName as User ,c.KRAdotprojectid as UserID,a.task_id as TaskId,a.task_name as TaskName,a.task_description,a.task_duration as Duration,date_format(a.task_start_date,'%d-%b-%Y %T' ) as StartDate,date_format(a.task_end_date,'%d-%b-%Y %T') as EndDate  from dotproject.tasks a left join dotproject.user_tasks b on a.task_id=b.task_id left join db_GlobalERP.UserMaster c  on c.KRAdotprojectid=b.user_id where task_end_date >='"+dt+"' and task_end_date <='"+dt1+"'  and c.EmpName like '%"+name13+"%'  and c.dept like '%"+department+"%'";
	query12="select a.id as TaskId,a.assigned_to_id as UserID,CONCAT(b.firstname, ' ', b.lastname) AS User,a.subject as TaskName,a.description as task_description ,  TO_CHAR(a.start_date, 'DD-Mon-YYYY HH24:MI:SS') AS StartDate,TO_CHAR(a.due_date, 'DD-Mon-YYYY 23:59:59') AS EndDate, a.estimated_hours as Duration from work_packages a JOIN users  b ON a.assigned_to_id = b.id where a.assigned_to_id="+openprojectid+" and due_date >= '"+dt+"' and due_date <='"+dt1+"' and a.type_id = 9 order by a.id asc";   
		
		System.out.println("query12---"+query12);
		rs=stmt1.executeQuery(query12);
		
		int i=1;
		
		while(rs.next())
		{
		
			
			String TaskId="",TaskName="",Duration="",StartDate="",EndDate="";
			String TaskDescription="";
			User=rs.getString("User");
			System.out.println("-User------->"+User);
			
			UserID=rs.getString("UserID");
			System.out.println("-UserID------->"+UserID);
			
			
			TaskId=rs.getString("TaskId");
			System.out.println("-TaskId------->"+TaskId);
			
			TaskName=rs.getString("TaskName");
			System.out.println("-TaskName------->"+TaskName);
			
			TaskDescription=rs.getString("task_description");
			System.out.println("-TaskDescription------->"+TaskDescription);
			
			Duration=rs.getString("Duration");
			System.out.println("-Duration------->"+Duration);
			
			StartDate=rs.getString("StartDate");
			System.out.println("-StartDate------->"+StartDate);
			
			EndDate=rs.getString("EndDate");
			System.out.println("-EndDate------->"+EndDate);
			
		
		%>
		<tr>
					<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=i%></td>
					<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("UserID")%></td>
								<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=rs.getString("User")%></td>
					<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("TaskId")%></td>
					<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=rs.getString("TaskName")%></td>
					<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=TaskDescription%></td>
					<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("Duration")%></td>
					<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("StartDate")%></td>
					<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("EndDate")%></td>
					<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=Status%></td>
					
				 </tr>
		<%
		i++;
		}
    
    }
    else if(Status.equals("Missed"))
    {
/*     	query12="select c.EmpName as User ,c.dotprojectid as UserID,a.task_id as TaskId,a.task_name as TaskName,a.task_duration as Duration,date_format(a.task_start_date,'%d-%b-%Y %T' ) as StartDate,date_format(a.task_end_date,'%d-%b-%Y %T') as EndDate  from dotproject.tasks a left join dotproject.user_tasks b on a.task_id=b.task_id left join db_GlobalERP.UserMaster c  on c.dotprojectid=b.user_id where task_end_date >='"+dt+"' and task_end_date <='"+dt1+"'  and c.EmpName like '%"+name13+"%' and a.task_id not in (select distinct(TaskID) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata where TaskEndDate >='"+dt+"' and TaskEndDate <='"+dt1+"' and userid=c.dotprojectid)  and c.dept like '%"+department+"%'";
 */   
 
    //query12="select c.EmpName as User ,c.KRAdotprojectid as UserID,a.task_id as TaskId,a.task_name as TaskName,a.task_duration as Duration,date_format(a.task_start_date,'%d-%b-%Y %T' ) as StartDate,date_format(a.task_end_date,'%d-%b-%Y %T') as EndDate  from dotproject.tasks a left join dotproject.user_tasks b on a.task_id=b.task_id left join db_GlobalERP.UserMaster c  on c.KRAdotprojectid=b.user_id where task_end_date >='"+dt+"' and task_end_date <='"+dt1+"'  and c.EmpName like '%"+name13+"%' and a.task_id not in (select distinct(TaskID) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata where TaskEndDate >='"+dt+"' and TaskEndDate <='"+dt1+"' and userid=c.KRAdotprojectid)  and c.dept like '%"+department+"%'";
	//query12="select c.EmpName as User ,c.KRAdotprojectid as UserID,a.task_id as TaskId,a.task_name as TaskName,a.task_description,a.task_duration as Duration,date_format(a.task_start_date,'%d-%b-%Y %T' ) as StartDate,date_format(a.task_end_date,'%d-%b-%Y %T') as EndDate  from dotproject.tasks a left join dotproject.user_tasks b on a.task_id=b.task_id left join db_GlobalERP.UserMaster c  on c.KRAdotprojectid=b.user_id where task_end_date >='"+dt+"' and task_end_date <='"+dt1+"'  and c.EmpName like '%"+name13+"%' and a.task_id not in (select distinct(TaskID) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata where TaskEndDate >='"+dt+"' and TaskEndDate <='"+dt1+"' and userid=c.KRAdotprojectid)  and c.dept like '%"+department+"%'";
    query12="select a.id as TaskId,a.assigned_to_id as UserID,CONCAT(b.firstname, ' ', b.lastname) AS User,a.subject as TaskName,a.description as task_description ,  TO_CHAR(a.start_date, 'DD-Mon-YYYY HH24:MI:SS') AS StartDate,TO_CHAR(a.due_date, 'DD-Mon-YYYY 23:59:59') AS EndDate, a.estimated_hours as Duration from work_packages a JOIN users  b ON a.assigned_to_id = b.id where a.assigned_to_id="+openprojectid+" and due_date >= '"+dt+"' and due_date <='"+dt1+"' and type_id = 9 and a.status_id = 1  order by a.id asc";
	
	System.out.println("query12---"+query12);
		rs=stmt2.executeQuery(query12);
		
		int i=1;
		
		while(rs.next())
		{
		
			
			String TaskId="",TaskName="",Duration="",StartDate="",EndDate="";
			String TaskDescription="";
			User=rs.getString("User");
			System.out.println("-User------->"+User);
			
			UserID=rs.getString("UserID");
			System.out.println("-UserID------->"+UserID);
			
			
			TaskId=rs.getString("TaskId");
			System.out.println("-TaskId------->"+TaskId);
			
			TaskName=rs.getString("TaskName");
			System.out.println("-TaskName------->"+TaskName);
			
			TaskDescription=rs.getString("task_description");
			System.out.println("-TaskDescription------->"+TaskDescription);
			
			Duration=rs.getString("Duration");
			System.out.println("-Duration------->"+Duration);
			
			StartDate=rs.getString("StartDate");
			System.out.println("-StartDate------->"+StartDate);
			
			EndDate=rs.getString("EndDate");
			System.out.println("-EndDate------->"+EndDate);
			
		
		%>
		<tr>
					<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=i%></td>
					<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("UserID")%></td>
								<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=rs.getString("User")%></td>
<%-- 					<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("TaskId")%></td>
 --%>					<td style="font-size: 11px;" align="right">
<%--  <a data-toggle="modal" href="#myModal1" onclick="return demo('<%=rs.getString("TaskName")%>','<%=rs.getString("UserID")%>','<%=rs.getString("TaskId")%>')"><%=rs.getString("TaskId")%></a></td>
 --%> 					
					
<a data-toggle="modal" href="#addMyModal" onclick="return demo('<%=datenew1%>','<%=datenew2%>','<%=HOD%>','<%=department%>','<%=rs.getString("User")%>','<%=Status%>','<%=Role%>','<%=rs.getString("TaskName")%>','<%=rs.getString("UserID")%>','<%=rs.getString("TaskId")%>')"><%=rs.getString("TaskId")%></a></td>
					
					<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=rs.getString("TaskName")%></td>
					<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=TaskDescription%></td>
					<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("Duration")%></td>
					<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("StartDate")%></td>
					<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("EndDate")%></td>
					<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=Status%></td>
					
				 </tr>
		<%
		i++;
		}
    
    
    
    }
    
    else if(Status.equals("Submitted"))
    {
   
    query12="SELECT a.id AS TaskId, a.assigned_to_id AS UserID, CONCAT(b.firstname, ' ', b.lastname) AS User, a.subject AS TaskName, a.description AS TaskDescription, TO_CHAR(a.start_date, 'DD-Mon-YYYY HH24:MI:SS') AS StartDate, TO_CHAR(a.due_date, 'DD-Mon-YYYY 23:59:59') AS EndDate, a.estimated_hours AS Duration, a.done_ratio AS TaskPercent, c.comments  as TaskComment FROM  work_packages a JOIN  users b  ON  a.assigned_to_id = b.id JOIN  time_entries c  ON  a.id = c.work_package_id"+
          " WHERE  a.assigned_to_id = '"+openprojectid+"'  AND a.due_date >= '"+dt+"'  AND a.due_date <= '"+dt1+"' AND a.status_id = 12 and and a.type_id = 9 ORDER BY  a.id ASC";
  System.out.println("query12---"+query12);
		rs=stmt3.executeQuery(query12);
		
		int i=1;
		
		while(rs.next())
		{
		
			String TaskId="",TaskName="",Duration="",StartDate="",EndDate="",Stat="",TaskPercent="",TaskComment="",TaskAttachment="";
			String TaskDescription="";
			
			User=rs.getString("User");
			System.out.println("-User------->"+User);
			
			UserID=rs.getString("UserID");
			System.out.println("-UserID------->"+UserID);
			
			TaskAttachment=rs.getString("TaskAttachment");
			System.out.println("TaskAttachment is ------->"+TaskAttachment);
			
			String[] TA=TaskAttachment.split(",");
			System.out.println("TA issssss------->"+TA[0]);
			System.out.println("Arrays.toString(TA) issssss------->"+ Arrays.toString(TA).substring(1,(Arrays.toString(TA)).trim().length()-1));
			
					
			TaskId=rs.getString("TaskId");
			System.out.println("-TaskId------->"+TaskId);
			
			TaskName=rs.getString("TaskName");
			System.out.println("-TaskName------->"+TaskName);
			
			TaskDescription=rs.getString("TaskDescription");
			System.out.println("-TaskDescription------->"+TaskDescription);
			
			Duration=rs.getString("Duration");
			System.out.println("-Duration------->"+Duration);
			
			StartDate=rs.getString("StartDate");
			System.out.println("-StartDate------->"+StartDate);
			
			EndDate=rs.getString("EndDate");
			System.out.println("-EndDate------->"+EndDate);
			
			Stat="Submitted";
			System.out.println("-Stat------->"+Stat);
			
			
			TaskPercent=rs.getString("TaskPercent");
			System.out.println("-TaskPercent------->"+TaskPercent);
			
			TaskComment=rs.getString("TaskComment");
			System.out.println("-TaskComment------->"+TaskComment);
			
		
		%>
		<tr>
					<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=i%></td>
					<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("UserID")%></td>
					<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=rs.getString("User")%></td>
<%--  					<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("TaskId")%></td>
 --%> 
 <td style="font-size: 11px;" align="right">
<%--  <a data-toggle="modal" href="#myModal1" onclick="return demo('<%=rs.getString("TaskName")%>','<%=rs.getString("UserID")%>','<%=rs.getString("TaskId")%>')"><%=rs.getString("TaskId")%></a></td>
 --%> 			
 
   <a data-toggle="modal" href="#addMyModal" onclick="return demo('<%=datenew1%>','<%=datenew2%>','<%=HOD%>','<%=department%>','<%=rs.getString("User")%>','<%=Status%>','<%=Role%>','<%=rs.getString("TaskName")%>','<%=rs.getString("UserID")%>','<%=rs.getString("TaskId")%>')"><%=rs.getString("TaskId")%></a></td>
 		
					<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=rs.getString("TaskName")%></td>
					<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=TaskDescription%></td>
					<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("Duration")%></td>
					<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("StartDate")%></td>
					<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("EndDate")%></td>
					<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("TaskPercent")%></td>
					<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=rs.getString("TaskComment")%></td>
 				<%-- <td style="font-size: 11px; face:san-serif; color:black" align="left"><%=rs.getString("TaskAttachment")%></td>
				 --%>	<%-- <td style="font-size: 11px; face:san-serif; color:black" align="left"><a href="TaskAttachment=<%=rs.getString("TaskAttachment")%>" target="_blank"><%=rs.getString("TaskAttachment")%></a></td>
			 --%>	<%-- <td style="font-size: 11px; face:san-serif; color:black" align="left"><a href="file:///home/twtech/<%=rs.getString("TaskAttachment")%>" ><%=rs.getString("TaskAttachment")%></a></td>
			 --%> 	<!-- <td style="font-size: 11px; face:san-serif; color:black" align="left"><a href="file:///home/twtech/Transworld-workspace/TWERPV21/WebContent/Accounts/163067angular2_mock_test_iv-230Jun201917:18:40.pdf" target="_blank">163074angular2_mock_test_iv-229Jun201913:31:46.pdf</a></td> 
 -->	<!-- <td style="font-size: 11px; face:san-serif; color:black" align="left"><a href="reports/cp.txt" target="_blank">163074angular2_mock_test_iv-229Jun201913:31:46.pdf</a></td> 
	 -->
			<%-- 	<td style="font-size: 11px; face:san-serif; color:black" align="left"><a href="Accounts/<%=Arrays.toString(TA).substring(1,(Arrays.toString(TA)).trim().length()-1)%>" target="_blank"><%=Arrays.toString(TA).substring(1,(Arrays.toString(TA)).trim().length()-1)%></a></td> 
		 --%>	<td style="font-size: 11px; face:san-serif; color:black" align="left">
	 <%for (int k=0;k<TA.length;k++) {%>
	 <a href=Downloadtaskattachment.jsp?filename=<%=TA[k]%> target="_blank"><%=TA[k]%><% if(k<(TA.length-1)){%><%=","%><%} %></a>
				<%} %>	</td> 
					
					<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=Stat%></td>
					<td style="font-size: 11px; face:san-serif; color:black" align="left">-</td>
				 </tr>
		<%
		i++;
		}
    
    
    }
    else
    {

		System.out.println("IN else");

		query12="SELECT distinct(a.taskId) as TaskId,a.UserId,b.EmpName AS USER,a.TaskName,a.TaskDescription AS TaskDescription,a.AssignedDuration AS Duration, a.TaskPercent,a.TaskComment AS TaskComment,a.TaskAttachment,DATE_FORMAT(a.TaskStartDate,'%d-%b-%Y %T' ) AS StartDate,DATE_FORMAT(a.TaskEndDate,'%d-%b-%Y %T') AS EndDate,a.TaskRejectionComment AS RejectionReason ,a.TaskStatus AS STATUS  FROM  db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildataCopy  a JOIN db_GlobalERP.UserMaster b  ON a.UserID=b.KRAdotprojectid  WHERE  b.empname LIKE '%"+name13+"%' AND b.companymasterid=100000 AND b.activestatus='Yes'  AND b.dept LIKE '%"+department+"%'  AND  a.TaskEndDate >='"+dt+"' AND a.TaskEndDate <='"+dt1+"' AND a.TaskStatus LIKE '%"+Status+"%' ORDER BY a.TaskID ";	
    	
        System.out.println("query12---"+query12);
		rs=st1.executeQuery(query12);
		
		int i=1;
		
		while(rs.next())
		{
		
			String TaskId="",TaskName="",Duration="",StartDate="",EndDate="",Stat="",TaskPercent="",TaskComment="",TaskAttachment="";
			String TaskDescription="",RejectionComment="";
			
			User=rs.getString("User");
			System.out.println("-User------->"+User);
			
			UserID=rs.getString("UserID");
			System.out.println("-UserID------->"+UserID);
			
			
			TaskId=rs.getString("TaskId");
			System.out.println("-TaskId------->"+TaskId);
			
			TaskName=rs.getString("TaskName");
			System.out.println("-TaskName------->"+TaskName);
			
			TaskDescription=rs.getString("TaskDescription");
			System.out.println("TaskDescription------->"+TaskDescription);
			
			Duration=rs.getString("Duration");
			System.out.println("-Duration------->"+Duration);
			
			StartDate=rs.getString("StartDate");
			System.out.println("-StartDate------->"+StartDate);
			
			EndDate=rs.getString("EndDate");
			System.out.println("-EndDate------->"+EndDate);
			
			Stat=rs.getString("Status");
			System.out.println("-Stat------->"+Stat);
			
			//TaskAttachment=rs.getString("TaskAttachment");
			//System.out.println("-TaskAttachment------->"+TaskAttachment);
			TaskAttachment=rs.getString("TaskAttachment");
			System.out.println("TaskAttachment is ------->"+TaskAttachment);
			
			String[] TA=TaskAttachment.split(",");
			System.out.println("TA issssss------->"+TA[0]);
			System.out.println("Arrays.toString(TA) issssss------->"+ Arrays.toString(TA).substring(1,(Arrays.toString(TA)).trim().length()-1));
			
			
			Arrays.toString(TA);
	        /* String CSV = "Google,Apple,Microsoft";

	        String[] values = CSV.split(",");

	        System.out.println(Arrays.toString(values)); 
	        Output :[Google, Apple, Microsoft]
	        */


			
			
			TaskPercent=rs.getString("TaskPercent");
			System.out.println("-TaskPercent------->"+TaskPercent);
			
			TaskComment=rs.getString("TaskComment");
			System.out.println("-TaskComment------->"+TaskComment);
			
			RejectionComment=rs.getString("RejectionReason");

			
		
		%>
		<tr>
					<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=i%></td>
					<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=UserID%></td>
					<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=User%></td>
<%-- 						<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("TaskId")%></td>
--%>					
<td style="font-size: 11px;" align="right">
<%--  <a data-toggle="modal" href="#myModal1" onclick="return demo('<%=rs.getString("TaskName")%>','<%=rs.getString("UserID")%>','<%=rs.getString("TaskId")%>')"><%=rs.getString("TaskId")%></a></td>
--%> 		

<a data-toggle="modal" href="#addMyModal" onclick="return demo('<%=datenew1%>','<%=datenew2%>','<%=HOD%>','<%=department%>','<%=rs.getString("User")%>','<%=Status%>','<%=Role%>','<%=rs.getString("TaskName")%>','<%=rs.getString("UserID")%>','<%=rs.getString("TaskId")%>')"><%=rs.getString("TaskId")%></a></td>
			
	<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=TaskName%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=TaskDescription%></td>
					<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=Duration%></td>
					<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=StartDate%></td>
					<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=EndDate%></td>
					<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=TaskPercent%></td>
				<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=TaskComment%></td>
				<%-- <td style="font-size: 11px; face:san-serif; color:black" align="left"><%=rs.getString("TaskAttachment")%></td>
				 --%>
				<%--  <td style="font-size: 11px; face:san-serif; color:black" align="left"><a href="TaskAttachment=<%=rs.getString("TaskAttachment")%>" target="_blank"><%=rs.getString("TaskAttachment")%></a></td>
			 --%>	<%-- <td style="font-size: 11px; face:san-serif; color:black" align="left"><a href="file:///home/twtech/<%=rs.getString("TaskAttachment")%>"><%=rs.getString("TaskAttachment")%></a></td>
--%>					
				<!-- <td style="font-size: 11px; face:san-serif; color:black" align="left"><a  href="file:///home/twtech/Transworld-workspace/TWERPV21/WebContent/Accounts/163067angular2_mock_test_iv-230Jun201917:18:40.pdf" target="_blank">file:///home/twtech/Transworld-workspace/TWERPV21/WebContent/Accounts/163067angular2_mock_test_iv-230Jun201917:18:40.pdf</a></td> 
-->	<!-- <td style="font-size: 11px; face:san-serif; color:black" align="left"><a href="reports/cp.txt" target="_blank">163074angular2_mock_test_iv-229Jun201913:31:46.pdf</a></td> 
-->	<%-- <td style="font-size: 11px; face:san-serif; color:black" align="left"><a href="Accounts/<%=rs.getString("TaskAttachment")%>" target="_blank"><%=rs.getString("TaskAttachment")%></a></td> 
	 --%>		
	<td style="font-size: 11px; face:san-serif; color:black" align="left">
 <%for (int k=0;k<TA.length;k++) {%>
 <a href=Downloadtaskattachment.jsp?filename=<%=TA[k]%> target="_blank"><%=TA[k]%><% if(k<(TA.length-1)){%><%=","%><%} %></a>
			<%} %>	</td> 
					<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=Status%></td>
					<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=RejectionComment%></td>
					
				 </tr>
		<%
		i++;
		}
    
    
    
    }

%>

		
	<% 
	}
		
	
		%>
		
			



</tbody>	
</table>
	</form>		
		
</div>		




</jsp:useBean>


</body>
<%@ include file="footer_new.jsp"%>
</html>
