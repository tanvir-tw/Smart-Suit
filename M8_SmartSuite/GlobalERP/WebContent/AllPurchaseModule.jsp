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
			/*margin-left:5%;*/
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
        		<div align="left" style="background-color:#C6DEFF;margin-left: 0%;height: 385px;width: 150px;position: absolute;">
	</div>
	<div align="right" style="background-color:#C6DEFF;margin-left:90%;margin-right:0%;  height:385px;width: 150px;position: absolute;">
	</div>
        <div style="font-size: 1.9em; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;">
		<a>Purchase Module </a>
		</div>    
        
        
        
        <table align="center">
        <tr>
        <td>
        <div id="mymenu" style="width:100%;background-color: #036;">
        <ul>
        
        <li><a href="#" style="background-color:#3399FF">File</a>
           <ul>
	           <li style="background-color: white;"><a href="#" style="color: black">NEW </a>
		           <ul>
		           <li  style="background-color: white;"><a href="#" style="color:black">Enquiry</a>
		           		<ul>
		           			<li  style="background-color: white;"><a href="PurchaseEnquiry.jsp" style="color:black">Enquiry</a></li>
		           			<li  style="background-color: white;"><a href="ExportPurchaseEnquiry.jsp" style="color:black">Export Enquiry</a></li>
<!--		           			<li  style="background-color: white;"><a href="#" style="color:black">Enquiry Without Sales Dept.</a></li>-->
		           		</ul>
		           </li>
		           <li  style="background-color: white;"><a href="purchaseQuotation.jsp" style="color:black">Quotation</a></li>
		           <li  style="background-color: white;"><a href="purchaseOrder.jsp" style="color:black">Order </a></li>
		           <li  style="background-color: white;"><a href="purchaseInvoice.jsp" style="color:black">Invoice</a></li>
		           <li  style="background-color: white;"><a href="addNewSupplier.jsp" style="color:black">Add Supplier</a></li>
		         
		           </ul>
	           </li>
	           
	           <li style="background-color: white;"><a href="#" style="color: black">CLOSE</a>
		         <ul>
		           <li  style="background-color: white;"><a href="PurchaseEnqList.jsp?id=close" style="color:black">Enquiry</a></li>
		           <li  style="background-color: white;"><a href="PurchaseQuatationList.jsp?id=close" style="color:black">Quotation</a></li>
		           <li  style="background-color: white;"><a href="PurchaseOrderList.jsp?id=close" style="color:black">Order </a></li>
		           <li  style="background-color: white;"><a href="PurchaseInvoiceList.jsp?id=close" style="color:black">Invoice </a></li>
		           </ul>  
	           </li>    
	            
	  		   <li style="background-color: white;"><a href="#" style="color: black">REVISE</a>
	     	 <ul>
	             <li  style="background-color: white;"><a href="PurchaseEnqList.jsp?id=revise" style="color:black">Enquiry</a></li>
		         <li  style="background-color: white;"><a href="PurchaseQuatationList.jsp?id=revise" style="color:black">Quotation</a></li>
		         <li  style="background-color: white;"><a href="PurchaseOrderList.jsp?id=revise" style="color:black">Order </a></li>
		          <li  style="background-color: white;"><a href="PurchaseInvoiceList.jsp?id=revise" style="color:black">Invoice</a></li>
		         </ul> 
             </li>  
              
              <li style="background-color: white;"><a href="#" style="color: black">VIEW</a>
	           	 <ul>
	             <li  style="background-color: white;"><a href="PurchaseEnqList.jsp" style="color:black">Enquiry</a></li>
		         <li  style="background-color: white;"><a href="PurchaseQuatationList.jsp" style="color:black">Quotation</a></li>
		         <li  style="background-color: white;"><a href="PurchaseOrderList.jsp" style="color:black">Order </a></li>
		          <li  style="background-color: white;"><a href="PurchaseInvoiceList.jsp" style="color:black">Invoice</a></li>
		         </ul>
             </li>
               
           </ul>
        </li>
       
        <li><a href="#" style="background-color:#3399FF">Edit</a>
           <ul> <li  style="background-color: white;"><a href="editSupplier.jsp" style="color:black">Edit Supplier</a></li>
           </ul>
        </li>
        
        <li><a href="#" style="background-color:#3399FF">Reports</a>
        <ul>
         <li style="background-color: white;"><a href="#" style="color: black">All Enquiry </a>
		           <ul>
		           <li  style="background-color: white;"><a href="PurchaseEnqList.jsp" style="color:black">By Date Range</a></li>
		          <!--  <li  style="background-color: white;"><a href="" style="color:black">Pending Quat Not Received</a></li> -->
		           </ul>
	    </li>
	 <!--   <li style="background-color: white;"><a href="#" style="color: black">Processed Enquiry </a>
		           <ul>
		           <li  style="background-color: white;"><a href="" style="color:black">Quot Received</a></li>
		           <li  style="background-color: white;"><a href="" style="color:black">Quat Not Received</a></li>
		           </ul>
	    </li>-->
	    <li style="background-color: white;"><a href="purchaseClosedEnquries.jsp" style="color: black">Closed Enquiry </a></li>
	    <li style="background-color: white;"><a href="PurchaseQuatationList.jsp" style="color: black">Purchase Quotation </a></li>
	    <li style="background-color: white;"><a href="PurchaseOrderReport.jsp" style="color: black">Purchase Order </a></li>
	    <li style="background-color: white;"><a href="PurchaseInvoiceList.jsp" style="color: black">Purchase Invoice </a></li> 
	    <li style="background-color: white;"><a href="purchaseGRN report.jsp" style="color: black">Purchase GRN </a></li>
	    <li style="background-color: white;"><a href="paymentAccDet.jsp" style="color: black">Payment Report </a></li>
	      <li style="background-color: white;"><a href="paymentRepForAllSupp.jsp" style="color: black">Vendor's Payment Report</a></li>
	      <li style="background-color: white;"><a href="ItemwisedetailsP.jsp" style="color: black">Purchase Order Report</a></li>
	      
        </ul>
        </li>
        <li><a href="#" style="background-color:#3399FF">Tools</a>
           <ul>
           <li style="background-color: white;"><a href="#" style="color: black">Add Items</a>
           <ul>
		           <li  style="background-color: white;"><a href="GroupMaster.jsp?id=group" style="color:black">Group</a></li>
		           <li  style="background-color: white;"><a href="GroupMaster.jsp?id=make" style="color:black">Make</a></li>
		        	 <!--    <li  style="background-color: white;"><a href="GroupMaster.jsp?id=model" style="color:black">Model </a></li>
		           <li  style="background-color: white;"><a href="GroupMaster.jsp?id=partno" style="color:black">Part No</a></li>
		           <li  style="background-color: white;"><a href="GroupMaster.jsp?id=description" style="color:black">Description</a></li>-->
		         
		   </ul>
           
           </li>
             <li style="background-color: white;"><a href="stockdet.jsp" style="color: black">Stock Update</a></li>
           </ul>
        </li>
        
        <li><a href="purchase.jsp" style="background-color:#3399FF">Search</a></li>
        
        <li><a href="#" style="background-color:#3399FF">Help</a>
           <ul>
           <li style="background-color: white;"><a href="" style="color: black">Under Construction</a></li>
           </ul>
        </li>
        
        <li><a href="home.jsp" style="background-color:#3399FF">Exit</a></li>
        </ul>
        </div>
        </td>
        </tr> 
        </table>
        
        <div>
        &nbsp;&nbsp;&nbsp;
        </div>
        
  		<div style="font-size: 1.7em; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;">
  		<div>&nbsp;&nbsp;&nbsp;</div>
  		<table align="center" >
  		<tr>
  		<td style="text-align: justify;">
  		<a>
  	
		The purchase order management module in eresource ERP includes On-time Requisition,<br></br>
	    Contract Management, Rate Sealing with vendors, Vendor Management. This module also <br></br>
	    offers access to approved supplier, purchase order management, purchase enquiry to be <br></br>
	    floated to multiple vendors on just a click of a button.
</a>
		</td>
		</tr>
		</table>
		</div>    
        
      
      <br><br> <br><br>
        <br><br> <br><br> 
        <div id="footer">
        <p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
        by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
        </div>
        
        </div>
        </body>
        </html>
        