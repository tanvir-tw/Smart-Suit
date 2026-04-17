<%@page import="java.util.HashMap"%>
<%@page import="java.io.InputStream"%>
<%@page import="org.apache.commons.io.FilenameUtils"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>
<%
Connection con=null ;
	try
	{
		Class.forName(DB_Driver);
		con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		
		Statement st1=con.createStatement();
		Statement stmt1 = con.createStatement();
		Statement stmt2= con.createStatement();
		Statement stmt3= con.createStatement();
		Statement stmt4= con.createStatement();
		String UACName=request.getParameter("UACName");
		String SuperAdmin=request.getParameter("SuperAdmin");
		String Admin=request.getParameter("Admin");
		String Sales=request.getParameter("Sales");
		String Purchase=request.getParameter("Purchase");
		String Claim=request.getParameter("Claim");
		String Account=request.getParameter("Account");
		String Collection=request.getParameter("Collection");
		String SalesAdmin=request.getParameter("SalesAdmin");
		String PurchaseAdmin=request.getParameter("PurchaseAdmin");
		String ClaimAdmin=request.getParameter("ClaimAdmin");
		String AccountAdmin=request.getParameter("AccountAdmin");
		String CollectionAdmin=request.getParameter("CollectionAdmin");

		if(SuperAdmin==null)
		{
			SuperAdmin="No";
		}
		if(Admin==null)
		{
			Admin="No";
		}
		if(Sales==null)
		{
			Sales="No";
		}
		if(Purchase==null)
		{
			Purchase="No";
		}
		if(Claim==null)
		{
			Claim="No";
		}
		if(Account==null)
		{
			Account="No";
		}
		if(Collection==null)
		{
			Collection="No";
		}
		if(SalesAdmin==null)
		{
			SalesAdmin="No";
		}
		if(PurchaseAdmin==null)
		{
			PurchaseAdmin="No";
		}
		if(ClaimAdmin==null)
		{
			ClaimAdmin="No";
		}
		if(AccountAdmin==null)
		{
			AccountAdmin="No";
		}
		if(CollectionAdmin==null)
		{
			CollectionAdmin="No";
		}


		System.out.println("1"+UACName);
		System.out.println("2"+SuperAdmin);
		System.out.println("3"+Admin);
		System.out.println("4"+Sales);
		System.out.println("5"+Purchase);
		System.out.println("6"+Claim);
		System.out.println("7"+Account);
		System.out.println("8"+Collection);
		System.out.println("9"+SalesAdmin);
		System.out.println("10"+PurchaseAdmin);
		System.out.println("11"+ClaimAdmin);
		System.out.println("12"+AccountAdmin);
		System.out.println("13"+CollectionAdmin);
		int UserTypeCode=Integer.parseInt(request.getParameter("UserTypeCode"));
		int AccessCode=Integer.parseInt(request.getParameter("AccessCode"));
		System.out.println("UAC 1 >>>>>>>>>>>>>>>>>>>>"+UserTypeCode);
		System.out.println("AC 2 >>>>>>>>>>>>>>>>>>>>"+AccessCode);
		
		String InsertUTM="UPDATE UserTypeMaster SET UserType='"+UACName+"' where UserTypeCode="+UserTypeCode;
		System.out.println("Update 1:"+InsertUTM);
		stmt3.executeUpdate(InsertUTM);
		
		String InsertACL="UPDATE AccesControlList SET AccessCode='"+AccessCode+"', SuperAdmin='"+SuperAdmin+"', Admin='"+Admin+"', Sales='"+Sales+"', Purchase='"+Purchase+"', Claim='"+Claim+"', Account='"+Account+"', Collection='"+Collection+"', SalesAdmin='"+SalesAdmin+"', PurchaseAdmin='"+PurchaseAdmin+"', ClaimAdmin='"+ClaimAdmin+"',AccountAdmin='"+AccountAdmin+"', CollectionAdmin='"+CollectionAdmin+"' where AccessCode="+AccessCode;
		System.out.println("Update 2:"+InsertACL);
		stmt4.executeUpdate(InsertACL);
		
		response.sendRedirect("alertGoTo.jsp?msg=Updated Successfully&goto=UserAccessControl.jsp");
	}
	catch(Exception e)
	{
		System.out.println(">>>>>>>>>>>>Exception:e"+e);
	}

%>