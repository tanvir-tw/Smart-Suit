<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict/aaa/EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="conn.jsp"%>
<%@ page language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage=""
%>
<%@
page import="javax.*,java.awt.*,

 com.lowagie.text.Chunk, 
 com.lowagie.text.Document, 
 com.lowagie.text.DocumentException, 
com.lowagie.text.Font,
com.lowagie.text.FontFactory, 
com.lowagie.text.HeaderFooter, 
com.lowagie.text.Image, 
com.lowagie.text.PageSize, 
com.lowagie.text.Paragraph, 
com.lowagie.text.Phrase,
 com.lowagie.text.pdf.BaseFont, 
 com.lowagie.text.pdf.PdfContentByte, 
 com.lowagie.text.pdf.PdfImportedPage, 
com.lowagie.text.pdf.PdfLayer, 
com.lowagie.text.pdf.PdfReader, 
com.lowagie.text.pdf.PdfStamper, 
com.lowagie.text.pdf.PdfString, 
com.lowagie.text.pdf.PdfWriter, 
java.io.FileOutputStream,
java.io.*,
java.util.*,
java.awt.*,
java.awt.geom.Rectangle2D,
com.lowagie.text.pdf.*,
com.lowagie.text.pdf.PdfPCellEvent,
com.lowagie.text.*,
com.lowagie.text.Image,
org.jfree.chart.ChartFactory,
org.jfree.chart.JFreeChart,
org.jfree.chart.plot.PlotOrientation,
org.jfree.data.DefaultCategoryDataset,
org.jfree.data.DefaultPieDataset,
org.jfree.chart.ChartFrame,
org.jfree.chart.renderer.BarRenderer,
org.jfree.chart.plot.CategoryPlot,
org.jfree.chart.plot.PiePlot3D"%>



<%@page import="com.lowagie.text.Rectangle"%>
<%@page import="org.apache.poi.hssf.util.HSSFColor.MAROON"%><jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
 
    <script src="dropdown.js" type="text/javascript"></script>
    <script src="dynamic.js" type="text/javascript"></script>

   
    <script type="text/javascript">
    </script>
   
   
    <body>
   
     
 <%
    erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
 %>
 
 <%
     Connection conn = null;
     Statement st = null, st1 = null,st2 = null ,st3 = null, st4 = null, st5 = null,st6 = null;
     String selectedName;
     String FollowUpType = "";
     //Font catFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,    Font.BOLD);
 %>
  <%!    String tgrp="",tmake="",tmodel=""; %>
 <%
     String fromDateCal = "", toDateCal = "", sql = "";
     String todaysTime = new SimpleDateFormat(" HH:mm:ss")
                 .format(new java.util.Date());
     NumberFormat nf = new DecimalFormat("#0.00");
     java.util.Date tdy = new java.util.Date();
     java.util.Date tomorrow = new java.util.Date();
     Calendar cal = Calendar.getInstance();
     Calendar now = Calendar.getInstance();
     cal.setTime(tdy);
     String todaysDate = new SimpleDateFormat("dd-MMM-yyyy")
                 .format(tdy);
     cal.add(Calendar.DAY_OF_MONTH, -1);
     java.util.Date YesterdaysDateAsDate = cal.getTime();
     String yesterdaysDate = new SimpleDateFormat("dd-MMM-yyyy")
                 .format(YesterdaysDateAsDate);

     fromDateCal = toDateCal = new SimpleDateFormat("dd-MMM-yyyy")
                 .format(new java.util.Date());
     try {
             conn = erp.ReturnConnection();
             st = conn.createStatement();
             st1 = conn.createStatement();
             st2 = conn.createStatement();
             st3 = conn.createStatement();
             st4 = conn.createStatement();
             st5 = conn.createStatement();
             st6 = conn.createStatement();
         }
         catch (Exception e)
         {
         }
     %>
   
   
    <%
    
    String purenqrefno=request.getParameter("purenqrefno");
    String twrefno=request.getParameter("twqrefno");
    
    String suppliercode="" , purenqdt="",DueDate="";
    String invoicedate1="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"purchaseenq WHERE PurchaseEnqNo='"+purenqrefno+"' and TWRefNo='"+twrefno+"'";
    ResultSet rsinvoicedate1=st.executeQuery(invoicedate1);
    if(rsinvoicedate1.next())
    {
    	
    	suppliercode = rsinvoicedate1.getString("Suppliercode");
    	purenqdt = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsinvoicedate1.getString("PurEnqDate")));
    	DueDate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsinvoicedate1.getString("DueDate")));
    	
    String a="",b="",c="",d="",f="";
    response.setContentType("application/pdf");
    String filename="PurchaseEnquiry"+twrefno+".pdf";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);

Document document = new Document();
try{
ByteArrayOutputStream buffer = new ByteArrayOutputStream();
PdfWriter writer=PdfWriter.getInstance(document, buffer);
   



Font catFont = new Font(Font.TIMES_ROMAN,10,Font.BOLD);
Font headFont = new Font(Font.TIMES_ROMAN,8,Font.BOLD);
Font new1=new Font(Font.TIMES_ROMAN,10,Font.BOLD);
Font new2=new Font(Font.TIMES_ROMAN,10,Font.BOLD);
Font new3=new Font(Font.TIMES_ROMAN,8,Font.BOLD);

Font NormalFont = new Font(Font.TIMES_ROMAN,10);
Font NormalFont1 = new Font(Font.TIMES_ROMAN,8,Font.BOLD);
Font Normal = new Font(Font.TIMES_ROMAN,8,Font.BOLD);
Font NormalFont21 = new Font(Font.TIMES_ROMAN,8);

Font underline=new Font(Font.TIMES_ROMAN,10,Font.UNDERLINE);
Font Fontforname = new Font(Font.TIMES_ROMAN,8,Font.BOLD);
Font forterms = new Font(Font.TIMES_ROMAN,8,Font.BOLD);
Font smallfont = new Font(Font.TIMES_ROMAN,6,Font.BOLD);
Font NF = new Font(Font.TIMES_ROMAN,1,Font.NORMAL);
Font smallfont2 = new Font(Font.TIMES_ROMAN,6);
document.setPageSize(PageSize.A4);
document.setMargins(20,20,15,11);
document.setMarginMirroring(false);
String sql11 ="select Companyname, address, phone, emailid, godownaddress,website,fax from CompanyMaster where companymid="+session.getAttribute("CompanyMasterID").toString() ;
ResultSet rsexe=st1.executeQuery(sql11);
rsexe.next();
String s1=rsexe.getString(1);
String s2=rsexe.getString(2);
String s3=rsexe.getString(3);
String s4=rsexe.getString(4);
String s5=rsexe.getString(5);
String s6=rsexe.getString(6);
String s7=rsexe.getString(7);
//String s8=rsexe.getString(8);

System.out.println(sql11);
System.out.println(s1+","+s2+","+s3+","+s4+","+s5);

document.open();
Paragraph NF2 = new Paragraph();
NF2.add(new Paragraph("",NF));
NF2.setAlignment("Center");
PdfContentByte canvas1 = writer.getDirectContent();
Rectangle rect1 = new Rectangle(10, 10, 583, 830);
rect1.setBorder(Rectangle.BOX);
rect1.setBorderWidth(1);
canvas1.rectangle(rect1);


Paragraph preface = new Paragraph();
preface.add(new Paragraph(s1,catFont));
preface.setAlignment("center");
preface.add(new Paragraph(s2,NormalFont));
preface.setAlignment("center");
preface.add(new Paragraph("Tel: "+s3+"  Fax: "+s7+"  "+s4+"  "+s6+"",NormalFont));
preface.setAlignment("center");
preface.add(new Paragraph("BILLING & DESPATCH : "+ s2,new3));
preface.setAlignment("center");



document.add(preface);


System.out.println("REF NO IS      "+purenqrefno);
/*String SqlEnqDet = "SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder WHERE PONo='"+ordrefno+"' ";
System.out.println(">>>>>>>>>>>      " + SqlEnqDet);
ResultSet rsEnqDet = st4.executeQuery(SqlEnqDet);
//if (rsEnqDet.next()) {
String suppliercode=rsEnqDet.getString("SupplierCode");   
String podate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsEnqDet.getString("PODate")));
String total=rsEnqDet.getString("Total");
String grandtot=rsEnqDet.getString("GrandTotal");
String discount=rsEnqDet.getString("DiscountPercent");
String totalwords=rsEnqDet.getString("TotalinWords");
String termsconditions=rsEnqDet.getString("Terms");
String currencytype=rsEnqDet.getString("CurrType");
String POQuoNo=rsEnqDet.getString("PurQuoNo");
String PDueDate=rsEnqDet.getString("PODueDate");
String Deliverydate=rsEnqDet.getString("DeliveryDate");
String generateBy=rsEnqDet.getString("SentBy");*/

String sql1="select * from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet where SupplierCode='"+suppliercode+"'";   
ResultSet rssql=st2.executeQuery(sql1);
rssql.next();
String suppliername=rssql.getString("SupplierName");
String add=rssql.getString("Address");
String stat=rssql.getString("State");
String count=rssql.getString("Country");
String zip=rssql.getString("Zip");
String contact=rssql.getString("ContactPerson");
String phn=rssql.getString("Phone");
String fx=rssql.getString("Fax");
String mail=rssql.getString("EMail");
String GSTINNo=rssql.getString("GSTINNo");
if(!GSTINNo.equals("-"))
{
	GSTINNo=rssql.getString("GSTINNo");
}
else
{
	GSTINNo="Not Updated";
}

Paragraph PurchaseEnq = new Paragraph();
PurchaseEnq.add(new Paragraph("",catFont));
PurchaseEnq.add(new Paragraph("Request For Quotation",catFont));
//PurchaseEnq.add(new Paragraph("Purchase Enquiry No. :  "+twrefno+" ",catFont));
PurchaseEnq.setAlignment("Center");
document.add(PurchaseEnq);
document.add(Chunk.NEWLINE );
PdfPTable tableFirst = new PdfPTable(2);

tableFirst.setWidthPercentage(100);
tableFirst.getDefaultCell().setBorder(Rectangle.NO_BORDER);
tableFirst.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
tableFirst.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);

PdfPCell firstcell = new PdfPCell();
firstcell.setFixedHeight(100f);

firstcell.addElement(new Paragraph(" To,",Fontforname));
firstcell.addElement(new Paragraph(" "+suppliername+" ",Fontforname ));
firstcell.addElement(new Paragraph(" "+add+" ",Fontforname )); 
firstcell.addElement(new Paragraph(" Kind Attn : "+contact+" ",Fontforname ));
firstcell.addElement(new Paragraph(" Phone No  : "+phn+" ",Fontforname ));
firstcell.addElement(new Paragraph(" Email        : "+mail+" ",Fontforname ));
firstcell.addElement(new Paragraph(" Fax            : "+phn+" ",Fontforname ));
tableFirst.addCell(firstcell);

PdfPCell firstcell1 = new PdfPCell();
firstcell1.setFixedHeight(70f);
firstcell1.addElement(new Paragraph("TW Ref No  : "+twrefno+" ",Fontforname));
firstcell1.addElement(new Paragraph("Pur Enquiry No  : "+purenqrefno+" ",Fontforname));
firstcell1.addElement(new Paragraph("Pur Enquiry Dt  : "+purenqdt+" ",Fontforname));
firstcell1.addElement(new Paragraph("Pur DueDate          : "+DueDate+" ",Fontforname));

tableFirst.addCell(firstcell1);

document.add(tableFirst);

Paragraph para2 = new Paragraph();
para2.add(new Paragraph("Dear Sir, ",NormalFont21));
para2.add(new Paragraph("We request you to please deliver us the following:- ",NormalFont21));
document.add(para2);
document.add(NF2);

PdfPTable table = new PdfPTable(8);
table.setWidthPercentage(100);

PdfPCell c1 = new PdfPCell(new Phrase("Sr No",NormalFont1));
c1.setHorizontalAlignment(Element.ALIGN_CENTER);
table.addCell(c1);


c1 = new PdfPCell(new Phrase("Group",NormalFont1));
c1.setHorizontalAlignment(Element.ALIGN_CENTER);
table.addCell(c1);

c1 = new PdfPCell(new Phrase("Make",NormalFont1));
c1.setHorizontalAlignment(Element.ALIGN_CENTER);
table.addCell(c1);

c1 = new PdfPCell(new Phrase("Model",NormalFont1));
c1.setHorizontalAlignment(Element.ALIGN_CENTER);
table.addCell(c1);

c1 = new PdfPCell(new Phrase("Part No",NormalFont1));
c1.setHorizontalAlignment(Element.ALIGN_CENTER);
table.addCell(c1);

c1 = new PdfPCell(new Phrase("Description",NormalFont1));
c1.setHorizontalAlignment(Element.ALIGN_CENTER);
table.addCell(c1);

c1 = new PdfPCell(new Phrase("Specification",NormalFont1));
c1.setHorizontalAlignment(Element.ALIGN_CENTER);
table.addCell(c1);

c1 = new PdfPCell(new Phrase("Quantity",NormalFont1));
c1.setHorizontalAlignment(Element.ALIGN_CENTER);
table.addCell(c1);



System.out.println("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPpppp");
       
    int i=1;String z="",o="";
    String refMakeNameTable="",sqlDisplayDesc="";
        //String sqlPurDet = "SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"enquireditems WHERE PurchaseEnqNo ='"+ purenqrefno + "'  ";
        String sqlPurDet = "SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"PRNItemMaster WHERE Purchase_RefNo='"+ purenqrefno + "'";
        System.out.println("TTTTTTTTTTTTTTTTTTTTTTTT     "+sqlPurDet);
                ResultSet rsPurDet = st3.executeQuery(sqlPurDet);
                
                while (rsPurDet.next()) {
                        String makeCode = "", itemCode = "",  quantity="", makeName = "",groupName="",Spec="";
                        int groupCode=0;
                        makeCode = rsPurDet.getString("Make");
                        itemCode = rsPurDet.getString("ItemCode");
                        groupCode = rsPurDet.getInt("TheGroup");
                       // quantity = rsPurDet.getString("Quantity");
                        quantity = rsPurDet.getString("ApprovedQuantity");
                        Spec = rsPurDet.getString("Specifications");
                       
                        String Groupsql = "SELECT TheGroupName FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"+ groupCode + "'  ";
                        ResultSet rsGroup = st4.executeQuery(Groupsql);
                        System.out.println(">>>>>>>>>>>"+Groupsql );
                        if(rsGroup.next())
                        {
                            groupName=rsGroup.getString("TheGroupName");
                       
                        }
                        if(groupCode<5)
                        {
                        	System.out.println("in groupcode<5 condition");
                            refMakeNameTable=session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5)+"makemaster";
                                        
                            String sqlMakename="SELECT MakeName FROM "+refMakeNameTable.toLowerCase()+"  WHERE makecode='"+makeCode+"' ";
                            ResultSet rsMakeName=st5.executeQuery(sqlMakename);
                            System.out.println("********>>>>            "+sqlMakename );
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
                        System.out.println("********>>>>"+sqlDisplayDesc);
                        ResultSet rsSql=st6.executeQuery(sqlDisplayDesc);
                        // while(rsSql.next()){
                        if(rsSql.next())
                        {
                       
                            a=rsSql.getString("Model");
                            b=rsSql.getString("PartNo");
                            c=rsSql.getString("Description");
                        
                        }else{
                        
                        	a="-";
                            b="-";
                            c="-";
                        
                        }
                            //d=rsPurDet.getString("UnitPrice");
                            //f=rsPurDet.getString("Quantity");
                            z=groupName;
                            o=makeName;


c1 = new PdfPCell(new Phrase(""+ i++ +"",NormalFont21));//sr
c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
table.addCell(c1);

 c1 = new PdfPCell(new Phrase(""+ z +"",NormalFont21));  //group
    c1.setHorizontalAlignment(Element.ALIGN_LEFT);
    table.addCell(c1);   

     c1 = new PdfPCell(new Phrase(""+ o +"",NormalFont21)); //make
        c1.setHorizontalAlignment(Element.ALIGN_LEFT);
        table.addCell(c1);   
       
         c1 = new PdfPCell(new Phrase(""+ a +"",NormalFont21));//model
            c1.setHorizontalAlignment(Element.ALIGN_LEFT);
            table.addCell(c1);
           
             c1 = new PdfPCell(new Phrase(""+ b +"",NormalFont21)); //part no
                c1.setHorizontalAlignment(Element.ALIGN_LEFT);
                table.addCell(c1);
               
                 c1 = new PdfPCell(new Phrase(""+ c +"",NormalFont21));//description
                    c1.setHorizontalAlignment(Element.ALIGN_LEFT);
                    table.addCell(c1);
                    
                    c1 = new PdfPCell(new Phrase(""+ Spec +"",NormalFont21));//specification
                    c1.setHorizontalAlignment(Element.ALIGN_LEFT);
                    table.addCell(c1);
                   
                  c1 = new PdfPCell(new Phrase(""+ quantity +"",NormalFont21)); //quantity
                            c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
                            table.addCell(c1);
                           
                          
                               
                                 


                        //}
            }
document.add(table);



try
{
Image image12=null;

SimpleTable table3215 = new SimpleTable();
table3215.setWidthpercentage(100f);
table3215.setBorder(Rectangle.NO_BORDER);
SimpleCell row5 = new SimpleCell(SimpleCell.ROW);

SimpleCell cellforname12 = new SimpleCell(SimpleCell.CELL);
cellforname12 = new SimpleCell(SimpleCell.CELL);
cellforname12.setWidth(0.30f);
cellforname12.add("");
row5.add(cellforname12);

SimpleCell cellforname123 = new SimpleCell(SimpleCell.CELL);
cellforname123 = new SimpleCell(SimpleCell.CELL);
cellforname123.setWidth(0.30f);
cellforname123.add("");
row5.add(cellforname123);

SimpleCell cellforname1234 = new SimpleCell(SimpleCell.CELL);
cellforname1234 = new SimpleCell(SimpleCell.CELL);
cellforname1234.setWidth(0.30f);
cellforname1234.add("");
row5.add(cellforname1234);


SimpleCell cellforname5 = new SimpleCell(SimpleCell.CELL);
cellforname5 = new SimpleCell(SimpleCell.CELL);
cellforname5.setWidth(100f);
cellforname5.setWidth(0.10f);
cellforname5.setWidthpercentage(100f);
cellforname5.setHorizontalAlignment(Element.ALIGN_LEFT);
row5.add(cellforname5);
table3215.addElement(row5);
document.add(table3215);
}
catch(Exception ex)
{
    System.out.print(ex);
    document.add(Chunk.NEWLINE );
   
   
}

Paragraph signature=new Paragraph();
signature.add(new Paragraph(" "+session.getAttribute("EmpName")+" ",Normal));
signature.setAlignment("Right");
document.add(signature);

Paragraph parabottom2=new Paragraph();
parabottom2.add(new Paragraph("(Authorised Signature)",Normal));
parabottom2.setAlignment("Right");
document.add(parabottom2);

Paragraph parabottom3 = new Paragraph();
parabottom3.add(new Paragraph("Contact Email:purchase@twtech.in",Normal));
parabottom3.add(new Paragraph("Contact No:+918600034609",Normal));
parabottom3.setAlignment("Left");
document.add(parabottom3);

// try{
// String paysql="select * from "+session.getAttribute("CompanyMasterID").toString()+"purchasequo where PurQuoNo="+POQuoNo;
// System.out.println(paysql);
// ResultSet rspay=pst.executeQuery(paysql);
// if(rspay.next())
// {
    //Payments Terms
// String payterm=    rspay.getString("TermsOfPayment");
// Paragraph paytrm=new Paragraph();
// paytrm.add(new Paragraph(" "+payterm+" ",NormalFont));
// paytrm.setAlignment("Left");

// document.add(paytrm);
// }}catch(Exception e)
// {
   
// }


PdfContentByte canvas12 = writer.getDirectContent();
Rectangle rect12 = new Rectangle(10, 10, 583, 830);
rect12.setBorder(Rectangle.BOX);
rect12.setBorderWidth(1);
canvas12.rectangle(rect12);


//}
document.close();

DataOutput dataOutput = new DataOutputStream(response.getOutputStream());
byte[] bytes = buffer.toByteArray();
response.setContentLength(bytes.length);
for(int j = 0; j < bytes.length; j++)
{
dataOutput.writeByte(bytes[j]);
}

}catch(Exception e){
    e.printStackTrace();
    }
    finally
    {
        response.getOutputStream().close();
    }   
   
   
   
   
}

%>
</jsp:useBean>    