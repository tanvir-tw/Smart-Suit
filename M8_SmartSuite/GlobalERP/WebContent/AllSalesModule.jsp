<! DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
        
        <%@ include file="header.jsp"%>
        <%@page import="java.util.Date"%>

<style type="text/css">
	    html, body, div, span, ol, ul, li
		{
			border: 0;
			margin: 0;
			padding: 0;
			vertical-align: baseline;
		}

		.clear{clear:both;}

		#mymenu 
		{ /* the menu container */
			margin-left:20%;
			font-family:verdana;
			width: 100%;
			height:22px;
			font-size: 14px;
			text-align:center;
			background:#2AA1CC
			/*border:thin solid;
			border-color:red;
			background: aqua;
			*/
		}

		#mymenu ul
		{ /* menu ul style */
			list-style: none;
			margin: 0;
			height:22px;

		}

		#mymenu li
		 { /* horizontal menu */
			float: left;
			position: relative;
			height:22px;
		
	     }
	     #mymenu ul li a:hover
		 {
	        background-color:#2EAFDA;
	     }
	     
	     
	     
	     
		#mymenu a 
		{ /* the link style of menu */
			color: white;
			display: block;
			line-height: 22px;
			/*padding: 10px;*/
			text-decoration: none;
			border:1px solid #99E7F9;
			width:120px;
			height:22px;
			/*background:#596ABF;*/
			background-color:#2AA1CC;
			
		}
		 /* The sub menu is hidden by default and its position is places right under the parent menu*/
		#mymenu ul ul
		 {
			display: none;
			position: absolute;
			top: 24px;
			left: 0;
			float: left;
			width: 160px;
			/*z-index: 99999;*/
			height:22px;
		
		}

		/* The sub menu list element is given a minimum width */
		#mymenu ul ul li
		 {
			/*min-width: auto;*/
	        height:22px;
			color:#E0F3F7;
			/*background-color:white;*/
		  }

		/* the third level menu (sub sub menu) is placed to the left side of its parent*/
		#mymenu ul ul ul 
		{
			left: 90%;
			height:22px;
			top: 3%;
		}

		#mymenu ul ul a
		{
			/*background-color: #6883F1;*/
			line-height: 1em;
			/*padding: 10px;*/
			width: 160px;
			/*height: auto;*/
			background-color:white;
			color:black;
			
		}
		#mymenu ul li:hover > ul
		{
			display: block;
		}

		/* Styles the anchor (a) tag when mouse over */
		#mymenu li:hover > a,
		#mymenu ul ul :hover > a
		{
			background: #EDF8FB;
			color: black;
		}
		
		
</style>
        <html>
        <body>
<%
Class.forName(DB_Driver);
Connection con1 = DriverManager.getConnection(DB_NAME, DB_USERNAME,DB_PASSWORD);
Statement st1 = con1.createStatement();
Statement st = con1.createStatement();
//st1.executeUpdate("TRUNCATE TABLE "+session.getAttribute("CompanyMasterID").toString()+"tmp_" + session.getAttribute("EmpName").toString().replaceAll(" ","_").replace(".","") +"");
String sqlCreateTmpTable="" +
    			"	CREATE TABLE IF NOT EXISTS "+session.getAttribute("CompanyMasterID").toString()+"tmp_" + session.getAttribute("EmpName").toString().replaceAll(" ","_").replace(".","") + " ( " +
				"		srno INT(10) NOT NULL, " +
				"		TheGroup     VARCHAR(50) NULL, " +
				"		make		VARCHAR(50) NULL, " +
				"		model		VARCHAR(50) NULL, " +
				"		partno		VARCHAR(50) NULL, " +	
				"		description		VARCHAR(255)	NULL, " +
				"		quantity		VARCHAR(50) NULL,  " +
				"		modelNotKnown		boolean NULL  " +
				");";
			
			st.executeUpdate(sqlCreateTmpTable);
			System.out.println(sqlCreateTmpTable);
			try
			{
				st1.executeUpdate("TRUNCATE TABLE "+session.getAttribute("CompanyMasterID").toString()+"tmp_" + session.getAttribute("EmpName").toString().replaceAll(" ","_").replace(".","") +"");
			}
			catch(Exception e)
			{
				System.out.println(e);
			}
%>     
		<div align="left" style="background-color:#C6DEFF;margin-left: 0%;height: 380px;width: 150px;position: absolute;">
	</div>
	<div align="right" style="background-color:#C6DEFF;margin-left:90%;margin-right:0%;  height:380px;width: 150px;position: absolute;">
	</div>
        <div style="font-size: 1.9em; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;">
		<a>Sales Module </a>
		</div>    
        
        <div id="mymenu"  style="width:100%;background-color: white;">
        <ul>
        
        <li><a href="#" style="background-color:#3399FF">File</a>
           <ul>
	           <li ><a href="#" >NEW</a>
		           <ul>
		           <li><a href="#" >Enquiry</a>
		           <ul>
		           <li><a href="sales.jsp" >Domestic</a></li>
		           <li><a href="Exportsales.jsp" >Export</a></li>
		           
		           
		           </ul>
		           
		           
		           </li>
		           <li><a href="salesenq.jsp" >Quotation</a></li>
		           <li><a href="salesorder.jsp">Order </a></li>
		           <li><a href="invoiceReport.jsp?id=proforma" >Proforma Invoice </a></li>
		           <li><a href="#" >Invoice</a>
		            <ul>
		           <li><a href="ProformaInvcList.jsp" >From Proforma</a></li>
		           <li><a href="invoiceReport.jsp?id=main" >From Order</a></li>
		           </ul>
		           </li>
		           </ul>
	           </li>
	           <li><a href="#" >CLOSE</a>
		           <ul>
		           <li><a href="salesEnqReport.jsp?id=close" >Enquiry</a></li>
		           <li><a href="showquotationlist.jsp?id=close" >Quotation</a></li>
		           <li><a href="showorderlist.jsp?id=close" >Order </a></li>
		           <li><a href="showinvoicelist.jsp?id=proformaclose">Proforma Invoice </a></li>
		           <li><a href="showinvoicelist.jsp?id=close" >Invoice </a></li>
		           </ul>
	           </li>    
	           <li ><a href="#" >REVISION</a>
	           	 <ul>
	             <li><a href="salesEnqReport.jsp?id=revise" >Enquiry</a></li>
		         <li><a href="showquotationlist.jsp?id=revise" >Quotation</a></li>
		         <li><a href="showorderlist.jsp?id=revise" >Order </a></li>
		         <li><a href="showinvoicelist.jsp?id=proformarevise" >Proforma Invoice </a></li>
		          <li><a href="showinvoicelist.jsp?id=revise">Invoice</a></li>
		         </ul>
               </li>
                
               <li><a href="#" style="background-color:#3399FF;" >VIEW</a>
	           	 	<ul>
	             		<li><a href="salesEnqReport.jsp?id=View" >Enquiry</a></li>
		         		<li><a href="showquotationlist.jsp?id=View">Quotation</a></li>
		         		<li><a href="showorderlist.jsp?id=View" >Order</a></li>
		         		<li><a href="showProformaInvoice.jsp?id=View" >Proforma Invoice</a></li>
		          		<li><a href="showinvoicelist.jsp?id=View">Invoice</a></li>
		         	</ul>
               </li>
            
               </ul>
        </li>
          
        <li><a href="#" style="background-color:#3399FF">Edit</a>
           <ul><li><a href="#" >Under Construction</a></li>
           </ul>
        </li>
        
        <li><a href="#" style="background-color:#3399FF">View</a>
           <ul>
           <li ><a href="ReceivableReport.jsp" >Receivable Report</a></li>
           <li ><a href="transporterInstallationReport.jsp">Transporter Report</a></li>
           </ul>
        </li>
        
        <li><a href="#" style="background-color:#3399FF;"  >Tools</a>
           <ul>
           <li><a href="transporterData.jsp" style="width: 250px;">Update TransporterData</a></li>
          <li><a href="VehicleAddition.jsp" style="width: 250px;">Configure New Vehicles</a></li> 
         <li><a href="vehiclebillreport.jsp" style="width: 250px;">Billing Detail Report</a></li> 
         <li><a href="autogeneratedbillreport.jsp" style="width: 250px;">Monthly Billing Generation Report</a></li>
         <li><a href="physicaldamagereport.jsp" style="width: 250px;">Physical Damage Invoice Report</a></li>
           </ul>
        </li>
        
        <li><a href="#" style="background-color:#3399FF">Help</a>
           <ul >
           <li><a href="">Under Construction</a></li>
           </ul>
        </li>
        
        <li><a href="home.jsp" style="background-color:#3399FF">Exit</a></li>
        </ul>
       
        </div>
    
        
  		<div style="font-size:1.5em; text-align:center; margin-top:0.5em; margin-bottom:0.5em;">
  		<div>&nbsp;&nbsp;&nbsp;</div>
  		<table align="center" >
  		<tr>
  		<td style="text-align:justify;">
  		<a>
  	
		Sales Module handle all the activities for domestic and export sales of an organization.Capturing enquiries <br></br>
	from potential and existing customers , Quotations and amendments to quotations with complete history,<br></br>
order placement,order scheduling and then dispatching and invoicing form the broad steps of the sales cycle. <br></br>
Besides all this, important analysis reports are provided to guide decision making and strategy planning. <br></br>
		  
	</a>
		</td>
		</tr>
		</table>
		</div>    
        
  
        <br><br> <br><br> <br><br> <br><br>
        <div id="footer">
        <p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
        by Transworld Technologies Ltd. All Rights Reserved.</a></p>
        </div>
        
        </div>
        </body>
        </html>
