<%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>
<%@page import="com.ConnectionClass"%> 

<%!
Connection con1=null;
Statement st1=null;
ResultSet rs=null;
%>
<% 
String query; String MonthNameList="";

try{	

	ConnectionClass connection= new ConnectionClass();
	con1 = connection.getConnect("db_GlobalERP"); 		
		st1=con1.createStatement();
		    	    
        String year=request.getParameter("year");

		int currentYear = java.time.LocalDate.now().getYear();
         String cntyear = Integer.toString(currentYear);
         System.out.println(cntyear);

	        if (year.equals(cntyear)) {
	            System.out.println("in if");

	        query="select  DATE_FORMAT(m1, '%b %Y') as month from ( select  (DATE(now()) - INTERVAL DAYOFMONTH(LAST_DAY(CONCAT(YEAR(Date(now())), '-12-31')))-0 DAY)  +INTERVAL m MONTH as m1 from ( select @rownum:=@rownum+1 as m from (select 1 union select 2 union select 3 union select 4) t1, (select 1 union select 2 union select 3 union select 4) t2, (select 1 union select 2 union select 3 union select 4) t3, (select 1 union select 2 union select 3 union select 4) t4, (select @rownum:=0) t0 ) d1 ) d2  where m1<=LAST_DAY(CONCAT(YEAR(Date(now())), '-12-31')) order by m1";
	       
	        }else{
	        	
		        query="select  DATE_FORMAT(m1, '%b %Y') as month from ( select  (DATE(CONCAT('"+year+"', '-01-01')) - INTERVAL DAYOFMONTH(LAST_DAY(CONCAT('"+year+"', '-12-31')))-1 DAY)  +INTERVAL m MONTH as m1 from ( select @rownum:=@rownum+1 as m from (select 1 union select 2 union select 3 union select 4) t1, (select 1 union select 2 union select 3 union select 4) t2, (select 1 union select 2 union select 3 union select 4) t3, (select 1 union select 2 union select 3 union select 4) t4, (select @rownum:=0) t0 ) d1 ) d2  where m1<=LAST_DAY(CONCAT('"+year+"', '-12-31')) order by m1";

	        }
	        
	        	st1=con1.createStatement();
	        	rs= st1.executeQuery(query);
	        	String month="",monthname="";
	        	System.out.println("Query :- "+query);
	            while(rs.next()){
	            month=rs.getString("month");
	            System.out.println("Month : " + month);
    
	            String[] arr = month.split(" ");
	            
	            String monthName = arr[0]; // "Nov"
	            String year1 = arr[1];      // "2025"
	            
	            System.out.println("Month Name: " + monthName);
	            System.out.println("Year1: " + year1);
	            
	            MonthNameList+="<option value='"+monthName+"'>"+monthName+"</option>";
	      
	            }
	            System.out.println("MonthNameList:"+MonthNameList);
	            out.println("<option value='Select'>Select</option>"+MonthNameList);


}catch(Exception e){
	            	e.printStackTrace();
	            }
%>