package com.erp.beans;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFRow;

public class AnnexureGeneration {
	
	Connection conn=null;
	Statement st = null,st1=null,st2=null;
	String InvoiceRefNo;
	String month,year;
	String CompanyMasterId;
	
	public void GetConnection() {
		
		
		String host1 = System.getenv("DB_GLOBALERP_HOST");
		String user1 = System.getenv("DB_GLOBALERP_USER");
		String pass1 = System.getenv("DB_GLOBALERP_PASS");
		
		String MM_dbConn_DRIVER = "com.mysql.cj.jdbc.Driver";
		
		try {
			Class.forName(MM_dbConn_DRIVER);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		try {
			conn = DriverManager.getConnection("jdbc:mysql://"+host1+"/db_GlobalERP", user1, pass1);
			st = conn.createStatement();
			st1 = conn.createStatement();
			st2 = conn.createStatement();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
	
	public AnnexureGeneration(String InvoiceRefNo,String Month,String Year,String CompanyMasterId) {
		this.InvoiceRefNo = InvoiceRefNo;
		this.month = Month;
		this.year = Year;
		this.CompanyMasterId =  CompanyMasterId;
		
	}
	

	public File CreateAnnexureForSalesProforma() {
	    GetConnection();

	    HSSFWorkbook workbook = new HSSFWorkbook();
	    HSSFSheet sheet = workbook.createSheet("Annexure Sheet");

	    FileOutputStream fos = null;
	    String filePath  = System.getenv("INVOICE_PATH");

	    if(filePath == null || filePath.isBlank()) {
	        filePath = "/var/www/html/GLOBALERP/VehicleMonthlyInvoices/";
	    }

	 
	    String fileName = "Annexure_" + this.InvoiceRefNo + ".xls";

	    File saveFile = new File(filePath, fileName);

	    try {
	        fos = new FileOutputStream(saveFile);

	        String[] headers = { "SrNo" ,"VehicleNo" , "UnitID" , "InstallDate" , "Status" ,"Transporter" , "VehAddedThisMonth" , "VehRemovedThisMonth" };

	        HSSFRow headerRow = sheet.createRow(0);
	        for (int i = 0; i < headers.length; i++) {
	            headerRow.createCell(i).setCellValue(headers[i]);
	        }

	        int RowNumber = 1;

	        String sql = "select distinct(Vehid),VehRegno,Transporter from db_GlobalERP."+this.CompanyMasterId+"fv_erp_relation"+this.year+"_"+this.month+" where InvoiceRefNo='"+this.InvoiceRefNo+"'";
	        System.out.println(sql);
	        ResultSet rs = st.executeQuery(sql);

	        while(rs.next()) {

	            String vehiclecode = rs.getString("Vehid");
	            String vehicleno = rs.getString("VehRegno");
	            String transporter = rs.getString("Transporter");

	            String unitid = "";
	            String installdate = "";
	            String status = "";
	            String VehAddedThisMonth="",vehRemovedThisMonth="";

	          
	            String sql1 = "select unitid,installeddate,status from db_gps.t_vehicledetails where vehiclecode='"+vehiclecode+"'";
	            System.out.println(sql1);
	            ResultSet rs1 = st1.executeQuery(sql1);

	            if(rs1.next()) {
	                unitid = rs1.getString("unitid");
	                installdate = new java.text.SimpleDateFormat("dd-MMM-yyyy")
	                        .format(new java.text.SimpleDateFormat("yyyy-MM-dd")
	                        .parse(rs1.getString("InstalledDate")));
	                status = rs1.getString("status");

	                if(status.equals("-")) {
	                    status = "Active";
	                }
	            }

	            String sqlbilldetails = "select VehAddedThisMonth,vehRemovedThisMonth from db_GlobalERP."+CompanyMasterId+"billingdetails"+this.year+"_"+this.month+" where VehID='"+vehiclecode+"' order by Rid desc limit 1";
	            System.out.println(sqlbilldetails);
	            ResultSet rs2 = st2.executeQuery(sqlbilldetails);

	            if(rs2.next()) {
	            	VehAddedThisMonth=rs2.getString("VehAddedThisMonth");
                    vehRemovedThisMonth=rs2.getString("vehRemovedThisMonth"); 
	            }

	            String[] rowdata = {
	                String.valueOf(RowNumber),
	                vehicleno,
	                unitid,
	                installdate,
	                status,
	                transporter,
	                VehAddedThisMonth,
	                vehRemovedThisMonth
	            };

	            HSSFRow datarow = sheet.createRow(RowNumber++);
	            for (int j = 0; j < headers.length; j++) {
	                datarow.createCell(j).setCellValue(rowdata[j]);
	            }
	        }

	        

	        workbook.write(fos);

	    } catch(Exception e) {
	        e.printStackTrace();
	    } finally {
	       
	        try { fos.close(); } catch (Exception e) {}
	        CloseConnection();
	    }

	    return saveFile;
	}
	
	public void CloseConnection() {
		try {
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	

}
