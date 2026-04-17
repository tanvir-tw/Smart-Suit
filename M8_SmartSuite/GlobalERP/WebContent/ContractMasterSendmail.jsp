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
String Id="",Name="",Email="",MobNo="",Company="",Qualification="",Stream="",ProfileStatus="";
String PayStructureStatus="",NewMedEndDate="",MedEndDate="";
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
%>
<div class="layout">
    <div id="EmailSidebar">
        <%@ include file="Emaildetails.jsp" %>
    </div>

    <!-- Main Content -->
    <div id="mainContent">
    <div class="row breadcrumbs-top">
           <h5 class="content-header-title text-center mb-0" style="color: #060637">Contract Master Send Mail</h5>
    </div>

  <br>
<table id="example" class="display">        
       <thead>
            <tr>
            <th class="col-width-4">SrNo.</th>
            <th>ID</th>
            <th>Name</th>
            <th>Send Mail</th>
            <th>Email</th>
            <th>MobNo</th>
            <th>Company</th>
            <th>Designation</th>
            <th>Dept</th>
            <th>ContractEnd</th>
            <th>Med.End</th>
            </tr>
        </thead> 
        <tbody>
        <% 
       

        String data="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractMasterNew where Status='Active'"; 

        System.out.println("check-------->"+data);

        ResultSet rs21=st.executeQuery(data);
      
        while(rs21.next())
        {
        	Id=rs21.getString("ContractorId");
        	Name=rs21.getString("ContractorName");
        	Email=rs21.getString("Email");
        	MobNo=rs21.getString("MobNo");
        	Company=rs21.getString("CompanyName");
        	Qualification=rs21.getString("Education");
        	MedEndDate=rs21.getString("MediclaimEndDate");
        	Stream=rs21.getString("Stream");
        	String Dept="",Designation="",ContractEndDate="";
        	String NewContractEndDate="";
        	 ProfileStatus="";
        	 PayStructureStatus="";
        	String ProfileDetails="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractorProfileMaster where ContractorId='"+Id+"'";
        	ResultSet rsProfileDetails=st1.executeQuery(ProfileDetails);
        	
        	if(rsProfileDetails.next())
        	{
        	
        	Dept=rsProfileDetails.getString("Department");
        	Designation=rsProfileDetails.getString("Designation");
        	ContractEndDate=rsProfileDetails.getString("ContractEndDate");
        	ProfileStatus="Done";
        	}
        	
        	else{
        		Dept="-";
        		Designation="-";
        		ProfileStatus="-";
        		ContractEndDate="-";
        	}

        	String Pay="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractorPayMaster where ContractorId='"+Id+"'";
        	ResultSet rsPay=st2.executeQuery(Pay);
        	if(rsPay.next())
        	{
        		PayStructureStatus="Done";
        	}
        	else
        	{
        		PayStructureStatus="-";
        	}
        	
        	if(ContractEndDate.equals("-"))
        	{
        		NewContractEndDate="-";
        	}
        	else
        	{
        		NewContractEndDate = new SimpleDateFormat("dd-MMM-yyyy")
                .format(new SimpleDateFormat("yyyy-MM-dd")
                        .parse(ContractEndDate));
        	}
        	
        	if(MedEndDate.equals("-"))
        	{
        		NewMedEndDate="-";
        	}
        	else
        	{
        		NewMedEndDate = new SimpleDateFormat("dd-MMM-yyyy")
                .format(new SimpleDateFormat("yyyy-MM-dd")
                        .parse(MedEndDate));
        	}
        	
        	%>
        	
        	<tr>
        		
        		<td class="text-center"><%=i%></td>
        		<td class="text-center"><%=Id%></td>
        		<td class="text-left"><%=Name%></td>
        		<%
        		if(PayStructureStatus.equals("-"))
        		{
        		%>
        		<td class="text-Center"><a href="#" onclick="senddata3('<%=Id %>','<%=Name %>')"><b>Send Mail</b></a></td>
        		<%}else{ %>
        		<td class="text-Center"><a href="#" onclick="senddata3('<%=Id %>','<%=Name %>')"><b>Send Mail</b></a></td>
        		<%} %>
        		<td class="text-left"><%=Email%></td>
        		<td class="text-center"><%=MobNo%></td>
        		<td class="text-left"><%=Company%></td>
        		<td class="text-left"><%=Designation%></td>
        		<td class="text-left"><%=Dept%></td>
        		<td class="text-right"><%=NewContractEndDate%></td>
        		<td class="text-right"><%=NewMedEndDate%></td>
        		
        		<%-- <%String datatwo="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"HrEmailMaster where ReceiverName like '"+Name+"' order by entrydatetime desc limit 1";
        		ResultSet rsPaytwo=st2.executeQuery(datatwo);
        		if(rsPaytwo.next()){
        			String body=rsPaytwo.getString("body");
        			String subject =rsPaytwo.getString("subject");
        		%>

        		<td class="text-left"><a href="#" onclick="window.open('detailedmessage.jsp?&fromid=<%=rsPaytwo.getString("fromid")%>&toid=<%=rsPaytwo.getString("Toid")%>&subject=<%=rsPaytwo.getString("subject") %>&insertdatetime=<%=new SimpleDateFormat( "dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsPaytwo.getString("EntryDateTime")))%>','','menubar=1,resizable=2,width=900,height=700,location=no');"><%=subject%></a></td>
        			
        		<%} else{
        		%>
        		<td class="text-center">-</td>
        		<%} --%>

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
	        fixedColumns: { 
	            left: 3      //To freeze two columns
	        }, 
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
		                        title: 'Contract Master Last Mail Report', 
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
		                        title: 'Contract Master Last Mail Report', 
	                            orientation: 'Portrait',
	                            pageSize: 'A4',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
		                        title: 'Contract Master Last Mail Report', 
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
		                        title: 'Contract Master Last Mail Report', 
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title: 'Contract Master Last Mail Report', 
							},
					],
				},
           ], 
       });
   });
</script>
<script>
function senddata3(id,Name)
{	 
	//alert("Id :- "+id);
	 //alert("Name :- "+Name);
	// window.location="sendmail.jsp?Id="+id+"&ContractorName="+Name+"";

	 window.open(
	'sendmail.jsp?Id='+id+'&ContractorName='+Name,   '_blank' // <- This is what makes it open in a new window.
	 );
	 
}
</script>
 <%@ include file="footer.jsp" %>
 </body>
</html>