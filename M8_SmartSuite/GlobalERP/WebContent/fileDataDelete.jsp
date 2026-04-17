
<%
String employeeList="",delEmployee="",fileList="",finalList="";
//Statement st,st1,st2;
%>

<%
try
	{ 
	employeeList=request.getParameter("AddName");
	delEmployee=request.getParameter("DelName");
	System.out.println(employeeList+"#######"+delEmployee);
	String sd1="";
    String[] arr=new String[20];
    String[] arr2=new String[20];
    
            int i=0,j=0,x=0;
            String d1 = "[,]";
        	String[] t1 = employeeList.split(d1);
            for (String t : t1)
            {
                    arr[i]=t;
                    i++;
            }
            String[] t2= delEmployee.split(d1);
            for (String t : t2)
            {
                    arr2[x]=t;
                    x++;
            }
            for(int l=0;l<x;l++)
            {
                delEmployee=arr2[l];
	            for( j=0;j<i;j++)
	            {
	                    if(arr[j].equals(delEmployee))
	                    {
	                            break;
	                    }
	            }
	            for( int k=j+1;k<i;k++,j++)
	            {
	                    arr[j]=arr[k];
	            }
            }
            for( j=0;j<i-(x);j++)
            {
            	if(sd1=="" || sd1==null)
            	{
            		sd1=arr[j];
            	}
            	else
            	{
            		sd1=sd1+","+arr[j];
            	}
            }
	
//	finalList="#"+finalList;
	/*
	System.out.println("on Jsp======>>"+finalList);
	response.sendRedirect("IwrdScanBk.jsp?fl="+finalList);
	*/
	finalList=sd1;
	
	System.out.println("ajax Delete**********************"+finalList+"*************************");
	out.println(finalList);

	}
	catch(Exception e)
	{
		out.print("Exception--->"+e);
	}

%>
