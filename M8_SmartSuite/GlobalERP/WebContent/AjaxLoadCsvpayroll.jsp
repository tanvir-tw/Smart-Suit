<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="scrollabletable.js"></script>
</head>

<body>
<%
HashMap<String,String> al=new HashMap<String,String>(); 
String buffer="";
String file=request.getParameter("file");
//System.out.println(file);
String[] data=file.split("@"); 



int counttw=0;
int countrgp=0;
int countncpl=0;
buffer+="<table border='2px' class='sortable'>";
buffer+="<tr><th>Sr No</th><th>Company</th><th>ContractorID</th><th>ContractorName</th><th>Month</th>"+
"<th>GP</th><th>TDS</th><th>SP</th><th>Recovery</th><th>NetPay</th><th>PayrollDate</th></tr>";
for(int i=1;i<data.length;i++){

	
	
	String[] tabdata=data[i].split(",");
	buffer+="<tr><td>"+i+"</td>";

	for(int j=0;j<tabdata.length;j++){
	 buffer+="<td>"+tabdata[j]+"</td>";
	 
	 if(tabdata[j].equals("TW")){
		 counttw++;
			
		}
		if(tabdata[j].equals("RGP")){
			countrgp++;
			
		}
		if(tabdata[j].equals("NCPL")){
			countncpl++;
			
		}
		
	}
	
	buffer+="</tr>";
}
buffer+="</table>";
System.out.println(counttw+"TWCOUNT");
System.out.println(countrgp+"RGPCOUNT");
System.out.println(countncpl+"NCPLCOUNT");
out.println(buffer);
System.out.println("Loaded Successfully........");
%>

</body>
</html>