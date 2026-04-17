package com.erp.beans;
import java.io.*;  
import javax.servlet.ServletException;  
import javax.servlet.http.*;  
  
public class DownloadServlet extends HttpServlet {  
  
	
/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

public void doGet(HttpServletRequest request, HttpServletResponse response)  
            throws ServletException, IOException 
  {  
	System.out.println("Inside Servlet");
	response.setContentType("text/html");  
	PrintWriter out = response.getWriter(); 
	HttpSession session = request.getSession();
	String arr="";
	String filename="";
	//session.setAttribute("UserName", username);session.getAttribute("searchtxt")!=null?session.getAttribute("searchtxt").toString():"";
	if(session.getAttribute("filenmarray")==null)
	{
		response.sendRedirect("alertGoTo.jsp?msg=You have not created file ,Please Create File .&goto=netBankingCreateFile.jsp");
	}
	else
	{
		arr=session.getAttribute("filenmarray").toString();
	//}
	filename=session.getAttribute("filename").toString();
	//String a=arr[i];
	System.out.println("fff  nnnmmmmmmmmmmmmmmmmmmmmmm"+arr);


	filename = filename+".txt";   
	System.out.println("fff  nnnmmmmmmmmmmmmmNAMEmmmmmmmmm"+filename);
	//String filepath = "/home/r_kunjir/Desktop/netbankingfiles/";   
	response.setContentType("APPLICATION/OCTET-STREAM");   
	response.setHeader("Content-Disposition","attachment; filename=\"" + filename + "\"");   

	//FileInputStream fileInputStream = new FileInputStream(filepath + filename);  
	FileInputStream fileInputStream = new FileInputStream(arr);
	int i;   
	while ((i=fileInputStream.read()) != -1) {  
		out.write(i);   
	}   
	fileInputStream.close();   
	out.close(); 
	}//end of else
}  
  
}  