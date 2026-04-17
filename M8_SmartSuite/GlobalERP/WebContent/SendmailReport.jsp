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
    
    <link href="cssnew/emailsidebar.css" rel="stylesheet"/>
</head>
 <body>
<%
// Variable Declaration
String fromdate="",todate="",templatevalue="",owner="";	
String sql="",srno="",id="",vahno="",transporter="",UnitID="";
String ReceiverName="",subject="",fromid="",Toid="",EntryDateTime="",template="",Tocc="";
int i=1;

 // Connection Initialization
Connection conn = null;
Statement st = null,st1=null,st2=null;

try {
	conn = connection.getConnect("db_GlobalERP");    
    st = conn.createStatement();
    st1 = conn.createStatement();
    st2 = conn.createStatement();

} catch (Exception e) {
    e.printStackTrace();
} 
%>  
<%
try{
	
	java.util.Date td =new java.util.Date();
    Format fmt = new SimpleDateFormat("yyyy-MM-dd");
    String sdt1 = fmt.format(td);
    String sdt2=sdt1;
    /* String vehno=request.getParameter("vehno"); */
            System.out.println("in page &&&&&&&&&&");

    String btn=request.getParameter("button");

	String inputtype=request.getParameter("dataFilter");
    System.out.println("inputtype"+inputtype);

    if(btn==null){
    	inputtype = "All"; 
    	
    	  sdt1=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(sdt1));
  	    sdt2=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(sdt2));

    }else{
   
	 fromdate=request.getParameter("calender");
	 todate=request.getParameter("calender1");
	 templatevalue=request.getParameter("templatevalue");
	 owner=request.getParameter("owner");
	
    System.out.println("fromdate"+fromdate);

	    if(null!=fromdate || null!=todate ) {
	    	sdt1 = fromdate;
	    	sdt2 = todate;
	    }

	    fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(sdt1));
	    todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(sdt2));

    }
%>
<div class="layout">
    <div id="EmailSidebar">
        <%@ include file="Emaildetails.jsp" %>
    </div>

    <!-- Main Content -->
    <div id="mainContent">
    <div class="row breadcrumbs-top">
           <h5 class="content-header-title text-center mb-0" style="color: #060637">Send Mail Report</h5>
    </div>
<form name="formreport" id="formreport" method="post">
  <div class="row align-items-end g-3">
    <div class="col-md-2" id="space"></div>
    <!-- Radio Buttons -->
    <div class="col-md-5 d-flex justify-content-end align-items-center" id="radio">
      <div class="form-check form-check-inline">
        <input class="form-check-input" type="radio" name="dataFilter" id="dataFilter1" value="All"  <%= "All".equals(inputtype) ? "checked" : "" %> onclick="ShowHide('0')">
        <label class="form-check-label" for="dataFilter1">All</label>
      </div>
        <!-- <input type="radio" name="dataFilter" value="token" onClick="ShowHide(0);"><font color="black" size="2">Token Number</font>-->
            
      <div class="form-check form-check-inline">
        <input class="form-check-input" type="radio" name="dataFilter" id="dataFilter2" value="date" <%= "date".equals(inputtype) ? "checked" : ""%> onclick="ShowHide('1')">
        <label class="form-check-label" for="dataFilter2">Date Range</label>
      </div>
       <!-- <input type="radio" name="dataFilter" value="vehno" onClick="ShowHide(2);"> <font color="black" size="2">Employee ID No.</font>--> 
      <div class="form-check form-check-inline">
        <input class="form-check-input" type="radio" name="dataFilter" id="dataFilter3" value="trans" <%= "trans".equals(inputtype) ? "checked" : "" %> onclick="ShowHide('3')">
        <label class="form-check-label" for="dataFilter3">Contractor</label>
      </div>

      <div class="form-check form-check-inline">
        <input class="form-check-input" type="radio" name="dataFilter" id="dataFilter4" value="temp" <%= "temp".equals(inputtype) ? "checked" : "" %> onclick="ShowHide('4')">
        <label class="form-check-label" for="dataFilter4">Template</label>
      </div>
    </div>

    <!-- Date Range -->
    <div class="row col-md-4 mt-3" id="daterange" style="display:none;">
     <div class="col-md-6" id="fromdate">
				<label for="from"><b>From</b></label>
					<div class="input-group input-group-merge" >
					<input type="text" name="calender" id="calender"  class="form-control" value="<%=sdt1%>"> 
					<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
				</div>
			</div>
			<div class="col-md-6" id="todate">
				<label for="to"><b>To</b></label>
				<div class="input-group input-group-merge" >	
					<input type="text" id="calender1" name="calender1"  class="form-control" value="<%=sdt2%>"/> 
				<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
 				</div>
		    </div>
    </div>
<script type="text/javascript">
        Calendar.setup(
	       {
	    	   inputField  : "calender",         // ID of the input field
			   ifFormat    : "%d-%b-%Y",     // the date format
			   button      : "trigger"       // ID of the button
	        } );
        
        Calendar.setup(
     	       {
     	    	   inputField  : "calender1",         // ID of the input field
     			   ifFormat    : "%d-%b-%Y",     // the date format
     			   button      : "trigger1"       // ID of the button
     	        } );
</script>
    <!-- Contractor -->
    <div class="col-md-3" id="trans" style="display:none;">
      <label for="Contractor"><b>Contractor</b></label>
            <div class="input-group input-group-merge">
      <select class="form-select" id="owner" name="owner">
        <option value="Select">Select</option>
        <%
          String que11="select Distinct(ContractorName) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractMasterNew where Status='Active' order by ContractorName";
          System.out.println("que11"+que11);
    	  ResultSet rst111=st.executeQuery(que11);
          while(rst111.next()){
        %>
          <option value="<%=rst111.getString("ContractorName")%>"><%=rst111.getString("ContractorName")%></option>
        <%
          }
        %>
      </select>
      <script>
                            const mySel = document.getElementById("owner");

                            // On page load
                             const savedValue = localStorage.getItem("selValue");
                             if (isBtNull) {
                             mySel.value = "Select"; // Default to "Select" if btn is null
                             } else if (savedValue) {
                              mySel.value = savedValue; // Restore saved value
                               }

                             // Add change event listener
                              mySel.addEventListener("change", function () {
                              localStorage.setItem("selValue", this.value); // Save selected value
                               });
                             </script>
      </div>
    </div>

    <!-- Template -->
    <div class="col-md-3" id="temp" style="display:none;">
      <label for="Template"><b>Template</b></label>
      <div class="input-group input-group-merge">
      <select class="form-select" id="templatevalue" name="templatevalue">
        <option value="Select">Select</option>
        <%
          String que1="Select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"EmailTemplate where Active='Yes'";
              System.out.println("que1"+que1);
    		  ResultSet rst11=st1.executeQuery(que1);
          while(rst11.next()){
        %>
          <option value="<%=rst11.getString("Template")%>"><%=rst11.getString("Template")%></option>
        <%
          }
        %>
      </select>
      <script>
                            const mySel = document.getElementById("templatevalue");

                            // On page load
                             const savedValue = localStorage.getItem("selValue");
                             if (isBtNull) {
                             mySel.value = "Select"; // Default to "Select" if btn is null
                             } else if (savedValue) {
                              mySel.value = savedValue; // Restore saved value
                               }

                             // Add change event listener
                              mySel.addEventListener("change", function () {
                              localStorage.setItem("selValue", this.value); // Save selected value
                               });
                             </script>
    </div>
</div>

    <!-- Submit Button -->
    <div class="col-md-2 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit">    </div>
  </div>
</form>
  <br>
<table id="example" class="display">        
       <thead>
            <tr>
            <th class="col-width-4">SrNo.</th>
           <!-- <th>Token</th>
            <th>Vehicle Reg no.</th>
			<th>Transporter</th>
			<th>UnitID</th>
			<th>Employee ID</th> -->
            <th>Contractor Name</th>
			<th>Subject</th>
            <!--<th>Body</th> -->
			<th>Template</th>
			<th>From ID</th>
            <th>To ID</th>
            <th><div style="width:200px;">To CC</div></th>
            <th>Insert Date Time</th>
            </tr>
        </thead> 
        <tbody>
        <% 
        /* if(inputtype.equalsIgnoreCase("vehno")){
        	sql="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"HrEmailMaster where MailName='TransworldHR' AND vahno like '%"+vehno+"%' order by EntryDateTime desc";
        } else if(inputtype.equalsIgnoreCase("token")){
			sql="select * from db_GlobalERP.t_allpendingmailtableERP where srno='"+data1+"' order by UpdatedDateTime asc";
        }*/if(inputtype.equalsIgnoreCase("date")){
			sql="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"HrEmailMaster where EntryDateTime>='"+fromdate+" 00:00:00' and EntryDateTime<= '"+todate+" 23:59:59' order by EntryDateTime Desc";
		}else if(inputtype.equalsIgnoreCase("trans")){
			sql="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"HrEmailMaster where ReceiverName='"+owner+"' order by EntryDateTime Desc";
		}else if(inputtype.equalsIgnoreCase("temp")){
			sql="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"HrEmailMaster where  template='"+templatevalue+"' order by EntryDateTime Desc";
		}else{
			sql="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"HrEmailMaster  order by EntryDateTime Desc";
		}
        System.out.println(sql);

        ResultSet rst1=st2.executeQuery(sql);
  
        while(rst1.next())
        {
        	ReceiverName=rst1.getString("ReceiverName");
        	subject=rst1.getString("subject");
        	fromid=rst1.getString("fromid");
        	Toid=rst1.getString("Toid");
        	EntryDateTime=rst1.getString("EntryDateTime");
        	template=rst1.getString("template");
        	Tocc=rst1.getString("Tocc");
        	srno=rst1.getString("srno");
        	/*id=rst1.getString("id");
        	vahno=rst1.getString("vahno");
        	transporter=rst1.getString("transporter");
        	UnitID=rst1.getString("UnitID");*/
        	%>
        	
        	<tr>
        		
              <td class="text-center"><%=i%></td>
        <%--  <td><%=srno=%></div></td> --%> 
        <%--  <td><div class="text-left"><%=id%></div></td>--%>     
              <td class="text-left"><%=ReceiverName%></td>
		 <%-- <td><%=vahno%></td>
			  <td colspan="1"><div class="text-left"><%=transporter%></div></td>
			   <td colspan="1"><div class="text-left"><%=UnitID%></div></td>
		<%-- <td class="text-right"style="width:300px;"><a href="#" onclick="window.print();return true;" title="Print"><img src="images/print.jpg" width="15px" height="15px"><%=date1%></img></a>&nbsp;<a href="#" title="Export to Excel"  onclick="gotoExcel('claim','tableHTML');"><img src="images/excel.jpg" width="15px" height="15px"></a></td> --%>  
	   			 
             <td><a href="#"  onclick="window.open('detailedmessage.jsp?&fromid=<%=fromid%>&toid=<%=Toid%>&subject=<%=subject %>&insertdatetime=<%=new SimpleDateFormat( "dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(EntryDateTime)) %>','','menubar=1,resizable=2,width=900,height=700,location=no');"><%=subject%></a></td>
 
		<%--  <td class="text-left"><a  href="#" onclick="doSubmit()" ><%=subject%></a></td>--%>
		<%--  <td class="text-left" ><%=body%></td> --%>
			  <td class="text-left"><%=template%></td>
              <td class="text-left"><%=fromid%></td>
              <td class="text-left"><%=Toid%></td>
              <td class="text-left"><div style="width:200px;white-space:normal; word-wrap:break-word; overflow-wrap:break-word;"><%=Tocc%></div></td>
        <%--  <td class="text-right"><%=EntryDateTime%></td>--%>  
              <td class="text-right"><%=new SimpleDateFormat( "dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(EntryDateTime))%></td>
        </tr>	 	

        		<%
        		i++;
        		}
        %>

        </tbody>
 </table>
 </div> 
</div>
 
 <%
 }catch(Exception e){
	System.out.println("Exception "+e);
	 }
%>
  <script type="text/javascript">
   $(document).ready(function () {
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-4"l><"col-sm-12 col-md-5"f><"col-sm-12 col-md-3 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
	       displayLength: -1,
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
					 orientation: 'Portrait',
                     pageSize: 'A4',
					buttons : [
							{
							 extend: 'excel',
	                         text: feather.icons['file'].toSvg({ class: 'font-small-4 me-50' }) + 'Excel',
	                         className: 'dropdown-item',  
		                        title: 'Contractor Mail History Report', 
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
		                        title: 'Contractor Mail History Report', 
	                            orientation: 'Portrait',
	                            pageSize: 'A4',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
		                        title: 'Contractor Mail History Report', 
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
		                        title: 'Contractor Mail History Report', 
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title: 'Contractor Mail History Report', 
							},
					],
				},
           ], 
       });
   });
</script>
<script>
function ShowHide(id)
		{

	      if(id==0)
			{
				document.getElementById("daterange").style.display='none';
				//document.getElementById("tokenno").style.display="";
				//document.getElementById("vehno").style.display='none';
				document.getElementById("trans").style.display='none';
				document.getElementById("temp").style.display='none';
			}
			else if(id==1)
			{				
				document.getElementById("daterange").style.display="";
				document.getElementById("space").style.display='none';

				/* document.getElementById("tokenno").style.display='none';
				document.getElementById("vehno").style.display='none';
			 */	document.getElementById("trans").style.display='none';
				document.getElementById("temp").style.display='none';
								
				
			}
			else if(id==2)
			{
				document.getElementById("daterange").style.display='none';
				/* document.getElementById("tokenno").style.display='none';
				document.getElementById("vehno").style.display="";
				 */document.getElementById("trans").style.display='none';
				document.getElementById("temp").style.display='none';
				
				
			}else if(id==3){
				//alert("ShowHide 3--->>>>>>>>>>" );
				document.getElementById("daterange").style.display='none';
				 /* document.getElementById("tokenno").style.display='none';
				 document.getElementById("vehno").style.display='none'; */
				document.getElementById("trans").style.display="";
				document.getElementById("temp").style.display='none';
			}else if(id==4){
				document.getElementById("daterange").style.display='none';
				/* document.getElementById("tokenno").style.display='none';
				document.getElementById("vehno").style.display='none';
				 */document.getElementById("trans").style.display='none';
				document.getElementById("temp").style.display="";
			}else{
				document.getElementById("daterange").style.display='none';
				/* document.getElementById("tokenno").style.display='none';
				document.getElementById("vehno").style.display='none';
				 */document.getElementById("trans").style.display='none';
				document.getElementById("temp").style.display='none';
			}
		}
$(window).bind("load",function()
		{
			var x=document.getElementById("radioValue").value;
			//alert(x);
			$("input[name='dataFilter'][value="+x+"]").attr('checked',true);
			if(x=="All")
			{
				ShowHide(0);
			}
			else if(x=="date")
			{
				ShowHide(1);
			}
			else if(x=="trans")
			{
				ShowHide(3);
			}
			else if(x=="temp")
			{
				ShowHide(4);
			}


		});

function doSubmit(){
	//window.open("detailedmessage.jsp","_self")
	// location.href="detailedmessage.jsp";
	 window.open('detailedmessage.jsp', ' menubar,resizable,dependent,status,width=300,height=200,left=10,top=10')

}

 function validate()
{
	 var datafilter;
	 	 //alert('$("val() '+$("input[name='dataFilter']:checked").val());
	//alert("in function validate");
	
	datafilter = $("input[name='dataFilter']:checked").val();
	//alert (datafilter);
	if(datafilter=="date"){
	var calender = document.getElementById("calender").value.trim();
	var calender1 = document.getElementById("calender1").value.trim();
	//alert(calender);
	//alert(calender1);
	if(calender > calender1){
		swal("From date should be less than To Date" );
		return false;
	}
	}
	if(datafilter=="trans"){
		var employee = document.getElementById("owner").value.trim();
		//alert(calender);
		//alert(calender1);
		if(employee=="Select"){
			swal("Please select Contractor Name " );
			return false;
		}
	}
	if(datafilter=="temp"){
		var employee = document.getElementById("templatevalue").value.trim();
		//alert(calender);
		//alert(calender1);
		if(employee=="Select"){
			swal("Please select Template " );
			return false;
		}
	}

	
} 
</script>
 <%@ include file="footer.jsp" %>
 </body>
</html>