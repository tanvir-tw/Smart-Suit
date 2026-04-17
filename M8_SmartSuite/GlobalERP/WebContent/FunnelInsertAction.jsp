<%@ include file="header.jsp"%>              
<%-- <%@ include file="header1.jsp" %> --%>
  <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="java.util.Date"%>	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 

<link rel="stylesheet" type="text/css" href="css/view.css" media="all">
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.2.1/css/responsive.dataTables.min.css">
<link rel="stylesheet" href="css/styleMakePlan.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/responsive/2.2.1/js/dataTables.responsive.min.js"></script>
 <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<script type="text/javascript">
$(document).ready(function() {
    $('#example').DataTable( {
        responsive: {
            details: {
                renderer: function ( api, rowIdx, columns ) {
                    var data = $.map( columns, function ( col, i ) {
                        return col.hidden ?
                            '<tr data-dt-row="'+col.rowIndex+'" data-dt-column="'+col.columnIndex+'">'+
                                '<td>'+col.title+':'+'</td> '+
                                '<td>'+col.data+'</td>'+
                            '</tr>' :
                            '';
                    } ).join('');
 
                    return data ?
                        $('<table/>').append( data ) :
                        false;
                }
            }
        }
    } );
} );
</script>

<script>
function Redirect()
{
	//swal("Plan Created Successfully", "", "success");
	alert("Data saved Successfully");
    window.location="FunnelReport.jsp";
	
}
</script>

<script>
function Redirect1(x,y)
{
	//swal("Plan Created Successfully", "", "success");
	alert("Data saved Successfully!");
    var x= document.getElementById("month").value.trim();
    var y= document.getElementById("year").value.trim();
   // alert(x);
   // alert(y);
    
	window.location="FunnelReport.jsp?month="+x+"&year="+y+"&button=Submit";
	
    return false;
	
}
</script>
</head>
<style type="text/css">
td.details-control {
    background: url('images/details_open.png') no-repeat center center;
    cursor: pointer;
}
tr.shown td.details-control {
    background: url('images/details_close.png') no-repeat center center;
}
</style>
<%
Class.forName(DB_Driver);
Connection conn,conn1;

Statement st,st1,st2,st3,st4,st5,st6;
%>

<%




conn = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
conn1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);

st1=conn.createStatement();
st2=conn.createStatement();
st3=conn.createStatement();
st4=conn.createStatement();
st5=conn.createStatement();
PreparedStatement ps = null;
ResultSet rs4 = null;

int rs1 = 0,rs2 = 0;
String data1,sql,sql1,data2,jcode,origin,destination,startdate;
/* String 	username="";
 */

Date Currdate = new Date(); 
 DateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
 String EntryDate = dateformat.format(Currdate);
 System.out.println("EntryDate-->>" + EntryDate);
 String month = request.getParameter("month1");
	System.out.println("month  : "+month );
	
	String year = request.getParameter("year1");
	System.out.println("year  : "+year );
	

/* String Status = "Scheduled";
DateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String PlanEntryDateTime = dateformat.format(Currdate);
 */
String EntryBy = session.getAttribute("username").toString();
System.out.println("EntryBy-->>" + EntryBy);
String count = request.getParameter("count");
System.out.println("count is:->>>>" + count);
int c = Integer.parseInt(count);

%>
<input type="hidden" name="month" id="month" value="<%=month%>"/>

<input type="hidden" name="year" id="year" value="<%=year%>"/>


<%

if(c>0)
{
	for(int j=1;j<=c;j++)
	{
		if(request.getParameter("chkbx2"+j).equals("true"))
		{
			System.out.println("chkbx2 is:--->>>>" + j);
			
			String techname = request.getParameter("tname"+j);
			System.out.println("TechName : "+techname);
		
			String contractorid = request.getParameter("contid"+j);
			System.out.println("contractorid  : "+contractorid );
			
			String piindex = request.getParameter("pin"+j);
			System.out.println("piindex  : "+piindex );
			
			String kraindex = request.getParameter("kra"+j);
			System.out.println("kraindex  : "+kraindex );
			
			
			String comments = request.getParameter("comments"+j);
			System.out.println("comments  : "+comments );
			
			String dateformated2=new SimpleDateFormat("MMM").format(new SimpleDateFormat("MM").parse(month));

			System.out.println("dateformated2 : "+dateformated2);
			
			

       sql="Select * from db_CustomerComplaints.t_technicianindex where  ContractorId='"+contractorid+"' and Month='"+dateformated2+"' and Year='"+year+"' ";
		System.out.println(sql);
		rs4=st1.executeQuery(sql);
		if(rs4.next())
		{
			String update_status_sql = "update db_CustomerComplaints.t_technicianindex set  PIIndex ='"+ piindex +"',KRAIndex='"+kraindex+"' , Comment='"+comments+"' where ContractorId='"+contractorid+"' and Month='"+dateformated2+"' and Year='"+year+"'";
		   System.out.println("Query is : "+update_status_sql);
		rs2 = st2.executeUpdate(update_status_sql);

           String PlanSql = "insert  into db_CustomerComplaints.t_technicianindexhistory (TechnicianName,ContractorId,PIIndex,KRAIndex,Month,Year,Comment,EntryBy,EntryDate) values ('"+techname+"','"+contractorid+"','"+piindex+"','"+kraindex+"','"+dateformated2+"','"+year+"','"+comments+"','"+EntryBy+"','"+EntryDate+"')";

			System.out.println("Query is : "+PlanSql);
		rs1 = st1.executeUpdate(PlanSql);


	      	
		}
		else
{
 String PlanSql = "insert  into db_CustomerComplaints.t_technicianindex   (TechnicianName,ContractorId,PIIndex,KRAIndex,Month,Year,Comment,EntryBy,EntryDate) values ('"+techname+"','"+contractorid+"','"+piindex+"','"+kraindex+"','"+dateformated2+"','"+year+"','"+comments+"','"+EntryBy+"','"+EntryDate+"')";
			System.out.println("Query is : "+PlanSql);
		rs1 = st1.executeUpdate(PlanSql);


String PlanSql2 = "insert  into db_CustomerComplaints.t_technicianindexhistory (TechnicianName,ContractorId,PIIndex,KRAIndex,Month,Year,Comment,EntryBy,EntryDate) values ('"+techname+"','"+contractorid+"','"+piindex+"','"+kraindex+"','"+dateformated2+"','"+year+"','"+comments+"','"+EntryBy+"','"+EntryDate+"')";

System.out.println("Query is : "+PlanSql2);
			rs1 = st1.executeUpdate(PlanSql2);
}
 



		
	
       
          }
        out.println("<script>  Redirect1();</script>");
		    			  

				

	}
}

%>

<body>


</body>
<br><br>
<%

conn.close();
//conn1.close();

%>




</html>
<%-- <%@ include file="footernew.jsp"%> --%>