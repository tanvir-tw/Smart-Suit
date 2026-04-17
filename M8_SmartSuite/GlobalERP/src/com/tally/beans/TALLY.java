package com.tally.beans;

import java.sql.*;
import java.net.*;
import java.io.*;
import java.text.*;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;
import org.w3c.dom.*;
import org.xml.sax.InputSource;

public class TALLY {
	Connection connmain=null;
	Connection connmain1=null;
	Statement stmain=null;
	Statement stmain1=null;
	 
    public void getConnection(String MM_dbConn_DRIVER,String MM_dbConn_STRING,String MM_dbConn_USERNAME, String MM_dbConn_PASSWORD) {
		try{
			Class.forName(MM_dbConn_DRIVER); 
			connmain = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
			stmain=connmain.createStatement();
		}catch (Exception e) {
			System.out.print(MM_dbConn_USERNAME+MM_dbConn_DRIVER+MM_dbConn_STRING+MM_dbConn_PASSWORD+"******Connection Error");
			e.printStackTrace();
		}
		
	}
	public Connection ReturnConnection() 
	{	
			return connmain;
	}
	
	public void closeConnection()
	{
		try{
			stmain.close();
			connmain.close();
			
		}catch (Exception e) {
			System.out.println("*****/Exception-->"+e);
			e.printStackTrace();
		}
    }
	public String connectTallyserver(String ipAddress)
	{   
		StringBuilder serverresponse = new StringBuilder();
		try
		{
	        URL url=null;
	      	url = new URL("http://"+ipAddress+":9000/");
	      	
	      	//url = new URL("http:// twdb.fleetview.in:9000/");
	      	HttpURLConnection connection = (HttpURLConnection) url.openConnection();
	      	connection.setRequestMethod("GET");
	      	connection.setDoOutput(true);
	      	connection.setReadTimeout(15*1000);
	      	connection.connect();
	      	BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
	        
	      	String line = null;
	      	while ((line = reader.readLine()) != null)
	        {
	      	   serverresponse.append(line + "\n");
	      	}
	      	System.out.println("server response"+serverresponse.toString());
	      	
		}
		catch (Exception e) 
		{
			System.out.println("*****/Exception-->"+e);
			e.printStackTrace();
			
			return "Not Connected !!! while Connecting to Tally"+e.toString();
		}
		return serverresponse.toString();
	}
	
	public String sendTallyserver(String xmldoc,String ipAddress)
	{
		StringBuilder response = new StringBuilder();
		String msgrec=null;
		try
		{
			URL url=null;
		    url = new URL("http://"+ipAddress+":9000/");
		    //url = new URL("http:// twdb.fleetview.in:9000/");
			URLConnection conn = url.openConnection();
		    conn.setDoOutput(true);
		    conn.setReadTimeout(15*1000);
		    conn.connect();
		    OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
		    wr.write(xmldoc.toString());
		    wr.flush();
		    System.out.println(xmldoc.toString());
		    BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		    String line = null;
		    while ((line = reader.readLine()) != null)
		    {
		      response.append(line + "\n");
		    }
		    System.out.println("Response Received from Tally:"+response.toString());
		    msgrec=xmlreadTallyserver(response.toString());
		    
		    System.out.println(msgrec);
		  
		}catch (Exception e)
		{
			System.out.println("*****/Exception-->Send Tally, Message from tally"+e.toString()+msgrec);
			e.printStackTrace();
		}
		return msgrec;
	}
	
	public String xmlreadTallyserver(String xmldoc)
	{
		String errormsg = null;
        try
        {
	      //File file = new File("c:\\response.xml");
		  DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		  DocumentBuilder db = dbf.newDocumentBuilder();
		  InputSource sx = new InputSource(new StringReader(xmldoc)); 
		  Document doc = db.parse(sx);
		  //Document doc = db.parse(xmldoc);
		  doc.getDocumentElement().normalize();
		  String abcde=doc.getDocumentElement().getNodeName();
		  //System.out.println("Root element " + doc.getDocumentElement().getNodeName());
		  System.out.println("Root element " + abcde);
		  NodeList nodeLst = doc.getElementsByTagName(abcde);
		  System.out.println("Information of responses"+nodeLst.item(0));
		  
		  for (int s = 0; s < nodeLst.getLength(); s++) {
		    Node fstNode = nodeLst.item(s);
		    System.out.println(fstNode);
		    
		    if (fstNode.getNodeType() == Node.ELEMENT_NODE) {
		      
		      Element fstElmnt = (Element) fstNode;
		      NodeList fstNmElmntLst = fstElmnt.getElementsByTagName("CREATED");
		      Element fstNmElmnt = (Element) fstNmElmntLst.item(0);
		      NodeList fstNm = fstNmElmnt.getChildNodes();
		      System.out.println("Created : "  + ((Node) fstNm.item(0)).getNodeValue());
		   
		      NodeList vchNmElmntLst = fstElmnt.getElementsByTagName("LASTVCHID");
		      Element vchNmElmnt = (Element) vchNmElmntLst.item(0);
		      NodeList vchNm = vchNmElmnt.getChildNodes();
		      String vch = (((Node) vchNm.item(0)).getNodeValue());
		      
		      NodeList lstNmElmntLst = fstElmnt.getElementsByTagName("ERRORS");
		      Element lstNmElmnt = (Element) lstNmElmntLst.item(0);
		      NodeList lstNm = lstNmElmnt.getChildNodes();
		      String errorcode = (((Node) lstNm.item(0)).getNodeValue());
		      errormsg = "Updated : Tally Voucher Number: "+vch;
		      //System.out.println("its errocode: "+errorcode);
		  
		      if (errorcode.contains("1")){
		    	  NodeList errNmElmntLst = fstElmnt.getElementsByTagName("LINEERROR");
			      Element errNmElmnt = (Element) errNmElmntLst.item(0);
			      NodeList errNm = errNmElmnt.getChildNodes();
			      errormsg = "Error :"+(((Node) errNm.item(0)).getNodeValue());
		      }
		      System.out.println("Errors : " + errormsg);
		    }
		  }
		  } catch (Exception e) 
		  {
		    e.printStackTrace();
		    errormsg="Resopose not received problem from xmlreadserver"+e.toString()+errormsg;
		  }
		
		return errormsg;
	}

	public String exportTallyserver(String xmldoc)
	{
		String errormsg = null;
		System.out.println("xmldoc received :"+xmldoc);
        try
        {
	      //File file = new File("c:\\response.xml");
		  DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		  DocumentBuilder db = dbf.newDocumentBuilder();
		  InputSource sx = new InputSource(new StringReader(xmldoc));
		  Document doc = db.parse(sx);
		  System.out.println("DOCUMENT:"+doc.toString());
		  doc.getDocumentElement().normalize();
		  System.out.println("DOCUMENT AFTER:"+doc.toString());
		  String abcde=doc.getDocumentElement().getNodeName();
		  System.out.println("Root element " + abcde);
		  NodeList nodeLst =doc.getElementsByTagName(abcde);
		  System.out.println("Information of responses"+nodeLst.item(0));
		  
		  for (int s = 0; s < nodeLst.getLength(); s++) {
		    Node fstNode = nodeLst.item(s);
		    System.out.println(fstNode);
		    
		    if (fstNode.getNodeType() == Node.ELEMENT_NODE) {
		      
		      Element fstElmnt = (Element) fstNode;
		      NodeList fstNmElmntLst = fstElmnt.getElementsByTagName("CREATED");
		      Element fstNmElmnt = (Element) fstNmElmntLst.item(0);
		      NodeList fstNm = fstNmElmnt.getChildNodes();
		      System.out.println("Created : "  + ((Node) fstNm.item(0)).getNodeValue());
		   
		      NodeList vchNmElmntLst = fstElmnt.getElementsByTagName("LASTVCHID");
		      Element vchNmElmnt = (Element) vchNmElmntLst.item(0);
		      NodeList vchNm = vchNmElmnt.getChildNodes();
		      String vch = (((Node) vchNm.item(0)).getNodeValue());
		      
		      NodeList lstNmElmntLst = fstElmnt.getElementsByTagName("ERRORS");
		      Element lstNmElmnt = (Element) lstNmElmntLst.item(0);
		      NodeList lstNm = lstNmElmnt.getChildNodes();
		      String errorcode = (((Node) lstNm.item(0)).getNodeValue());
		      errormsg = "Updated : Tally Voucher Number: "+vch;
		      //System.out.println("its errocode: "+errorcode);
		  
		      if (errorcode.contains("1")){
		    	  NodeList errNmElmntLst = fstElmnt.getElementsByTagName("LINEERROR");
			      Element errNmElmnt = (Element) errNmElmntLst.item(0);
			      NodeList errNm = errNmElmnt.getChildNodes();
			      errormsg = "Error :"+(((Node) errNm.item(0)).getNodeValue());
		      }
		      System.out.println("Errors : " + errormsg);
		    }
		  }
		  } catch (Exception e) 
		  {
		    e.printStackTrace();
		    errormsg="Resopose not received problem from exporttallyserver"+e.toString()+errormsg;
		  }
		
		return errormsg;
	}

	public String search_in_tables(String sql) throws SQLException
    	{
		String errormsg = "NOT FOUND";
		String a="com.mysql.cj.jdbc.Driver";
		String b="jdbc:mysql:// twdb.fleetview.in/TWSQL_TWALLDATA";
		String c="erp";
	    String d="1@erp";
	    try{
			Class.forName(a); 
			connmain = DriverManager.getConnection(b,c,d);
			stmain=connmain.createStatement();
		}catch (Exception e) {
			System.out.print(c+a+b+d+"******Connection Error");
			e.printStackTrace();
		}
	    ResultSet rs=stmain.executeQuery(sql);
        try
        {
        	while(rs.next()) 
            {
        		errormsg="Already "+rs.getString("tallyvid");
            }
	    }
	    catch (Exception e) 
	    {
	        e.printStackTrace();
	        errormsg = "search in table problem "+e.toString();
        }
	    return errormsg;
	}
	
	
	public String historylog(String TableName,String FieldNames, String DataValues, String RecordIdentifier, String UserName) throws SQLException
	{
		String errormsg = "NOT FOUND";
		String a="com.mysql.cj.jdbc.Driver";
		//String b="jdbc:mysql://219.64.93.243:3307/TWSQL_TWALLDATA";
		String b="jdbc:mysql:// twdb.fleetview.in/TWSQL_TWALLDATA";
		String c="erp";
		String d="1@erp";
		//String c="unit";
		//String d="1@utp";
		String mTableName=TableName;
		String mFieldNames[]=FieldNames.split(",");
		String mDataValues[]=DataValues.split(",");
		String mRecordIdentifier=RecordIdentifier;
		String mUserName=UserName;
		String sql="";
		String sql1="";
		try
		{
			Class.forName(a); 
			connmain = DriverManager.getConnection(b,c,d);
			stmain=connmain.createStatement();
			connmain1 = DriverManager.getConnection(b,c,d);
			stmain1=connmain1.createStatement();

		}
		catch (Exception e)
		{
			System.out.print(c+a+b+d+"******Connection Error");
			e.printStackTrace();
		}
    	//System.out.print("TableName"+mTableName+"FieldNames"+mFieldNames[1]+"DataValues"+mDataValues[1]+"RecordIdentifier"+mRecordIdentifier);
		sql = "Select * from "+mTableName+" where "+mRecordIdentifier;
		//System.out.print("sql---->>>"+sql);
        ResultSet rs=stmain.executeQuery(sql);
        String mDateUpdation=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
        
        try
        {
         	if(rs.next()) 
            {
         		for (int i = 0; i < mFieldNames.length; i++) 
         	    {
         			//System.out.print("Values====>>>>"+mFieldNames[i]+rs.getString(mFieldNames[i]));
         			if (mDataValues[i].equalsIgnoreCase(rs.getString(mFieldNames[i])))
         			{
         				//System.out.print("Matched:===>>"+i);
         			}
         			else
         			{
         				System.out.print("New Value====>>>>"+mDataValues[i]+"Previous value=====>>>"+rs.getString(mFieldNames[i]));
                        sql1="INSERT INTO t_HistoryLog (date_updation,databasename,tablename,record_id,old_value,new_value,username,columnname) "+
                                "VALUES('"+mDateUpdation+"','"+b+"','"+mTableName+"','"+mRecordIdentifier+"','" +rs.getString(mFieldNames[i])+"','"+mDataValues[i]+"','"+mUserName+"','"+mFieldNames[i]+"')";
                        //System.out.print(sql1);
                        stmain1.executeUpdate(sql1);
                   }
         			
          	    }
         	}
        }
        catch (Exception e) 
        {
        	e.printStackTrace();
        	errormsg = "history Updation problem "+e.toString();
        }	
        connmain.close();
        connmain1.close();
        
        return errormsg;
	}
}

