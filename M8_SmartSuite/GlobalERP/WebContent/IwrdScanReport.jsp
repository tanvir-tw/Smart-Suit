 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
 <%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
<%@ include file="headernew.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Global ERP</title>
</head>
 <body style="background-color:azure;">
	<%

/*   String monthFirstDate = session.getAttribute("7daysback").toString(); 
 */	 String monthFirstDate = session.getAttribute("PresentMonthFirst").toString();  
 String fname="";
	int srno=0;
	int sn=1;
	String todaysDate = session.getAttribute("today").toString(); 
	String datex1="",datex2="",bt="",data1="",data2="",dt="",dt1="",dttime="",dt1time="";
	
		Statement stmt=null,st1=null;
		String sql=null;
		ResultSet rst=null;		
		int cnt=0;
%>
<% 
try {
	Connection conn = null;
		conn = connection.getConnect("db_leaveapplication");    
        stmt=conn.createStatement();
		st1=conn.createStatement();
} catch (Exception e) {
    e.printStackTrace();
} 
%> 
<%
try{
bt=request.getParameter("button");
System.out.println("button "+bt);
	
	if (bt== null || bt.equals("null")) {		
		datex1 = monthFirstDate;
		datex2 = todaysDate;
		System.out.println("in if datex1 "+datex1);	
		System.out.println("datex2 "+datex2);

	} else {	
		datex1 = request.getParameter("data");
		datex2 = request.getParameter("data1");
		
		System.out.println("in else datex1 "+datex1);
		System.out.println("datex2 "+datex2);
	}

 dt = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));
 dttime=""+dt+" 00:00:00";

 dt1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex2));
 dt1time=""+dt1+" 23:59:59";

%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Uploaded Documents</h5>
    </div>
</div>
  <form name="formreport" id="formreport" method="post">
		    <div class="row col-12">
		    <div class="col-md-4"></div>
				<div class="col-md-2" id="fromdate">
				<label for="from"><b>From</b></label>
					<div class="input-group input-group-merge" >
					<input type="text" name="data" id="data"  class="form-control" value="<%=datex1%>"> 
					<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
				</div>
			</div>
			<div class="col-md-2" id="todate">
				<label for="to"><b>To</b></label>
				<div class="input-group input-group-merge" >	
					<input type="text" id="data1" name="data1"  class="form-control" value="<%=datex2%>"/> 
				<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
 				</div>
		    </div>
			<div class="col-md-2 mt-4">
			
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit" >
			</div>
			<div class="col-md-2"></div>
		</div>
</form> 
<script type="text/javascript">
        Calendar.setup(
	       {
	    	   inputField  : "data",         // ID of the input field
			   ifFormat    : "%d-%b-%Y",     // the date format
			   button      : "trigger"       // ID of the button
	        } );
        
        Calendar.setup(
     	       {
     	    	   inputField  : "data1",         // ID of the input field
     			   ifFormat    : "%d-%b-%Y",     // the date format
     			   button      : "trigger1"       // ID of the button
     	        } );
</script>
<br>
  <div class="col-md-12 mb-2">
    <div class="d-flex flex-column flex-sm-row gap-3 fw-bold justify-content-start text-start">

        <span style="cursor:pointer; color:red;" 
             onclick="invaliddocs();">● Invalid Doc Report</span>

        <span style="cursor:pointer; color:blue;"
              onclick="duplicatedocs();">● Duplicate Doc Report</span>
    </div>
</div>

<form action="InwardScanSelected.jsp" method="post">
<input type="hidden" id="serialSelected" name="serialSelected" value="">
		<%
int i=0;
		System.out.println(dt+"*******************"+dt1);
		String sql1="select count(*) as cnt1 from t_uploadedFiles where FileStatus='uploaded' ";
		ResultSet rs=st1.executeQuery(sql1);
		if(rs.next())
		{
			cnt=rs.getInt("cnt1");
		}
		%>
<div class="col-md-12 mb-2">
    <div class="d-flex flex-column flex-sm-row gap-3 fw-bold justify-content-start text-start">
			
<input type="submit" class="btn btn-primary"  id="button" name="button" value="Send" onclick="return validate(this.form);" >
<%
String pendCnt="";
String sqlPending="select count(*) as Pend from t_uploadedFiles where FileStatus='uploaded'";
ResultSet rsPending=st1.executeQuery(sqlPending);
if(rsPending.next())
{
	pendCnt=rsPending.getString("Pend");
}
%> <span style="margin-right:30px;">
    Total Pending Document : <%= pendCnt%>
</span>
<%
String pendCnt1="";
String sqlPending1="select count(*) as Pend from t_uploadedFiles where FileStatus='uploaded' and UpdatedDateTime>='"+dt+" 00:00:00' and UpdatedDateTime<='"+dt1+" 23:59:59'";
System.out.println(sqlPending1);
ResultSet rsPending1=st1.executeQuery(sqlPending1);
if(rsPending1.next())
{
	pendCnt1=rsPending1.getString("Pend");
}
%> Pending Document In Selected Date Range : <%= pendCnt1%>
<input type="hidden" name="chbx" id="chbx" value="<%=i%>"></input>
<input type="hidden" name="recordCnt" id="recordCnt" value="<%=cnt%>"></input>
 </div>
</div>

 <table id="example" class="display" style="width: 100%">  
<thead>
    <tr>
        <th></th>
        <th>Sr.</th>
        <th>File Name</th>
        <th>Upload Date</th>
        <th>Uploaded By</th>
        <th>Mark As</th>
    </tr>
</thead>
<tbody>
<%
int trcnt=0;
try
{
	System.out.println(dt+"***********************************************"+dt1);
	DateFormat d1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	DateFormat d2=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
	String sqlData="";
	try
	{
		System.out.println(">>>>>>>>>>>>"+request.getQueryString().toString());
		sqlData="select * from t_uploadedFiles where FileStatus='uploaded' and UpdatedDateTime>='"+dt+" 00:00:00' and UpdatedDateTime<='"+dt1+" 23:59:59' order by UpdatedDateTime asc";
	}
	catch(Exception e)
	{
		sqlData="select * from t_uploadedFiles where FileStatus='uploaded' and UpdatedDateTime>='"+dt+" 00:00:00' and UpdatedDateTime<='"+dt1+" 23:59:59' order by UpdatedDateTime asc";
	}
		
	ResultSet rs1=st1.executeQuery(sqlData);
	while(rs1.next())
	{
		
		fname=rs1.getString("FileName");
		srno=rs1.getInt("SrNo");
		%>
				<tr>
					<td class="text-center"><input type="checkbox" name="cb<%=i%>"
						id="cb<%=i%>" value="<%=rs1.getInt("SrNo")%>"
						onclick="GetFiles('<%=rs1.getInt("SrNo")%>','<%=i %>');"></input></td>
					<td class="text-center"><%=sn++%></td>
					<%
					
					%>
					<%-- <td class="text-left"><a href="downloadFile.jsp?documentName=<%=rs1.getString("FileName")%>"><%=rs1.getString("FileName")%></a></td> --%>
<%-- <td class="text-left">
    <a href="<%=urlBase %><%=rs1.getString("FileName")%>" target="_blank"> <%=rs1.getString("FileName")%>
    </a>
</td> --%>
<td class="text-left">
    <a href="downloadFile.jsp?file=<%=rs1.getString("FileName")%>">
        <%=rs1.getString("FileName")%>
    </a>
</td>
					<td class="text-right"><%=d2.format(d1.parse(rs1.getString("UpdatedDateTime")))%></td>
					<td >
							<%=rs1.getString("UploadedBy").toString()%></td>
					<td class="text-center"><a href="#"
						onclick="invalid('<%=fname %>','1')"><font color="red">Invalid</font></a>
						/ <a href="#" onclick="duplicate('<%=fname %>','2')">Duplicate</a></td>


				</tr>
				<%
		i++;
	}
	%>
				<input type="hidden" name="chbxCnt" id="chbxCnt" value="<%=i %>" />
				<input type="hidden" name="filename" id="filename" value="<%=fname%>" />

<%
}
catch(Exception e)
{
	System.out.println("Thumbnail Exception======>>"+e);	
}
%>

</tbody>
</table>


		  <div class="col-md-5">
      <div id="showcontent"
           class="card p-2"
           style="display:none; min-height:400px; overflow:auto;">
      </div>
		<script>document.getElementById("showcontent").style.visibility="hidden";</script>
		</div>
</form>
</div>
<%
 }catch(Exception e){
	System.out.println("Exception "+e);
	 }
%>	
	<script>
var thumbnail="";
//var thumbnailn="";
function ShowPicture(event,help_id)
{	
	//alert(event+"===="+help_id);
		var mhelp_id=help_id;
		//alert(help_id);
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
				//alert(reslt);
	     		document.getElementById("showcontent").innerHTML=reslt;
				document.getElementById("showcontent").style.visibility="visible";
			} 
		}
		var queryString = "?help_id=" +mhelp_id;
		
		ajaxRequest.open("GET", "testTab.jsp" + queryString, true);
		ajaxRequest.send(null); 
}
function thumbNail(list,thumbnailn)
{
	//alert(list+"======"+thumbnailn);
	var mhelp_id=list;
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
				//alert(reslt);
				var mySplitResult = reslt.split("$");
				var ajxRes1=mySplitResult[0];
				var ajxRes2=mySplitResult[1];
				var ajxRes3=mySplitResult[2];

				//alert(ajxRes3);
				//alert(ajxRes3.trim() == "Inwarded");
				
				if(ajxRes3.trim() == "Inwarded")
				{
					alert("These documents already has been inwarded!");
					location = "IwrdScanReport.jsp";
					//assignAjxResult(ajxRes1,ajxRes2);	     		
					//document.getElementById("showcontent").style.visibility="visible";
					
				}if(ajxRes3.trim() == "Uploaded")
				{
					assignAjxResult(ajxRes1,ajxRes2);	     		
					document.getElementById("showcontent").style.visibility="visible";
				}	
				
		}
	}
	var queryString = "?list="+list+"&thumbnailn="+thumbnailn;
	try
	{
		ajaxRequest.open("GET", "testTab.jsp" + queryString, true);
		ajaxRequest.send(null);
	} 
	catch (e) 
	{
		alert(e);
	}
}
function assignAjxResult(res1,res2)
{
	thumbnail=res2;
	document.getElementById("showcontent").innerHTML=res1;
	document.getElementById("serialSelected").value=res2;
}
function GetFiles(file,i)
{
	//alert(i);
	var thumbnailn="";
	//alert("===get Files======");
	
	if((document.getElementById("cb"+i).checked)==true)
	{
		//alert("chkd");
		if(thumbnail=="")
		{
			thumbnail=file;
		}
		else
		{
			thumbnail=thumbnail+","+file;
		}
	}

	if((document.getElementById("cb"+i).checked)==false)
	{
		//alert("UNchkd");
		if(thumbnailn=="")
		{
			thumbnailn=file;
		}
		else
		{
			thumbnailn=thumbnailn+","+file;
		}
	}
	thumbNail(thumbnail,thumbnailn);
}
function validate(form)
{
	  var total=0;
	  var cnt=document.getElementById("chbxCnt").value;
	  for(var i=0; i < cnt; i++)
	  {
		 try
		 {
		    if((document.getElementById("cb"+i).checked)==true) 
			{
		      total++;
		    }
		 }
		 catch(e)
		 {
		 }
	  }
	  if( total == 0 ) 
	  {
		alert("Please Select Document For Inward");
	    return false;
	  } 
	  return true;
}
function getFTPImage(ftpFile)
{
	
	try
	{
	 window.open('showFTPNew.jsp?ftpFile='+escape(ftpFile)+'','mywindow','width=700, height=700, toolbar=false, location=false, status=no, menubar=no, resizable=no, scrollbars=yes'); 
		
	} 
	catch(e)
	{
		alert(e);
	}
} 

function invalid(fname,id)
{
	//alert("IN ");
	//var mhelp_id=list;
	var filename=fname;
	//alert(filename);
	var idnew=id;
	//alert(idnew);
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
		alert("File Status Updated.");
		reload();
		} 
	}
	var queryString = "?fname="+filename+"&id="+id;
	try
	{
		ajaxRequest.open("GET", "ValidandDuplicateDocs.jsp" + queryString, true);
		ajaxRequest.send(null);
	} 
	catch (e) 
	{
		alert(e);
	}

}

function duplicate(fname,id)
{
	//alert("IN ");
	//var mhelp_id=list;
	var filename=fname;
	//alert(filename);
	var idnew=id;
	//alert(idnew);
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
			alert("File Status Updated.");
			reload();
		} 
	}
	var queryString = "?fname="+filename+"&id="+id;
	try
	{
		ajaxRequest.open("GET", "ValidandDuplicateDocs.jsp" + queryString, true);
		ajaxRequest.send(null);
	} 
	catch (e) 
	{
		alert(e);
	}
}



function reload()
{
	window.location.reload();
}

function invaliddocs()
{
	window.open('invaliddocsreport.jsp?validity=invalid','mywindow','width=400, height=500, resizable=yes, scrollbars=yes');
}

function duplicatedocs()
{
	window.open('invaliddocsreport.jsp?validity=duplicate','mywindow','width=400, height=500, resizable=yes, scrollbars=yes');

}
</script>

  <script type="text/javascript">
   $(document).ready(function () {
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-4"f><"col-sm-12 col-md-2 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
	       displayLength: -1,
	        scrollY: 330,
	        scrollX: true, 
	        colReorder: true,
	        scrollCollapse: true,
	        pagingType: 'full_numbers',  //alternative pagination 
	        //keys: true,  //Keytable
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
								title: 'Report Template from '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
								title: 'Report Template from '+$("#data").val()+ 'to' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
								title: 'Report Template from '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
								title: 'Report Template from '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
								title: 'Report Template from '+$("#data").val()+ 'to' +$("#data1").val(),
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