<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="conn.jsp" %>
    <%@ page import="java.util.*"
             import="java.sql.*"
     %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%!
Connection conn = null;
Statement st=null,st1=null,st2=null,st3=null,st4=null;
Statement stitems = null , stupdt = null;
%>
<%

try{

	Class.forName(DB_Driver);
	conn = DriverManager.getConnection(DB_NAME, DB_USERNAME, DB_PASSWORD);

	st = conn.createStatement();
	st1 = conn.createStatement();
	st2 = conn.createStatement();
	st3 = conn.createStatement();
	st4 = conn.createStatement();
	stitems = conn.createStatement();
	stupdt = conn.createStatement();

String supplierlist=request.getParameter("suppliercodes");
int checkedNumber=Integer.parseInt(request.getParameter("checkedNumber"));
String export = "No";

String[] supplier = new String[5];
StringBuffer buffer = new StringBuffer("");
String prnlist="";
String PRNNo="";
String PartNo="",Make="",Model="",Group="";
String ItemName="",ItemCode="",ItemSpec="",Remark="";
String ReqQty="";
int RequestQty=0;
int ApprovedQty=0;

int j=0;
int k=0;
java.util.Date today = new java.util.Date();
String PenqDate=new SimpleDateFormat("yyyy-MM-dd").format(today);
String PenqTime=new SimpleDateFormat("HH:mm:ss").format(today);

String PRNRefNo= request.getParameter("prnrefno");
String comid = session.getAttribute("CompanyMasterID").toString();


int PEnqNO=0;
String penqno="select MAX(PurchaseEnqNo) AS PurEnqNo from db_GlobalERP."+comid+"purchaseenq";


ResultSet rspq = st.executeQuery(penqno);


if(rspq.next()){
	PEnqNO=rspq.getInt(1);
	
PEnqNO++;

}
String twrefno = "";

if(export.equals("Yes"))

{
	 twrefno="TW/EXPSE:0/PUR:";
}else
{
	 twrefno="TW/SE:0/PUR:";
}

twrefno+=PEnqNO;
String twrefno1=twrefno;

int count=0;
StringTokenizer suplist = new StringTokenizer(supplierlist,",");
String supcode1="";
int k1=1;
while(suplist.hasMoreTokens()){
	
	supcode1 = suplist.nextToken(); 
	
	
	System.out.println("supplier-: "+supcode1);
	
	twrefno=twrefno1+"/"+(k1);
	System.out.println("NO IS    *****  "+twrefno);
	
	//insert purchase enquiry into  purchase enquiry master
	String insertEnquiry="Insert into db_GlobalERP."+comid+"purchaseenq (PurchaseEnqNo ,Suppliercode ,SalesEnqNo ,TWRefNo ,PurEnqDate ,Remarks ,SentBy ,PurEnqTime ,SalesenqRecvdDate ,SalesenqRecvdTime ,QuoReceived ,PurEnqClosed ,reasonForClosing ,ModeOfDelivery ,DateOfDelivery,DueDate) "+
					                                "values('"+PEnqNO+"','"+supcode1+"','0','"+twrefno+"','"+PenqDate+"','"+Remark+"','"+session.getAttribute("EmpName")+"','"+PenqTime+"','0000-00-00','00:00:00','0','0','-','-','	0000-00-00',DATE(NOW())+INTERVAL 30 DAY)";
     System.out.println(">>>>insertEnquiry:"+insertEnquiry);
     st4.executeUpdate(insertEnquiry);
	
	
	System.out.println("--------------------------------");
	k1++;
	
}



System.out.println("count:"+count);





while (j <= checkedNumber) {
	if (request.getParameter("purquot" + j) != null) {
		
		if(k==0){
			buffer.append(j);
			prnlist = request.getParameter("prnno"+j);
			
		}else{
			 buffer.append(","+j);
			 prnlist += ","+ request.getParameter("prnno"+j);
		}
		
		PRNNo = request.getParameter("prnno"+j);
		
		ItemName = request.getParameter("itemname"+j);
		ItemSpec = request.getParameter("itemspec"+j);
		ApprovedQty = Integer.parseInt(request.getParameter("apprqty"+j)); 
		
		//get Remaining details from DB for each PRNNo(unique identifier for each item in PRNRefNo)
    	String sql="select * from db_GlobalERP."+comid+"PRNItemMaster where PRNNo='"+PRNNo+"'";
		System.out.println("sqlfetchPRNData---->"+sql);
		ResultSet rs = st1.executeQuery(sql);
		if(rs.next()){
			Group = rs.getString("TheGroup");
			Make=rs.getString("Make");
			Model=rs.getString("Model");
			PartNo=rs.getString("PartNo");
			ItemCode=rs.getString("ItemCode");
			ReqQty=rs.getString("Quantity");
			Remark=rs.getString("Remark");
			
		}
		
		System.out.println("PRN RefNo:"+PRNRefNo);
		System.out.println("PRNNo:"+PRNNo);
		System.out.println("Group:"+Group);
		System.out.println("Make:"+Make);
		System.out.println("Model:"+Model);
		System.out.println("PartNo:"+PartNo);
		System.out.println("ItemCode:"+ItemCode);
		System.out.println("ItemName:"+ItemName);
		System.out.println("ItemSpecs:"+ItemSpec);
		
		//System.out.println("ReqQty(string):"+ReqQty);
		if(ReqQty!=null){
		    RequestQty = Integer.parseInt(ReqQty);
		}else{
			RequestQty=0;
		}
		
		System.out.println("Req. Qty(int):"+RequestQty);
		System.out.println("Approved. Qty:"+ApprovedQty);
		
		String insertIntoItems="Insert into db_GlobalERP."+comid+"enquireditems (PurchaseEnqNo ,TheGroup ,Make ,ItemCode ,Quantity ,RecommendedSupp) "+
				                                                          "values('"+PEnqNO+"','"+Group+"','"+Make+"', '"+ItemCode+"' ,'"+ApprovedQty+"','-')";
		System.out.println(">>>>>>>insertIntoItems:"+insertIntoItems);
		st2.executeUpdate(insertIntoItems);
		
		
		//String updateItemMaster = "update db_GlobalERP."+comid+"PRNItemMaster set Purchase_RefNo='"+PEnqNO+"',ApprovedQuantity="+ApprovedQty+",Status='Enquired' where PRNNo='"+PRNNo+"' and PRN_RefNo='"+PRNRefNo+"'";
		String updateItemMaster = "update db_GlobalERP."+comid+"PRNItemMaster set Purchase_RefNo='"+PEnqNO+"',ApprovedQuantity="+ApprovedQty+",Specifications='"+ItemSpec+"',Status='Enquired' where PRNNo='"+PRNNo+"' and PRN_RefNo='"+PRNRefNo+"'";
		System.out.println("update---->"+updateItemMaster);
		st3.executeUpdate(updateItemMaster);
		
		
		
		
		k++;
	}

	j++;
}

System.out.println("prnlist:"+prnlist);

//add new logic to upddate PRNMaster

boolean enqflag = false;

String sql_prnitems = "select * from db_GlobalERP."+comid+"PRNItemMaster where PRN_RefNo='"+PRNRefNo+"'";
ResultSet rsitems = stitems.executeQuery(sql_prnitems);
while(rsitems.next()){
    String status =  rsitems.getString("Status");
    if(status.equals("Enquired") || status.equals("Rejected")){
       enqflag=true;
    }else{
    	enqflag=false;
    	break;
    } 

}

if(enqflag==true){
	//update PRNMaster
	String updt = "update db_GlobalERP."+comid+"PRNMaster set status='Completed' where PRN_RefNo='"+PRNRefNo+"'";
	stupdt.executeUpdate(updt);
}

}catch(Exception ex){
	ex.printStackTrace();
}finally{
	conn.close();
}

response.sendRedirect("PurchaseRequisitionEnquiryReport.jsp");

%>
</body>
</html>