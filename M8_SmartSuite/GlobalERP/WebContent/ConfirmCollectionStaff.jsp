<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>

<script type="text/javascript">

function fun(){
	
	
	
	
		  //alert("a");
		  var  agree=confirm("Are you sure !");
		  //alert(agree);
		  
		  var SrNo=document.getElementById("deactiveid").value;
		 // var VehCode=document.getElementById("VehCode").value;
		  //var SrNo=document.getElementById("SrNo").value;
		  //alert(SrNo) ;
		  if(agree)
		  {
			 	
			 window.location="collectionCancel.jsp?action=delete&id="+SrNo+"";
			 return true ;
		  }	  	   
		  else
		  {
			  //alert("D") ;
			 
			 window.location="collectionStaffReport.jsp";
		     return false ;
		  }	  	   
	 
}

</script>
<form name="collection" id="collection">
<body>
<%			
			
		String id1=request.getParameter("Id");
System.out.println("FromDAte======>>>"+id1);
%>

<input type="hidden" id="deactiveid" name="deactiveid" value="<%=id1%>" />

<script>
window.onload=fun ;
</script>
</body>
</form>
</html>