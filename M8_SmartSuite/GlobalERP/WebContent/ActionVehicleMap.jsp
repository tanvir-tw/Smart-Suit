<%@page import="java.util.Date"%>
<%
		Date today = new Date();
		int k=0,j=0;
 		String chkedbx="",chkedveh="",vehid="",first="",billYear="",billMonth="";
 		
 		billYear=request.getParameter("billYear");
 		billMonth=request.getParameter("billMonth");
		StringBuffer buffer=new StringBuffer(","); 
 		int len=Integer.parseInt(request.getParameter("checkedNumber").toString());
 		System.out.println("len::"+len);
 		int newlen=len+1;
 		while(j!=newlen)	
 		{
 		if(request.getParameter("check"+j)!=null)
 		buffer.append(j+",");
 		
 		String s=request.getParameter("check"+j);		
 			j++;
 		}		
 		for(int h=0;h <= len;h++)
 		{
 		if(buffer.toString().contains(","+k+","))
 		{

 			 first=request.getParameter("net_id1"+k) ;
 			vehid=request.getParameter("veh_id"+k) ;
 	
 			chkedbx=chkedbx+","+first;
 			chkedveh=chkedveh+","+vehid;
	 		
 		}
 		
 		k++;
 		}
%>

<%

try
{
	String  vehlist="",task_id = "";
	vehlist=chkedveh.replaceFirst(",","");
	String []arr=vehlist.split(",");
	response.sendRedirect("homeNew.jsp?Vehlist="+vehlist+"&billYear="+billYear+"&billMonth="+billMonth+"");
}
catch(Exception e)
{
	System.out.println(">>>>>>>>>>>>Exception:e"+e);
} 

%>
