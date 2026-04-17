<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script>
function fun(){
	  var  agree=confirm("Are you sure !");
	  var SrNo=document.getElementById("deactiveid").value;
	  var Company=document.getElementById("company").value;
	  if(agree)
	  {
		 window.location="ASCSummaryCancel.jsp?action=delete&id="+SrNo+"&company="+Company+"";
		 return true ;
	  }	  	   
	  else
	  {
		 window.location="ASCPendingInvoiceReport.jsp";
	     return false ;
	  }	  	   
}
</script>
<body>

<%			
		String id1=request.getParameter("Id");
		String company=request.getParameter("company");
%>
<input type="hidden" id="deactiveid" name="deactiveid" value="<%=id1%>" />
<input type="hidden" id="company" name="company" value="<%=company%>" />

<script>
window.onload=fun ;
</script>

</body>
</html>