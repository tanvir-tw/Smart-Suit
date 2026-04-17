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
String name=session.getAttribute("EmpName").toString();
String mail = session.getAttribute("EmpEmail").toString();
System.out.println("Employee mail is:" + mail);
String subject="",sender="",body="",EntryDateTime="";
int i=1;

 // Connection Initialization
Connection conn = null;
Statement st = null;

try {
	conn = connection.getConnect("db_GlobalERP");    
    st = conn.createStatement();
} catch (Exception e) {
    e.printStackTrace();
} 
%>  
<%
try{
%>
<input type="hidden" name="finalname" id="finalname" value="<%=name %>">

<div class="layout">
    <div id="EmailSidebar">
        <%@ include file="Emaildetails.jsp" %>
    </div>

    <!-- Main Content -->
    <div id="mainContent">
    <div class="row breadcrumbs-top">
           <h5 class="content-header-title text-center mb-0" style="color: #060637">INBOX</h5>
    </div>
  <br>
   <div class="container" style="width:80%;">
<table id="example" class="display" style="width:100%;">        
       <thead>
            <tr>
            <th class="col-width-4">SrNo.</th>
            <th>Subject</th>
			<th>From</th>
			<th>Date</th>
            </tr>
        </thead> 
        <tbody>
        <% 
      //String data="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractMasterNew where Status='Active'"; 
        /* String datatwo="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"HrEmailMaster order by entrydatetime desc ";
        ResultSet rs22=st4.executeQuery(datatwo);
        while(rs22.next()){
        	tocccc=rs22.getString("tocc");
        	System.out.println("tocc is" + tocccc);
        	
        	if(tocccc.contains(",")){
        	String	 toccccd [] =tocccc.split(",");
        		System.out.println("toddd is" + toccccd[1]);
        	finaltocc=Arrays.toString(toccccd);
        	 System.out.println("Array: "
                     + finaltocc);
        	 System.out.println("maillll is:" + mail);
        	 if(finaltocc.contains(mail)){
        		 
        			 empname=mail;
        			 System.out.println("HELLO is" + empname);

        		 }
        	 else{
        		 empname=mail;
        		 
        	 }
        	}//end of if
        	
        } */
     String data="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"HrEmailMaster where toid='"+empname+"'  or toid='"+mail+"' or tocc='"+mail+"' or tocc='"+empname+"' or find_in_set('"+mail+"',tocc) <> 0 or find_in_set('"+empname+"',tocc) <> 0 order by entrydatetime desc"; 
System.out.println("check-------->"+data);
ResultSet rs21=st.executeQuery(data);

while(rs21.next())
{
	subject = rs21.getString("subject");
	sender=rs21.getString("sendername");
	body=rs21.getString("body");
		EntryDateTime=rs21.getString("EntryDateTime");
		String EntryDateTimetwo []=EntryDateTime.split("\\s+");
		String xc=EntryDateTimetwo[0];
		System.out.println("xc is->>"+ xc);
		//Date xcm=new SimpleDateFormat("dd-MM-yyyy").parse(xc);

String xcm = new SimpleDateFormat("dd-MMM-yyyy")
.format(new SimpleDateFormat("yyyy-mm-dd")
.parse(xc));
		System.out.println("xcm is->>"+ xcm);
		String xcone=EntryDateTimetwo[1];
		xcone=xcone.substring(0,xcone.length()-2);
		System.out.println("yc is->>"+ xcone);
		
		String finality=xcm+" "+xcone;
		System.out.println("finality is->>"+ finality);
		
	%>
	
	<tr>
		
		<td class="text-center"><%=i%></td>
		<td class="text-left"><a href="#" onclick="window.open('detailedmessage.jsp?&fromid=<%=rs21.getString("fromid")%>&toid=<%=rs21.getString("Toid")%>&subject=<%=rs21.getString("subject") %>&insertdatetime=<%=new SimpleDateFormat( "dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs21.getString("EntryDateTime"))) %>','','menubar=1,resizable=2,width=900,height=700,location=no');"><%=subject%></a></td>		
		<td class="text-left"><%=sender%></td>
		<td class="text-right"><%=finality %></td>
			
</tr>	 	

		<%
		i++;
		}%>
        </tbody>
 </table>
 </div> 
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
		                        title: 'Inbox Report Of '+$("#finalname").val(), 
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
		                        title: 'Inbox Report Of '+$("#finalname").val(), 
	                            orientation: 'Portrait',
	                            pageSize: 'A4',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
 	                        title: 'Inbox Report Of '+$("#finalname").val(), 
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
 	                        title: 'Inbox Report Of '+$("#finalname").val(), 
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title: 'Inbox Report Of '+$("#finalname").val(), 
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