package com.transactions.beans;

import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.HeaderFooter;
import com.lowagie.text.Image;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

import java.awt.Color;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.MalformedURLException;

public class DemoRequest {

	public void EmailDemoRequest() throws DocumentException, MalformedURLException, IOException{
		
		Document document = new Document();
		PdfWriter writer=PdfWriter.getInstance(document, 
				new FileOutputStream("/home/manjit/Desktop/abc.pdf"));
		//ByteArrayOutputStream buffer = new ByteArrayOutputStream();
	//	PdfWriter writer=PdfWriter.getInstance(document, buffer);
		document.open();
		Image logo = Image.getInstance("/home/manjit/workspace/ERPTEST/WebContent/images/mobile.jpg");
		logo.setAlignment(Image.LEFT);
		logo.scaleAbsoluteHeight(20);
		logo.scaleAbsoluteWidth(17);
		logo.scalePercent(17);
		    
		Chunk chunk = new Chunk(logo,0,-35);
		HeaderFooter header = new HeaderFooter(new Phrase(chunk), false);
		header.setAlignment(Element.ALIGN_LEFT);
		header.setBorder(Rectangle.NO_BORDER);
		document.setHeader(header);
	        
		String srt="I/We XXXXXX (â€œCompanyâ€�) am/are interested in the above products and request you for a Demo of the above products at XXXXX location. Date:XXXXX Duration: XXXXX days. No. of demo units XXXXX. " +
				"We do not deal in these particular products nor do we intend to do so in future. We will issue a successful demo project completion certificate after the successful completion of the demonstration project. " +
				"" +
				"We hereby declare and undertake that we will not copy, reverse engineer or otherwise attempt to acquire the design or software in any manner. We shall not part with the unit or disclose any information including username and password, with any other person or entity for any reason & we conform that the sole purpose of this demo is to evaluate the product and solution for our own use or for the use of our contract vendors / contracted associates in such an event we will ensure the same protection as committed by us. All the demo units will be returned in good working condition to Transworld by the company, in case of loss/damage of the unit, the Company undertakes to pay Rs.18000/- per unit to Transworld." +
				"Company declares and agrees that Transworld exclusively owns the designs, intellectual property including but not limited to material, software and information that comprises or is a part of Vehicle Tracking and Location Systems and the product known as the Mobile Eye, that is provided to the Company and the Company acknowledges the same.";

		BaseFont bf_courier = BaseFont.createFont(BaseFont.TIMES_ROMAN, "Cp1257", false);
    
    HeaderFooter footer = new HeaderFooter(
                  new Phrase("Transworld Compressor Technologies Ltd.   ", new Font(bf_courier)), true);
   
    footer.setBorder(Rectangle.NO_BORDER);
      footer.setAlignment(Element.ALIGN_CENTER);
      document.setFooter(footer);
		document.open();

		Paragraph p2=new Paragraph("Transworld Compressor Technologies Ltd.");
		// p2.font().setStyle(Font.BOLD);
		p2.setAlignment("center");
		document.add(p2);
		
		Paragraph p3=new Paragraph(" C-3/8,Rakshalekha, Koregaon Park, Pune 411 011. INDIA ",  FontFactory.getFont(FontFactory.HELVETICA, 10
		           ));
		//p3.font().setStyle(Font.UNDERLINE);
		p3.setAlignment("center");
		document.add(p3);

		Paragraph pAnchor=new Paragraph(new Chunk("www.Mobile-Eye.in",
				FontFactory.getFont(FontFactory.COURIER, 10, Font.BOLD, new Color(102, 102, 200))).setAnchor("http://www.Mobile-Eye.in"));
		pAnchor.setAlignment("center");
		document.add(pAnchor);
		
		document.add(Chunk.NEWLINE);
		Paragraph p1=new Paragraph("DEMO REQUEST FORM",
				FontFactory.getFont(FontFactory.HELVETICA, 14, Font.BOLD, new Color(104, 104, 210)));
		p1.setAlignment("center");
		document.add(p1);
		
		Paragraph p=new Paragraph(srt);
		document.add(p);
		document.add(Chunk.NEWLINE);
		PdfPCell cell = new PdfPCell();
		cell.addElement(new Paragraph("PRODUCT & DESCRIPTION"));
		cell.setBackgroundColor(Color.LIGHT_GRAY);
		PdfPTable table1 = new PdfPTable(1);
		table1.setHorizontalAlignment(Element.ALIGN_LEFT);
		table1.addCell(cell);
		document.add(table1);
		
		  p1=new Paragraph("Demo of the vehicle tracking software,hardware," +
				"peripherals,accessories and services related to it.",
				FontFactory.getFont(FontFactory.HELVETICA, 12, Font.NORMAL, new Color(104, 104, 210)));
		p1.setAlignment("center");
		document.add(p1);
		document.add(Chunk.NEWLINE);
		
		cell = new PdfPCell();
		cell.addElement(new Paragraph("COMPANY DETAILS"));
		cell.setBackgroundColor(Color.LIGHT_GRAY);
		table1 = new PdfPTable(1);
		table1.setHorizontalAlignment(Element.ALIGN_LEFT);
		table1.addCell(cell);
		document.add(table1);
		
		PdfPTable table = new PdfPTable(4);
		table.getDefaultCell().setBorder(0);

		table.addCell(getCell("Company Name :",true,false));
		table.addCell(getCell("???___XXX___???",false,true));
		table.addCell(getCell("Address :",true,false));
		table.addCell(getCell("???___  ___  ADDRESS  ___________ Address Address Address  ___???",false,true));
		table.addCell(getCell("City",true,false));
		table.addCell(getCell("???CITY???",false,false));
		table.addCell(getCell("Zip",true,false));
		table.addCell(getCell("???__ZIP__???",false,false));
		table.addCell(getCell("State :",true,false));
		table.addCell(getCell("???State???",false,false));
		table.addCell(getCell("Country :",true,false));
		table.addCell(getCell("???Country???",false,false));
		table.addCell(getCell("Name :",true,false));
		table.addCell(getCell("???Name???",false,false));
		table.addCell(getCell("Designation :",true,false));
		table.addCell(getCell("???Designation???",false,false));
		table.addCell(getCell("Phone :",true,false));
		table.addCell(getCell("???_PH_???",false,false));
		table.addCell(getCell("Fax :",true,false));
		table.addCell(getCell("???__FAX__???",false,false));
		table.addCell(getCell("Email :",true,false));
		table.addCell(getCell("???__@Email__???",false,true));	
		table.addCell(getCell("Date :",true,false));
		table.addCell(getCell("???Date???",false,false));
		table.addCell(getCell("Amount :",true,false));
		table.addCell(getCell("???__AMT__???",false,false));
		table.addCell(getCell("Palce :",true,false));
		table.addCell(getCell("???___Palce___???",false,true));
		
		table.addCell(getCell(" ",true,false));	table.addCell(getCell(" ",true,false));
		table.addCell(getCell(" ",true,false));	table.addCell(getCell(" ",true,false));		
		table.addCell(getCell(" ",true,false));	table.addCell(getCell(" ",true,false));
		table.addCell(getCell(" ",true,false));	table.addCell(getCell(" ",true,false));
		
		
		table.addCell(getCell("",true,false));
		table.addCell(getCell("___________",false,false));
		table.addCell(getCell("",true,false));
		table.addCell(getCell("___________",false,false));
		table.addCell(getCell("",true,false));
		table.addCell(getCell("Signature",false,false));
		table.addCell(getCell("",true,false));
		table.addCell(getCell("Company Seal",false,false));
		
		document.add(table);    
		
		document.close();
		
	}
	public   PdfPCell getCell(String cellData,boolean isBold,boolean isColspan){
		Paragraph para=new Paragraph(cellData,FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL));
		/* if(isBold)
		para.font().setStyle(Font.BOLD);*/
			
		PdfPCell cell=new PdfPCell(para);
		cell.setBorder(0);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		if(isColspan)
			cell.setColspan(3);
		return cell;
		
	}
}
