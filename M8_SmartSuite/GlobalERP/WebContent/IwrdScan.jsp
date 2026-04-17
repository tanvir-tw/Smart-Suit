<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" import="java.text.*" import="java.util.*"%>
<%@ include file="headernew.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>GlobalERP | Multiple File Upload</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    
</head>
<body style="background-color: azure;">
<div class="container-fluid mt-2" id="main">
    <div class="content-header col-12 mb-3">
    <%  String resendMsg=request.getParameter("resendMsg");
					 if(!(resendMsg==null))
					 {
					 %>
					 <br>
        <h5 class="content-header-title text-center mb-0" style="color: #29ac1d;"><%=resendMsg%></h5>
        
        <%}
					 else
					 { %>
					 <h5 class="content-header-title text-center mb-0" style="color: #060637;">Multiple File Upload</h5>
					 
					<% } %>
					 
    </div>
    <br>
    <div class="row d-flex justify-content-center"> 
   <div class="col-md-3"></div>        
  <div class="col-md-3 mb-4 ms-1">
        
            <div class="card shadow-sm">
                <div class="card-body">
                    <form action="IwrdScanRequest.jsp" method="post" enctype="multipart/form-data" id="form1">
                        <div class="mb-3">
                            <input type="file" name="MyFile" id="MyFile" class="form-control form-control-sm" style="display:block;">
                            <input type="hidden" name="fileName" id="fileName" value="">
                        </div>
                        
                        <div class="text-center">
                            <button type="submit" id="submitButton1" class="btn btn-primary btn-sm px-4" onclick="return validate();" style="background-color:#1582AB;">Upload</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
 
        <div class="col-md-4 mb-4">
            <div class="table-responsive" style="max-width:550px; margin:auto;">
                <table class="table table-bordered text-center align-middle">
                    <thead>
                        <tr>
                            <th colspan="2" style="background-color:#1582AB;color:white;">List of Documents</th>
                        </tr>
                        <tr>
                            <th style="width:80%;">File Name</th>
                            <th style="width:20%;">Action</th>
                        </tr>
                    </thead>
                    <tbody style="background-color:white;" id="files_list">
                        <!-- Files dynamically added here -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
var dispAtchFile = null;

// MultiSelector function
function MultiSelector(list_target, max) {
    var fileList = null;
    this.list_target = list_target;
    this.count = 0;
    this.id = 0;
    this.max = max || -1;

    this.addElement = function(element) {
        if (element.tagName === 'INPUT' && element.type === 'file') {
            element.name = 'file_' + this.id++;
            element.multi_selector = this;

            element.onchange = function() {
                this.multi_selector.addListRow(this);
                this.style.display = 'none';

                var new_element = document.createElement('input');
                new_element.type = 'file';
                new_element.name = 'file_' + this.multi_selector.id++;
                new_element.multi_selector = this.multi_selector;
                new_element.className = 'form-control form-control-sm';
                this.parentNode.appendChild(new_element);
                this.multi_selector.addElement(new_element);
            };

            if (this.max !== -1 && this.count >= this.max) element.disabled = true;
            this.count++;
            this.current_element = element;
        } else {
            alert('Error: not a file input element');
        }
    };

    this.addListRow = function(element) {
        var new_row = document.createElement('tr');

        var file_name_td = document.createElement('td');
        file_name_td.textContent = element.value;

        var action_td = document.createElement('td');
        var delete_icon = document.createElement('i');
        delete_icon.className = 'bi bi-trash-fill text-danger';
        delete_icon.style.cursor = 'pointer';
        delete_icon.style.fontSize = '1.5rem';

        delete_icon.onclick = function() {
            element.parentNode.removeChild(element);
            new_row.parentNode.removeChild(new_row);

            var dispDelFile = element.value;
            removeFileList(dispAtchFile, dispDelFile);

            element.multi_selector.count--;
            element.multi_selector.current_element.disabled = false;
        };

        action_td.appendChild(delete_icon);
        new_row.appendChild(file_name_td);
        new_row.appendChild(action_td);
        this.list_target.appendChild(new_row);

        if (!dispAtchFile) dispAtchFile = element.value;
        else dispAtchFile += "," + element.value;
        testIt(dispAtchFile);
    };
}
function removeFileList(AddName, DelName) {
    var ajaxRequest;
    try { ajaxRequest = new XMLHttpRequest(); }
    catch (e) {
        try { ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP"); }
        catch (e) {
            try { ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP"); }
            catch (e) { alert("Your browser broke!"); return false; }
        }
    }

    ajaxRequest.onreadystatechange = function() {
        if (ajaxRequest.readyState === 4) testIt(ajaxRequest.responseText);
    }
    ajaxRequest.open("GET","fileDataDelete.jsp?AddName="+AddName+"&DelName="+DelName,true);
    ajaxRequest.send(null);
}
function testIt(p1) {
    dispAtchFile = p1.replace(/\s+/g,'');
    document.getElementById("fileName").value = dispAtchFile;
}

function validate() {
    var val1 = document.getElementById("fileName").value.replace(/\s+/g,'');
    if (val1 === "") {
        alert("Please Select File For Upload");
        return false;
    }
    return true;
}

var multi_selector = new MultiSelector(document.getElementById('files_list'), 10);
multi_selector.addElement(document.getElementById('MyFile'));
</script>

<%@ include file="footer.jsp" %>
</body>
</html>
