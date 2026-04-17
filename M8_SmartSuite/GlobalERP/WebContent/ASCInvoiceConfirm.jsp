<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script>
function calculate()
{	
	var junkVal=document.getElementById('grandTotal').value;
    junkVal=Math.floor(junkVal);
    var obStr=new String(junkVal);
     numReversed=obStr.split("");
    actnumber=numReversed.reverse();

   if(Number(junkVal) >=0){
    }
    else{
    alert('wrong Number cannot be converted');
    return false;
    }
    if(Number(junkVal)==0){
        document.getElementById('container').innerHTML=obStr+''+'Rupees Zero Only';
        return false;
    }
    if(actnumber.length>9){
        alert('Oops!!!! the Number is too big to covertes');
        return false;
    }
 
    var iWords=["Zero", " One", " Two", " Three", " Four", " Five", " Six", " Seven", " Eight", " Nine"];
    var ePlace=['Ten', ' Eleven', ' Twelve', ' Thirteen', ' Fourteen', ' Fifteen', ' Sixteen', ' Seventeen', ' Eighteen', ' Nineteen'];
    var tensPlace=['dummy', ' Ten', ' Twenty', ' Thirty', ' Forty', ' Fifty', ' Sixty', ' Seventy', ' Eighty', ' Ninety' ];
 
    var iWordsLength=numReversed.length;
    var totalWords="";
    var inWords=new Array();
    var finalWord="";
    j=0;
	for(i=0; i<iWordsLength; i++){
    switch(i)
        {
        case 0:
        if(actnumber[i]==0 || actnumber[i+1]==1 ) {
                inWords[j]='';
            }
            else {
                inWords[j]=iWords[actnumber[i]];
            }
            inWords[j]=inWords[j]+' Only';
        break;
        case 1:
            tens_complication();
            break;
        case 2:
       if(actnumber[i]==0) {
           inWords[j]='';
        }
        else if(actnumber[i-1]!=0 && actnumber[i-2]!=0) {
                inWords[j]=iWords[actnumber[i]]+' Hundred and';
        }
            else {
            inWords[j]=iWords[actnumber[i]]+' Hundred';
            }
       break;
        case 3:
            if(actnumber[i]==0 || actnumber[i+1]==1) {
                inWords[j]='';
            }
            else {
            inWords[j]=iWords[actnumber[i]];
            }
            if(actnumber[i+1] != 0 || actnumber[i] > 0){
            inWords[j]=inWords[j]+" Thousand";
        }
            break;
        case 4:
            tens_complication();
        break;
        case 5:
            if(actnumber[i]==0 || actnumber[i+1]==1) {
            inWords[j]='';
            }
        else {
            inWords[j]=iWords[actnumber[i]];
        }
            if(actnumber[i+1] != 0 || actnumber[i] > 0){
                inWords[j]=inWords[j]+" Lacs";
       }
            break;
        case 6:
            tens_complication();
            break;
        case 7:
            if(actnumber[i]==0 || actnumber[i+1]==1 ){
                inWords[j]='';
            }
            else {
                inWords[j]=iWords[actnumber[i]];
            }
            inWords[j]=inWords[j]+" Crore";
            break;
        case 8:
            tens_complication();
        break;
        default:
            break;
    }
        j++;
}

	function tens_complication() {
        if(actnumber[i]==0) {
            inWords[j]='';
        }
        else if(actnumber[i]==1) {
        inWords[j]=ePlace[actnumber[i-1]];
        }
        else {
       inWords[j]=tensPlace[actnumber[i]];
        }
	}
inWords.reverse();
for(i=0; i<inWords.length; i++) {
    finalWord+=inWords[i];
}
    document.getElementById("rupees").innerHTML=finalWord;
    var InvoiceStatus=document.getElementById("InvoiceStatus").value;
    
    if(InvoiceStatus=="Invoiced")
    	{
    		Redirect();
    	}
    else
    	{
    		fun();
    	}
}

function Redirect()
{	
	
		alert("Summary Is Already Invoiced");
	  	window.location="ASCPendingInvoiceReport.jsp";
	     return false ;
}

function fun(){
	  var  agree=confirm("You Want To Create Invoice !");
	  var SrNo=document.getElementById("deactiveid").value;
	  var Company=document.getElementById("company").value;
	  var Total=document.getElementById("Total").value;
	  var GrandTotal=document.getElementById("GrandTotal").value;
	  var Rupees=document.getElementById("rupees").value;
	  if(agree)
	  {
		 window.location="ASCInvoiceInsert.jsp?id="+SrNo+"&company="+Company+"&Total="+Total+"&GrandTotal="+GrandTotal+"&Rupees="+Rupees+"";
		 return true ;
	  }	  	   
	  else
	  {
		 window.location="ASCPendingInvoiceReport.jsp";
	     return false ;
	  }	
}
</script>
<body>

<%			
		String id1=request.getParameter("Id");
		String company=request.getParameter("company");
		String total=request.getParameter("Total");
		String Grandtotal=request.getParameter("GrandTotal");
		String InvoiceStatus=request.getParameter("InvoiceStatus");
		
		if(InvoiceStatus.equals("Invoiced"))
		{
			out.println("<script>  Redirect();</script>");
		}
		else{
			%>
<script>
window.onload=calculate ;
</script>
			<% 
		}
%>
<input type="hidden" id="deactiveid" name="deactiveid" value="<%=id1%>" />
<input type="hidden" id="company" name="company" value="<%=company%>" />
<input type="hidden" id="Total" name="Total" value="<%=total%>" />
<input type="hidden" id="GrandTotal" name="GrandTotal" value="<%=Grandtotal%>" />
<input type="hidden" id="InvoiceStatus" name="InvoiceStatus" value="<%=InvoiceStatus%>" />
		
		<input type="hidden" id="grandTotal" name="grandTotal" value=<%=Grandtotal %> />
		<textarea readonly="readonly" name="rupees" id="rupees"   style="width: 230px; border: none; display : none;"></textarea>

<script>
window.onload=calculate ;
</script>
</body>
</html>