<%@include file="conn.jsp" %>
<%
System.out.println("In AjaxValidateEmpCode.jsp");
String empcode="";
Connection  conn = null;
Statement st = null;
String sql = "";
String recordflag="";
try{
	
	Class.forName(DB_Driver);
	
	conn = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
	
	 st = conn.createStatement();
	 
	 empcode = request.getParameter("empcode");
	
	 sql = "select * from db_GlobalERP.UserMaster where EmpCode='"+empcode+"' and companymasterid='"+session.getAttribute("CompanyMasterID").toString()+"'";
	 System.out.println("sql--->"+sql);
	 ResultSet rs = st.executeQuery(sql);
	 if(rs.next()){
		 recordflag="true";
	 }else{
		 recordflag="false";
	 }
	 
	 out.println(recordflag);
	
	
	
}catch(Exception e){
	e.printStackTrace();
}finally{
	conn.close();
}
%>