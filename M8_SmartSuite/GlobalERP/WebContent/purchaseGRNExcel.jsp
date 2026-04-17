<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
<%@ include file="header.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<%@page import="java.util.Date"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
<%@page import="java.util.Date.*"%>
<%@page import="java.util.Calendar"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFSheet"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFCell"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFDateUtil"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFRow"%>
<%@ page import="java.io.FileNotFoundException"%>
<%@ page import="java.io.FileOutputStream"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.activation.*"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.StringTokenizer"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css">
<script type="text/javascript"  src="https://code.jquery.com/jquery-1.12.4.js"></script> 
<script type="text/javascript"  src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script> 


  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
 <!--  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- Export Options Links of DataTables -->

<link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.5.1/css/buttons.dataTables.min.css">
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/dataTables.buttons.min.js"></script> 
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.flash.min.js"></script> 
<script src=" https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js"></script>
<script src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js"></script>
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.html5.min.js"></script>
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.print.min.js "></script>

<style>
/*Scroll - horizontal and vertical*/
div.dataTables_wrapper { 
        width: 100%;   /* Table-width */
        margin: 0 auto;
    }
</style>
 
<script type="text/javascript">
 $(document).ready(function() {
	    $('#example').DataTable( {
	    	"pagingType": "full_numbers",
	    	
	        dom: 'Blfrtip',
	        scrollY: 400,
	        scrollX: true, 
	        buttons: [
	        	
	        	{
	        		extend: 'collection',
	        		
	        		text: 'Export',
	        		buttons: [
	        			{
	                        extend: 'excel',
	                        title: 'GRN Details Report ', 
	                    },
	                    {
	                        extend: 'pdf',
	                        orientation: 'landscape',
	                        pageSize: 'LEGAL',
	                        title: 'GRN Details Report ', 
	                    },
	                    {
	                        extend: 'csv',
	                        title: 'GRN Details Report ', 
	                    },
	                    {
	                        extend: 'print',
	                        title: 'GRN Details Report ', 
	                    },
	                    {
	                        extend: 'copy',
	                        title: 'GRN Details Report ', 
	                    },
	                    
	            				/* 'copy', 'csv', 'excel', 'pdf', 'print' */
	            			]
	        	}
	        ],
	        lengthMenu: [[-1, 10, 25, 50, 100], ["All", 10, 25, 50, 100 ]],
	           
	    	
	    } );
	} );

</script>
<%
	erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
%>
<%
	Connection conn = null;
	Statement st = null, st1 =null;
	
	String fname="";
	String FileName=request.getParameter("FileName");
	String CompId=session.getAttribute("CompanyMasterID").toString();	
	System.out.println("CompId.."+CompId);		


%>



<body ONKEYDOWN="if (event.keyCode == 27){document.getElementById('companyList').style.display = 'none';}" >
	<div
		style="font-size: 1.6em; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;">
	<a><b>GRN Details Report</b></a></div>


	<br>
	

<div>
<%
//select the taskowner and task creator

					
                    if(CompId.equals("100000")){
                    	
                 //fname = "/home/twtech/Nishant/Documents/" + FileName;   //path from where file is to be read
                  	
                       fname = "/usr/share/tomcat/webapps/TransworldDocs/ERPDocs/100000/GRNDocs/" + FileName; 
                    }
    				
                    else  if(CompId.equals("100005")){
                    	
                        fname = "/usr/share/tomcat/webapps/TransworldDocs/ERPDocs/100005/GRNDocs/" + FileName; 

                    }
                    else if(CompId.equals("100010")){
                    	
                        fname = "/usr/share/tomcat/webapps/TransworldDocs/ERPDocs/100010/GRNDocs/" + FileName; 

                    }
                    else if(CompId.equals("100015")){
                   	
                        fname = "/usr/share/tomcat/webapps/TransworldDocs/ERPDocs/100015/GRNDocs/" + FileName; 

                   }
                    else if(CompId.equals("100025")){
                      	
                        fname = "/usr/share/tomcat/webapps/TransworldDocs/ERPDocs/100025/GRNDocs/" + FileName; 

                  }
                    else if(CompId.equals("100030")){
                     	
                        fname = "/usr/share/tomcat/webapps/TransworldDocs/ERPDocs/100030/GRNDocs/" + FileName; 

                 }
                    else if(CompId.equals("100035")){
                     	
                        fname = "/usr/share/tomcat/webapps/TransworldDocs/ERPDocs/100035/GRNDocs/" + FileName; 

                 }
                    else  if(CompId.equals("100037")){
                     	
                        fname = "/usr/share/tomcat/webapps/TransworldDocs/ERPDocs/100037/GRNDocs/" + FileName; 

                 }
                    else  if(CompId.equals("100037")){
                    	
                        fname = "/usr/share/tomcat/webapps/TransworldDocs/ERPDocs/100037/GRNDocs/" + FileName; 

                }
                    else  if(CompId.equals("100039")){
                    	
                        fname = "/usr/share/tomcat/webapps/TransworldDocs/ERPDocs/100039/GRNDocs/" + FileName; 

                }
                    else   if(CompId.equals("100041")){
                    	
                        fname = "/usr/share/tomcat/webapps/TransworldDocs/ERPDocs/100041/GRNDocs/" + FileName; 

                }
                    else   if(CompId.equals("100043")){
                    	
                        fname = "/usr/share/tomcat/webapps/TransworldDocs/ERPDocs/100043/GRNDocs/" + FileName; 

                }
                    else                    
                    {
                    
                        fname = "/usr/share/tomcat/webapps/TransworldDocs/ERPDocs/100046/GRNDocs/" + FileName; 

                     }
							

		// fname = "/home/twtech/NASRIN/" + FileName;   //path from where file is to be read
		
		System.out.println("The filename is :" + FileName);
		System.out.println("The filepath is :" + fname);

		List sheetData = new ArrayList();
		FileInputStream fis = null;
		try {

			fis = new FileInputStream(fname);
			HSSFWorkbook workbook = new HSSFWorkbook(fis);
			HSSFSheet sheet = workbook.getSheetAt(0);
			Iterator rows = sheet.rowIterator();
			while (rows.hasNext()) {
				HSSFRow row = (HSSFRow) rows.next();
				Iterator cells = row.cellIterator();

				List data = new ArrayList();
				while (cells.hasNext()) {
					HSSFCell cell = (HSSFCell) cells.next();
					data.add(cell);

				}

				sheetData.add(data);
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (fis != null) {
				fis.close();
			}
		}
		//show excel data=====
		//	System.out.println("The >>>>>>>>>>>>is :");

		int cnt = 0;
		boolean msgpgflg = false;
		ArrayList al = new ArrayList();
		String rjtask = "";
		String seventhdt = "";
		
		
%>

<table id="example"  class="display"  a style="width:100%"  cellspacing="0" border="1">  
		<thead>
	     <tr>
	         <th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;" >Sr No.</th>
		    <th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">GRN No</th>
		    <th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">GRN Date</th>
		    <th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">PO No</th>
		    <th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Carrier</th>
		    <th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Docket No.</th>
		    <th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Sender Person Name</th>
 		    <th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">TW Reference No</th>
 		    <th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Make</th>
 		    <th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Model</th>
 		    <th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Description</th>
 		    <th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Invoice No</th>
            <th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Warranty</th>
		    <th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Expiry Date</th>
		    <th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Supplier Name</th>
 		    <th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Supplier contact</th>
 		    <th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Supplier Email Id</th>
	  
 		      </tr>
		</thead>
		
        <tbody>
<%

//excel file reading 

   		 	// Iterates the data and print it out to the console.	
		for (int i = 1; i < sheetData.size(); i++) {
			//cnt++;
			String row = "";
			List list = (List) sheetData.get(i);

			
			try {
				//System.out.println( "IN ntry   ");
				for (int j = 0; j < list.size(); j++) {
					HSSFCell cell = (HSSFCell) list.get(j);

					System.out.println("The cell type is :" + cell.getCellType());

					if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
						System.out.println("IN IFFFFFFFFF    ");
						if (HSSFDateUtil.isCellDateFormatted(cell)) {
							System.out.print(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
									.format(cell.getDateCellValue()));
							System.out.println("hibhihihihih>>>>" + cell.getDateCellValue());
							if (row.equals("")) {
								System.out.println( "IN another iff ");
								row = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
										.format(cell.getDateCellValue());
								System.out.println("in if>>>>" +row);

							} else {
								row = row + "$" + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
										.format(cell.getDateCellValue());
								System.out.println("in else>>>>" + row);

							}
						} else {
								System.out.println( "INanothsr    ELS SSSSSSS ");
							System.out.print(new BigDecimal(cell.getNumericCellValue()).toString());
							if (row.equals("")) {
								row = new BigDecimal(cell.getNumericCellValue()).toString();
							} else {
								row = row + "$" + new BigDecimal(cell.getNumericCellValue()).toString();
							}
						}

					}

					else {
						System.out.println( "IN mainn     ELS SSSSSSS ");
						System.out.print(cell.toString());
						if (row.equals("")) {
							row = cell.toString();
						} else {
							row = row + "$" + cell.toString();
						}
					}

				}
			} catch (Exception ioe) {
				System.out.println("The exception is :" + ioe);
				ioe.printStackTrace();
			}
			//code for row
			System.out.println("\nThe row is >>  " + row);

			//Insert Row into database
	    String SrNo=""; 
	    String GRNNo=""; 
	    String GRNDate=""; 
	    String PONo=""; 
	    String Carrier=""; 
	    String DocketNo=""; 
	    String SenderPersonName=""; 
	    String TWReferenceNo="";
	    String Make=""; 
	    String Model="";
	    String Description=""; 
	    String InvoiceNo="";
	    String Warranty="";
	    String ExpiryDate="";  
	    String SupplierName="";
	    String SupplierContact="";
	    String SupplierEmailId="";

	    
			int countFeild = 0;
			try {

				StringTokenizer stringTokenizer = new StringTokenizer(row, "$");
				System.out.println("The total no. of tokens generated :  " + stringTokenizer.countTokens());
				countFeild = stringTokenizer.countTokens();

				
				int status=0;
				if (stringTokenizer.countTokens() == 17) {   //here 11 is the total number of columns
					System.out.println("INN");
				     
		
				    //get each row value
				    
			  SrNo=stringTokenizer.nextToken();
             GRNNo=stringTokenizer.nextToken();
             GRNDate=stringTokenizer.nextToken();
             PONo=stringTokenizer.nextToken();            
             Carrier=stringTokenizer.nextToken();
             DocketNo=stringTokenizer.nextToken();
             SenderPersonName=stringTokenizer.nextToken();
             TWReferenceNo=stringTokenizer.nextToken();
             Make=stringTokenizer.nextToken();
             Model=stringTokenizer.nextToken();
             Description=stringTokenizer.nextToken();				    
             InvoiceNo=stringTokenizer.nextToken();				                      
             Warranty=stringTokenizer.nextToken();
             ExpiryDate=stringTokenizer.nextToken();  
             SupplierName=stringTokenizer.nextToken();				                      
             SupplierContact=stringTokenizer.nextToken();
             SupplierEmailId=stringTokenizer.nextToken();  
         		  	
             
             GRNDate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(GRNDate));
             ExpiryDate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(ExpiryDate));

             
                    System.out.println("SrNo:"+SrNo);
                    System.out.println("GRNNo:"+GRNNo);
				    System.out.println("GRNDate:"+GRNDate);
					System.out.println("PONo:"+PONo);
					System.out.println("Carrier:"+Carrier);
					System.out.println("DocketNo:"+DocketNo);
					System.out.println("SenderPersonName:"+SenderPersonName);
					System.out.println("TWReferenceNo:"+TWReferenceNo);
					System.out.println("Make:"+Make);
					System.out.println("Model:"+Model);
					System.out.println("Description:"+Description);
					System.out.println("InvoiceNo:"+InvoiceNo);
					System.out.println("Warranty:"+Warranty);
					System.out.println("ExpiryDate:"+ExpiryDate);	
					System.out.println("SupplierName:"+SupplierName);
					System.out.println("SupplierContact:"+SupplierContact);
					System.out.println("SupplierEmailId:"+SupplierEmailId);
			
					
				}
				

	   %>
	   
             <tr>
             <td align="right" style="font-size:11px;" >
                    <div align="right"> <%=SrNo%></div>
             </td>
		    <td style="font-size:11px;">
                     <div align="right"><%=GRNNo%></a></div>
            </td>
             <td style="font-size:11px;">
                     <div align="left"><%=GRNDate%></div>
            </td>
            <td style="font-size:11px;">
                     <div align="right"><%=PONo%></div>
             </td>
             <td style="font-size:11px;"> 
                     <div align="left"><%=Carrier%></div>
             </td>        
             <td style="font-size:11px;">
                     <div align="left"><%=DocketNo%></div>
            </td>
             <td style="font-size:11px;">
                     <div align="left"><%=SenderPersonName%></div>
             </td>
             <td style="font-size:11px;">
                     <div align="right"><%=TWReferenceNo%></div>
             </td>
             <td style="font-size:11px;"> 
                     <div align="left"><%=Make%></div>
              </td>       
             <td style="font-size:11px;">
                     <div align="left"><%=Model%></a></div>
            </td>
             <td style="font-size:11px;">
                     <div align="left"><%=Description%></div>
            </td>
              <td style="font-size:11px;"> 
                     <div align="left"><%=InvoiceNo%></div>
              </td>       
             <td style="font-size:11px;">
                     <div align="right"><%=Warranty%></a></div>
            </td>
             <td style="font-size:11px;">
                     <div align="left"><%=ExpiryDate%></div>
            </td>
             <td style="font-size:11px;">
                     <div align="left"><%=SupplierName%></div>
             </td>
             <td style="font-size:11px;"> 
                     <div align="left"><%=SupplierContact%></div>
             </td>
             <td style="font-size:11px;"> 
                     <div align="left"><%=SupplierEmailId%></div>
             </td>
</tr>
	   
	   <% 
	    
			} catch (Exception e) {
				System.out.println("Exception " + e);
				e.printStackTrace();
			}
			
		
		}
%>

						
					
		</tbody>
		</table>
	
	
</body>
</html>
</jsp:useBean>