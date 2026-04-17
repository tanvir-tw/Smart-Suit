package com.erp.beans;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.Format;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.OfficeXmlFileException;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.omg.CORBA.DynAnyPackage.Invalid;
import com.erp.beans.InvalidData;
import com.erp.beans.ValidData;
import com.erp.beans.DisplayData;

public class ExcelFollowupReader {

	Connection conn=null,con=null; 
	PreparedStatement ps=null;
	Statement stmt=null,stmt1=null,stmt2=null,stn3=null,stmt3=null,stmt4=null,stmt10=null;
	ResultSet rs=null;

	/** Creates a new instance of POIExcelReader */
	public ExcelFollowupReader()
	{}

	/**
	 * This method is used to display the Excel content to command line.
	 *
	 * @param xlsPath
	 */
	@SuppressWarnings ({ "unchecked", "deprecation" })

	/*private void getConnection() throws ClassNotFoundException, SQLException{
		String MM_dbConn_DRIVER="com.mysql.cj.jdbc.Driver";
		String MM_dbConn_USERNAME="erp";
		String MM_dbConn_PASSWORD="1@erp";
		String MM_dbConn_STRING="jdbc:mysql:// twdb.fleetview.in/db_gps";
		Class.forName(MM_dbConn_DRIVER);
		conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

	}*/

	private void getnewConnection() throws ClassNotFoundException, SQLException
	{
		String MM_dbConn_DRIVER="com.mysql.cj.jdbc.Driver";
		String MM_dbConn_USERNAME="erp";
	//	String MM_dbConn_USERNAME="erp";
		
		String MM_dbConn_PASSWORD="1@erp";
		//	String MM_dbConn_PASSWORD="1@erp";
	String MM_dbConn_STRING="jdbc:mysql:// twdb.fleetview.in/db_GlobalERP";
//		String MM_dbConn_STRING="jdbc:mysql://192.168.2.55/twsql_twalldata";
		Class.forName(MM_dbConn_DRIVER);
		con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		stmt=con.createStatement();
		stmt1=con.createStatement();
		stmt2=con.createStatement();
		stn3=con.createStatement();
		stmt3=con.createStatement();
		stmt4=con.createStatement();
		stmt10=con.createStatement();
	}

	public ArrayList<DisplayData> displayFromExcel (String xlsPath) throws ClassNotFoundException, SQLException, ParseException,OfficeXmlFileException
	{

		InputStream inputStream = null;

		try
		{
			inputStream = new FileInputStream (xlsPath);
		}
		catch (FileNotFoundException e)
		{
			System.out.println ("File not found in the specified path.");
			e.printStackTrace ();
		}



		POIFSFileSystem fileSystem = null;
		//bean for insertion
		ValidData valid = null;
		InvalidData invaliddata =null;
		DisplayData dispdata=null;

		ArrayList<ValidData> validList= new ArrayList<ValidData>();
		ArrayList<InvalidData> invalidList= new ArrayList<InvalidData>();
		ArrayList<DisplayData> dispList= new ArrayList<DisplayData>();

		try
		{
			fileSystem = new POIFSFileSystem (inputStream);

			HSSFWorkbook      workBook = new HSSFWorkbook (fileSystem);
			HSSFSheet         sheet    = workBook.getSheetAt (0);
			Iterator rows     = sheet.rowIterator ();
			System.out.println(sheet.getLastRowNum()+"<<last row no   >>  "+sheet.getDefaultColumnWidth());
			while (rows.hasNext ())	{
				System.out.println("row:"+rows);
				boolean insertFlag = false;
				System.out.println("@@@@@@@@@@@@@@@@@@@@"+insertFlag);
				//valid and invalid bean
				valid = new ValidData();
				invaliddata = new InvalidData();
				dispdata=new DisplayData();
				// 
				HSSFRow row = (HSSFRow)rows.next ();
				// display row number in the console.
				System.out.println ("Row No.: " + row.getRowNum ());
				int rowno=row.getRowNum ();
				if(rowno!=0){
					// once get a row its time to iterate through cells.
					Iterator cells = row.cellIterator ();

					while (cells.hasNext ()) {

						HSSFCell cell = (HSSFCell)cells.next ();

						System.out.println ("Cell No.: " + cell.getColumnIndex());

						/*
						 * Now we will get the cell type and display the values
						 * accordingly.
						 */

						switch(cell.getColumnIndex())
						{
						
						
						case 0:
						{
							
							
							try
							{
							int srno = (int) cell.getNumericCellValue();
							System.out.println("PROspect cust coe ::  %%%%%%%%%%%%%"+srno);
								dispdata.setProspCustCode(srno+"");
								if(srno!=0 )
								{
									System.out.println("IN 'IF' OF PROSPECTIVE CODE   ");
									valid.setProspCustCode(srno);	
								}
								else
								{
									System.out.println("IN 'ELSE'  OF PROSPECTIVE CODE   ");
									invaliddata.setProspCustCode(srno);	
									dispdata.setProspCustCode("Error "+srno);
									insertFlag = true;
								}
							}
							catch(Exception e)
							{	dispdata.setProspCustCode("Customer COSE IS WRONg");
							//	dispdata.setSrNo("Error: Sr.No should be in number format");
								insertFlag = true;
								e.printStackTrace();
							}
							break;
						}

						case 1:
						{
							int srno1 = (int) cell.getNumericCellValue();
							try
							{
							
							System.out.println("SALES CUST CODE ::  %%%%%%%%%%%%%"+srno1);
								dispdata.setSalesCustCode(srno1+"");
								if(srno1!=0)
								{
									System.out.println("IN IF OF SALES CUST CODE   ");
									valid.setSalesCustCode(srno1);	
								}
								else
								{
									System.out.println("IN ELSE  OF SALES CUST CODE   ");
									invaliddata.setSalesCustCode(srno1);	
									dispdata.setSalesCustCode("Error "+srno1);
									insertFlag = true;
								}
							}
							catch(Exception e)
							{
								invaliddata.setSalesCustCode(srno1);	
								e.printStackTrace();
								dispdata.setSalesCustCode(srno1+"Error: Sr.No should be in number format");
								insertFlag = true;
							}
							break;
						}

						case 2:
						{
							HSSFRichTextString Date = cell.getRichStringCellValue ();
							String var= Date.toString();
							try{
								
								System.out.println("  DATE  ::  %%%%%%%%%%%%%"+var);
								dispdata.setDate(var);
								if(var!="" || var!=null)
								{
									valid.setDate(var);
									
										
								}
								else
								{
									invaliddata.setDate(var);
									dispdata.setDate(var+"Error: Date format is wrong.");
									insertFlag = true;
								}
								
								
						
							}catch(Exception e)
							{
								invaliddata.setDate(var);
								dispdata.setDate(var+"[Error: DATE is in Incorrect Format]");
								e.printStackTrace();
								insertFlag = true;
							}


							break;
						}
											
						case 3:
						{
							HSSFRichTextString Status= cell.getRichStringCellValue ();
							String var= Status.toString();
							try{
								
								System.out.println(" STATUS  :: %%%%%%%%%%%%%"+var);
								dispdata.setStatus(var);
							
								if(var.contains("cold") || var.contains("hot") || var.contains("warm"))
								{

									valid.setStatus(var);
									
									//	System.out.println("valid "+var);
								}

								else
								{
									invaliddata.setStatus("Error "+var);
									dispdata.setStatus(var+"[Error:Staus is Wrong]");
									insertFlag = true;
								}
								
							}catch(Exception e)
							{
								e.printStackTrace();
								invaliddata.setStatus("Error "+var);
								dispdata.setStatus(var+"[Error:Staus is Wrong]");
								insertFlag = true;
							}
						

							break;
						} 
						
						case 4:
						{
							HSSFRichTextString FollowupType= cell.getRichStringCellValue ();
							String var= FollowupType.toString();
							
							try{
								System.out.println("FOLLOW UP TYPE   "+var);
								dispdata.setFollowupType(var);
							//	valid.setFollowupType(var);
								
								
								if(var.contains("visit") || var.contains("Visit") ||  var.contains("visits") || var.contains("Visits") || var.contains("email") || var.contains("Email") || var.contains("call") || var.contains("phonecall") || var.contains("call"))
								{

									valid.setFollowupType(var);

									//	System.out.println("valid "+var);
								}

								else
								{
									invaliddata.setFollowupType("Error "+var);
									dispdata.setFollowupType(var+"[Error:Followup Type is Wrong]");
									insertFlag = true;
								}
								
							}catch(Exception e)
							{
								e.printStackTrace();
								invaliddata.setFollowupType("Error "+var);
								dispdata.setFollowupType(var+"[Error:Followup Type is Wrong]");
								insertFlag = true;
							}
						

							break;
						} 
						
						case 5:
						{
							HSSFRichTextString FollowUpInOut= cell.getRichStringCellValue ();
							String var= FollowUpInOut.toString();
							try{
									System.out.println("FOLLOUW UP IN OUT ::   %%%%%%%%%%%%%"+var);
								dispdata.setFollowUpInOut(var);
							//	valid.setFollowupType(var);
								if(var.equalsIgnoreCase("In") || var.equalsIgnoreCase("out") || var.equalsIgnoreCase("in") || var.equalsIgnoreCase("Out"))
								{

									valid.setFollowUpInOut(var);
									System.out.println("valid "+var);
								}

								else
								{
									System.out.println("INVALID   valid "+var); 
									invaliddata.setFollowUpInOut("Error "+var);
									dispdata.setFollowUpInOut(var+"[Error:Followup Should Be Either 'IN' Or 'Out'");
									insertFlag = true;
								}
								
							}catch(Exception e)
							{
								e.printStackTrace();
								invaliddata.setFollowUpInOut("Error "+var);
								dispdata.setFollowUpInOut(var+"[Error:Followup Should Be Either 'IN' Or 'Out'");
								insertFlag = true;
							}
						

							break;
						} 
						case 6:
						{
							HSSFRichTextString Comments= cell.getRichStringCellValue ();
							String var= Comments.toString();
							try{
								
								System.out.println("COMMENTS ::  %%%%%%%%%%%%%"+var);
								dispdata.setComments(var);
								
								if(var!="" || var!=null)
								{
								valid.setComments(var);
								
								}
								else
								{
									invaliddata.setComments(var);
									dispdata.setComments("NO COMMENTS ENTERED  : "+var);
									insertFlag = true;
								}
								
								
							}catch(Exception e)
							{
								e.printStackTrace();
								invaliddata.setComments(var);
								dispdata.setComments(var+" NO COMMENTS  ENTERED ");
								insertFlag = true;	
							}
						

							break;
						} 
						case 7:
						{
							HSSFRichTextString NextFollowUpDate= cell.getRichStringCellValue ();
							String var= NextFollowUpDate.toString();
							try{
								
								System.out.println("NEXT DATE ::  %%%%%%%%%%%%%"+var);
								dispdata.setNextFollowUpDate(var);
								
						/*		boolean dateflag=false;
								try
								{
									Date dateformat=new SimpleDateFormat("yyyy-dd-mm").format(new SimpleDateFormat("dd/MM/yy HH:mm").parse(var));;
									
								}catch(Exception e){}
								*/
								if(var!="" || var!=null)
								{
									valid.setNextFollowUpDate(var);
									
										
								}
								else
								{
									invaliddata.setNextFollowUpDate(var);
									dispdata.setNextFollowUpDate("CHECK Next FollowUp Date  :   "+var);
									insertFlag = true;
								}
										
					
							}catch(Exception e)
							{
								e.printStackTrace();
								invaliddata.setNextFollowUpDate(var);
								dispdata.setNextFollowUpDate(var+"FOLLOW UP DATE IS WRONG  ");
								insertFlag = true;
							}
						

							break;
						} 
					
						case 8:
						{
							int MarketingRepCode = (int) cell.getNumericCellValue();
							System.out.println("MAR REP CODE ::  %%%%%%%%%%%%%"+MarketingRepCode);
							try{
								
								
								dispdata.setMarketingRepCode(MarketingRepCode);
								
								if(MarketingRepCode!=0)
								{
									
									valid.setMarketingRepCode(MarketingRepCode);
										
								}
								else
								{
								dispdata.setMarketingRepCode(MarketingRepCode);
									
								invaliddata.setMarketingRepCode(MarketingRepCode);
								insertFlag = true;
								}
					
					
							}catch(Exception e)
							{
								invaliddata.setMarketingRepCode(MarketingRepCode);
								dispdata.setMarketingRepCode(MarketingRepCode);
								e.printStackTrace();
								insertFlag = true;
							}
						

							break;
						}
						case 9:
						{
							HSSFRichTextString ProspCustName= cell.getRichStringCellValue ();
							String var= ProspCustName.toString();
					
							try{
								System.out.println("PROS CUST NAMR ::   %%%%%%%%%%%%%"+var);
								dispdata.setProspCustName(var);
								
								if(var!="" || var!=null)
								{	
								valid.setProspCustName(var);
								
							
								}
								else
								{
									invaliddata.setProspCustName(var);
									dispdata.setProspCustName("CHECK PROSPECT NAME  : "  +var);
									insertFlag = true;
								}
							}catch(Exception e)
							{
								invaliddata.setProspCustName(var);
								e.printStackTrace();
								dispdata.setProspCustName(var+"CHECK PROSPECT NAME   ");
								insertFlag = true;
							}
						

							break;
						}
						case 10:
						{
							HSSFRichTextString PaymentFollowup= cell.getRichStringCellValue ();
							String var= PaymentFollowup.toString();
							try{
								
								System.out.println("PAYMENT FOLLOW UP  ::  %%%%%%%%%%%%%"+var);
								dispdata.setPaymentFollowup(var);
							
								if(var.contains("Yes") || var.contains("No")  ||  var!="" || var!=null || var.contains("yes") || var.contains("no"))
								{

									valid.setPaymentFollowup(var);

									//	System.out.println("valid "+var);
								}

								else
								{
									
									valid.setPaymentFollowup(var);
									invaliddata.setPaymentFollowup("Error "+var);
									dispdata.setPaymentFollowup(var+"[Error: Payment follow Up Should be Yes Or No");
								
									insertFlag = true;
								}
							}catch(Exception e)
							{
								e.printStackTrace();
								invaliddata.setPaymentFollowup("Error "+var);
								dispdata.setPaymentFollowup("CHeck Paymnt Follow UP ");
								insertFlag = true;
							}
														
							break;
						}
							
						default :
						{
							try{
								System.out.println ("Wrong value not numeric: " + cell.getNumericCellValue ());
							}catch(Exception e)
							{
								e.printStackTrace();
								insertFlag = true;
							}
							//insertFlag = true;
							break;
						}
						}//switch end

						//System.out.println("****************************  *********   ");
						
					}//cell end

					System.out.println("IN   IN   INN   INNNNN    "+insertFlag);
										
					if(insertFlag==true)
					{
							System.out.println("Flag is TRUEEEEEEEEEEEEEEEEEEEEEEE");
							try
							{
								int ProspCustCode=0,salescustcode=0,marketingRepCode=0;
								String Date=null,Time=null,Status="",followupType="",FollowUpInOut="",Comments="";
								String nextfollowUpdate="",nextfollowUptime=null,prospCustName=null,PaymentFollowup="";																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																			
								invalidList.add(invaliddata);
								dispList.add(dispdata);
								validList.add(valid);
								java.util.Date d12=new java.util.Date();  	
								Format frt2=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
								String now= frt2.format(d12);
								getnewConnection();
								
								Iterator<InvalidData> itr1 = invalidList.iterator();
								Iterator<ValidData> itr = validList.iterator();

								Iterator<DisplayData> ditr = dispList.iterator();				
								while (ditr.hasNext()) 
								{
									
								System.out.println("IN WHILE   ");
								DisplayData element = ditr.next();
																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																		
								
													
								}
							}
							catch(Exception e){}
							
							
						}else{
							try
							{
								int ProspCustCode=0,salescustcode=0,marketingRepCode=0;
								String Date=null,Time=null,Status="",followupType="",FollowUpInOut="",Comments="";
								String nextfollowUpdate="",nextfollowUptime=null,prospCustName=null,PaymentFollowup="";																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																			

								validList.add(valid); 
								java.util.Date d12=new java.util.Date();  	
								Format frt2=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
								String now= frt2.format(d12);
								getnewConnection();
								
								Iterator<ValidData> itr = validList.iterator();
															
								while (itr.hasNext()) 
								{
									
								System.out.println("IN WHILE   ");
								ValidData element = itr.next();
								ProspCustCode=element.getProspCustCode();
								salescustcode=element.getSalesCustCode();
								Date=element.getDate();
							
								//Time=element.getTime();
								Status=element.getStatus();
								followupType=element.getFollowupType();
								FollowUpInOut=element.getFollowUpInOut();
								Comments=element.getComments();
								System.out.println("66666666666666666666666666       "+Comments);
								nextfollowUpdate=element.getNextFollowUpDate();
								
								marketingRepCode=element.getMarketingRepCode();
								prospCustName=element.getProspCustName();
								PaymentFollowup=element.getPaymentFollowup();																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																	
															
								}
								String newdate=Date.substring(0, 11);
								System.out.println("NEWDATE   "+newdate);
								String followupdate=new SimpleDateFormat(
								"yyyy-MM-dd")
								.format(new SimpleDateFormat(
										"dd-MMM-yyyy")
										.parse(newdate));
								System.out.println("follow date    "+followupdate);
								Time=Date.substring(12,Date.length());
								System.out.println("NEW TIME IS ::    "+Time);
															
								String anotherdate=nextfollowUpdate.substring(0,11);
								System.out.println("date is   for next foll :    "+anotherdate);
								
								String nextfollowupdate=new SimpleDateFormat(
								"yyyy-MM-dd")
								.format(new SimpleDateFormat(
										"dd-MMM-yyyy")
										.parse(anotherdate));
								System.out.println("FOLLO   FOLL    "+nextfollowupdate);
						
								System.out.println("-----------------------------------------  ");
								String nexttime=nextfollowUpdate.substring(12,nextfollowUpdate.length());
								System.out.println("-----------------------------------------  "+nexttime);
								
								System.out.println("?????    "+ProspCustCode);
								System.out.println("?????    "+salescustcode);
								System.out.println("?????    "+Date);
								
								System.out.println("?????    "+Status);
								System.out.println("?????    "+followupType);
								System.out.println("?????    "+FollowUpInOut);
								System.out.println("?????    "+Comments);
								System.out.println("?????    "+nextfollowUpdate);
								System.out.println("?????    "+marketingRepCode);
								System.out.println("?????    "+prospCustName);
								System.out.println("?????    "+PaymentFollowup);
							
								String sqlQuery="INSERT INTO t_followup ( "+ 
									"	ProspCustCode,FollowUpDate,FollowUpTime,Status,	FollowUpType, FollowUpInOut,"+ 
									"	Comments,NextFollowUpDate 	,NextFollowUpTime,"+ 
									" 	MarketingRepcode ,"+ 
									"	ProspCustName , "+ 
									"   PaymentFollowup) VALUES "+ 
									"   ('"+ProspCustCode+" ','"+followupdate+"','"+Time+"','"+Status+"','"+followupType+"','"+FollowUpInOut+"',"+
									" '"+Comments+"','"+nextfollowupdate+"','"+nexttime+"','"+marketingRepCode+"','"+prospCustName+"','"+PaymentFollowup+"')";
								System.out.println("FOLLOWUP QUERY  "+sqlQuery);
							stmt.executeUpdate(sqlQuery);
								
							}catch(Exception e){e.printStackTrace();}
							
							}
						
				}// End of if row 0 end
			}//End of while -row end
		}
		catch (IOException e)
		{
			e.printStackTrace ();
		}
		catch(OfficeXmlFileException e)
		{
			e.printStackTrace();
		}
	
		if(!(validList.isEmpty()))
		{
			/*ManageCustomers cust = new ManageCustomers(); 
			flag = cust.insertCorpEmp(corp,validList);
			if(flag.equalsIgnoreCase("true"))
				return flag;*/
		}

		return dispList;
	}

	private String validateString(String var) 
	{
		String FlagOK="false";
		String str=var;
		for(int i=0;i<str.length();i++)
		{
			FlagOK="false";
			//if(var.charAt(i)>=65 && var.charAt(i)<=90 || var.charAt(i)>=97 && var.charAt(i)<=122 || var.charAt(i)>=48 && var.charAt(i)<=57)
			if (Character.isLetterOrDigit(var.charAt(i)) || Character.isWhitespace(var.charAt(i)))
			{
				FlagOK="true";

			}
			else
				break;

		}

		return FlagOK;
	}

	private String validateName(String var) 
	{
		String FlagOK="false";
		String str=var;
		for(int i=0;i<str.length();i++)
		{
			FlagOK="false";
			//if(var.charAt(i)>=65 && var.charAt(i)<=90 || var.charAt(i)>=97 && var.charAt(i)<=122 || var.charAt(i)>=48 && var.charAt(i)<=57)
			if (Character.isLetter(var.charAt(i)) || Character.isWhitespace(var.charAt(i)))
			{
				FlagOK="true";
			}
			
		}
		return FlagOK;
	}

	public String validate(String regex,String var)
	{ 
	String msg="false";
	Pattern p=Pattern.compile(regex);
	Matcher m=p.matcher(var);
	boolean b=m.matches();
	if(b==true)
	{
		msg="true";
	}
	else
	{
		msg="false";
	}

	return msg;
	}
	/*switch (cell.getCellType ()){

			case HSSFCell.CELL_TYPE_NUMERIC :
			{
				//checking data types of cells


				/*if(cell.getColumnIndex() == 0 || cell.getColumnIndex() == 1 || cell.getColumnIndex() == 2
						|| cell.getColumnIndex() == 2 ||  cell.getColumnIndex() == 3 || cell.getColumnIndex() == 3
						|| cell.getColumnIndex() == 2 ||  cell.getColumnIndex() == 3 || cell.getColumnIndex() == 3
						|| cell.getColumnIndex() == 2 ||  cell.getColumnIndex() == 3 || cell.getColumnIndex() == 3){
					System.out.println ("Wrong value not numeric: " + cell.getNumericCellValue ());
					insertFlag = true;
				}else{
					if(cell.getColumnIndex()==4){
						double d = cell.getNumericCellValue();
						if(HSSFDateUtil.isValidExcelDate(d)){
							System.out.println(HSSFDateUtil.getJavaDate(d));
							String datef=new SimpleDateFormat("yyyy-MM-dd").format(HSSFDateUtil.getJavaDate(d));
							System.out.println(datef);
							}
					}else{
						System.out.println ("Numeric value: " + cell.getNumericCellValue ());
					}
				}
				break;
			}
			case HSSFCell.CELL_TYPE_STRING :
			{
				if(cell.getColumnIndex() == 3){
					System.out.println ("Wrong value not string: " + cell.getRichStringCellValue ());
					insertFlag = true;
				}else{

					// cell type string.
					HSSFRichTextString richTextString = cell.getRichStringCellValue ();

					System.out.println ("String value: " + richTextString.getString ());
				}
				break;
			}

			default :
			{

				// types other than String and Numeric.
				System.out.println ("Type not supported.");

				break;
			}
			} */

}