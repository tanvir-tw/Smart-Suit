
function OnChangeGetRepCode(dropdown)
{
	var vv1=dropdown.selectedIndex;
	var SelValue1 = dropdown.options[vv1].value;
	if(SelValue1=="Select")
	{
	   document.mainpageform.ccode.value = "";		          
	   document.mainpageform.cpname.value = "";
	}
	else if(SelValue1=="Other")
	{
	} 
 else
 {
  var ajaxRequest;
	     try{
				ajaxRequest = new XMLHttpRequest();
	        }  
            catch (e)
            {
		        try
                  {
		  				 ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
	      		  } 
                     catch (e)
                     {
			  			 try
                         {
			     			  ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
			  			 } 
                         catch (e)
                         {
			     				 alert("Your browser broke!");
			      				return false;
			   			 }
	        		}
              }
              var queryString = "?repName=" +SelValue1;
          	ajaxRequest.open("GET", "getRepCode.jsp" + queryString, true);
          	ajaxRequest.send(null); 
          	ajaxRequest.onreadystatechange = function()
            {
                   if(ajaxRequest.readyState == 4)
                   {
                           var reslt=ajaxRequest.responseText;
                           var mySplitResult = reslt.split("#");
                           document.getElementById("repCode").innerHTML=mySplitResult[0];
                   }
            }
 }
}
function tabview_aux(TabViewId, id) {
	var TabView = document.getElementById(TabViewId);

	var Tabs = TabView.firstChild;
	while (Tabs.className != "Tabs")
		Tabs = Tabs.nextSibling;

	var Tab = Tabs.firstChild;
	var i = 0;

	do {
		if (Tab.tagName == "A") {
			i++;
			Tab.href = "javascript:tabview_switch('" + TabViewId + "', "
					+ i + ");";
			Tab.className = (i == id) ? "Active" : "";
			Tab.blur();
		}
	} while (Tab = Tab.nextSibling);

	var Pages = TabView.firstChild;
	while (Pages.className != 'Pages')
		Pages = Pages.nextSibling;

	var Page = Pages.firstChild;
	var i = 0;

	do {
		if (Page.className == 'Page') {
			i++;
			if (Pages.offsetHeight)
				Page.style.height = (Pages.offsetHeight - 2) + "px";
			Page.style.overflow = "auto";
			Page.style.display = (i == id) ? 'block' : 'none';
		}
	} while (Page = Page.nextSibling);
}

function tabview_switch(TabViewId, id) {
	tabview_aux(TabViewId, id);
}

function tabview_initialize(TabViewId) {
	tabview_aux(TabViewId, 1);
}
function OnChangeGetCompanyDetails(dropdown)
{
	var vv1=dropdown.selectedIndex;
	var SelValue1 = dropdown.options[vv1].value;
	
	if(SelValue1=="Select")
	{
	   document.mainpageform.ccode.value = "";		          
	   document.mainpageform.cpname.value = "";
	}
	else if(SelValue1=="Other")
	{
	} 
 else
 {
	 
  var ajaxRequest;
	     try{
				ajaxRequest = new XMLHttpRequest();
	        }  
            catch (e)
            {
		        try
                  {
		  				 ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
	      		  } 
                     catch (e)
                     {
			  			 try
                         {
			     			  ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
			  			 } 
                         catch (e)
                         {
			     				 alert("Your browser broke!");
			      				return false;
			   			 }
	        		}
              }
              var queryString = "?companyName=" +SelValue1;
          	ajaxRequest.open("GET", "getCompanyDetails.jsp" + queryString, true);
          	ajaxRequest.send(null); 
          	ajaxRequest.onreadystatechange = function()
            {
                   if(ajaxRequest.readyState == 4)
                   {
                           var reslt=ajaxRequest.responseText;
                           var mySplitResult = reslt.split("#");
                           document.getElementById("companyCode").innerHTML=mySplitResult[0];
                           document.getElementById("companyCity").innerHTML=mySplitResult[1];
                           document.getElementById("companyPhoneNumber").innerHTML=mySplitResult[2];
                           document.getElementById("companyProduct").innerHTML=mySplitResult[3];
                   }
            }
 }
}



function OnChangeGetCustomerDetails(dropdown)
{
	alert("test");
	document.getElementById("companyList").style.display=none;
	var vv1=dropdown.selectedIndex;
	var SelValue1 = dropdown.options[vv1].value;
	
	if(SelValue1=="Select")
	{
	   document.mainpageform.ccode.value = "";		          
	   document.mainpageform.cpname.value = "";
	}
	else if(SelValue1=="Other")
	{
	} 
 else
 {
	 
  var ajaxRequest;
	     try{
				ajaxRequest = new XMLHttpRequest();
	        }  
            catch (e)
            {
		        try
                  {
		  				 ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
	      		  } 
                     catch (e)
                     {
			  			 try
                         {
			     			  ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
			  			 } 
                         catch (e)
                         {
			     				 alert("Your browser broke!");
			      				return false;
			   			 }
	        		}
              }
              var queryString = "?customerName=" +SelValue1;
          	ajaxRequest.open("GET", "getCustomerDetails.jsp" + queryString, true);
          	ajaxRequest.send(null); 
          	ajaxRequest.onreadystatechange = function()
            {
                   if(ajaxRequest.readyState == 4)
                   {
                           var reslt=ajaxRequest.responseText;
                           var mySplitResult = reslt.split("#");
                           document.getElementById("customerCode").innerHTML=mySplitResult[0];
                           document.getElementById("customerContactPerson").innerHTML=mySplitResult[1];
                           document.getElementById("customerProduct").innerHTML=mySplitResult[2];
                           document.getElementById("customerWeeklyOff").innerHTML=mySplitResult[3];
                           document.getElementById("customerCity").innerHTML=mySplitResult[4];
                           document.getElementById("customerPhoneNumber").innerHTML=mySplitResult[5];
                           document.getElementById("customerEmail").innerHTML=mySplitResult[6];
                           document.getElementById("customerEnteredBy").innerHTML=mySplitResult[7];
                   }
            }
 }
}

function showFollowUpEntryForm(divid, state) {

	document.getElementById(divid).style.display=state;

}
function validate() {
	if(document.addFolloUp.customerCode.value=="" || document.addFolloUp.companyCode.value=="")
	{
	}
}
function testText() {
	alert("conentertext");
}







