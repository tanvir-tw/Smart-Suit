 <%@ include file="conn.jsp" %>
 <%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>


<%!
Connection con1;
%>
<% 
try
{
		Class.forName(DB_Driver);
		con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		Statement stmt1=con1.createStatement();
		ResultSet rs1=null;
		String sql1="";
		boolean flag=false;

		String todaydate="";
        todaydate=new SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());
        System.out.println(request.getQueryString());
		String modiflag = request.getParameter("modiflag");
		String mPayment_id=request.getParameter("id");
		String myaction = request.getParameter("action");
		String msend_data = request.getParameter("mydata");
		System.out.println(modiflag+"payment_id"+mPayment_id+myaction+msend_data);
		String received_data[]  = msend_data.split("zzz");
		
		String buffer="";
		String mAccountname="",name="";
		
		if (modiflag.contains("C") && myaction.contains("GET") )
		{
            sql1="select * from "+session.getAttribute("CompanyMasterID").toString()+"epayments where payment_id="+mPayment_id+" limit 1";
            rs1=stmt1.executeQuery(sql1);
        	while(rs1.next())
			{
        		buffer+="#"+rs1.getString("voucherno");
        		String mPayment_date =new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs1.getString("payment_date")));
    			String mCheque_date =new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs1.getString("cheque_date")));
  				buffer+="#"+mPayment_date;
  				buffer+="#"+rs1.getString("paid_to");
  				buffer+="#"+rs1.getString("cheque_no");
  				buffer+="#"+mCheque_date;
  				buffer+="#"+rs1.getString("amount");
  				buffer+="#"+rs1.getString("purinvoiceno");
  				buffer+="#"+rs1.getString("bank_name");
  				buffer+="#"+rs1.getString("payment_id");
			} 
        	
			out.println(buffer);
		}
		
		if (modiflag.contains("N") && myaction.contains("POST") )
		{
			String mPayment_date =new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(received_data[7]));
			
			String mCheque_date =new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(received_data[8]));
			System.out.println("a:"+mPayment_date+mCheque_date);
			try
		    {
				if (received_data[9]==null || received_data[9].contains("undefined") || received_data[9]=="0")
				{
      				sql1="INSERT into "+session.getAttribute("CompanyMasterID").toString()+"epayments (voucherno,payment_date,paid_to,cheque_no,cheque_date,amount,purinvoiceno,bank_name)"+
		    	            "VALUES ('"+received_data[1]+"','"+mPayment_date+"','"+received_data[2]+"','"+received_data[3]+"','"+mCheque_date+"','"+received_data[4]+"','"+received_data[5]+"','"+received_data[6]+"')";
				}
				else 
				{
					sql1="UPDATE "+session.getAttribute("CompanyMasterID").toString()+"epayments set voucherno='"+received_data[1]+"', payment_date='"+mPayment_date+"',paid_to='"+received_data[2]+"',cheque_no='"+received_data[3]+"',cheque_date='"+mCheque_date+"', amount='"+received_data[4]+"',purinvoiceno='"+received_data[5]+"', bank_name='"+received_data[6]+"' where payment_id="+received_data[9];
				}
				System.out.println(sql1);
		    	stmt1.executeUpdate(sql1);	
		    }
		    catch(Exception e)
            {
		    	e.printStackTrace();
            }
        }
		if (modiflag.contains("N") && myaction.contains("GET"))
		{
            buffer="##"+todaydate+"###"+todaydate+"#0###";
			out.println(buffer);
		}
		if (modiflag.contains("D") && myaction.contains("GET"))
		{
            buffer="#null#null#null#null#null#0#null#null#null";
            sql1="DELETE from "+session.getAttribute("CompanyMasterID").toString()+"epayments where payment_id="+mPayment_id+" limit 1";
            try
            {
            	stmt1.executeUpdate(sql1);
            
            }
            catch(Exception e)
            {
            	
            }
            
		}
}
catch(Exception e)
{
	out.print("#noting");
}
finally
{
	con1.close();
}


%>
