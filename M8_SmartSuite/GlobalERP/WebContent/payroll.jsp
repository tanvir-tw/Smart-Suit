<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 <%@ include file="header.jsp"%>
<html>
<head>
<script src="js/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Payroll</title>
<style>
  #byte_content {
    margin: 5px 0;
    max-height: 100px;
    overflow-y: auto;
    overflow-x: hidden;
  }
  #load{
  }
</style>
<!-- this script is only for Auto hide and display loading image -->
<script>
	function hideImage(){
        $("#load").hide();
    }
	function showImage(){
		$("#load").show();
    }
	function validate(){
		var krn=document.getElementById("files").value;
		if(krn==""){
			alert("No File");
			return false;
		}
	}
</script>
<script type="text/javascript">
function f2(){
	hideImage();
	var res=document.getElementById("input").value;
	document.getElementById("csvdata").innerHTML=res;
}
</script>
</head>
<body onload="f2()">
<center><br><br><br>
<!-- <input type="file" id="files" name="file" accept="text/csv" onchange="f1()" /> -->
<!-- <input type="submit" id="files_xml" name="file_xml" value="Convert to xml" onclick="f3()" /> -->

<div id="byte_content"></div>
<script>
var data;
function f3(){
	showImage();
	var data1=document.getElementById("xml_test").value;
	
    var xmlhttp;
    if (window.XMLHttpRequest)
      {// code for IE7+, Firefox, Chrome, Opera, Safari
      xmlhttp=new XMLHttpRequest();
      }
    else
      {// code for IE6, IE5
      xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
      }
    xmlhttp.onreadystatechange=function()
      {
      if (xmlhttp.readyState==4 && xmlhttp.status==200)
        {
    	  hideImage();
        alert("Xml Created Succussfully Desktop ");
        }
      }
    var body = "file=" + data1;
    xmlhttp.open("POST", "AjaxCreateXmlpayroll.jsp", true);
    xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xmlhttp.setRequestHeader("Content-Length", body.length);
    xmlhttp.setRequestHeader("Connection", "close");
    xmlhttp.send(body);
    hideImage();
    
}
function readBlob(opt_startByte, opt_stopByte) {
    var files = document.getElementById('files').files;
    if (!files.length) {
      alert('Please select a file!');
      return;
    }
    var file = files[0];
    var start = 0;
    var stop =  file.size - 1;
    //alert("Size of file "+stop);

    var reader = new FileReader();

    // If we use onloadend, we need to check the readyState.
    reader.onloadend = function(evt) {
      if (evt.target.readyState == FileReader.DONE) { // DONE == 2
        var data=evt.target.result;
        var str = data;
        var str = str.replace(/\n/gi,'@');
        document.getElementById("xml_test").value=str;
        document.getElementById("xml_test_1").value=str;
        var xmlhttp;
        if (str=="")
          {
          document.getElementById("csvdata").innerHTML="";
          return;
          }
        if (window.XMLHttpRequest)
          {// code for IE7+, Firefox, Chrome, Opera, Safari
          xmlhttp=new XMLHttpRequest();
          }
        else
          {// code for IE6, IE5
          xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
          }
        xmlhttp.onreadystatechange=function()
          {
          if (xmlhttp.readyState==4 && xmlhttp.status==200)
            {
        	hideImage();
        	document.getElementById("csvdata").innerHTML=xmlhttp.responseText;
            document.getElementById("input").value=xmlhttp.responseText;
            alert("CSV Loaded SuccessFully......!!!!!!");
            
            }
          
          
          }
        var body = "file=" + str;
        xmlhttp.open("POST", "AjaxLoadCsvpayroll.jsp", true);
        xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xmlhttp.setRequestHeader("Content-Length", body.length);
        xmlhttp.setRequestHeader("Connection", "close");
        xmlhttp.send(body);
      }
    };
    var blob = file.slice(start, stop + 1);
    reader.readAsBinaryString(blob);
  }
  function f1(){
	  showImage();
	  readBlob(0, 500000000000000000000);  
  }
  function viewOld(){
	  window.open("XMLDownload.jsp", "View Payroll Xmls");
	  //window.open("viewOldPayrollXml.jsp", "View Payroll Xmls");
  }
</script>
<!-- AjaxCreateXmlpayroll.jsp -->
<input type="hidden" id="input" name="input">
<input type="hidden" id="xml_test" name="input">
<form action="AjaxCreateXmlpayroll.jsp" method="post" onsubmit="return validate()">
<input type="file" id="files" name="file" accept="text/csv" onchange="f1()" />
<input type="hidden" name="file_send" id="xml_test_1" name="input">
<input type="submit" value="Convert to xml" >
<input type="button" value="View Old Records" onclick="viewOld()">
</form>
<p id="load" style="float : right;margin-right: 50%;color: red;">Loading......!</p>
<br><br><br>
<div  id="csvdata"></div>
</center>
<div id="footer" style="margin-top: 20%">
<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
by Transworld Compressor Technologies Ltd. All Rights Reserved.</a></p>
</div>
</body>
</html>