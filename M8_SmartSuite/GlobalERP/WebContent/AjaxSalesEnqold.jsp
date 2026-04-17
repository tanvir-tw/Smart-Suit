<%@ include file="conn.jsp"%>
<%@page import="java.util.Date"%>
<%
	Connection con1 = null;
%>
<%
	try {
		Class.forName(DB_Driver);
		con1 = DriverManager.getConnection(DB_NAME, DB_USERNAME,
				DB_PASSWORD);
		System.out.println("con1 is"+con1);
		Statement stmt1 = con1.createStatement();
		Statement st1 = con1.createStatement();
		Statement stmt2 = con1.createStatement();
		System.out.println("stmt2 is"+stmt2);
		ResultSet rs1 = null;
		String buffer = "";

		String group="",make="", srno="", description = "-", quantity = "", modelNotKnown = "",model="";
        int Srno=0;
		
		if(request.getParameter("delete")==null)
		{
            String sql1="Select Max(srno) from "+session.getAttribute("CompanyMasterID").toString()+"tmp_"+ session.getAttribute("EmpName").toString().replaceAll(" ","_").replace(".","") +"";
            System.out.println("in delete ==null");
            ResultSet rs2=st1.executeQuery(sql1);
            if(rs2.next())
            {
            	Srno=rs2.getInt(1)+1;
            }
            else
            {
            	Srno=1;
            }
			group=request.getParameter("group");
			make=request.getParameter("make");
			//srno=request.getParameter("srno");
			quantity = request.getParameter("quantity");
			model = request.getParameter("model");
			System.out.println(request.getParameter("modelNotKnown")+"   *-/++++++++++++");
			modelNotKnown = request.getParameter("modelNotKnown");
			description = request.getParameter("description").replace("^^","+");
			System.out.println("description is"+description);
			String sql = " INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"tmp_"+ session.getAttribute("EmpName").toString().replaceAll(" ","_").replace(".","") +" "+
			"(srno,TheGroup,make,model,description,quantity,modelNotKnown) VALUES "
					+ "('"+Srno+"','"+group+"','"+make+"','"+model+"','" + description + "','" + quantity + "',"+modelNotKnown+")";
			 stmt1.executeUpdate(sql);
	
			buffer = "#Yes";
			out.println(buffer);
		}
		else
		{
			System.out.println("in ajax sales enq");
			srno=request.getParameter("srno");
			int var=Integer.parseInt(srno)-1;
			String sql =""; //" SELECT srno  FROM  "+session.getAttribute("CompanyMasterID").toString()+"tmp_"+ session.getAttribute("EmpName").toString().replaceAll(" ","_").replace(".","") +" ORDER BY srno ASC LIMIT "+var+",1 ";
			
			//ResultSet rs=stmt1.executeQuery(sql);
			//rs.next();
				
			sql="DELETE from  "+session.getAttribute("CompanyMasterID").toString()+"tmp_"+ session.getAttribute("EmpName").toString().replaceAll(" ","_").replace(".","") +" where srno='"+srno+"'  ";
			System.out.println(sql);
			try{
				System.out.println("before deletion");
				int a=stmt2.executeUpdate(sql);
				System.out.println("after deletion"+a);
			}catch(Exception e){
				System.out.println(e);
			}			
			buffer = "#Yes";
			out.println(buffer);
		}
			
		
	} catch (Exception e) {
		System.out.println("insert sales enq in tmp table > "+e);
		out.println("#NO");
	} finally {
		con1.close();
	}
%>
