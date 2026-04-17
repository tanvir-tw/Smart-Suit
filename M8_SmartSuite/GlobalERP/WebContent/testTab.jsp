
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="com.ConnectionClass"%>
<% 
	
	ConnectionClass connection = new ConnectionClass();
	Connection conn= null;
	Statement stmt1 =null, stmt2=null, stmt3=null;
	
	
	String serverid="",usernm="",passwd="",list="",thumbnailn="";
try
{
	conn = connection.getConnect("db_leaveapplication");
	stmt1 = conn.createStatement();
	stmt2 = conn.createStatement();
	stmt3 = conn.createStatement();
	
	ResultSet rs1=null;
	
	String sqlftp="select * from t_ftpconnection";
	ResultSet rsftp=stmt2.executeQuery(sqlftp);
	rsftp.next();
	serverid=rsftp.getString("ServerID");
	usernm=rsftp.getString("Username");
	passwd=rsftp.getString("Password");
	
	if (request.getParameter("list") != null)
	{
		list=request.getParameter("list");
	}
	if (request.getParameter("thumbnailn") != null)
	{
		thumbnailn=request.getParameter("thumbnailn");
	}
	
	System.out.println(list+"**********"+thumbnailn);
	//***Convert String 1 to ArrayList*********************************************
	ArrayList a2=new ArrayList();
	String delims1 = "[,]";
    String[] token1 = thumbnailn.split(delims1);
	for (String t : token1)
	{
		a2.add(t);
	}
	System.out.println("a2====="+a2);
	//***Convert String 2 to ArrayList*********************************************
	ArrayList a1=new ArrayList();
	String delims12 = "[,]";
    String[] token = list.split(delims12);
	for (String t : token)
	{
		if( !(t.equals("undefined")) )
		{
			a1.add(t);	
		}
		
	}
	System.out.println("a1====="+a1);
	a1.removeAll(a2);
	System.out.println(a1.size()+"a1>>>>>>>>>>>>>>>"+a1);
	//********************************************************************************
	String l1="";
	try
	{
		if(a1.size() != 0)
		{
			System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
			for(int j=0; j<=a1.size()-1; j++)
			{
				if(l1.equals("") || l1=="")
				{
					l1=a1.get(j).toString();
				}
				else
				{
					l1=l1+","+a1.get(j).toString();
				}
			}
		}
	}
	catch(Exception e)
	{
		System.out.println("Exception -------->>"+e);
		
	}
	System.out.println("l1====="+l1);
	//for testing
	//l1 = "2,3,5";
	System.out.println("l1====="+l1);
	//************************************************
	
	int cnt = 0;
	String sqlchk = "Select count(*) as cnt from t_uploadedFiles where SrNo in ("+l1+") and FileStatus = 'inwarded'";
	ResultSet rschk = stmt3.executeQuery(sqlchk);	
	if(rschk.next())
	{
		cnt = rschk.getInt("cnt");
	}
	System.out.println("Count =======>"+cnt);
	if(cnt == 0)
	{	
				System.out.println("Inside the if==");

				String sql1="select * from t_uploadedFiles where SrNo in ("+l1+") ORDER BY FIELD(SrNo,"+l1+")";
				System.out.println(sql1);
			    rs1=stmt1.executeQuery(sql1);
				String buffer="<table><tr>"; 
				int rwCnt=0;
				while(rs1.next())
			   	{
						rwCnt++;
			       // 	buffer=buffer+"<td><a href='#' onclick=getFTPImage('"+rs1.getString("FileName")+"');>"+
			       String w=rs1.getString("FileName").replace(" ","%");
			       buffer=buffer+"<td><a href='#' onclick=display('"+w+"');>"+
					//	"<img src='ftp://sumedh:789&*(medh@202.38.172.58/test/"+rs1.getString("FileName")+"' height='200' width='200'></img></a><br>"+rs1.getString("FileName")+"</td>";
					  "<embed src='http://twtech.in/TWDOC/"+rs1.getString("FileName")+"' height='300' width='200'></embed><br>"+rs1.getString("FileName")+"</td>";
			        	if(rwCnt%3==0)
			        	{
			        		buffer=buffer+"</tr>";
			        	}
				}
				buffer=buffer+"</table>$"+l1+"$Uploaded";
				System.out.println(buffer);
				out.print(buffer);
				stmt1.close();
				conn.close();
	}else
	{
			System.out.println("Inside the else==");
			String sql1="select * from t_uploadedFiles where SrNo in ("+l1+") ORDER BY FIELD(SrNo,"+l1+")";
			System.out.println(sql1);
		    rs1=stmt1.executeQuery(sql1);
			String buffer="<table><tr>"; 
			int rwCnt=0;
			while(rs1.next())
		   	{
					rwCnt++;
		       // 	buffer=buffer+"<td><a href='#' onclick=getFTPImage('"+rs1.getString("FileName")+"');>"+
		       String w=rs1.getString("FileName").replace(" ","%");
		       buffer=buffer+"<td><a href='#' onclick=display('"+w+"');>"+
				//	"<img src='ftp://sumedh:789&*(medh@202.38.172.58/test/"+rs1.getString("FileName")+"' height='200' width='200'></img></a><br>"+rs1.getString("FileName")+"</td>";
				  "<embed src='http://twtech.in/TWDOC/"+rs1.getString("FileName")+"' height='300' width='200'></embed><br>"+rs1.getString("FileName")+"</td>";
		        	if(rwCnt%2==0)
		        	{
		        		buffer=buffer+"</tr>";
		        	}
			}
			buffer=buffer+"</table>$"+l1+"$Inwarded";
			System.out.println(buffer);
			out.print(buffer);
			
			  
			stmt1.close();
			conn.close();
	}
}
catch(Exception e)
{
	System.out.print("^^^^^^^^^^^"+e);
}
finally
{
	conn.close();
}
%>
